package jadx.core.dex.visitors.regions.structured;

import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier;

/**
 * Detects the CFG shape for nested multi-entry loop region transformation
 * (outer/inner loop with multiple resume entries) — independent of suspend-function signature.
 */
public final class NestedMultiEntryLoopDetector {

	private NestedMultiEntryLoopDetector() {
	}

	public static boolean matches(MethodNode mth) {
		GraphShapeClassifier.Component component = findPrimaryMultiEntryComponent(mth);
		return component != null && matchesSharedLoopShape(component);
	}

	public static GraphShapeClassifier.Component findPrimaryMultiEntryComponent(MethodNode mth) {
		return GraphShapeClassifier.analyze(mth).getMultiEntryComponents().stream()
				.filter(component -> component.getLoopStartCount() >= 2)
				.findFirst()
				.orElse(null);
	}

	private static boolean matchesSharedLoopShape(GraphShapeClassifier.Component component) {
		return component.getLoopStartCount() >= 2 && component.getEntries().size() >= 3;
	}

	public static boolean hasMultiEntryComponent(MethodNode mth) {
		ControlFlowComponentGraph graph = ControlFlowComponentGraph.build(mth);
		return graph.getMultiEntryComponents().stream()
				.anyMatch(component -> component.getLoopStartCount() >= 2 && component.getEntries().size() >= 3);
	}
}
