package jadx.core.dex.visitors.regions.structured;

import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier;

public final class CoroutinePatternDetector {
	private CoroutinePatternDetector() {
	}

	public static boolean isKotlinCoroutineStateMachine(MethodNode mth) {
		return mth.contains(jadx.core.dex.attributes.AType.KOTLIN_COROUTINE);
	}

	public static boolean hasStructuredMultiEntryLoop(MethodNode mth) {
		if (!isKotlinCoroutineStateMachine(mth)) {
			return false;
		}
		ControlFlowComponentGraph graph = ControlFlowComponentGraph.build(mth);
		return graph.getMultiEntryComponents().stream()
				.anyMatch(component -> component.getLoopStartCount() >= 2 && component.getEntries().size() >= 3);
	}

	public static GraphShapeClassifier.Component findPrimaryMultiEntryComponent(MethodNode mth) {
		return GraphShapeClassifier.analyze(mth).getMultiEntryComponents().stream()
				.filter(component -> component.getLoopStartCount() >= 2)
				.findFirst()
				.orElse(null);
	}
}
