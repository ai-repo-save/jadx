package jadx.core.codegen.kotlin;

import org.jetbrains.annotations.Nullable;

import jadx.api.ICodeWriter;
import jadx.core.codegen.ClassGen;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.PrimitiveType;
import jadx.core.dex.nodes.ClassNode;

public final class KotlinTypeGen {

	private KotlinTypeGen() {
	}

	public static boolean isVoid(ArgType type) {
		return type == ArgType.VOID || type.equals(ArgType.VOID);
	}

	public static void useType(ClassGen classGen, ICodeWriter code, ArgType type) {
		PrimitiveType stype = type.getPrimitiveType();
		if (stype == null) {
			code.add(type.toString());
			return;
		}
		if (stype == PrimitiveType.OBJECT) {
			if (type.isGenericType()) {
				code.add(type.getObject());
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

	public static void useClassLiteral(ClassGen classGen, ICodeWriter code, ArgType clsType) {
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

	public static void emitNewArray(ClassGen classGen, ICodeWriter code, ArgType arrayType, int explicitDims) {
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
}
