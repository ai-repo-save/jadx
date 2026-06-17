package jadx.core.codegen.lang;

import jadx.api.ICodeWriter;
import jadx.api.plugins.input.data.AccessFlags;
import jadx.core.codegen.AnnotationGen;
import jadx.core.codegen.InsnGen;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.api.IMethodGen;
import jadx.core.dex.info.AccessInfo;
import jadx.core.dex.instructions.NewArrayNode;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.CodeVar;
import jadx.core.dex.instructions.args.InsnArg;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.utils.exceptions.CodegenException;

/**
 * Language-specific code generation policy and syntax emission.
 */
public interface CodeLanguage {

	boolean isKotlin();

	boolean preserveConstructorOrder();

	boolean allowConstructorTernaryInlining();

	String enumClassKeyword();

	String genericExtendsKeyword();

	boolean methodNeedsSemicolon();

	boolean fieldNeedsSemicolon();

	AccessInfo filterClassAccess(AccessInfo access);

	AccessInfo filterFieldAccess(AccessInfo access, boolean inCompanion);

	AccessInfo filterMethodAccess(AccessInfo access, boolean inCompanion, AccessInfo clsAccess);

	void addSupertypes(IClassGen classGen, ICodeWriter code, AccessInfo af, ArgType superClass, ClassNode cls);

	void emitFieldTypeAndName(IClassGen classGen, ICodeWriter code, FieldNode field, boolean isFinal);

	void useType(IClassGen classGen, ICodeWriter code, ArgType type);

	void declareVar(InsnGen insnGen, ICodeWriter code, CodeVar codeVar);

	void emitConstClass(InsnGen insnGen, ICodeWriter code, ArgType clsType);

	void emitCast(InsnGen insnGen, ICodeWriter code, InsnArg arg, ArgType type, boolean wrap) throws CodegenException;

	void emitInstanceOf(InsnGen insnGen, ICodeWriter code, InsnArg arg, ArgType type, boolean wrap) throws CodegenException;

	void emitNewArray(InsnGen insnGen, ICodeWriter code, NewArrayNode insn) throws CodegenException;

	void emitFilledNewArray(InsnGen insnGen, ICodeWriter code, InsnNode insn, boolean declareVar) throws CodegenException;

	String arrayLengthProperty();

	void emitConstructorNew(IClassGen classGen, ICodeWriter code);

	void emitAnonymousClassPrefix(ICodeWriter code);

	boolean shouldSkipAnnotation(String annotationClass);

	void addOverride(IMethodGen methodGen, ICodeWriter code, MethodNode mth);

	String getMethodModifierPrefix(MethodNode mth);

	void addThrows(AnnotationGen annotationGen, MethodNode mth, ICodeWriter code);

	static AccessInfo removeJavaOnlyFlags(AccessInfo access) {
		return access
				.remove(AccessFlags.PUBLIC)
				.remove(AccessFlags.FINAL)
				.remove(AccessFlags.STATIC)
				.remove(AccessFlags.ABSTRACT)
				.remove(AccessFlags.NATIVE)
				.remove(AccessFlags.SYNCHRONIZED)
				.remove(AccessFlags.VOLATILE)
				.remove(AccessFlags.TRANSIENT);
	}
}
