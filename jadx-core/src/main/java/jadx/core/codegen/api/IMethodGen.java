package jadx.core.codegen.api;

import jadx.api.ICodeWriter;
import jadx.core.codegen.NameGen;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.utils.exceptions.CodegenException;

/**
 * Language-neutral method code generation API.
 * Implementations: {@link jadx.core.codegen.java.JavaMethodGen}, {@link jadx.core.codegen.kotlin.KotlinMethodGen}.
 */
public interface IMethodGen {

	IClassGen getClassGen();

	MethodNode getMethodNode();

	NameGen getNameGen();

	boolean addDefinition(ICodeWriter code);

	void addInstructions(ICodeWriter code) throws CodegenException;

	void addRegionInsns(ICodeWriter code) throws CodegenException;

	void dumpInstructions(ICodeWriter code);
}
