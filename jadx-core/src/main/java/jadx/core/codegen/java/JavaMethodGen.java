package jadx.core.codegen.java;

import java.util.List;

import jadx.api.CommentsLevel;
import jadx.api.ICodeWriter;
import jadx.api.plugins.input.data.AccessFlags;
import jadx.api.plugins.input.data.annotations.EncodedValue;
import jadx.api.plugins.input.data.attributes.JadxAttrType;
import jadx.api.plugins.input.data.attributes.types.AnnotationMethodParamsAttr;
import jadx.core.Consts;
import jadx.core.codegen.AnnotationGen;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.common.ClassGenBase;
import jadx.core.codegen.common.MethodGenBase;
import jadx.core.codegen.utils.CodeGenUtils;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.SkipMethodArgsAttr;
import jadx.core.dex.info.AccessInfo;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.CodeVar;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.instructions.args.SSAVar;
import jadx.core.dex.nodes.MethodNode;
import jadx.api.metadata.annotations.VarNode;

public final class JavaMethodGen extends MethodGenBase {

	public JavaMethodGen(IClassGen classGen, MethodNode mth) {
		super(classGen, mth);
	}

	@Override
	public boolean addDefinition(ICodeWriter code) {
		MethodNode mth = getMethodNode();
		AnnotationGen annotationGen = getAnnotationGen();
		if (mth.getMethodInfo().isClassInit()) {
			code.startLine();
			code.attachDefinition(mth);
			code.add("static");
			return true;
		}
		if (mth.contains(AFlag.ANONYMOUS_CONSTRUCTOR)) {
			code.startLine();
			code.attachDefinition(mth);
			return false;
		}
		if (Consts.DEBUG_USAGE) {
			ClassGenBase.addMthUsageInfo(code, mth);
		}
		classGen.getLang().addOverride(this, code, mth);
		annotationGen.addForMethod(code, mth);

		AccessInfo clsAccFlags = mth.getParentClass().getAccessFlags();
		AccessInfo ai = mth.getAccessFlags();
		if (clsAccFlags.isInterface()) {
			ai = ai.remove(AccessFlags.ABSTRACT);
			ai = ai.remove(AccessFlags.PUBLIC);
		}
		if (clsAccFlags.isAnnotation()) {
			ai = ai.remove(AccessFlags.PUBLIC);
		}
		if (mth.getMethodInfo().hasAlias() && !ai.isConstructor()) {
			CodeGenUtils.addRenamedComment(code, mth, mth.getName());
		}
		if (mth.contains(AFlag.INCONSISTENT_CODE) && mth.checkCommentsLevel(CommentsLevel.ERROR)) {
			code.startLine("/*");
			code.incIndent();
			code.startLine("Code decompiled incorrectly, please refer to instructions dump.");
			if (!mth.root().getArgs().isShowInconsistentCode()) {
				if (code.isMetadataSupported()) {
					code.startLine("To view partially-correct code enable 'Show inconsistent code' option in preferences");
				} else {
					code.startLine("To view partially-correct add '--show-bad-code' argument");
				}
			}
			code.decIndent();
			code.startLine("*/");
		}

		code.startLineWithNum(mth.getSourceLine());
		code.add(ai.makeString(mth.checkCommentsLevel(CommentsLevel.INFO)));
		if (clsAccFlags.isInterface() && !mth.isNoCode() && !mth.getAccessFlags().isStatic()) {
			code.add("default ");
		}

		if (classGen.addGenericTypeParameters(code, mth.getTypeParameters(), false)) {
			code.add(' ');
		}
		if (ai.isConstructor()) {
			code.attachDefinition(mth);
			code.add(classGen.getClassNode().getShortName());
		} else {
			classGen.useType(code, mth.getReturnType());
			code.add(' ');
			MethodNode defMth = getMethodForDefinition();
			code.attachDefinition(defMth);
			code.add(defMth.getAlias());
		}
		code.add('(');
		addMethodArguments(code);
		code.add(')');

		classGen.getLang().addThrows(annotationGen, mth, code);

		if (mth.getParentClass().getAccessFlags().isAnnotation()) {
			EncodedValue def = annotationGen.getAnnotationDefaultValue(mth);
			if (def != null) {
				code.add(" default ");
				annotationGen.encodeValue(mth.root(), code, def);
			}
		}
		return true;
	}

	private void addMethodArguments(ICodeWriter code) {
		MethodNode mth = getMethodNode();
		List<RegisterArg> args = mth.getArgRegs();
		AnnotationMethodParamsAttr paramsAnnotation = mth.get(JadxAttrType.ANNOTATION_MTH_PARAMETERS);
		int argNum = -1;
		int lastArgNum = args.size() - 1;
		boolean first = true;
		for (RegisterArg mthArg : args) {
			argNum++;
			if (SkipMethodArgsAttr.isSkip(mth, argNum)) {
				continue;
			}
			if (first) {
				first = false;
			} else {
				code.add(", ");
			}
			SSAVar ssaVar = mthArg.getSVar();
			CodeVar var;
			if (ssaVar == null) {
				var = CodeVar.fromMthArg(mthArg, classGen.isFallbackMode());
			} else {
				var = ssaVar.getCodeVar();
			}

			if (paramsAnnotation != null) {
				getAnnotationGen().addForParameter(code, paramsAnnotation, argNum);
			}
			if (var.isFinal()) {
				code.add("final ");
			}
			ArgType argType;
			ArgType varType = var.getType();
			if (varType == null || varType == ArgType.UNKNOWN) {
				argType = mthArg.getInitType();
			} else {
				argType = varType;
			}
			if (argNum == lastArgNum && mth.getAccessFlags().isVarArgs()) {
				if (argType.isArray()) {
					ArgType elType = argType.getArrayElement();
					classGen.useType(code, elType);
					code.add("...");
				} else {
					mth.addWarnComment("Last argument in varargs method is not array: " + var);
					classGen.useType(code, argType);
				}
			} else {
				classGen.useType(code, argType);
			}
			code.add(' ');
			String varName = getNameGen().assignArg(var);
			if (code.isMetadataSupported() && ssaVar != null) {
				code.attachDefinition(VarNode.get(mth, var));
			}
			code.add(varName);
		}
	}
}
