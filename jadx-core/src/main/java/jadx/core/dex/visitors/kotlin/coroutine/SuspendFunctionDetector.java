package jadx.core.dex.visitors.kotlin.coroutine;

import java.util.List;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.nodes.SuspendFunctionAttr;
import jadx.core.dex.attributes.nodes.SuspendFunctionAttr.Source;
import jadx.core.dex.info.ClassInfo;
import jadx.core.dex.instructions.IndexInsnNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.utils.Utils;

/**
 * Detects Kotlin {@code suspend fun} from JVM signature (Continuation last param, Object return)
 * or method-entry continuation receiver cast when metadata is obfuscated.
 */
public final class SuspendFunctionDetector {

	private static final String CONTINUATION_CLASS = "kotlin.coroutines.Continuation";

	private SuspendFunctionDetector() {
	}

	public static @Nullable SuspendFunctionAttr detect(MethodNode mth) {
		ArgType retType = mth.getReturnType();
		if (!retType.isObject()) {
			return null;
		}
		List<ArgType> argTypes = mth.getArgTypes();
		if (argTypes.isEmpty()) {
			return null;
		}
		int contIdx = argTypes.size() - 1;
		ArgType contType = argTypes.get(contIdx);
		if (!contType.isObject()) {
			return null;
		}
		if (isContinuationArgType(mth, contType)) {
			return new SuspendFunctionAttr(contType, contIdx, Source.SIGNATURE);
		}
		if (hasContinuationEntryCast(mth)) {
			return new SuspendFunctionAttr(contType, contIdx, Source.ENTRY_CAST);
		}
		return null;
	}

	private static boolean isContinuationArgType(MethodNode mth, ArgType type) {
		String typeStr = type.toString();
		if (typeStr.contains("Continuation")) {
			return true;
		}
		if (!type.isObject()) {
			return false;
		}
		ClassInfo clsInfo = ClassInfo.fromName(mth.root(), type.getObject());
		ClassNode cls = mth.root().resolveClass(clsInfo);
		return cls != null && implementsContinuation(mth, cls);
	}

	private static boolean implementsContinuation(MethodNode mth, ClassNode cls) {
		for (ArgType iface : cls.getInterfaces()) {
			if (iface.isObject() && CONTINUATION_CLASS.equals(iface.getObject())) {
				return true;
			}
		}
		ArgType superType = cls.getSuperClass();
		if (superType == null || !superType.isObject()) {
			return false;
		}
		if (superType.getObject().startsWith("kotlin.coroutines.jvm.internal.")) {
			return true;
		}
		ClassNode parent = mth.root().resolveClass(ClassInfo.fromType(mth.root(), superType));
		return parent != null && implementsContinuation(mth, parent);
	}

	private static boolean hasContinuationEntryCast(MethodNode mth) {
		if (mth.isNoCode() || mth.getBasicBlocks().isEmpty()) {
			return false;
		}
		int blockLimit = 0;
		for (BlockNode block : mth.getBasicBlocks()) {
			if (blockLimit++ > 10) {
				break;
			}
			for (InsnNode insn : block.getInstructions()) {
				if (insn.getType() != InsnType.CHECK_CAST || !(insn instanceof IndexInsnNode)) {
					continue;
				}
				ArgType castType = ((IndexInsnNode) insn).getIndexAsType();
				if (castType.isObject() && !castType.getObject().startsWith("java.")) {
					return true;
				}
			}
		}
		return false;
	}

	public static @Nullable ArgType getContinuationArgType(MethodNode mth) {
		SuspendFunctionAttr attr = detect(mth);
		return attr != null ? attr.getContinuationArgType() : null;
	}

	public static int getContinuationArgIndex(MethodNode mth) {
		SuspendFunctionAttr attr = detect(mth);
		return attr != null ? attr.getContinuationArgIndex() : -1;
	}

	public static @Nullable ArgType lastArgType(MethodNode mth) {
		List<ArgType> args = mth.getArgTypes();
		return args.isEmpty() ? null : Utils.last(args);
	}
}
