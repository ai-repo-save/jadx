package jadx.core.dex.visitors;

import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.utils.exceptions.JadxException;

/**
 * Visitor interface for traverse dex tree
 */
public interface IDexTreeVisitor {

	/**
	 * Visitor short id
	 */
	String getName();

	/**
	 * Called after loading dex tree, but before visitor traversal.
	 */
	void init(RootNode root) throws JadxException;

	/**
	 * Visit class
	 *
	 * @return false for disable child methods and inner classes traversal
	 */
	boolean visit(ClassNode cls) throws JadxException;

	/**
	 * Visit method
	 */
	void visit(MethodNode mth) throws JadxException;

	/**
	 * @return false if this visitor does all work in {@link #init(RootNode)} and class traversal can be
	 *         skipped
	 */
	default boolean isClassTraversalNeeded() {
		return true;
	}

	/**
	 * @return true if top-level class visits are independent and can run in parallel (after
	 *         {@link #init})
	 */
	default boolean isParallelClassTraversal() {
		return false;
	}
}
