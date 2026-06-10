package jadx.core.dex.attributes.nodes;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import jadx.api.plugins.input.data.attributes.IJadxAttribute;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.info.ClassInfo;
import jadx.core.dex.info.FieldInfo;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.visitors.kotlin.coroutine.SuspendPoint;

/**
 * Kotlin CPS state-machine model extracted from bytecode: label dispatch map and suspend sites.
 * This is not a suspend-function marker and not a region-transform marker.
 */
public final class StateMachineAttr implements IJadxAttribute {

	public static final String RESUME_BEFORE_INVOKE_MSG = "call to 'resume' before 'invoke' with coroutine";

	private final ClassInfo continuationClass;
	private final FieldInfo labelField;
	private final InsnNode suspendedMarkerInsn;
	private final BlockNode dispatchBlock;
	private final Map<Integer, BlockNode> labelToResumeBlock;
	private final List<SuspendPoint> suspendPoints;

	public StateMachineAttr(
			ClassInfo continuationClass,
			FieldInfo labelField,
			InsnNode suspendedMarkerInsn,
			BlockNode dispatchBlock,
			Map<Integer, BlockNode> labelToResumeBlock,
			List<SuspendPoint> suspendPoints) {
		this.continuationClass = continuationClass;
		this.labelField = labelField;
		this.suspendedMarkerInsn = suspendedMarkerInsn;
		this.dispatchBlock = dispatchBlock;
		this.labelToResumeBlock = Collections.unmodifiableMap(labelToResumeBlock);
		this.suspendPoints = Collections.unmodifiableList(suspendPoints);
	}

	public ClassInfo getContinuationClass() {
		return continuationClass;
	}

	public FieldInfo getLabelField() {
		return labelField;
	}

	public InsnNode getSuspendedMarkerInsn() {
		return suspendedMarkerInsn;
	}

	public BlockNode getDispatchBlock() {
		return dispatchBlock;
	}

	public Map<Integer, BlockNode> getLabelToResumeBlock() {
		return labelToResumeBlock;
	}

	public List<SuspendPoint> getSuspendPoints() {
		return suspendPoints;
	}

	@Override
	public AType<StateMachineAttr> getAttrType() {
		return AType.STATE_MACHINE;
	}
}
