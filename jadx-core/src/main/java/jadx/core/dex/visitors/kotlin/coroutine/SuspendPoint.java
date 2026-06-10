package jadx.core.dex.visitors.kotlin.coroutine;

import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.InsnNode;

/**
 * Kotlin coroutine suspend site: label assignment, suspending invoke, and suspended check.
 */
public final class SuspendPoint {

	private final int label;
	private final BlockNode labelStoreBlock;
	private final InsnNode labelStoreInsn;
	private final BlockNode invokeBlock;
	private final InsnNode invokeInsn;
	private final BlockNode suspendCheckBlock;

	public SuspendPoint(
			int label,
			BlockNode labelStoreBlock,
			InsnNode labelStoreInsn,
			BlockNode invokeBlock,
			InsnNode invokeInsn,
			BlockNode suspendCheckBlock) {
		this.label = label;
		this.labelStoreBlock = labelStoreBlock;
		this.labelStoreInsn = labelStoreInsn;
		this.invokeBlock = invokeBlock;
		this.invokeInsn = invokeInsn;
		this.suspendCheckBlock = suspendCheckBlock;
	}

	public int getLabel() {
		return label;
	}

	public BlockNode getLabelStoreBlock() {
		return labelStoreBlock;
	}

	public InsnNode getLabelStoreInsn() {
		return labelStoreInsn;
	}

	public BlockNode getInvokeBlock() {
		return invokeBlock;
	}

	public InsnNode getInvokeInsn() {
		return invokeInsn;
	}

	public BlockNode getSuspendCheckBlock() {
		return suspendCheckBlock;
	}

	@Override
	public String toString() {
		return "SuspendPoint{label=" + label + ", check=" + suspendCheckBlock + '}';
	}
}
