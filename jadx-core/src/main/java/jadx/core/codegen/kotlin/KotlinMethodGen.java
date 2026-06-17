package jadx.core.codegen.kotlin;

import java.util.List;

import jadx.api.CommentsLevel;
import jadx.api.ICodeWriter;
import jadx.api.plugins.input.data.AccessFlags;
import jadx.api.plugins.input.data.annotations.EncodedValue;
import jadx.api.plugins.input.data.attributes.JadxAttrType;
import jadx.api.plugins.input.data.attributes.types.AnnotationMethodParamsAttr;
import jadx.core.Consts;
import jadx.core.codegen.AnnotationGen;
import jadx.core.codegen.InsnGen;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.common.ClassGenBase;
import jadx.core.codegen.common.CodeGenFactory;
import jadx.core.codegen.common.MethodGenBase;
import jadx.core.codegen.lang.CodeLanguage;
import jadx.core.codegen.utils.CodeGenUtils;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.MethodDefaultParamsAttr;
import jadx.core.dex.attributes.nodes.SkipMethodArgsAttr;
import jadx.core.dex.attributes.nodes.SuspendFunctionAttr;
import jadx.core.dex.info.AccessInfo;
import jadx.core.dex.info.FieldInfo;
import jadx.core.dex.instructions.IndexInsnNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.CodeVar;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.instructions.args.SSAVar;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.api.metadata.annotations.VarNode;
import jadx.core.utils.exceptions.CodegenException;

public final class KotlinMethodGen extends MethodGenBase {

	public KotlinMethodGen(IClassGen classGen, MethodNode mth) {
		super(classGen, mth);
	}

	@Override
	public boolean addDefinition(ICodeWriter code) {
		MethodNode mth = getMethodNode();
		AnnotationGen annotationGen = getAnnotationGen();
		if (mth.getMethodInfo().isClassInit()) {
			code.startLine();
			code.attachDefinition(mth);
			code.add("init");
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
		CodeLanguage lang = classGen.getLang();
		AccessInfo ai = lang.filterMethodAccess(mth.getAccessFlags(), classGen.isInCompanionContext(), clsAccFlags);
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
		if (!ai.isConstructor() || classGen.isInCompanionContext()) {
			code.add(lang.getMethodModifierPrefix(mth));
			code.add(ai.makeString(mth.checkCommentsLevel(CommentsLevel.INFO)));
		}

		if (classGen.addGenericTypeParameters(code, mth.getTypeParameters(), false)) {
			code.add(' ');
		}
		if (ai.isConstructor()) {
			code.attachDefinition(mth);
			code.add("constructor");
		} else {
			code.add("fun ");
			MethodNode defMth = getMethodForDefinition();
			code.attachDefinition(defMth);
			code.add(defMth.getAlias());
		}
		code.add('(');
		addKotlinMethodArguments(code);
		code.add(')');
		if (!ai.isConstructor()) {
			ArgType retType = mth.getReturnType();
			SuspendFunctionAttr suspendAttr = mth.get(AType.SUSPEND_FUNCTION);
			if (suspendAttr != null && retType.isObject() && retType.equals(ArgType.OBJECT)) {
				// JVM suspend bridge returns java.lang.Object
			} else if (!KotlinTypeGen.isVoid(retType)) {
				code.add(": ");
				classGen.useType(code, retType);
			}
		}

		lang.addThrows(annotationGen, mth, code);

		if (mth.getParentClass().getAccessFlags().isAnnotation()) {
			EncodedValue def = annotationGen.getAnnotationDefaultValue(mth);
			if (def != null) {
				code.add(" = ");
				annotationGen.encodeValue(mth.root(), code, def);
			}
		}
		return true;
	}

	private void addKotlinMethodArguments(ICodeWriter code) {
		MethodNode mth = getMethodNode();
		List<RegisterArg> args = mth.getArgRegs();
		AnnotationMethodParamsAttr paramsAnnotation = mth.get(JadxAttrType.ANNOTATION_MTH_PARAMETERS);
		int argNum = -1;
		int paramIdx = -1;
		int lastArgNum = args.size() - 1;
		boolean first = true;
		for (RegisterArg mthArg : args) {
			argNum++;
			if (SkipMethodArgsAttr.isSkip(mth, argNum)) {
				continue;
			}
			paramIdx++;
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
			ArgType argType;
			ArgType varType = var.getType();
			if (varType == null || varType == ArgType.UNKNOWN) {
				argType = mthArg.getInitType();
			} else {
				argType = varType;
			}
			String varName = getNameGen().assignArg(var);
			if (code.isMetadataSupported() && ssaVar != null) {
				code.attachDefinition(VarNode.get(mth, var));
			}
			code.add(varName);
			code.add(": ");
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
			MethodDefaultParamsAttr defaultParams = mth.get(AType.METHOD_DEFAULT_PARAMS);
			if (defaultParams != null) {
				MethodDefaultParamsAttr.DefaultValue defaultValue = defaultParams.getDefault(paramIdx);
				if (defaultValue != null) {
					code.add(" = ");
					try {
						if (!emitKotlinFieldReadDefault(code, defaultValue.getValueInsn())) {
							InsnGen insnGen = new InsnGen(
									CodeGenFactory.createMethodGen(classGen, defaultValue.getSourceMth()), false);
							insnGen.makeInsn(defaultValue.getValueInsn(), code, InsnGen.Flags.INLINE);
						}
					} catch (CodegenException e) {
						code.add("/* default */");
					}
				}
			}
		}
	}

	private boolean emitKotlinFieldReadDefault(ICodeWriter code, InsnNode valueInsn) {
		MethodNode mth = getMethodNode();
		if (valueInsn.getType() != InsnType.IGET) {
			return false;
		}
		Object index = ((IndexInsnNode) valueInsn).getIndex();
		if (!(index instanceof FieldInfo)) {
			return false;
		}
		FieldInfo fieldInfo = (FieldInfo) index;
		if (!fieldInfo.getDeclClass().equals(mth.getParentClass().getClassInfo())) {
			return false;
		}
		code.add("this.");
		code.add(fieldInfo.getAlias());
		return true;
	}
}
