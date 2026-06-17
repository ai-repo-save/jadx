package jadx.core.codegen.kotlin;

import org.jetbrains.annotations.Nullable;

import jadx.api.ICodeWriter;
import jadx.api.plugins.input.data.AccessFlags;
import jadx.api.plugins.input.data.attributes.JadxAttrType;
import jadx.api.plugins.input.data.attributes.types.InnerClassesAttr;
import jadx.api.plugins.input.data.attributes.types.InnerClsInfo;
import jadx.core.codegen.api.IClassGen;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.FieldReplaceAttr;
import jadx.core.dex.info.ClassInfo;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.PrimitiveType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.MethodNode;

public final class KotlinTypeGen {

	private KotlinTypeGen() {
	}

	public static boolean isVoid(ArgType type) {
		return type == ArgType.VOID || type.equals(ArgType.VOID);
	}

	public static void useType(IClassGen classGen, ICodeWriter code, ArgType type) {
		PrimitiveType stype = type.getPrimitiveType();
		if (stype == null) {
			code.add(type.toString());
			return;
		}
		if (stype == PrimitiveType.OBJECT) {
			if (type.isGenericType()) {
				code.add(type.getObject());
			} else if (type.equals(ArgType.OBJECT) || "java.lang.Object".equals(type.getObject())) {
				code.add("Any");
			} else {
				classGen.useClass(code, type);
			}
			return;
		}
		if (stype == PrimitiveType.ARRAY) {
			useType(classGen, code, type.getArrayElement());
			code.add("Array");
			return;
		}
		code.add(kotlinPrimitiveName(stype));
	}

	@Nullable
	public static String kotlinPrimitiveName(PrimitiveType stype) {
		switch (stype) {
			case BOOLEAN:
				return "Boolean";
			case CHAR:
				return "Char";
			case BYTE:
				return "Byte";
			case SHORT:
				return "Short";
			case INT:
				return "Int";
			case LONG:
				return "Long";
			case FLOAT:
				return "Float";
			case DOUBLE:
				return "Double";
			default:
				return null;
		}
	}

	@Nullable
	public static String kotlinPrimitiveArrayType(ArgType arrayType) {
		if (arrayType.getArrayDimension() != 1) {
			return null;
		}
		PrimitiveType el = arrayType.getArrayRootElement().getPrimitiveType();
		if (el == null || el == PrimitiveType.OBJECT || el == PrimitiveType.ARRAY) {
			return null;
		}
		String name = kotlinPrimitiveName(el);
		return name == null ? null : name + "Array";
	}

	public static void useClassLiteral(IClassGen classGen, ICodeWriter code, ArgType clsType) {
		classGen.useType(code, clsType);
		code.add("::class.java");
	}

	public static void emitFilledArrayPrefix(ICodeWriter code, ArgType arrayType) {
		String primArray = kotlinPrimitiveArrayType(arrayType);
		if (primArray != null) {
			String el = primArray.substring(0, primArray.length() - "Array".length());
			code.add(Character.toLowerCase(el.charAt(0)) + el.substring(1) + "ArrayOf");
			return;
		}
		code.add("arrayOf");
	}

	public static void emitNewArray(IClassGen classGen, ICodeWriter code, ArgType arrayType, int explicitDims) {
		String primitiveArray = kotlinPrimitiveArrayType(ArgType.array(arrayType.getArrayRootElement(), explicitDims));
		if (primitiveArray != null && explicitDims == arrayType.getArrayDimension()) {
			code.add(primitiveArray).add('(');
			return;
		}
		if (arrayType.getArrayDimension() == 1 && arrayType.getArrayElement().getPrimitiveType() == PrimitiveType.OBJECT) {
			code.add("arrayOfNulls<");
			classGen.useType(code, arrayType.getArrayElement());
			code.add(">(");
			return;
		}
		code.add("Array<");
		useType(classGen, code, arrayType);
		code.add(">(");
	}

	public static boolean isKotlinCompanionClass(ClassNode cls) {
		return "Companion".equals(cls.getClassInfo().getAliasShortName());
	}

	/**
	 * Kotlin {@code inner class} holds a reference to the outer instance (non-static nested class).
	 */
	public static boolean isKotlinInnerClass(ClassNode cls) {
		if (!cls.isInner() || cls.contains(AType.ANONYMOUS_CLASS)) {
			return false;
		}
		if (isKotlinCompanionClass(cls) || cls.getAccessFlags().isObject()) {
			return false;
		}
		if (cls.getAccessFlags().isStatic()) {
			return false;
		}
		ClassNode parent = cls.getParentClass();
		if (parent == null) {
			return false;
		}
		InnerClassesAttr innerClassesAttr = parent.get(JadxAttrType.INNER_CLASSES);
		if (innerClassesAttr != null) {
			InnerClsInfo innerClsInfo = innerClassesAttr.getMap().get(cls.getClassInfo().makeRawFullName());
			if (innerClsInfo != null && (innerClsInfo.getAccessFlags() & AccessFlags.STATIC) != 0) {
				return false;
			}
		}
		ClassInfo parentClass = parent.getClassInfo();
		if (hasOuterInstanceBinding(cls, parentClass)) {
			return true;
		}
		for (MethodNode mth : cls.getMethods()) {
			if (mth.isConstructor() && mth.contains(AFlag.SKIP_FIRST_ARG)) {
				return true;
			}
		}
		return false;
	}

	private static boolean hasOuterInstanceBinding(ClassNode cls, ClassInfo parentClass) {
		for (FieldNode field : cls.getFields()) {
			FieldReplaceAttr replace = field.get(AType.FIELD_REPLACE);
			if (replace != null
					&& replace.getReplaceType() == FieldReplaceAttr.ReplaceWith.CLASS_INSTANCE
					&& parentClass.equals(replace.getClsRef())) {
				return true;
			}
			if (field.getAccessFlags().isSynthetic() && field.getName().startsWith("this$")) {
				ArgType type = field.getType();
				if (type.isObject() && parentClass.getFullName().equals(type.getObject())) {
					return true;
				}
			}
		}
		return false;
	}
}
