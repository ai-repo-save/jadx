package jadx.core.codegen.api;

import java.util.List;
import java.util.Set;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import jadx.api.ICodeInfo;
import jadx.api.ICodeWriter;
import jadx.api.args.IntegerFormat;
import jadx.core.codegen.AnnotationGen;
import jadx.core.codegen.NameGen;
import jadx.core.codegen.lang.CodeLanguage;
import jadx.core.dex.info.ClassInfo;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.utils.exceptions.CodegenException;

/**
 * Language-neutral class code generation API.
 * Implementations: {@link jadx.core.codegen.java.JavaClassGen}, {@link jadx.core.codegen.kotlin.KotlinClassGen}.
 */
public interface IClassGen {

	ICodeInfo makeClass() throws CodegenException;

	ClassNode getClassNode();

	CodeLanguage getLang();

	AnnotationGen getAnnotationGen();

	IClassGen getParentGen();

	void useType(ICodeWriter code, ArgType type);

	void useClass(ICodeWriter code, ArgType type);

	void useClass(ICodeWriter code, String rawCls);

	void useClass(ICodeWriter code, ClassInfo classInfo);

	void useClass(ICodeWriter code, ClassNode classNode);

	void addClsName(ICodeWriter code, ClassInfo classInfo);

	void addClsShortNameForced(ICodeWriter code, ClassInfo classInfo);

	boolean addGenericTypeParameters(ICodeWriter code, List<ArgType> generics, boolean classDeclaration);

	void addClassCode(ICodeWriter code) throws CodegenException;

	void addClassDeclaration(ICodeWriter code);

	void addClassBody(ICodeWriter code) throws CodegenException;

	void addClassBody(ICodeWriter code, boolean printClassName) throws CodegenException;

	void addMethodCode(ICodeWriter code, MethodNode mth) throws CodegenException;

	void addField(ICodeWriter code, FieldNode field);

	boolean isFallbackMode();

	boolean isBodyGenStarted();

	void setBodyGenStarted(boolean bodyGenStarted);

	@Nullable
	NameGen getOuterNameGen();

	void setOuterNameGen(@NotNull NameGen outerNameGen);

	Set<ClassInfo> getImports();

	IntegerFormat getIntegerFormat();

	/**
	 * {@code true} while emitting members inside a Kotlin {@code companion object} block.
	 */
	default boolean isInCompanionContext() {
		return false;
	}
}
