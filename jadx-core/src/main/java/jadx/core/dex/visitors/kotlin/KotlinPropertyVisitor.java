package jadx.core.dex.visitors.kotlin;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.FieldInitInsnAttr;
import jadx.core.dex.attributes.nodes.KotlinFieldFlagsAttr;
import jadx.core.dex.info.FieldInfo;
import jadx.core.dex.info.MethodInfo;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.instructions.IfOp;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.InvokeNode;
import jadx.core.dex.instructions.mods.ConstructorInsn;
import jadx.core.dex.instructions.IndexInsnNode;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.instructions.args.InsnWrapArg;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.AbstractVisitor;
import jadx.core.dex.visitors.ExtractFieldInit;
import jadx.core.dex.visitors.JadxVisitor;
import jadx.core.dex.visitors.PrepareForCodeGen;
import jadx.core.utils.exceptions.JadxException;

/**
 * Detects Kotlin {@code lateinit} and {@code lazy} property lowering from JVM bytecode.
 * <p>
 * {@code lateinit}: null-check on field read + {@code Intrinsics.throwUninitializedPropertyAccessException}.
 * {@code lazy}: delegate field type implements {@code kotlin.Lazy} and is initialized with {@code LazyImpl(Function0)}.
 */
@JadxVisitor(
		name = "KotlinPropertyVisitor",
		desc = "Detect Kotlin lateinit and lazy property patterns",
		runAfter = ExtractFieldInit.class,
		runBefore = PrepareForCodeGen.class
)
public class KotlinPropertyVisitor extends AbstractVisitor {

	private static final String KOTLIN_LAZY = "kotlin.Lazy";
	private static final String FUNCTION0 = "kotlin.jvm.functions.Function0";

	private RootNode root;

	@Override
	public void init(RootNode root) throws JadxException {
		this.root = root;
	}

	@Override
	public boolean visit(ClassNode cls) throws JadxException {
		for (ClassNode inner : cls.getInnerClasses()) {
			visit(inner);
		}
		detectLateinitFields(cls);
		detectLazyFields(cls);
		return false;
	}

	private void detectLateinitFields(ClassNode cls) {
		Set<FieldInfo> initFields = collectConstructorInitializedFields(cls);
		Set<FieldInfo> lateinitFields = new HashSet<>();
		for (MethodNode mth : cls.getMethods()) {
			if (mth.isNoCode() || mth.contains(AType.JADX_ERROR)) {
				continue;
			}
			for (BlockNode block : mth.getBasicBlocks()) {
				scanBlockForLateinit(cls, mth, block, initFields, lateinitFields);
			}
		}
		for (FieldInfo fieldInfo : lateinitFields) {
			FieldNode field = cls.searchField(fieldInfo);
			if (field != null && !field.getAccessFlags().isStatic()) {
				KotlinFieldFlagsAttr.getOrCreate(field).setLateinit(true);
			}
		}
	}

	private void scanBlockForLateinit(ClassNode cls, MethodNode mth, BlockNode block, Set<FieldInfo> initFields,
			Set<FieldInfo> lateinitFields) {
		List<InsnNode> insns = block.getInstructions();
		for (int i = 0; i < insns.size(); i++) {
			InsnNode insn = insns.get(i);
			if (insn.getType() != InsnType.IF || !(insn instanceof IfNode)) {
				continue;
			}
			IfNode ifInsn = (IfNode) insn;
			NullCheckInfo nullCheck = getNullCheck(ifInsn);
			if (nullCheck == null) {
				continue;
			}
			FieldInfo fieldInfo = findLateinitFieldRead(cls, mth, ifInsn, nullCheck.testedReg);
			if (fieldInfo == null || initFields.contains(fieldInfo)) {
				continue;
			}
			if (isLateinitThrowBranch(nullCheck.throwBranch)) {
				lateinitFields.add(fieldInfo);
			}
		}
	}

	private static final class NullCheckInfo {
		final InsnArg testedReg;
		final @Nullable BlockNode throwBranch;

		NullCheckInfo(InsnArg testedReg, @Nullable BlockNode throwBranch) {
			this.testedReg = testedReg;
			this.throwBranch = throwBranch;
		}
	}

	private static @Nullable NullCheckInfo getNullCheck(IfNode ifInsn) {
		if (ifInsn.getArg(1).isZeroLiteral()) {
			return nullCheckForReg(ifInsn, ifInsn.getArg(0));
		}
		if (ifInsn.getArg(0).isZeroLiteral()) {
			return nullCheckForReg(ifInsn, ifInsn.getArg(1));
		}
		return null;
	}

	private static @Nullable NullCheckInfo nullCheckForReg(IfNode ifInsn, InsnArg testedReg) {
		if (ifInsn.getOp() == IfOp.EQ) {
			return new NullCheckInfo(testedReg, ifInsn.getThenBlock());
		}
		if (ifInsn.getOp() == IfOp.NE) {
			return new NullCheckInfo(testedReg, ifInsn.getElseBlock());
		}
		return null;
	}

	private static @Nullable FieldInfo findLateinitFieldRead(ClassNode cls, MethodNode mth, IfNode ifInsn, InsnArg testedReg) {
		FieldInfo wrapped = fieldFromWrappedArg(ifInsn.getArg(0), cls);
		if (wrapped != null) {
			return wrapped;
		}
		wrapped = fieldFromWrappedArg(ifInsn.getArg(1), cls);
		if (wrapped != null) {
			return wrapped;
		}
		int ifOffset = ifInsn.getOffset();
		FieldInfo best = null;
		int bestOffset = -1;
		for (BlockNode block : mth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				if (insn.getOffset() >= ifOffset || insn.getType() != InsnType.IGET) {
					continue;
				}
				RegisterArg result = insn.getResult();
				if (result == null || !result.sameReg(testedReg)) {
					continue;
				}
				FieldInfo fieldInfo = (FieldInfo) ((IndexInsnNode) insn).getIndex();
				if (!fieldInfo.getDeclClass().equals(cls.getClassInfo())) {
					continue;
				}
				if (insn.getOffset() > bestOffset) {
					bestOffset = insn.getOffset();
					best = fieldInfo;
				}
			}
		}
		return best;
	}

	private static @Nullable FieldInfo fieldFromWrappedArg(InsnArg arg, ClassNode cls) {
		if (!arg.isInsnWrap()) {
			return null;
		}
		InsnNode wrap = ((InsnWrapArg) arg).getWrapInsn();
		if (wrap.getType() != InsnType.IGET) {
			return null;
		}
		FieldInfo fieldInfo = (FieldInfo) ((IndexInsnNode) wrap).getIndex();
		if (!fieldInfo.getDeclClass().equals(cls.getClassInfo())) {
			return null;
		}
		return fieldInfo;
	}

	private static boolean isLateinitThrowBranch(@Nullable BlockNode block) {
		return block != null && isLateinitThrowBlock(block);
	}

	private static boolean isLateinitThrowBlock(BlockNode block) {
		boolean hasThrowInvoke = false;
		boolean hasOther = false;
		for (InsnNode insn : block.getInstructions()) {
			if (insn.getType() == InsnType.NOP) {
				continue;
			}
			if (insn.getType() == InsnType.INVOKE && insn instanceof InvokeNode) {
				InvokeNode invoke = (InvokeNode) insn;
				MethodInfo callMth = invoke.getCallMth();
				if (invoke.isStaticCall()
						&& callMth.getReturnType().equals(ArgType.VOID)
						&& callMth.getArgsCount() == 1
						&& callMth.getArgumentsTypes().get(0).isObject()) {
					if (hasThrowInvoke) {
						hasOther = true;
					} else {
						hasThrowInvoke = true;
					}
					continue;
				}
			}
			if (insn.getType() == InsnType.THROW) {
				continue;
			}
			hasOther = true;
		}
		return hasThrowInvoke && !hasOther;
	}

	private static Set<FieldInfo> collectConstructorInitializedFields(ClassNode cls) {
		Set<FieldInfo> fields = new HashSet<>();
		for (MethodNode mth : cls.getMethods()) {
			if (!mth.isConstructor() || mth.isNoCode()) {
				continue;
			}
			for (BlockNode block : mth.getBasicBlocks()) {
				for (InsnNode insn : block.getInstructions()) {
					if (insn.getType() == InsnType.IPUT) {
						fields.add((FieldInfo) ((IndexInsnNode) insn).getIndex());
					}
				}
			}
		}
		return fields;
	}

	private void detectLazyFields(ClassNode cls) {
		for (FieldNode field : cls.getFields()) {
			if (field.getAccessFlags().isStatic() || !field.getAccessFlags().isFinal()) {
				continue;
			}
			if (!isLazyDelegateType(field)) {
				continue;
			}
			if (hasLazyDelegateInit(cls, field)) {
				KotlinFieldFlagsAttr.getOrCreate(field).setLazyDelegate(true);
			}
		}
	}

	private boolean hasLazyDelegateInit(ClassNode cls, FieldNode field) {
		FieldInitInsnAttr initAttr = field.get(AType.FIELD_INIT_INSN);
		if (initAttr != null && isLazyDelegateInit(initAttr.getInsn())) {
			return true;
		}
		for (MethodNode mth : cls.getMethods()) {
			if (!mth.isConstructor() || mth.isNoCode()) {
				continue;
			}
			for (BlockNode block : mth.getBasicBlocks()) {
				List<InsnNode> insns = block.getInstructions();
				for (int i = 0; i < insns.size(); i++) {
					InsnNode insn = insns.get(i);
					if (insn.getType() != InsnType.IPUT) {
						continue;
					}
					FieldInfo fieldInfo = (FieldInfo) ((IndexInsnNode) insn).getIndex();
					if (!fieldInfo.equals(field.getFieldInfo())) {
						continue;
					}
					if (isLazyDelegateIput(insns, i)) {
						return true;
					}
				}
			}
		}
		return false;
	}

	private boolean isLazyDelegateIput(List<InsnNode> insns, int iputIdx) {
		InsnNode iputInsn = insns.get(iputIdx);
		InsnArg valueArg = iputInsn.getArg(1);
		if (valueArg.isInsnWrap()) {
			return isLazyDelegateInit(iputInsn);
		}
		if (!valueArg.isRegister()) {
			return false;
		}
		InsnArg reg = valueArg;
		for (int i = iputIdx - 1; i >= 0 && iputIdx - i <= 8; i--) {
			InsnNode insn = insns.get(i);
			if (insn.getType() == InsnType.NOP) {
				continue;
			}
			if (insn.getType() == InsnType.MOVE) {
				RegisterArg result = insn.getResult();
				if (result != null && result.sameReg(reg)) {
					reg = insn.getArg(0);
					continue;
				}
				return false;
			}
			if (insn.getType() != InsnType.INVOKE || !(insn instanceof InvokeNode)) {
				return false;
			}
			InvokeNode invoke = (InvokeNode) insn;
			MethodInfo callMth = invoke.getCallMth();
			if (!callMth.isConstructor() || invoke.getArgsCount() != 2) {
				return false;
			}
			InsnArg instArg = invoke.getArg(0);
			if (!instArg.isRegister() || !((RegisterArg) instArg).sameReg(reg)) {
				return false;
			}
			ClassNode typeCls = root.resolveClass(callMth.getDeclClass().getType());
			if (typeCls == null || !implementsKotlinLazy(typeCls, new HashSet<>())) {
				return false;
			}
			return isFunction0Type(callMth.getArgumentsTypes().get(0));
		}
		return false;
	}

	private boolean isLazyDelegateType(FieldNode field) {
		ArgType type = field.getType();
		if (!type.isObject()) {
			return false;
		}
		ClassNode typeCls = root.resolveClass(type);
		if (typeCls == null) {
			return false;
		}
		return implementsKotlinLazy(typeCls, new HashSet<>());
	}

	private boolean implementsKotlinLazy(ClassNode cls, Set<String> visited) {
		String name = cls.getClassInfo().getFullName();
		if (!visited.add(name)) {
			return false;
		}
		if (KOTLIN_LAZY.equals(name)) {
			return true;
		}
		for (ArgType iface : cls.getInterfaces()) {
			if (iface.isObject() && KOTLIN_LAZY.equals(iface.getObject())) {
				return true;
			}
		}
		ArgType superClass = cls.getSuperClass();
		if (!superClass.isObject()) {
			return false;
		}
		ClassNode parent = root.resolveClass(superClass);
		return parent != null && implementsKotlinLazy(parent, visited);
	}

	private boolean isLazyDelegateInit(InsnNode insn) {
		InsnNode ctorInsn = unwrapInitInsn(insn);
		if (ctorInsn == null) {
			return false;
		}
		MethodInfo callMth;
		int functionArgCount;
		if (ctorInsn.getType() == InsnType.CONSTRUCTOR && ctorInsn instanceof ConstructorInsn) {
			ConstructorInsn ctrInsn = (ConstructorInsn) ctorInsn;
			callMth = ctrInsn.getCallMth();
			functionArgCount = ctrInsn.getArgsCount();
		} else if (ctorInsn.getType() == InsnType.INVOKE && ctorInsn instanceof InvokeNode) {
			InvokeNode invoke = (InvokeNode) ctorInsn;
			callMth = invoke.getCallMth();
			functionArgCount = callMth.getArgumentsTypes().size();
		} else {
			return false;
		}
		if (!callMth.isConstructor() || functionArgCount != 1) {
			return false;
		}
		ClassNode typeCls = root.resolveClass(callMth.getDeclClass().getType());
		if (typeCls == null || !implementsKotlinLazy(typeCls, new HashSet<>())) {
			return false;
		}
		return isFunction0Type(callMth.getArgumentsTypes().get(0));
	}

	private boolean isFunction0Type(ArgType type) {
		if (!type.isObject()) {
			return false;
		}
		if (FUNCTION0.equals(type.getObject())) {
			return true;
		}
		ClassNode cls = root.resolveClass(type);
		if (cls == null) {
			return false;
		}
		return implementsFunction0(cls, new HashSet<>());
	}

	private boolean isFunction0Type(InsnArg arg) {
		if (arg.isInsnWrap()) {
			InsnNode wrap = ((InsnWrapArg) arg).getWrapInsn();
			if (wrap.getType() == InsnType.CONST || wrap.getType() == InsnType.CONST_STR) {
				return false;
			}
		}
		ArgType type = arg.getType();
		if (type.isObject() && FUNCTION0.equals(type.getObject())) {
			return true;
		}
		if (!type.isObject()) {
			return false;
		}
		return isFunction0Type(type);
	}

	private boolean implementsFunction0(ClassNode cls, Set<String> visited) {
		String name = cls.getClassInfo().getFullName();
		if (!visited.add(name)) {
			return false;
		}
		if (FUNCTION0.equals(name)) {
			return true;
		}
		for (ArgType iface : cls.getInterfaces()) {
			if (iface.isObject() && FUNCTION0.equals(iface.getObject())) {
				return true;
			}
		}
		ArgType superClass = cls.getSuperClass();
		if (!superClass.isObject()) {
			return false;
		}
		ClassNode parent = root.resolveClass(superClass);
		return parent != null && implementsFunction0(parent, visited);
	}

	private static @Nullable InsnNode unwrapInitInsn(InsnNode insn) {
		if (insn.getType() == InsnType.IPUT && insn.getArgsCount() >= 2) {
			InsnArg val = insn.getArg(1);
			if (val.isInsnWrap()) {
				return unwrapInitInsn(((InsnWrapArg) val).getWrapInsn());
			}
			if (val.isRegister()) {
				return null;
			}
		}
		if (insn.getType() == InsnType.MOVE) {
			InsnArg arg = insn.getArg(0);
			if (arg.isInsnWrap()) {
				return unwrapInitInsn(((InsnWrapArg) arg).getWrapInsn());
			}
		}
		if (insn.getType() == InsnType.INVOKE || insn.getType() == InsnType.CONSTRUCTOR) {
			return insn;
		}
		return null;
	}
}
