package jadx.core.codegen.kotlin;

import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.jetbrains.annotations.Nullable;

import jadx.api.CommentsLevel;
import jadx.api.ICodeWriter;
import jadx.api.JadxArgs;
import jadx.api.args.IntegerFormat;
import jadx.api.metadata.annotations.NodeEnd;
import jadx.core.codegen.InsnGen;
import jadx.core.codegen.common.CodeGenFactory;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.api.IMethodGen;
import jadx.core.codegen.common.ClassGenBase;
import jadx.core.codegen.common.CodeGenFactory;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.KotlinDataClassAttr;
import jadx.core.dex.attributes.nodes.LineAttrNode;
import jadx.core.dex.attributes.nodes.MethodDefaultParamsAttr;
import jadx.core.dex.attributes.nodes.SkipMethodArgsAttr;
import jadx.core.dex.info.AccessInfo;
import jadx.core.dex.info.FieldInfo;
import jadx.core.dex.instructions.IndexInsnNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.utils.exceptions.CodegenException;

public final class KotlinClassGen extends ClassGenBase {

	private boolean companionContext;

	public KotlinClassGen(ClassNode cls, JadxArgs args) {
		super(cls, args);
	}

	public KotlinClassGen(ClassNode cls, IClassGen parent) {
		super(cls, parent);
	}

	public KotlinClassGen(ClassNode cls, IClassGen parent, boolean useImports, boolean fallback,
			boolean showBadCode, IntegerFormat integerFormat) {
		super(cls, (ClassGenBase) parent, useImports, fallback, showBadCode, integerFormat);
	}

	@Override
	public boolean isInCompanionContext() {
		return companionContext;
	}

	@Override
	protected void emitClassDeclaration(ICodeWriter clsCode) {
		AccessInfo[] afHolder = new AccessInfo[1];
		emitCommonClassDeclarationPrefix(clsCode, afHolder);
		AccessInfo af = afHolder[0];
		boolean isDataClass = cls.getAccessFlags().isData();
		boolean isKotlinObject = cls.getAccessFlags().isObject();
		if (af.isInterface()) {
			if (af.isAnnotation()) {
				clsCode.add('@');
			}
			clsCode.add("interface ");
		} else if (af.isEnum()) {
			clsCode.add(lang.enumClassKeyword());
		} else if (isKotlinObject) {
			clsCode.add("object ");
		} else {
			if (isDataClass) {
				clsCode.add("data ");
			}
			if (KotlinTypeGen.isKotlinInnerClass(cls)) {
				clsCode.add("inner ");
			}
			clsCode.add("class ");
		}
		clsCode.attachDefinition(cls);
		clsCode.add(cls.getClassInfo().getAliasShortName());
		if (isDataClass) {
			addDataClassPrimaryConstructor(clsCode);
		}
		emitClassDeclarationSuffix(clsCode, af);
	}

	@Override
	protected void emitClassBody(ICodeWriter clsCode, boolean printClassName) throws CodegenException {

		clsCode.add('{');
		if (printClassName && cls.checkCommentsLevel(CommentsLevel.INFO)) {
			clsCode.add(" // from class: " + cls.getClassInfo().getFullName());
		}
		setBodyGenStarted(true);
		clsDeclOffset = clsCode.getLength();
		clsCode.incIndent();
		emitKotlinClassBody(clsCode, printClassName);
		clsCode.decIndent();
		clsCode.startLine('}');
		clsCode.attachAnnotation(NodeEnd.VALUE);
	}

	private void emitKotlinClassBody(ICodeWriter clsCode, boolean printClassName) throws CodegenException {
		addEnumFields(clsCode);
		for (FieldNode f : cls.getFields()) {
			if (!f.getAccessFlags().isStatic() && !isDataClassPrimaryField(f)) {
				addField(clsCode, f);
			}
		}
		addInstanceMembers(clsCode);
		addCompanion(clsCode);
	}

	private void addInstanceMembers(ICodeWriter clsCode) {
		ClassNode companionCls = findCompanionClass();
		Stream.of(cls.getInnerClasses(), cls.getMethods())
				.flatMap(Collection::stream)
				.filter(node -> !skipNode(node))
				.filter(node -> !(node instanceof ClassNode) || node != companionCls)
				.filter(node -> !(node instanceof MethodNode) || isInstanceMethod((MethodNode) node))
				.sorted(Comparator.comparingInt(LineAttrNode::getSourceLine))
				.forEach(node -> {
					if (node instanceof ClassNode) {
						addInnerClass(clsCode, (ClassNode) node);
					} else {
						addMethod(clsCode, (MethodNode) node);
					}
				});
	}

	private boolean isInstanceMethod(MethodNode mth) {
		if (mth.getMethodInfo().isClassInit()) {
			return false;
		}
		return !mth.getAccessFlags().isStatic();
	}

	private boolean isDataClassPrimaryField(FieldNode field) {
		KotlinDataClassAttr dataClassAttr = cls.get(AType.KOTLIN_DATA_CLASS);
		return dataClassAttr != null && dataClassAttr.isPrimaryCtorField(field);
	}

	private void addDataClassPrimaryConstructor(ICodeWriter code) {
		KotlinDataClassAttr dataClassAttr = cls.get(AType.KOTLIN_DATA_CLASS);
		if (dataClassAttr == null) {
			return;
		}
		MethodNode ctor = dataClassAttr.getPrimaryConstructor();
		List<FieldNode> ctorFields = dataClassAttr.getPrimaryCtorFields();
		if (ctorFields.isEmpty()) {
			return;
		}
		MethodDefaultParamsAttr defaultParams = ctor.get(AType.METHOD_DEFAULT_PARAMS);
		List<RegisterArg> args = ctor.getArgRegs();
		code.add('(');
		boolean first = true;
		int fieldIdx = 0;
		int paramIdx = -1;
		for (int argNum = 0; argNum < args.size(); argNum++) {
			if (SkipMethodArgsAttr.isSkip(ctor, argNum)) {
				continue;
			}
			paramIdx++;
			if (fieldIdx >= ctorFields.size()) {
				break;
			}
			FieldNode field = ctorFields.get(fieldIdx++);
			if (!first) {
				code.add(", ");
			} else {
				first = false;
			}
			code.add("val ");
			code.attachDefinition(field);
			code.add(field.getAlias());
			code.add(": ");
			useType(code, field.getType());
			if (defaultParams != null) {
				MethodDefaultParamsAttr.DefaultValue defaultValue = defaultParams.getDefault(paramIdx);
				if (defaultValue != null) {
					code.add(" = ");
					emitDefaultParamValue(code, ctor, defaultValue);
				}
			}
		}
		code.add(')');
	}

	private void emitDefaultParamValue(ICodeWriter code, MethodNode ctor, MethodDefaultParamsAttr.DefaultValue defaultValue) {
		InsnNode valueInsn = defaultValue.getValueInsn();
		if (valueInsn.getType() == InsnType.IGET) {
			Object index = ((IndexInsnNode) valueInsn).getIndex();
			if (index instanceof FieldInfo) {
				FieldInfo fieldInfo = (FieldInfo) index;
				if (fieldInfo.getDeclClass().equals(cls.getClassInfo())) {
					code.add("this.");
					code.add(fieldInfo.getAlias());
					return;
				}
			}
		}
		try {
			InsnGen insnGen = new InsnGen(CodeGenFactory.createMethodGen(this, defaultValue.getSourceMth()), false);
			insnGen.makeInsn(valueInsn, code, InsnGen.Flags.INLINE);
		} catch (CodegenException e) {
			code.add("/* default */");
		}
	}

	private void addCompanion(ICodeWriter clsCode) throws CodegenException {
		if (cls.getAccessFlags().isObject()) {
			return;
		}
		ClassNode companionCls = findCompanionClass();
		boolean hasOuterStaticFields = cls.getFields().stream()
				.anyMatch(f -> !skipNode(f) && f.getAccessFlags().isStatic() && !isCompanionRefField(f, companionCls));
		boolean hasOuterStaticMethods = cls.getMethods().stream()
				.anyMatch(m -> !skipNode(m) && isCompanionStaticMethod(m));
		boolean hasCompanionMembers = companionCls != null && hasCompanionInnerMembers(companionCls);
		if (!hasOuterStaticFields && !hasOuterStaticMethods && !hasCompanionMembers) {
			return;
		}
		if (clsCode.getLength() != clsDeclOffset) {
			clsCode.newLine();
		}
		clsCode.startLine("companion object {");
		clsCode.incIndent();
		companionContext = true;
		for (FieldNode f : cls.getFields()) {
			if (f.getAccessFlags().isStatic() && !isCompanionRefField(f, companionCls) && !skipNode(f)) {
				addField(clsCode, f);
			}
		}
		if (companionCls != null) {
			for (FieldNode f : companionCls.getFields()) {
				if (!f.getAccessFlags().isStatic() && !skipNode(f)) {
					addField(clsCode, f);
				}
			}
		}
		Stream<MethodNode> outerStaticMethods = cls.getMethods().stream()
				.filter(m -> !skipNode(m))
				.filter(this::isCompanionStaticMethod);
		Stream<MethodNode> companionMethods = companionCls == null ? Stream.empty()
				: companionCls.getMethods().stream()
						.filter(m -> !skipNode(m))
						.filter(m -> !m.isConstructor());
		Stream.concat(outerStaticMethods, companionMethods)
				.sorted(Comparator.comparingInt(LineAttrNode::getSourceLine))
				.forEach(m -> addMethod(clsCode, m));
		companionContext = false;
		clsCode.decIndent();
		clsCode.startLine("}");
	}

	@Nullable
	private ClassNode findCompanionClass() {
		for (ClassNode innerCls : cls.getInnerClasses()) {
			if (KotlinTypeGen.isKotlinCompanionClass(innerCls)) {
				return innerCls;
			}
			if ("Companion".equals(innerCls.getClassInfo().getShortName()) && isCompanionRefFieldExists(innerCls)) {
				return innerCls;
			}
		}
		return null;
	}

	private boolean isCompanionRefFieldExists(ClassNode companionCls) {
		String companionType = companionCls.getClassInfo().makeRawFullName();
		for (FieldNode field : cls.getFields()) {
			if (field.getAccessFlags().isStatic()
					&& field.getType().isObject()
					&& companionType.equals(field.getType().getObject())) {
				return true;
			}
		}
		return false;
	}

	private boolean isCompanionRefField(FieldNode field, @Nullable ClassNode companionCls) {
		if (companionCls == null || !field.getAccessFlags().isStatic()) {
			return false;
		}
		return field.getType().isObject()
				&& companionCls.getClassInfo().makeRawFullName().equals(field.getType().getObject());
	}

	private boolean hasCompanionInnerMembers(ClassNode companionCls) {
		for (FieldNode field : companionCls.getFields()) {
			if (!skipNode(field) && !field.getAccessFlags().isStatic()) {
				return true;
			}
		}
		for (MethodNode mth : companionCls.getMethods()) {
			if (!skipNode(mth) && !mth.isConstructor()) {
				return true;
			}
		}
		return false;
	}

	private boolean isCompanionStaticMethod(MethodNode mth) {
		if (mth.getMethodInfo().isClassInit() || !mth.getAccessFlags().isStatic()) {
			return false;
		}
		return !mth.getAccessFlags().isSynthetic() || !mth.getName().startsWith("access$");
	}
}
