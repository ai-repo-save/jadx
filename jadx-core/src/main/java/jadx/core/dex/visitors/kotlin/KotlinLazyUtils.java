package jadx.core.dex.visitors.kotlin;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.InvokeNode;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.instructions.args.InsnWrapArg;
import jadx.core.dex.instructions.mods.ConstructorInsn;
import jadx.core.dex.nodes.InsnNode;

/**
 * Helpers for Kotlin {@code lazy} delegate lowering.
 */
public final class KotlinLazyUtils {

	private KotlinLazyUtils() {
	}

	public static @Nullable InsnArg extractDelegateInitializerArg(InsnNode insn) {
		InsnNode ctorInsn = unwrapInitInsn(insn);
		if (ctorInsn == null) {
			return null;
		}
		if (ctorInsn.getType() == InsnType.CONSTRUCTOR && ctorInsn instanceof ConstructorInsn) {
			ConstructorInsn ctrInsn = (ConstructorInsn) ctorInsn;
			if (ctrInsn.getArgsCount() != 1) {
				return null;
			}
			return ctrInsn.getArg(0);
		}
		if (ctorInsn.getType() == InsnType.INVOKE && ctorInsn instanceof InvokeNode) {
			InvokeNode invoke = (InvokeNode) ctorInsn;
			if (!invoke.getCallMth().isConstructor() || invoke.getArgsCount() != 2) {
				return null;
			}
			return invoke.getArg(1);
		}
		return null;
	}

	static @Nullable InsnNode unwrapInitInsn(InsnNode insn) {
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
