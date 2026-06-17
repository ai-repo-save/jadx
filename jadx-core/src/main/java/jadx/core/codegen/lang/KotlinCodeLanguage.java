package jadx.core.codegen.lang;

import jadx.api.ICodeWriter;
import jadx.api.plugins.input.data.AccessFlags;
import jadx.core.Consts;
import jadx.core.codegen.AnnotationGen;
import jadx.core.codegen.ClassGen;
import jadx.core.codegen.InsnGen;
import jadx.core.codegen.MethodGen;
import jadx.core.codegen.kotlin.KotlinTypeGen;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.MethodOverrideAttr;
import jadx.core.dex.info.AccessInfo;
import jadx.core.dex.instructions.FilledNewArrayNode;
import jadx.core.dex.instructions.NewArrayNode;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.CodeVar;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.instructions.args.PrimitiveType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.utils.Utils;
import jadx.core.utils.exceptions.CodegenException;

class KotlinCodeLanguage implements CodeLanguage {

	private static final String KOTLIN_METADATA_ANNOTATION = "Lkotlin/Metadata;";

	@Override
	public boolean isKotlin() {
		return true;
	}

	@Override
	public boolean preserveConstructorOrder() {
		return true;
	}

	@Override
	public boolean allowConstructorTernaryInlining() {
		return false;
	}

	@Override
	public String enumClassKeyword() {
		return "enum class ";
	}

	@Override
	public String genericExtendsKeyword() {
		return " : ";
	}

	@Override
	public boolean usesKotlinClassBody() {
		return true;
	}

	@Override
	public boolean methodNeedsSemicolon() {
		return false;
	}

	@Override
	public boolean fieldNeedsSemicolon() {
		return false;
	}

	@Override
	public AccessInfo filterClassAccess(AccessInfo access) {
		AccessInfo filtered = CodeLanguage.removeJavaOnlyFlags(access);
		if (access.isData()) {
			filtered = filtered.remove(AccessFlags.DATA);
		}
		return filtered;
	}

	@Override
	public AccessInfo filterFieldAccess(AccessInfo access, boolean inCompanion) {
		AccessInfo filtered = CodeLanguage.removeJavaOnlyFlags(access);
		if (inCompanion) {
			filtered = filtered.remove(AccessFlags.STATIC);
		}
		return filtered;
	}

	@Override
	public AccessInfo filterMethodAccess(AccessInfo access, boolean inCompanion, AccessInfo clsAccess) {
		AccessInfo filtered = CodeLanguage.removeJavaOnlyFlags(access);
		if (inCompanion) {
			filtered = filtered.remove(AccessFlags.STATIC);
		}
		if (clsAccess.isInterface()) {
			filtered = filtered.remove(AccessFlags.ABSTRACT).remove(AccessFlags.PUBLIC);
		}
		if (clsAccess.isAnnotation()) {
			filtered = filtered.remove(AccessFlags.PUBLIC);
		}
		return filtered;
	}

	@Override
	public void addSupertypes(ClassGen classGen, ICodeWriter code, AccessInfo af, ArgType sup, ClassNode cls) {
		boolean first = true;
		if (sup != null
				&& !sup.equals(ArgType.OBJECT)
				&& !cls.contains(jadx.core.dex.attributes.AFlag.REMOVE_SUPER_CLASS)
				&& !af.isInterface()
				&& !af.isEnum()) {
			code.add(": ");
			classGen.useClass(code, sup);
			first = false;
		}
		if (!cls.getInterfaces().isEmpty() && !af.isAnnotation()) {
			for (ArgType interf : cls.getInterfaces()) {
				if (first) {
					code.add(": ");
					first = false;
				} else {
					code.add(", ");
				}
				classGen.useClass(code, interf);
			}
			if (!first) {
				code.add(' ');
			}
		}
	}

	@Override
	public void emitFieldTypeAndName(ClassGen classGen, ICodeWriter code, FieldNode field, boolean isFinal) {
		code.add(isFinal ? "val " : "var ");
		code.attachDefinition(field);
		code.add(field.getAlias());
		code.add(": ");
		useType(classGen, code, field.getType());
	}

	@Override
	public void useType(ClassGen classGen, ICodeWriter code, ArgType type) {
		if (isJavaLangObject(type)) {
			code.add("Any");
			return;
		}
		KotlinTypeGen.useType(classGen, code, type);
	}

	@Override
	public boolean addMethodDefinition(MethodGen methodGen, ICodeWriter code) {
		return methodGen.addKotlinDefinition(code);
	}

	@Override
	public void declareVar(InsnGen insnGen, ICodeWriter code, CodeVar codeVar) {
		code.add(codeVar.isFinal() ? "val " : "var ");
		insnGen.defVar(code, codeVar);
		code.add(": ");
		useType(insnGen.getClassGen(), code, codeVar.getType());
	}

	@Override
	public void emitConstClass(InsnGen insnGen, ICodeWriter code, ArgType clsType) {
		KotlinTypeGen.useClassLiteral(insnGen.getClassGen(), code, clsType);
	}

	@Override
	public void emitCast(InsnGen insnGen, ICodeWriter code, InsnArg arg, ArgType type, boolean wrap) throws CodegenException {
		if (wrap) {
			code.add('(');
		}
		insnGen.addArg(code, arg, true);
		code.add(" as ");
		useType(insnGen.getClassGen(), code, type);
		if (wrap) {
			code.add(')');
		}
	}

	@Override
	public void emitInstanceOf(InsnGen insnGen, ICodeWriter code, InsnArg arg, ArgType type, boolean wrap) throws CodegenException {
		if (wrap) {
			code.add('(');
		}
		insnGen.addArg(code, arg);
		code.add(" is ");
		useType(insnGen.getClassGen(), code, type);
		if (wrap) {
			code.add(')');
		}
	}

	@Override
	public void emitNewArray(InsnGen insnGen, ICodeWriter code, NewArrayNode insn) throws CodegenException {
		ArgType arrayType = insn.getArrayType();
		int argsCount = insn.getArgsCount();
		KotlinTypeGen.emitNewArray(insnGen.getClassGen(), code, arrayType, argsCount);
		for (int k = 0; k < argsCount; k++) {
			if (k != 0) {
				code.add(", ");
			}
			insnGen.addArg(code, insn.getArg(k), false);
		}
		code.add(')');
	}

	@Override
	public String arrayLengthProperty() {
		return ".size";
	}

	@Override
	public void emitFilledNewArray(InsnGen insnGen, ICodeWriter code, InsnNode insn, boolean declareVar) throws CodegenException {
		FilledNewArrayNode filledInsn = (FilledNewArrayNode) insn;
		if (!declareVar) {
			KotlinTypeGen.emitFilledArrayPrefix(code, filledInsn.getArrayType());
		}
		code.add('(');
		int c = insn.getArgsCount();
		int wrap = 0;
		for (int i = 0; i < c; i++) {
			insnGen.addArg(code, insn.getArg(i), false);
			if (i + 1 < c) {
				code.add(", ");
			}
			wrap++;
			if (wrap == 1000) {
				code.startLine();
				wrap = 0;
			}
		}
		code.add(')');
	}

	@Override
	public void emitConstructorNew(ClassGen classGen, ICodeWriter code) {
		// Kotlin omits `new` for constructor calls
	}

	@Override
	public void emitAnonymousClassPrefix(ICodeWriter code) {
		code.add("object : ");
	}

	@Override
	public boolean shouldSkipAnnotation(String annotationClass) {
		return Consts.OVERRIDE_ANNOTATION.equals(annotationClass)
				|| KOTLIN_METADATA_ANNOTATION.equals(annotationClass);
	}

	@Override
	public void addOverride(MethodGen methodGen, ICodeWriter code, MethodNode mth) {
		MethodOverrideAttr overrideAttr = mth.get(AType.METHOD_OVERRIDE);
		if (overrideAttr == null || overrideAttr.getBaseMethods().contains(mth)) {
			return;
		}
		if (Consts.DEBUG) {
			code.startLine("// related by override: ");
			code.add(Utils.listToString(overrideAttr.getRelatedMthNodes(), ", ", m -> m.getParentClass().getFullName()));
		}
	}

	@Override
	public void addThrows(AnnotationGen annotationGen, MethodNode mth, ICodeWriter code) {
		// Kotlin does not use checked exception declarations
	}

	@Override
	public String getMethodModifierPrefix(MethodNode mth) {
		return isMethodOverride(mth) ? "override " : "";
	}

	private boolean isMethodOverride(MethodNode mth) {
		MethodOverrideAttr overrideAttr = mth.get(AType.METHOD_OVERRIDE);
		return overrideAttr != null && !overrideAttr.getBaseMethods().contains(mth);
	}

	private static boolean isJavaLangObject(ArgType type) {
		if (type == null) {
			return false;
		}
		if (type.equals(ArgType.OBJECT)) {
			return true;
		}
		PrimitiveType stype = type.getPrimitiveType();
		return stype == PrimitiveType.OBJECT && !type.isGenericType() && "java.lang.Object".equals(type.getObject());
	}
}
