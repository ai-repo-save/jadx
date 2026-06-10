package jadx.core.dex.visitors.kotlin.coroutine;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.nodes.StateMachineAttr;
import jadx.core.dex.info.ClassInfo;
import jadx.core.dex.info.FieldInfo;
import jadx.core.dex.instructions.ArithNode;
import jadx.core.dex.instructions.ArithOp;
import jadx.core.dex.instructions.ConstStringNode;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.instructions.IfOp;
import jadx.core.dex.instructions.IndexInsnNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.InvokeNode;
import jadx.core.dex.instructions.InvokeType;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.instructions.args.InsnWrapArg;
import jadx.core.dex.instructions.args.LiteralArg;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.utils.BlockUtils;
import jadx.core.utils.InsnUtils;

/**
 * Extracts Kotlin CPS state-machine structure from bytecode: label dispatch and suspend sites.
 */
public final class StateMachineAnalyzer {

	private static final int LABEL_SUSPENDED_BIT = Integer.MIN_VALUE;

	private StateMachineAnalyzer() {
	}

	public static String diagnose(MethodNode mth) {
		if (mth.isNoCode() || mth.getBasicBlocks().isEmpty()) {
			return "no-code";
		}
		if (findCoroutineSuspendedMarkerInsn(mth) == null) {
			return "no-suspended-marker";
		}
		if (findLabelField(mth) == null) {
			return "no-label-field";
		}
		FieldInfo labelField = findLabelField(mth);
		if (findDispatchBlock(mth, labelField) == null) {
			return "no-dispatch-block";
		}
		BlockNode dispatch = findDispatchBlock(mth, labelField);
		if (parseLabelDispatch(mth, dispatch, labelField).isEmpty()) {
			return "empty-label-dispatch";
		}
		InsnNode suspended = findCoroutineSuspendedMarkerInsn(mth);
		if (suspended == null || suspended.getResult() == null
				|| collectSuspendPoints(mth, labelField, suspended.getResult()).isEmpty()) {
			return "no-suspend-points";
		}
		return "ok";
	}

	public static @Nullable StateMachineAttr analyze(MethodNode mth) {
		if (mth.isNoCode() || mth.getBasicBlocks().isEmpty()) {
			return null;
		}
		InsnNode suspendedMarkerInsn = findCoroutineSuspendedMarkerInsn(mth);
		if (suspendedMarkerInsn == null) {
			return null;
		}
		RegisterArg suspendedReg = suspendedMarkerInsn.getResult();
		if (suspendedReg == null) {
			return null;
		}
		FieldInfo labelField = findLabelField(mth);
		if (labelField == null) {
			return null;
		}
		ClassInfo continuationClass = labelField.getDeclClass();
		BlockNode dispatchBlock = findDispatchBlock(mth, labelField);
		if (dispatchBlock == null) {
			return null;
		}
		Map<Integer, BlockNode> labelToResumeBlock = parseLabelDispatch(mth, dispatchBlock, labelField);
		if (labelToResumeBlock.isEmpty()) {
			return null;
		}
		List<SuspendPoint> suspendPoints = collectSuspendPoints(mth, labelField, suspendedReg);
		if (suspendPoints.isEmpty()) {
			return null;
		}
		ClassInfo continuationFromCast = findContinuationClass(mth);
		if (continuationFromCast != null) {
			continuationClass = continuationFromCast;
		}
		return new StateMachineAttr(
				continuationClass,
				labelField,
				suspendedMarkerInsn,
				dispatchBlock,
				labelToResumeBlock,
				suspendPoints);
	}

	/**
	 * Kotlin loads {@code COROUTINE_SUSPENDED} either via {@code invoke-static getCOROUTINE_SUSPENDED()}
	 * or {@code sget} on the singleton field (R8 / newer compilers). The marker register must participate
	 * in {@code if-ne invokeResult, marker} / {@code return marker} suspend checks — not merely exist.
	 */
	private static @Nullable InsnNode findCoroutineSuspendedMarkerInsn(MethodNode mth) {
		InsnNode invokeMarker = findSuspendedMarkerInvokeInsn(mth);
		if (invokeMarker != null) {
			return invokeMarker;
		}
		return findSuspendedMarkerSgetInsn(mth);
	}

	private static @Nullable InsnNode findSuspendedMarkerInvokeInsn(MethodNode mth) {
		for (BlockNode block : mth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				if (insn.getType() != InsnType.INVOKE || !(insn instanceof InvokeNode)) {
					continue;
				}
				InvokeNode invoke = (InvokeNode) insn;
				if (invoke.getInvokeType() != InvokeType.STATIC || invoke.getArgsCount() != 0) {
					continue;
				}
				RegisterArg result = invoke.getResult();
				// void static side effects (e.g. Kotlin throwIndexOverflow) have no result register
				if (result == null || !result.getType().isObject()) {
					continue;
				}
				if (isSuspendedMarkerUsed(mth, result)) {
					return insn;
				}
			}
		}
		return null;
	}

	private static @Nullable InsnNode findSuspendedMarkerSgetInsn(MethodNode mth) {
		for (BlockNode block : mth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				if (insn.getType() != InsnType.SGET) {
					continue;
				}
				FieldInfo field = getFieldInsn(insn);
				if (field == null || !field.getType().isObject()) {
					continue;
				}
				RegisterArg result = insn.getResult();
				if (result == null) {
					continue;
				}
				if (isSuspendedMarkerUsed(mth, result)) {
					return insn;
				}
			}
		}
		return null;
	}

	private static boolean isSuspendedMarkerUsed(MethodNode mth, RegisterArg markerReg) {
		for (BlockNode block : mth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				if (insn instanceof IfNode && isSuspendCheck((IfNode) insn, markerReg)) {
					return true;
				}
			}
		}
		return false;
	}

	private static @Nullable FieldInfo findLabelField(MethodNode mth) {
		for (BlockNode block : mth.getBasicBlocks()) {
			List<InsnNode> insns = block.getInstructions();
			for (int i = 0; i < insns.size(); i++) {
				InsnNode insn = insns.get(i);
				if (insn.getType() != InsnType.IGET) {
					continue;
				}
				FieldInfo field = getFieldInsn(insn);
				if (field == null || !field.getType().equals(ArgType.INT)) {
					continue;
				}
				if (hasSuspendedBitMask(mth, block, insns, i, field)) {
					return field;
				}
			}
		}
		return null;
	}

	private static boolean hasSuspendedBitMask(MethodNode mth, BlockNode igetBlock, List<InsnNode> insns, int igetIndex,
			FieldInfo field) {
		if (hasSuspendedBitMaskInBlock(insns, igetIndex)) {
			return true;
		}
		BlockNode block = singleLinearSucc(igetBlock);
		for (int depth = 0; depth < 3 && block != null; depth++) {
			for (InsnNode insn : block.getInstructions()) {
				if (isSuspendedBitCheckInsn(insn)) {
					return true;
				}
				if (isSuspendedBitUnwrapInsn(insn, field)) {
					return true;
				}
			}
			block = singleLinearSucc(block);
		}
		return false;
	}

	private static boolean hasSuspendedBitMaskInBlock(List<InsnNode> insns, int igetIndex) {
		for (int i = igetIndex + 1; i < insns.size(); i++) {
			InsnNode insn = insns.get(i);
			if (insn.getType() == InsnType.CONST) {
				LiteralArg lit = getLiteral(insn);
				if (lit != null && lit.getLiteral() == LABEL_SUSPENDED_BIT) {
					return true;
				}
			}
			if (insn.getType() == InsnType.IF) {
				if (isSuspendedBitCheckInsn(insn)) {
					return true;
				}
				break;
			}
		}
		return false;
	}

	private static boolean isSuspendedBitCheckInsn(InsnNode insn) {
		if (!(insn instanceof IfNode)) {
			return false;
		}
		IfNode ifInsn = (IfNode) insn;
		return containsArithWithLiteral(ifInsn.getArg(0), ArithOp.AND, LABEL_SUSPENDED_BIT)
				|| containsArithWithLiteral(ifInsn.getArg(1), ArithOp.AND, LABEL_SUSPENDED_BIT);
	}

	private static boolean isSuspendedBitUnwrapInsn(InsnNode insn, FieldInfo field) {
		if (insn.getType() != InsnType.IPUT || !Objects.equals(getFieldInsn(insn), field)) {
			return false;
		}
		InsnArg value = insn.getArg(0);
		if (!value.isInsnWrap()) {
			return false;
		}
		InsnNode wrap = ((InsnWrapArg) value).getWrapInsn();
		return wrap instanceof ArithNode
				&& ((ArithNode) wrap).getOp() == ArithOp.SUB
				&& hasArithLiteral((ArithNode) wrap, LABEL_SUSPENDED_BIT);
	}

	private static boolean containsArithWithLiteral(InsnArg arg, ArithOp op, long literal) {
		if (!arg.isInsnWrap()) {
			return false;
		}
		InsnNode wrap = ((InsnWrapArg) arg).getWrapInsn();
		return wrap instanceof ArithNode
				&& ((ArithNode) wrap).getOp() == op
				&& hasArithLiteral((ArithNode) wrap, literal);
	}

	private static boolean hasArithLiteral(ArithNode arith, long literal) {
		for (InsnArg arg : arith.getArguments()) {
			if (arg.isLiteral() && ((LiteralArg) arg).getLiteral() == literal) {
				return true;
			}
		}
		return false;
	}

	private static @Nullable ClassInfo findContinuationClass(MethodNode mth) {
		for (BlockNode block : mth.getBasicBlocks()) {
			List<InsnNode> insns = block.getInstructions();
			for (int i = 0; i < insns.size(); i++) {
				if (insns.get(i).getType() != InsnType.INSTANCE_OF) {
					continue;
				}
				for (int j = i + 1; j < insns.size() && j < i + 4; j++) {
					InsnNode next = insns.get(j);
					if (next.getType() == InsnType.CHECK_CAST && next instanceof IndexInsnNode) {
						ArgType type = ((IndexInsnNode) next).getIndexAsType();
						if (type.isObject()) {
							return ClassInfo.fromName(mth.root(), type.getObject());
						}
					}
				}
			}
		}
		return null;
	}

	private static @Nullable BlockNode findDispatchBlock(MethodNode mth, FieldInfo labelField) {
		for (BlockNode block : mth.getBasicBlocks()) {
			List<InsnNode> insns = block.getInstructions();
			for (int i = 0; i < insns.size(); i++) {
				InsnNode insn = insns.get(i);
				if (insn.getType() != InsnType.IGET) {
					continue;
				}
				FieldInfo field = getFieldInsn(insn);
				if (!Objects.equals(field, labelField)) {
					continue;
				}
				if (hasSuspendedBitMask(mth, block, insns, i, labelField)) {
					continue;
				}
				BlockNode dispatch = findFirstDispatchIfBlock(mth, block, i);
				if (dispatch != null) {
					return dispatch;
				}
			}
		}
		return null;
	}

	private static @Nullable BlockNode findFirstDispatchIfBlock(MethodNode mth, BlockNode startBlock, int fromInsnIndex) {
		BlockNode block = startBlock;
		for (int steps = 0; steps < 8 && block != null; steps++) {
			List<InsnNode> insns = block.getInstructions();
			int start = block == startBlock ? fromInsnIndex + 1 : 0;
			for (int i = start; i < insns.size(); i++) {
				InsnNode insn = insns.get(i);
				if (insn instanceof IfNode && isDispatchIf(mth, (IfNode) insn)) {
					return block;
				}
			}
			block = singleLinearSucc(block);
		}
		return null;
	}

	private static boolean isDispatchIf(MethodNode mth, IfNode ifInsn) {
		if (isSuspendedBitCheckInsn(ifInsn)) {
			return false;
		}
		if (ifInsn.getOp() != IfOp.EQ && ifInsn.getOp() != IfOp.NE) {
			return false;
		}
		return extractDispatchLabel(mth, ifInsn) != null;
	}

	private static Map<Integer, BlockNode> parseLabelDispatch(MethodNode mth, BlockNode start, FieldInfo labelField) {
		Map<Integer, BlockNode> map = new LinkedHashMap<>();
		BlockNode block = start;
		int steps = 0;
		while (block != null && steps++ < mth.getBasicBlocks().size()) {
			IfNode dispatchIf = findDispatchIf(mth, block);
			if (dispatchIf == null) {
				break;
			}
			Integer label = extractDispatchLabel(mth, dispatchIf);
			BlockNode entry = extractDispatchEntry(dispatchIf);
			if (label != null && entry != null && !isResumeBeforeInvokeThrow(entry)) {
				map.putIfAbsent(label, entry);
			}
			block = nextDispatchBlock(mth, block, dispatchIf);
		}
		return map;
	}

	private static @Nullable IfNode findDispatchIf(MethodNode mth, BlockNode block) {
		for (InsnNode insn : block.getInstructions()) {
			if (insn instanceof IfNode && isDispatchIf(mth, (IfNode) insn)) {
				return (IfNode) insn;
			}
		}
		return null;
	}

	private static @Nullable BlockNode nextDispatchBlock(MethodNode mth, BlockNode block, IfNode ifInsn) {
		if (ifInsn.getOp() != IfOp.EQ && ifInsn.getOp() != IfOp.NE) {
			return null;
		}
		BlockNode entry = BlockUtils.followEmptyPath(extractDispatchEntry(ifInsn));
		BlockNode preferred = ifInsn.getOp() == IfOp.EQ
				? BlockUtils.followEmptyPath(ifInsn.getElseBlock())
				: BlockUtils.followEmptyPath(ifInsn.getThenBlock());
		if (preferred != null && !preferred.equals(entry) && findDispatchIf(mth, preferred) != null) {
			return preferred;
		}
		for (BlockNode succ : block.getSuccessors()) {
			BlockNode follow = BlockUtils.followEmptyPath(succ);
			if (follow == null || follow.equals(entry) || findDispatchIf(mth, follow) == null) {
				continue;
			}
			return follow;
		}
		return null;
	}

	private static @Nullable Integer extractDispatchLabel(MethodNode mth, IfNode ifInsn) {
		if (ifInsn.getOp() == IfOp.EQ && ifInsn.getArg(1).isZeroLiteral()) {
			return 0;
		}
		if (ifInsn.getOp() == IfOp.EQ && ifInsn.getArg(0).isZeroLiteral()) {
			return 0;
		}
		if (ifInsn.getOp() == IfOp.EQ || ifInsn.getOp() == IfOp.NE) {
			return getComparedLabel(mth, ifInsn);
		}
		return null;
	}

	private static @Nullable BlockNode extractDispatchEntry(IfNode ifInsn) {
		if (ifInsn.getOp() == IfOp.EQ && ifInsn.getArg(1).isZeroLiteral()) {
			return BlockUtils.followEmptyPath(ifInsn.getThenBlock());
		}
		if (ifInsn.getOp() == IfOp.EQ) {
			return BlockUtils.followEmptyPath(ifInsn.getThenBlock());
		}
		if (ifInsn.getOp() == IfOp.NE) {
			return BlockUtils.followEmptyPath(ifInsn.getElseBlock());
		}
		return null;
	}

	private static @Nullable BlockNode singleLinearSucc(BlockNode block) {
		List<BlockNode> succs = block.getSuccessors();
		if (succs.size() == 1) {
			return succs.get(0);
		}
		return null;
	}

	private static @Nullable Integer getComparedLabel(MethodNode mth, IfNode ifInsn) {
		InsnArg a = ifInsn.getArg(0);
		InsnArg b = ifInsn.getArg(1);
		Integer label = getConstIntValue(mth, b);
		if (label != null) {
			return label;
		}
		return getConstIntValue(mth, a);
	}

	private static @Nullable Integer getConstIntValue(MethodNode mth, InsnArg arg) {
		Object val = InsnUtils.getConstValueByArg(mth.root(), arg);
		if (val instanceof LiteralArg) {
			return (int) ((LiteralArg) val).getLiteral();
		}
		return null;
	}

	private static List<SuspendPoint> collectSuspendPoints(
			MethodNode mth,
			FieldInfo labelField,
			RegisterArg suspendedReg) {
		List<SuspendPoint> points = new ArrayList<>();
		Set<String> seen = new HashSet<>();
		for (BlockNode checkBlock : mth.getBasicBlocks()) {
			for (InsnNode insn : checkBlock.getInstructions()) {
				if (!(insn instanceof IfNode)) {
					continue;
				}
				IfNode ifInsn = (IfNode) insn;
				if (!isSuspendCheck(ifInsn, suspendedReg)) {
					continue;
				}
				InvokeSite invokeSite = findSuspendInvoke(ifInsn, checkBlock);
				if (invokeSite == null) {
					continue;
				}
				LabelStore store = findLabelStoreBeforeSuspend(checkBlock, labelField);
				if (store == null) {
					continue;
				}
				String key = store.label + "@" + checkBlock.getId();
				if (!seen.add(key)) {
					continue;
				}
				points.add(new SuspendPoint(
						store.label,
						store.block,
						store.insn,
						invokeSite.block,
						invokeSite.insn,
						checkBlock));
			}
		}
		return points;
	}

	private static boolean isSuspendCheck(IfNode ifInsn, RegisterArg suspendedReg) {
		if (ifInsn.getOp() != IfOp.NE && ifInsn.getOp() != IfOp.EQ) {
			return false;
		}
		if (!referencesSuspendedReg(ifInsn, suspendedReg)) {
			return false;
		}
		return isSuspendedReturnBlock(ifInsn.getThenBlock(), suspendedReg)
				|| isSuspendedReturnBlock(ifInsn.getElseBlock(), suspendedReg);
	}

	private static boolean referencesSuspendedReg(IfNode ifInsn, RegisterArg suspendedReg) {
		return sameRegister(ifInsn.getArg(0), suspendedReg) || sameRegister(ifInsn.getArg(1), suspendedReg);
	}

	private static boolean isSuspendedReturnBlock(@Nullable BlockNode block, RegisterArg suspendedReg) {
		block = BlockUtils.followEmptyPath(block);
		if (block == null) {
			return false;
		}
		List<InsnNode> insns = block.getInstructions();
		if (insns.size() != 1) {
			return false;
		}
		InsnNode retInsn = insns.get(0);
		if (retInsn.getType() != InsnType.RETURN || retInsn.getArgsCount() == 0) {
			return false;
		}
		InsnArg retArg = retInsn.getArg(0);
		return retArg.isRegister() && sameRegister(retArg, suspendedReg);
	}

	private static @Nullable InvokeSite findSuspendInvoke(IfNode ifInsn, BlockNode checkBlock) {
		InsnNode wrapped = extractWrappedInvoke(ifInsn.getArg(0));
		if (wrapped == null) {
			wrapped = extractWrappedInvoke(ifInsn.getArg(1));
		}
		if (wrapped != null && hasContinuationArg(wrapped)) {
			return new InvokeSite(checkBlock, wrapped);
		}
		BlockNode block = checkBlock;
		for (int depth = 0; depth < 12 && block != null; depth++) {
			InsnNode invoke = findLastInvoke(block);
			if (invoke != null && hasContinuationArg(invoke)) {
				return new InvokeSite(block, invoke);
			}
			block = singlePred(block);
		}
		return null;
	}

	private static @Nullable InsnNode extractWrappedInvoke(InsnArg arg) {
		if (!arg.isInsnWrap()) {
			return null;
		}
		InsnNode wrap = ((InsnWrapArg) arg).getWrapInsn();
		if (wrap.getType() == InsnType.INVOKE) {
			return wrap;
		}
		return null;
	}

	private static @Nullable LabelStore findLabelStoreBeforeSuspend(BlockNode start, FieldInfo labelField) {
		ArrayDeque<BlockNode> queue = new ArrayDeque<>();
		Set<BlockNode> visited = new HashSet<>();
		queue.add(start);
		while (!queue.isEmpty() && visited.size() < 60) {
			BlockNode block = queue.poll();
			if (!visited.add(block)) {
				continue;
			}
			LabelStore store = findLastLabelStoreInBlock(block, labelField);
			if (store != null) {
				return store;
			}
			for (BlockNode pred : block.getPredecessors()) {
				queue.add(pred);
			}
		}
		return null;
	}

	private static @Nullable LabelStore findLastLabelStoreInBlock(BlockNode block, FieldInfo labelField) {
		List<InsnNode> insns = block.getInstructions();
		for (int i = insns.size() - 1; i >= 0; i--) {
			InsnNode insn = insns.get(i);
			if (insn.getType() != InsnType.IPUT) {
				continue;
			}
			if (!Objects.equals(getFieldInsn(insn), labelField)) {
				continue;
			}
			if (isSuspendedBitUnwrapInsn(insn, labelField)) {
				continue;
			}
			Integer label = getIputIntLabel(insn, insns);
			if (label != null && label > 0) {
				return new LabelStore(label, block, insn);
			}
		}
		return null;
	}

	private static @Nullable Integer getIputIntLabel(InsnNode iputInsn, List<InsnNode> insns) {
		InsnArg val = iputInsn.getArg(0);
		if (val.isLiteral()) {
			return (int) ((LiteralArg) val).getLiteral();
		}
		return findIntConstBefore(insns, iputInsn);
	}

	private static @Nullable Integer findIntConstBefore(List<InsnNode> insns, InsnNode iputInsn) {
		if (!iputInsn.getArg(0).isRegister()) {
			return null;
		}
		RegisterArg valueReg = (RegisterArg) iputInsn.getArg(0);
		int iputIdx = insns.indexOf(iputInsn);
		for (int i = iputIdx - 1; i >= 0; i--) {
			InsnNode insn = insns.get(i);
			if (insn.getType() == InsnType.CONST && insn.getResult() != null
					&& sameRegister(insn.getResult(), valueReg)) {
				LiteralArg lit = getLiteral(insn);
				if (lit != null) {
					return (int) lit.getLiteral();
				}
			}
		}
		return null;
	}

	private static boolean hasContinuationArg(InsnNode invoke) {
		if (!(invoke instanceof InvokeNode) || invoke.getArgsCount() == 0) {
			return false;
		}
		InvokeNode inv = (InvokeNode) invoke;
		if (!inv.getCallMth().getReturnType().isObject()) {
			return false;
		}
		InsnArg lastArg = inv.getArg(inv.getArgsCount() - 1);
		if (!lastArg.isRegister() || !lastArg.getType().isObject()) {
			return false;
		}
		String lastType = lastArg.getType().toString();
		if (lastType.contains("Continuation")) {
			return true;
		}
		// Kotlin suspend stub: trailing Object continuation parameter (often obfuscated, e.g. Lz2/e;)
		return true;
	}

	private static @Nullable InsnNode findLastInvoke(BlockNode block) {
		InsnNode lastInvoke = null;
		for (InsnNode insn : block.getInstructions()) {
			if (insn.getType() == InsnType.INVOKE) {
				lastInvoke = insn;
			}
		}
		return lastInvoke;
	}

	private static @Nullable BlockNode singlePred(BlockNode block) {
		List<BlockNode> preds = block.getPredecessors();
		if (preds.size() == 1) {
			return preds.get(0);
		}
		return null;
	}

	private static boolean isSingleReturnBlock(@Nullable BlockNode block) {
		if (block == null) {
			return false;
		}
		List<InsnNode> insns = block.getInstructions();
		return insns.size() == 1 && insns.get(0).getType() == InsnType.RETURN;
	}

	private static boolean isResumeBeforeInvokeThrow(@Nullable BlockNode block) {
		if (block == null) {
			return false;
		}
		for (InsnNode insn : block.getInstructions()) {
			if (insn.getType() == InsnType.CONST_STR) {
				String str = ((ConstStringNode) insn).getString();
				if (str.contains(StateMachineAttr.RESUME_BEFORE_INVOKE_MSG)) {
					return true;
				}
			}
		}
		return false;
	}

	private static @Nullable FieldInfo getFieldInsn(InsnNode insn) {
		if (!(insn instanceof IndexInsnNode)) {
			return null;
		}
		Object index = ((IndexInsnNode) insn).getIndex();
		if (index instanceof FieldInfo) {
			return (FieldInfo) index;
		}
		return null;
	}

	private static @Nullable LiteralArg getLiteral(InsnNode insn) {
		if (!insn.isConstInsn() || !insn.getArg(0).isLiteral()) {
			return null;
		}
		return (LiteralArg) insn.getArg(0);
	}

	private static boolean sameRegister(InsnArg a, RegisterArg b) {
		return a.isRegister() && ((RegisterArg) a).getRegNum() == b.getRegNum();
	}

	private static final class InvokeSite {
		final BlockNode block;
		final InsnNode insn;

		InvokeSite(BlockNode block, InsnNode insn) {
			this.block = block;
			this.insn = insn;
		}
	}

	private static final class LabelStore {
		final int label;
		final BlockNode block;
		final InsnNode insn;

		LabelStore(int label, BlockNode block, InsnNode insn) {
			this.label = label;
			this.block = block;
			this.insn = insn;
		}
	}
}
