package jadx.core.dex.visitors.kotlin;

import java.util.ArrayList;
import java.util.List;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.nodes.KotlinDataClassAttr;
import jadx.core.dex.attributes.nodes.MethodDefaultParamsAttr;
import jadx.core.dex.info.ClassInfo;
import jadx.core.dex.info.FieldInfo;
import jadx.core.dex.info.MethodInfo;
import jadx.core.dex.instructions.BaseInvokeNode;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.instructions.IndexInsnNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.InvokeNode;
import jadx.core.dex.instructions.mods.ConstructorInsn;
import jadx.core.dex.instructions.mods.TernaryInsn;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.instructions.args.InsnWrapArg;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.AbstractVisitor;
import jadx.core.dex.visitors.ExtractFieldInit;
import jadx.core.dex.visitors.JadxVisitor;
import jadx.core.dex.visitors.PrepareForCodeGen;
import jadx.core.utils.exceptions.JadxException;

/**
 * Detects Kotlin default parameter values from:
 * <ul>
 * <li>{@code DefaultImpls.method$default} for interface methods</li>
 * <li>{@code copy$default} for data class {@code copy}</li>
 * <li>synthetic constructors with bitmask + {@code DefaultConstructorMarker} for primary constructors</li>
 * </ul>
 */
@JadxVisitor(
		name = "KotlinDefaultArgsVisitor",
		desc = "Detect Kotlin default parameter values",
		runAfter = ExtractFieldInit.class,
		runBefore = PrepareForCodeGen.class
)
public class KotlinDefaultArgsVisitor extends AbstractVisitor {

	private static final String DEFAULT_IMPLS = "DefaultImpls";
	private static final String DEFAULT_SUFFIX = "$default";
	private static final String COPY_DEFAULT = "copy$default";
	private static final String DEFAULT_CTOR_MARKER = "kotlin.jvm.internal.DefaultConstructorMarker";

	@Override
	public boolean visit(ClassNode cls) throws JadxException {
		if (cls.root().getArgs().isKotlinOutput()) {
			processDataClassDefaultArgsEarly(cls);
		}
		for (ClassNode inner : cls.getInnerClasses()) {
			if (DEFAULT_IMPLS.equals(inner.getClassInfo().getShortName())) {
				processDefaultImpls(cls, inner);
				inner.add(AFlag.DONT_GENERATE);
			}
			visit(inner);
		}
		return false;
	}

	/**
	 * Extract default parameter values while synthetic ctor / copy$default still have instruction IR
	 * (IF or TERNARY). Does not require {@code isData} — metadata pass handles attr and hiding.
	 */
	private void processDataClassDefaultArgsEarly(ClassNode cls) {
		MethodNode primaryCtor = findPrimaryConstructor(cls);
		if (primaryCtor == null) {
			return;
		}
		boolean hasDefaultCtor = false;
		for (MethodNode mth : cls.getMethods()) {
			if (isDefaultConstructorStub(mth)) {
				hasDefaultCtor = true;
				BaseInvokeNode ctorCall = findConstructorCall(mth, primaryCtor);
				if (ctorCall != null) {
					applyDefaults(mth, primaryCtor, ctorCall);
				}
			}
		}
		if (hasDefaultCtor || cls.searchMethodByShortName(COPY_DEFAULT) != null) {
			processCopyDefault(cls);
		}
	}

	/**
	 * Called from kotlin-metadata decompile pass for data classes (after regions are built).
	 */
	public static void processDataClassCopy(ClassNode cls) {
		if (!cls.root().getArgs().isKotlinOutput() || !cls.getAccessFlags().isData()) {
			return;
		}
		new KotlinDefaultArgsVisitor().processCopyDefault(cls);
	}

	/**
	 * Called from kotlin-metadata decompile pass after {@code isData} flag is set.
	 */
	public static void processDataClass(ClassNode cls) {
		if (!cls.root().getArgs().isKotlinOutput() || !cls.getAccessFlags().isData()) {
			return;
		}
		MethodNode primaryCtor = findPrimaryConstructor(cls);
		if (primaryCtor == null) {
			return;
		}
		List<FieldNode> ctorFields = collectCtorFieldOrder(primaryCtor);
		KotlinDataClassAttr.getOrCreate(cls, primaryCtor, ctorFields);
		primaryCtor.add(AFlag.DONT_GENERATE);

		for (MethodNode mth : cls.getMethods()) {
			if (isDefaultConstructorStub(mth)) {
				BaseInvokeNode ctorCall = findConstructorCall(mth, primaryCtor);
				if (ctorCall != null) {
					applyDefaults(mth, primaryCtor, ctorCall);
				}
				mth.add(AFlag.DONT_GENERATE);
			}
		}
	}

	private void processCopyDefault(ClassNode cls) {
		if (!cls.root().getArgs().isKotlinOutput()) {
			return;
		}
		for (MethodNode mth : cls.getMethods()) {
			if (!COPY_DEFAULT.equals(mth.getName()) || !mth.getAccessFlags().isStatic()) {
				continue;
			}
			MethodNode copyMth = cls.searchMethodByShortName("copy");
			if (copyMth == null) {
				continue;
			}
			InvokeNode copyCall = findInvokeCall(mth, copyMth.getMethodInfo());
			if (copyCall != null) {
				applyDefaults(mth, copyMth, copyCall);
			}
			mth.add(AFlag.DONT_GENERATE);
		}
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

	private static void applyDefaults(MethodNode defaultMth, MethodNode targetMth, BaseInvokeNode targetCall) {
		MethodDefaultParamsAttr attr = MethodDefaultParamsAttr.getOrCreate(targetMth);
		applyDefaultsFromCallArgs(defaultMth, targetCall, attr);
		applyDefaultsFromTernaryBlocks(defaultMth, targetCall, attr);
		applyDefaultsFromIfBlocks(defaultMth, targetCall, attr);
	}

	private static void applyDefaultsFromCallArgs(MethodNode defaultMth, BaseInvokeNode targetCall, MethodDefaultParamsAttr attr) {
		int firstArg = targetCall.getFirstArgOffset();
		for (int i = firstArg; i < targetCall.getArgsCount(); i++) {
			int paramIdx = i - firstArg;
			if (attr.getDefault(paramIdx) != null) {
				continue;
			}
			InsnNode defaultInsn = extractDefaultFromCallArg(defaultMth, targetCall.getArg(i));
			if (defaultInsn != null) {
				attr.addDefault(paramIdx, defaultMth, defaultInsn);
			}
		}
	}

	private static void applyDefaultsFromTernaryBlocks(MethodNode defaultMth, BaseInvokeNode targetCall, MethodDefaultParamsAttr attr) {
		for (BlockNode block : defaultMth.getBasicBlocks()) {
			List<InsnNode> insns = block.getInstructions();
			for (int i = 0; i < insns.size(); i++) {
				InsnNode insn = insns.get(i);
				if (insn.getType() != InsnType.TERNARY || !(insn instanceof TernaryInsn)) {
					continue;
				}
				int targetArgIdx = resolveTargetArgIndex(targetCall, insn, insns, i);
				if (targetArgIdx < 0 || attr.getDefault(targetArgIdx) != null) {
					continue;
				}
				InsnNode defaultInsn = extractDefaultFromTernary(defaultMth, (TernaryInsn) insn);
				if (defaultInsn == null) {
					continue;
				}
				attr.addDefault(targetArgIdx, defaultMth, defaultInsn);
			}
		}
	}

	private static void applyDefaultsFromIfBlocks(MethodNode defaultMth, BaseInvokeNode targetCall, MethodDefaultParamsAttr attr) {
		for (BlockNode block : defaultMth.getBasicBlocks()) {
			List<InsnNode> insns = block.getInstructions();
			for (int i = 0; i < insns.size(); i++) {
				InsnNode insn = insns.get(i);
				if (insn.getType() != InsnType.IF || !(insn instanceof IfNode)) {
					continue;
				}
				IfNode ifInsn = (IfNode) insn;
				InsnNode valueInsn = extractDefaultValueInsn(defaultMth, insns, i, ifInsn.getElseBlock());
				if (valueInsn == null) {
					valueInsn = extractDefaultValueInsn(defaultMth, insns, i, ifInsn.getThenBlock());
				}
				if (valueInsn == null) {
					valueInsn = scanFollowingDefaultInit(insns, i + 1, targetCall);
				}
				if (valueInsn == null) {
					continue;
				}
				int targetArgIdx = resolveTargetArgIndex(targetCall, valueInsn, insns, i);
				if (targetArgIdx < 0 || attr.getDefault(targetArgIdx) != null) {
					continue;
				}
				InsnNode defaultInsn = unwrapDefaultInsn(defaultMth, insns, i, valueInsn);
				attr.addDefault(targetArgIdx, defaultMth, defaultInsn);
			}
		}
	}

	private static @Nullable InsnNode extractDefaultFromCallArg(MethodNode defaultMth, InsnArg arg) {
		if (arg.isInsnWrap()) {
			InsnNode wrap = ((InsnWrapArg) arg).getWrapInsn();
			if (wrap.getType() == InsnType.TERNARY) {
				return extractDefaultFromTernary(defaultMth, (TernaryInsn) wrap);
			}
		}
		if (arg.isRegister()) {
			InsnNode assignInsn = ((RegisterArg) arg).getAssignInsn();
			if (assignInsn != null && assignInsn.getType() == InsnType.TERNARY) {
				return extractDefaultFromTernary(defaultMth, (TernaryInsn) assignInsn);
			}
		}
		return null;
	}

	private static @Nullable InsnNode extractDefaultFromTernary(MethodNode defaultMth, TernaryInsn ternInsn) {
		InsnArg thenArg = ternInsn.getArg(0);
		InsnArg elseArg = ternInsn.getArg(1);
		boolean thenParam = isParamArg(defaultMth, thenArg);
		boolean elseParam = isParamArg(defaultMth, elseArg);
		if (thenParam && !elseParam) {
			return insnFromDefaultBranchArg(defaultMth, elseArg);
		}
		if (elseParam && !thenParam) {
			return insnFromDefaultBranchArg(defaultMth, thenArg);
		}
		if (!thenParam && isDefaultBranchArg(defaultMth, thenArg)) {
			return insnFromDefaultBranchArg(defaultMth, thenArg);
		}
		if (!elseParam && isDefaultBranchArg(defaultMth, elseArg)) {
			return insnFromDefaultBranchArg(defaultMth, elseArg);
		}
		return null;
	}

	private static boolean isParamArg(MethodNode mth, InsnArg arg) {
		if (arg.isRegister()) {
			RegisterArg reg = (RegisterArg) arg;
			for (RegisterArg mthArg : mth.getArgRegs()) {
				if (mthArg.sameReg(reg)) {
					return true;
				}
			}
		}
		InsnNode insn = unwrapBranchInsn(arg);
		return isParamPassMove(mth, insn);
	}

	private static boolean isDefaultBranchArg(MethodNode mth, InsnArg arg) {
		if (arg.isLiteral()) {
			return true;
		}
		InsnNode insn = unwrapBranchInsn(arg);
		if (insn == null) {
			return false;
		}
		return isDefaultValueInsn(insn) || extractValueInsn(mth, insn) != null;
	}

	private static @Nullable InsnNode insnFromDefaultBranchArg(MethodNode mth, InsnArg arg) {
		if (arg.isLiteral()) {
			InsnNode constInsn = new InsnNode(InsnType.CONST, 1);
			constInsn.addArg(arg);
			return constInsn;
		}
		InsnNode insn = unwrapBranchInsn(arg);
		if (insn == null) {
			return null;
		}
		InsnNode value = extractValueInsn(mth, insn);
		return value != null ? value : (isDefaultValueInsn(insn) ? insn : null);
	}

	private static @Nullable InsnNode unwrapBranchInsn(InsnArg arg) {
		if (arg.isInsnWrap()) {
			return ((InsnWrapArg) arg).getWrapInsn();
		}
		return null;
	}

	private static boolean isParamPassMove(MethodNode mth, InsnNode insn) {
		if (insn == null || insn.getType() != InsnType.MOVE || insn.getArgsCount() == 0 || !insn.getArg(0).isRegister()) {
			return false;
		}
		RegisterArg src = (RegisterArg) insn.getArg(0);
		for (RegisterArg argReg : mth.getArgRegs()) {
			if (argReg.sameReg(src)) {
				return true;
			}
		}
		return false;
	}

	private static boolean isDefaultValueInsn(InsnNode insn) {
		if (insn == null) {
			return false;
		}
		switch (insn.getType()) {
			case CONST:
			case CONST_STR:
			case INVOKE:
			case SGET:
			case IGET:
				return true;
			default:
				return false;
		}
	}

	private static @Nullable InsnNode extractValueInsn(MethodNode mth, InsnNode insn) {
		if (insn == null) {
			return null;
		}
		if (insn.getType() == InsnType.MOVE && insn.getArgsCount() > 0) {
			if (insn.getArg(0).isInsnWrap()) {
				return ((InsnWrapArg) insn.getArg(0)).getWrapInsn();
			}
			if (insn.getArg(0).isRegister()) {
				InsnNode resolved = resolveRegisterInMethod(mth, (RegisterArg) insn.getArg(0));
				if (resolved != null) {
					return resolved;
				}
			}
		}
		if (isDefaultValueInsn(insn)) {
			return insn;
		}
		return null;
	}

	private static @Nullable InsnNode resolveRegisterInMethod(MethodNode mth, RegisterArg reg) {
		for (BlockNode block : mth.getBasicBlocks()) {
			List<InsnNode> insns = block.getInstructions();
			for (int i = 0; i < insns.size(); i++) {
				InsnNode insn = insns.get(i);
				if (insn.getResult() == null || !insn.getResult().sameReg(reg)) {
					continue;
				}
				if (isDefaultValueInsn(insn)) {
					return insn;
				}
				if (insn.getType() == InsnType.MOVE && insn.getArgsCount() > 0) {
					InsnNode resolved = extractValueInsn(mth, insn);
					if (resolved != null) {
						return resolved;
					}
				}
			}
		}
		return null;
	}

	private static @Nullable MethodNode findPrimaryConstructor(ClassNode cls) {
		MethodNode best = null;
		int bestArgs = -1;
		for (MethodNode mth : cls.getMethods()) {
			if (!mth.isConstructor() || mth.getAccessFlags().isSynthetic()) {
				continue;
			}
			int argsCount = mth.getArgRegs().size();
			if (argsCount > bestArgs) {
				bestArgs = argsCount;
				best = mth;
			}
		}
		return best;
	}

	private static List<FieldNode> collectCtorFieldOrder(MethodNode ctor) {
		List<FieldNode> fields = new ArrayList<>();
		ClassNode cls = ctor.getParentClass();
		for (BlockNode block : ctor.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				if (insn.getType() != InsnType.IPUT) {
					continue;
				}
				Object index = ((IndexInsnNode) insn).getIndex();
				if (!(index instanceof FieldInfo)) {
					continue;
				}
				FieldNode field = cls.searchField((FieldInfo) index);
				if (field != null && !fields.contains(field)) {
					fields.add(field);
				}
			}
		}
		return fields;
	}

	private static boolean isDefaultConstructorStub(MethodNode mth) {
		if (!mth.isConstructor() || !mth.getAccessFlags().isSynthetic()) {
			return false;
		}
		List<ArgType> argTypes = mth.getArgTypes();
		if (argTypes.size() < 2) {
			return false;
		}
		ArgType markerType = argTypes.get(argTypes.size() - 1);
		if (!markerType.isObject()) {
			return false;
		}
		if (DEFAULT_CTOR_MARKER.equals(markerType.getObject())) {
			return true;
		}
		return !argTypes.get(argTypes.size() - 2).isObject();
	}

	private static boolean isSameInvokeInsn(InsnNode insn, BaseInvokeNode targetCall) {
		if (insn.getType() == InsnType.INVOKE && insn instanceof InvokeNode) {
			return ((InvokeNode) insn).getCallMth().equals(targetCall.getCallMth());
		}
		if (insn.getType() == InsnType.CONSTRUCTOR && insn instanceof ConstructorInsn) {
			return ((ConstructorInsn) insn).getCallMth().equals(targetCall.getCallMth());
		}
		return false;
	}

	private static @Nullable InsnNode scanFollowingDefaultInit(List<InsnNode> insns, int start, BaseInvokeNode targetCall) {
		for (int i = start; i < insns.size(); i++) {
			InsnNode insn = insns.get(i);
			if (insn.getType() == InsnType.IF || insn.getType() == InsnType.GOTO) {
				break;
			}
			if (insn == targetCall || isSameInvokeInsn(insn, targetCall)) {
				break;
			}
			if (insn.getType() == InsnType.INVOKE && insn instanceof InvokeNode) {
				InvokeNode invoke = (InvokeNode) insn;
				if (invoke.getCallMth().equals(targetCall.getCallMth())) {
					break;
				}
				return insn;
			}
			if (insn.getType() == InsnType.CONSTRUCTOR && insn instanceof ConstructorInsn) {
				ConstructorInsn ctr = (ConstructorInsn) insn;
				if (ctr.getCallMth().equals(targetCall.getCallMth())) {
					break;
				}
				return insn;
			}
			if (insn.getType() == InsnType.CONST || insn.getType() == InsnType.CONST_STR
					|| insn.getType() == InsnType.SGET || insn.getType() == InsnType.IGET) {
				return insn;
			}
		}
		return null;
	}

	private static int resolveTargetArgIndex(BaseInvokeNode targetCall, InsnNode valueInsn, List<InsnNode> insns, int ifIdx) {
		RegisterArg assignedReg = valueInsn.getResult();
		if (assignedReg == null) {
			assignedReg = findAssignedRegisterAfter(insns, ifIdx, valueInsn);
		}
		if (assignedReg == null) {
			return -1;
		}
		int firstArg = targetCall.getFirstArgOffset();
		for (int i = firstArg; i < targetCall.getArgsCount(); i++) {
			if (argUsesRegister(targetCall.getArg(i), assignedReg)) {
				return i - firstArg;
			}
		}
		return -1;
	}

	private static boolean argUsesRegister(InsnArg arg, RegisterArg reg) {
		if (arg.isRegister()) {
			RegisterArg argReg = (RegisterArg) arg;
			if (argReg.sameReg(reg)) {
				return true;
			}
			InsnNode assignInsn = argReg.getAssignInsn();
			if (assignInsn != null && assignInsn.getType() == InsnType.MOVE && assignInsn.getArgsCount() > 0) {
				return argUsesRegister(assignInsn.getArg(0), reg);
			}
		}
		return false;
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

	private static @Nullable BaseInvokeNode findConstructorCall(MethodNode defaultMth, MethodNode ctor) {
		MethodInfo expectedMth = ctor.getMethodInfo();
		for (BlockNode block : defaultMth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				if (insn.getType() == InsnType.CONSTRUCTOR && insn instanceof ConstructorInsn) {
					ConstructorInsn ctr = (ConstructorInsn) insn;
					if (ctr.getCallMth().equals(expectedMth)) {
						return ctr;
					}
				}
			}
		}
		return findInvokeCall(defaultMth, expectedMth);
	}

	private static @Nullable InvokeNode findInvokeCall(MethodNode defaultMth, MethodInfo expectedMth) {
		InvokeNode[] found = new InvokeNode[1];
		for (BlockNode block : defaultMth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				insn.visitInsns(inner -> {
					if (inner.getType() == InsnType.INVOKE && inner instanceof InvokeNode) {
						InvokeNode invoke = (InvokeNode) inner;
						if (invoke.getCallMth().equals(expectedMth)) {
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

	private static @Nullable InsnNode extractDefaultValueInsn(MethodNode mth, List<InsnNode> blockInsns, int ifInsnIdx,
			BlockNode block) {
		if (block == null) {
			return null;
		}
		List<InsnNode> branchInsns = block.getInstructions();
		for (int i = 0; i < branchInsns.size(); i++) {
			InsnNode insn = branchInsns.get(i);
			if (insn.getType() == InsnType.NOP || insn.getType() == InsnType.GOTO) {
				continue;
			}
			if (insn.getType() == InsnType.MOVE && insn.getArgsCount() > 0) {
				if (insn.getArg(0).isInsnWrap()) {
					return ((InsnWrapArg) insn.getArg(0)).getWrapInsn();
				}
				if (insn.getArg(0).isRegister()) {
					RegisterArg src = (RegisterArg) insn.getArg(0);
					InsnNode resolved = resolveRegisterValue(mth, branchInsns, i, src);
					if (resolved == null) {
						resolved = resolveRegisterValue(mth, blockInsns, ifInsnIdx, src);
					}
					if (resolved != null) {
						return resolved;
					}
				}
				return null;
			}
			if (insn.getType() == InsnType.INVOKE || insn.getType() == InsnType.CONST
					|| insn.getType() == InsnType.CONST_STR || insn.getType() == InsnType.SGET
					|| insn.getType() == InsnType.IGET) {
				return insn;
			}
			return null;
		}
		return null;
	}

	private static InsnNode unwrapDefaultInsn(MethodNode mth, List<InsnNode> insns, int ifIdx, InsnNode valueInsn) {
		if (valueInsn.getType() == InsnType.MOVE && valueInsn.getArgsCount() > 0 && valueInsn.getArg(0).isRegister()) {
			int moveIdx = insns.indexOf(valueInsn);
			InsnNode resolved = null;
			if (moveIdx != -1) {
				resolved = resolveRegisterValue(mth, insns, moveIdx, (RegisterArg) valueInsn.getArg(0));
			}
			if (resolved == null) {
				resolved = resolveRegisterValue(mth, insns, ifIdx, (RegisterArg) valueInsn.getArg(0));
			}
			if (resolved != null) {
				return resolved;
			}
		}
		return valueInsn;
	}

	private static @Nullable InsnNode resolveRegisterValue(MethodNode mth, List<InsnNode> insns, int beforeIdx, RegisterArg reg) {
		for (int i = beforeIdx - 1; i >= 0; i--) {
			InsnNode insn = insns.get(i);
			if (insn.getType() == InsnType.IF) {
				break;
			}
			if (insn.getResult() == null || !insn.getResult().sameReg(reg)) {
				continue;
			}
			if (insn.getType() == InsnType.CONST || insn.getType() == InsnType.CONST_STR
					|| insn.getType() == InsnType.INVOKE || insn.getType() == InsnType.SGET
					|| insn.getType() == InsnType.IGET) {
				return insn;
			}
			if (insn.getType() == InsnType.MOVE && insn.getArgsCount() > 0) {
				if (insn.getArg(0).isInsnWrap()) {
					return ((InsnWrapArg) insn.getArg(0)).getWrapInsn();
				}
				if (insn.getArg(0).isRegister()) {
					InsnNode resolved = resolveRegisterValue(mth, insns, i, (RegisterArg) insn.getArg(0));
					if (resolved != null) {
						return resolved;
					}
				}
			}
		}
		return null;
	}
}
