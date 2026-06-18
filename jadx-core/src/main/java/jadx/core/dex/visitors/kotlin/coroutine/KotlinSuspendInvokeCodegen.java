package jadx.core.dex.visitors.kotlin.coroutine;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.MethodOverrideAttr;
import jadx.core.dex.attributes.nodes.SkipMethodArgsAttr;
import jadx.core.dex.attributes.nodes.SuspendFunctionAttr;
import jadx.core.dex.instructions.BaseInvokeNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.instructions.args.InsnWrapArg;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.nodes.IMethodDetails;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;

/**
 * Kotlin suspend invoke codegen: {@link SkipMethodArgsAttr} hides the synthetic
 * {@code Continuation} parameter at call sites, except CPS resume calls inside
 * {@code ContinuationImpl.invokeSuspend} that pass {@code this} explicitly in bytecode.
 */
public final class KotlinSuspendInvokeCodegen {

	private static final String CONTINUATION_IMPL_PKG = "kotlin.coroutines.jvm.internal.";

	private KotlinSuspendInvokeCodegen() {
	}

	public static boolean shouldSkipInvokeArg(
			MethodNode caller,
			@Nullable MethodNode callee,
			BaseInvokeNode invoke,
			int invokeArgIndex,
			int startArgNum) {
		int calleeArgIndex = invokeArgIndex - startArgNum;
		if (!SkipMethodArgsAttr.isSkip(callee, calleeArgIndex)) {
			return false;
		}
		return !isExplicitContinuationResume(caller, callee, invoke, invokeArgIndex);
	}

	/**
	 * CPS {@code invokeSuspend} passes {@code this} as the continuation argument; drop
	 * synthetic {@code CAST}/{@code CHECK_CAST} wrappers before emitting the call.
	 */
	public static InsnArg unwrapContinuationThisCast(
			MethodNode caller,
			@Nullable MethodNode callee,
			BaseInvokeNode invoke,
			int invokeArgIndex,
			InsnArg arg) {
		if (!isExplicitContinuationResume(caller, callee, invoke, invokeArgIndex)) {
			return arg;
		}
		return unwrapCast(arg);
	}

	private static boolean isExplicitContinuationResume(
			MethodNode caller,
			@Nullable MethodNode callee,
			BaseInvokeNode invoke,
			int invokeArgIndex) {
		if (callee == null || !isContinuationImplInvokeSuspend(caller)) {
			return false;
		}
		RegisterArg thisArg = caller.getThisArg();
		if (thisArg == null) {
			return false;
		}
		int contIdx = getContinuationArgIndex(callee);
		if (contIdx < 0) {
			return false;
		}
		int calleeArgIndex = invokeArgIndex - invoke.getFirstArgOffset();
		if (calleeArgIndex != contIdx) {
			return false;
		}
		InsnArg contArg = invoke.getArg(invokeArgIndex);
		if (contArg.isSameVar(thisArg) || contArg.contains(AFlag.THIS) || contArg.isAnyThis()) {
			return true;
		}
		RegisterArg contReg = getRegisterArg(contArg);
		return contReg != null && (contReg.isSameVar(thisArg) || contReg.contains(AFlag.THIS));
	}

	private static int getContinuationArgIndex(MethodNode callee) {
		SuspendFunctionAttr suspendAttr = callee.get(AType.SUSPEND_FUNCTION);
		if (suspendAttr != null) {
			return suspendAttr.getContinuationArgIndex();
		}
		SkipMethodArgsAttr skipAttr = callee.get(AType.SKIP_MTH_ARGS);
		if (skipAttr != null) {
			for (int i = 0; i < callee.getMethodInfo().getArgsCount(); i++) {
				if (skipAttr.isSkip(i)) {
					return i;
				}
			}
		}
		return -1;
	}

	private static boolean isContinuationImplInvokeSuspend(MethodNode caller) {
		if (!"invokeSuspend".equals(caller.getName())) {
			return false;
		}
		MethodOverrideAttr overrideAttr = caller.get(AType.METHOD_OVERRIDE);
		if (overrideAttr != null) {
			for (IMethodDetails baseMth : overrideAttr.getBaseMethods()) {
				String declCls = baseMth.getMethodInfo().getDeclClass().getFullName();
				if (declCls.startsWith(CONTINUATION_IMPL_PKG)) {
					return true;
				}
			}
		}
		String superCls = caller.getParentClass().getSuperClass().getObject();
		return superCls != null && superCls.startsWith(CONTINUATION_IMPL_PKG);
	}

	@Nullable
	private static RegisterArg getRegisterArg(@Nullable InsnArg arg) {
		InsnArg current = arg;
		while (current != null) {
			if (current.isRegister()) {
				return (RegisterArg) current;
			}
			current = unwrapOneCast(current);
		}
		return null;
	}

	private static InsnArg unwrapCast(InsnArg arg) {
		InsnArg current = arg;
		InsnArg inner;
		while ((inner = unwrapOneCast(current)) != null) {
			current = inner;
		}
		return current;
	}

	@Nullable
	private static InsnArg unwrapOneCast(InsnArg arg) {
		if (arg.isInsnWrap()) {
			InsnNode wrapInsn = ((InsnWrapArg) arg).getWrapInsn();
			if (wrapInsn.getType() == InsnType.CHECK_CAST
					|| wrapInsn.getType() == InsnType.CAST
					|| wrapInsn.getType() == InsnType.MOVE) {
				return wrapInsn.getArg(0);
			}
		}
		return null;
	}
}
