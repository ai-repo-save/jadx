package jadx.core.dex.visitors.regions.structured;

import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier;

public final class CoroutinePatternDetector {
	private CoroutinePatternDetector() {
	}

	public static boolean isKotlinCoroutineStateMachine(MethodNode mth) {
		if (mth.isNoCode() || mth.getArgTypes().size() < 2) {
			return false;
		}
		boolean hasContinuationInstanceOf = false;
		boolean hasLabelFieldLoad = false;
		boolean hasSuspendedConst = false;
		for (BlockNode block : mth.getBasicBlocks()) {
			for (InsnNode insn : block.getInstructions()) {
				if (insn.getType() == InsnType.INSTANCE_OF) {
					String insnStr = insn.toString();
					if (insnStr.contains("Continuation")
							|| insnStr.contains("/02xW;")
							|| insnStr.contains("/0Jym;")) {
						hasContinuationInstanceOf = true;
					}
				}
				if (insn.getType() == InsnType.IGET) {
					String field = insn.toString();
					if (field.contains("LLIZ")) {
						hasLabelFieldLoad = true;
					}
				}
				if (insn.getType() == InsnType.INVOKE && insn.toString().contains("LJFF()")) {
					hasSuspendedConst = true;
				}
			}
		}
		return hasContinuationInstanceOf && hasLabelFieldLoad && hasSuspendedConst;
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
