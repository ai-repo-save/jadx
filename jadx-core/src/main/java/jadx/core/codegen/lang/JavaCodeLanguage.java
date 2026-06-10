package jadx.core.codegen.lang;

import java.util.Iterator;

import jadx.api.ICodeWriter;
import jadx.core.Consts;
import jadx.core.codegen.AnnotationGen;
import jadx.core.codegen.ClassGen;
import jadx.core.codegen.InsnGen;
import jadx.core.codegen.MethodGen;
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

class JavaCodeLanguage implements CodeLanguage {

	@Override
	public boolean isKotlin() {
		return false;
	}

	@Override
	public boolean preserveConstructorOrder() {
		return false;
	}

	@Override
	public boolean allowConstructorTernaryInlining() {
		return true;
	}

	@Override
	public String enumClassKeyword() {
		return "enum ";
	}

	@Override
	public String genericExtendsKeyword() {
		return " extends ";
	}

	@Override
	public boolean usesKotlinClassBody() {
		return false;
	}

	@Override
	public boolean methodNeedsSemicolon() {
		return true;
	}

	@Override
	public boolean fieldNeedsSemicolon() {
		return true;
	}

	@Override
	public AccessInfo filterClassAccess(AccessInfo access) {
		return access;
	}

	@Override
	public AccessInfo filterFieldAccess(AccessInfo access, boolean inCompanion) {
		return access;
	}

	@Override
	public AccessInfo filterMethodAccess(AccessInfo access, boolean inCompanion, AccessInfo clsAccess) {
		return access;
	}

	@Override
	public void addSupertypes(ClassGen classGen, ICodeWriter code, AccessInfo af, ArgType sup, ClassNode cls) {
		if (sup != null
				&& !sup.equals(ArgType.OBJECT)
				&& !cls.contains(jadx.core.dex.attributes.AFlag.REMOVE_SUPER_CLASS)) {
			code.add("extends ");
			classGen.useClass(code, sup);
			code.add(' ');
		}

		if (!cls.getInterfaces().isEmpty() && !af.isAnnotation()) {
			if (cls.getAccessFlags().isInterface()) {
				code.add("extends ");
			} else {
				code.add("implements ");
			}
			for (Iterator<ArgType> it = cls.getInterfaces().iterator(); it.hasNext();) {
				ArgType interf = it.next();
				classGen.useClass(code, interf);
				if (it.hasNext()) {
					code.add(", ");
				}
			}
			if (!cls.getInterfaces().isEmpty()) {
				code.add(' ');
			}
		}
	}

	@Override
	public void emitFieldTypeAndName(ClassGen classGen, ICodeWriter code, FieldNode field, boolean isFinal) {
		classGen.useType(code, field.getType());
		code.add(' ');
		code.attachDefinition(field);
		code.add(field.getAlias());
	}

	@Override
	public void useType(ClassGen classGen, ICodeWriter code, ArgType type) {
		PrimitiveType stype = type.getPrimitiveType();
		if (stype == null) {
			code.add(type.toString());
		} else if (stype == PrimitiveType.OBJECT) {
			if (type.isGenericType()) {
				code.add(type.getObject());
			} else {
				classGen.useClass(code, type);
			}
		} else if (stype == PrimitiveType.ARRAY) {
			useType(classGen, code, type.getArrayElement());
			code.add("[]");
		} else {
			code.add(stype.getLongName());
		}
	}

	@Override
	public boolean addMethodDefinition(MethodGen methodGen, ICodeWriter code) {
		return methodGen.addJavaDefinition(code);
	}

	@Override
	public void declareVar(InsnGen insnGen, ICodeWriter code, CodeVar codeVar) {
		if (codeVar.isFinal()) {
			code.add("final ");
		}
		useType(insnGen.getClassGen(), code, codeVar.getType());
		code.add(' ');
		insnGen.defVar(code, codeVar);
	}

	@Override
	public void emitConstClass(InsnGen insnGen, ICodeWriter code, ArgType clsType) {
		useType(insnGen.getClassGen(), code, clsType);
		code.add(".class");
	}

	@Override
	public void emitCast(InsnGen insnGen, ICodeWriter code, InsnArg arg, ArgType type, boolean wrap) throws CodegenException {
		if (wrap) {
			code.add('(');
		}
		code.add('(');
		useType(insnGen.getClassGen(), code, type);
		code.add(") ");
		insnGen.addArg(code, arg, true);
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
		code.add(" instanceof ");
		useType(insnGen.getClassGen(), code, type);
		if (wrap) {
			code.add(')');
		}
	}

	@Override
	public void emitNewArray(InsnGen insnGen, ICodeWriter code, NewArrayNode insn) throws CodegenException {
		ArgType arrayType = insn.getArrayType();
		int argsCount = insn.getArgsCount();
		code.add("new ");
		useType(insnGen.getClassGen(), code, arrayType.getArrayRootElement());
		int k = 0;
		for (; k < argsCount; k++) {
			code.add('[');
			insnGen.addArg(code, insn.getArg(k), false);
			code.add(']');
		}
		int dim = arrayType.getArrayDimension();
		for (; k < dim; k++) {
			code.add("[]");
		}
	}

	@Override
	public String arrayLengthProperty() {
		return ".length";
	}

	@Override
	public void emitFilledNewArray(InsnGen insnGen, ICodeWriter code, InsnNode insn, boolean declareVar) throws CodegenException {
		FilledNewArrayNode filledInsn = (FilledNewArrayNode) insn;
		if (!declareVar) {
			code.add("new ");
			useType(insnGen.getClassGen(), code, filledInsn.getArrayType());
		}
		code.add('{');
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
		code.add('}');
	}

	@Override
	public void emitConstructorNew(ClassGen classGen, ICodeWriter code) {
		code.add("new ");
	}

	@Override
	public void emitAnonymousClassPrefix(ICodeWriter code) {
		code.add("new ");
	}

	@Override
	public boolean shouldSkipAnnotation(String annotationClass) {
		return Consts.OVERRIDE_ANNOTATION.equals(annotationClass);
	}

	@Override
	public void addOverride(MethodGen methodGen, ICodeWriter code, MethodNode mth) {
		MethodOverrideAttr overrideAttr = mth.get(AType.METHOD_OVERRIDE);
		if (overrideAttr == null) {
			return;
		}
		if (!overrideAttr.getBaseMethods().contains(mth)) {
			code.startLine("@Override");
			if (mth.checkCommentsLevel(jadx.api.CommentsLevel.INFO)) {
				code.add(" // ");
				code.add(Utils.listToString(overrideAttr.getOverrideList(), ", ",
						md -> md.getMethodInfo().getDeclClass().getAliasFullName()));
			}
		}
		if (Consts.DEBUG) {
			code.startLine("// related by override: ");
			code.add(Utils.listToString(overrideAttr.getRelatedMthNodes(), ", ", m -> m.getParentClass().getFullName()));
		}
	}

	@Override
	public String getMethodModifierPrefix(MethodNode mth) {
		return "";
	}

	@Override
	public void addThrows(AnnotationGen annotationGen, MethodNode mth, ICodeWriter code) {
		annotationGen.addThrows(mth, code);
	}

	protected void defVar(InsnGen insnGen, ICodeWriter code, CodeVar codeVar) {
		insnGen.defVar(code, codeVar);
	}
}
