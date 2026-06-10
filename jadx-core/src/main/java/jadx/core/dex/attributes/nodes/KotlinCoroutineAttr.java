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
 * Kotlin coroutine state machine model: detection fingerprints plus label dispatch and suspend sites.
 */
public final class KotlinCoroutineAttr implements IJadxAttribute {

	public static final String RESUME_BEFORE_INVOKE_MSG = "call to 'resume' before 'invoke' with coroutine";

	private final ClassInfo continuationClass;
	private final FieldInfo labelField;
	private final InsnNode suspendedMarkerInsn;
	private final BlockNode dispatchBlock;
	private final Map<Integer, BlockNode> labelToResumeBlock;
	private final List<SuspendPoint> suspendPoints;

	public KotlinCoroutineAttr(
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
	public AType<KotlinCoroutineAttr> getAttrType() {
		return AType.KOTLIN_COROUTINE;
	}
}
