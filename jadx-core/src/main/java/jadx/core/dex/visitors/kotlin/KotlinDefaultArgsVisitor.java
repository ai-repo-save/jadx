package jadx.core.dex.visitors.kotlin;

import java.util.List;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.nodes.MethodDefaultParamsAttr;
import jadx.core.dex.info.ClassInfo;
import jadx.core.dex.info.MethodInfo;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.InvokeNode;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.instructions.args.InsnWrapArg;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.AbstractVisitor;
import jadx.core.dex.visitors.ExtractFieldInit;
import jadx.core.dex.visitors.JadxVisitor;
import jadx.core.dex.visitors.PrepareForCodeGen;
import jadx.core.utils.exceptions.JadxException;

/**
 * Detects Kotlin interface default parameters from {@code DefaultImpls.method$default} lowering.
 */
@JadxVisitor(
		name = "KotlinDefaultArgsVisitor",
		desc = "Detect Kotlin default parameter values from DefaultImpls",
		runAfter = ExtractFieldInit.class,
		runBefore = PrepareForCodeGen.class
)
public class KotlinDefaultArgsVisitor extends AbstractVisitor {

	private static final String DEFAULT_IMPLS = "DefaultImpls";
	private static final String DEFAULT_SUFFIX = "$default";

	@Override
	public boolean visit(ClassNode cls) throws JadxException {
		for (ClassNode inner : cls.getInnerClasses()) {
			if (DEFAULT_IMPLS.equals(inner.getClassInfo().getShortName())) {
				processDefaultImpls(cls, inner);
				inner.add(AFlag.DONT_GENERATE);
			}
			visit(inner);
		}
		return false;
	}

	private void processDefaultImpls(ClassNode iface, ClassNode defaultImpls) {
		for (MethodNode defaultMth : defaultImpls.getMethods()) {
			if (!defaultMth.getAccessFlags().isStatic() || defaultMth.isConstructor()) {
				continue;
			}
			if (!defaultMth.getName().endsWith(DEFAULT_SUFFIX)) {
				continue;
			}
			InvokeNode ifaceCall = findIfaceCall(defaultMth, iface);
			if (ifaceCall == null) {
				continue;
			}
			MethodNode targetMth = iface.searchMethod(ifaceCall.getCallMth());
			if (targetMth == null) {
				continue;
			}
			applyDefaults(defaultMth, targetMth, ifaceCall);
		}
	}

	private void applyDefaults(MethodNode defaultMth, MethodNode targetMth, InvokeNode ifaceCall) {
		MethodDefaultParamsAttr attr = MethodDefaultParamsAttr.getOrCreate(targetMth);
		for (BlockNode block : defaultMth.getBasicBlocks()) {
			List<InsnNode> insns = block.getInstructions();
			for (int i = 0; i < insns.size(); i++) {
				InsnNode insn = insns.get(i);
				if (insn.getType() != InsnType.IF || !(insn instanceof IfNode)) {
					continue;
				}
				IfNode ifInsn = (IfNode) insn;
				InsnNode valueInsn = extractDefaultValueInsn(ifInsn.getElseBlock());
				if (valueInsn == null) {
					valueInsn = extractDefaultValueInsn(ifInsn.getThenBlock());
				}
				if (valueInsn == null) {
					valueInsn = scanFollowingDefaultInit(insns, i + 1, ifaceCall);
				}
				if (valueInsn == null) {
					continue;
				}
				int targetArgIdx = resolveTargetArgIndex(ifaceCall, valueInsn, insns, i);
				if (targetArgIdx < 0) {
					continue;
				}
				attr.addDefault(targetArgIdx, defaultMth, valueInsn);
			}
		}
	}

	private static @Nullable InsnNode scanFollowingDefaultInit(List<InsnNode> insns, int start, InvokeNode ifaceCall) {
		for (int i = start; i < insns.size(); i++) {
			InsnNode insn = insns.get(i);
			if (insn.getType() == InsnType.IF || insn.getType() == InsnType.GOTO) {
				break;
			}
			if (insn == ifaceCall) {
				break;
			}
			if (insn.getType() == InsnType.INVOKE && insn instanceof InvokeNode) {
				InvokeNode invoke = (InvokeNode) insn;
				if (invoke.getCallMth().equals(ifaceCall.getCallMth())) {
					break;
				}
				return insn;
			}
			if (insn.getType() == InsnType.CONST || insn.getType() == InsnType.CONST_STR
					|| insn.getType() == InsnType.SGET) {
				return insn;
			}
		}
		return null;
	}

	private static int resolveTargetArgIndex(InvokeNode ifaceCall, InsnNode valueInsn, List<InsnNode> insns, int ifIdx) {
		RegisterArg assignedReg = valueInsn.getResult();
		if (assignedReg == null) {
			assignedReg = findAssignedRegisterAfter(insns, ifIdx, valueInsn);
		}
		if (assignedReg != null) {
			for (int i = 1; i < ifaceCall.getArgsCount(); i++) {
				InsnArg arg = ifaceCall.getArg(i);
				if (arg.isRegister() && ((RegisterArg) arg).sameReg(assignedReg)) {
					return i - 1;
				}
			}
		}
		return -1;
	}

	private static @Nullable RegisterArg findAssignedRegisterAfter(List<InsnNode> insns, int ifIdx, InsnNode valueInsn) {
		for (int i = ifIdx + 1; i < insns.size(); i++) {
			InsnNode insn = insns.get(i);
			if (insn == valueInsn) {
				if (i + 1 < insns.size() && insns.get(i + 1).getType() == InsnType.MOVE) {
					return insns.get(i + 1).getResult();
				}
				return null;
			}
			if (insn.getType() == InsnType.MOVE && insn.getArgsCount() > 0) {
				InsnArg arg = insn.getArg(0);
				if (arg.isInsnWrap() && ((InsnWrapArg) arg).getWrapInsn() == valueInsn) {
					return insn.getResult();
				}
			}
		}
		return null;
	}

	private static @Nullable InvokeNode findIfaceCall(MethodNode defaultMth, ClassNode iface) {
		ClassInfo ifaceInfo = iface.getClassInfo();
		InvokeNode[] found = new InvokeNode[1];
		for (BlockNode block : defaultMth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				insn.visitInsns(inner -> {
					if (inner.getType() == InsnType.INVOKE && inner instanceof InvokeNode) {
						InvokeNode invoke = (InvokeNode) inner;
						if (invoke.getCallMth().getDeclClass().equals(ifaceInfo)) {
							found[0] = invoke;
						}
					}
				});
				if (found[0] != null) {
					return found[0];
				}
			}
		}
		return null;
	}

	private static @Nullable InsnNode extractDefaultValueInsn(BlockNode block) {
		for (InsnNode insn : block.getInstructions()) {
			if (insn.getType() == InsnType.NOP || insn.getType() == InsnType.GOTO) {
				continue;
			}
			if (insn.getType() == InsnType.MOVE && insn.getArgsCount() > 0 && insn.getArg(0).isInsnWrap()) {
				return ((InsnWrapArg) insn.getArg(0)).getWrapInsn();
			}
			if (insn.getType() == InsnType.INVOKE || insn.getType() == InsnType.CONST
					|| insn.getType() == InsnType.CONST_STR || insn.getType() == InsnType.SGET) {
				return insn;
			}
			return null;
		}
		return null;
	}

	private static @Nullable RegisterArg findAssignedRegister(BlockNode block) {
		for (InsnNode insn : block.getInstructions()) {
			if (insn.getType() == InsnType.MOVE) {
				return insn.getResult();
			}
		}
		return null;
	}
}
