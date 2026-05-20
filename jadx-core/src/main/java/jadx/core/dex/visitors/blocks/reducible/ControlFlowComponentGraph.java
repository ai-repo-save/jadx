package jadx.core.dex.visitors.blocks.reducible;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.Edge;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier.Result;
import jadx.core.utils.BlockUtils;

/**
 * Read-only control-flow facts collected before any irreducible lowering is selected.
 */
public final class ControlFlowComponentGraph {
	private final List<Node> nodes;
	private final List<Edge> edges;
	private final List<Component> components;
	private final List<BridgeNode> bridges;
	private final List<NaturalLoop> naturalLoops;

	private ControlFlowComponentGraph(
			List<Node> nodes,
			List<Edge> edges,
			List<Component> components,
			List<BridgeNode> bridges,
			List<NaturalLoop> naturalLoops) {
		this.nodes = Collections.unmodifiableList(nodes);
		this.edges = Collections.unmodifiableList(edges);
		this.components = Collections.unmodifiableList(components);
		this.bridges = Collections.unmodifiableList(bridges);
		this.naturalLoops = Collections.unmodifiableList(naturalLoops);
	}

	public static ControlFlowComponentGraph build(MethodNode mth) {
		List<BlockNode> blocks = mth.getBasicBlocks();
		List<Node> nodes = collectNodes(blocks);
		List<Edge> edges = collectEdges(blocks);
		List<BridgeNode> bridges = collectBridges(blocks);
		List<NaturalLoop> naturalLoops = collectNaturalLoops(mth);
		List<Component> components = collectComponents(GraphShapeClassifier.analyze(mth), bridges, naturalLoops);
		return new ControlFlowComponentGraph(nodes, edges, components, bridges, naturalLoops);
	}

	public List<Node> getNodes() {
		return nodes;
	}

	public List<Edge> getEdges() {
		return edges;
	}

	public List<Component> getComponents() {
		return components;
	}

	public List<Component> getMultiEntryComponents() {
		return components.stream()
				.filter(Component::isMultiEntry)
				.collect(Collectors.toList());
	}

	public List<BridgeNode> getBridges() {
		return bridges;
	}

	public List<NaturalLoop> getNaturalLoops() {
		return naturalLoops;
	}

	private static List<Node> collectNodes(List<BlockNode> blocks) {
		List<Node> nodes = new ArrayList<>(blocks.size());
		for (BlockNode block : blocks) {
			nodes.add(new Node(block, detectSyntheticKind(block), hasProtectedBoundary(block)));
		}
		return nodes;
	}

	private static List<Edge> collectEdges(List<BlockNode> blocks) {
		List<Edge> edges = new ArrayList<>();
		for (BlockNode block : blocks) {
			for (BlockNode successor : block.getSuccessors()) {
				edges.add(new Edge(block, successor));
			}
		}
		return edges;
	}

	private static List<BridgeNode> collectBridges(List<BlockNode> blocks) {
		List<BridgeNode> bridges = new ArrayList<>();
		for (BlockNode block : blocks) {
			if (detectSyntheticKind(block) == SyntheticKind.EMPTY_JOIN_BRIDGE) {
				bridges.add(new BridgeNode(block, block.getSuccessors().get(0), block.getPredecessors()));
			}
		}
		return bridges;
	}

	private static List<NaturalLoop> collectNaturalLoops(MethodNode mth) {
		List<NaturalLoop> loops = new ArrayList<>();
		for (BlockNode block : mth.getBasicBlocks()) {
			for (BlockNode successor : block.getSuccessors()) {
				if (block == successor || block.getDoms().get(successor.getPos())) {
					loops.add(new NaturalLoop(successor, block, BlockUtils.getAllPathsBlocks(successor, block)));
				}
			}
		}
		return loops;
	}

	private static List<Component> collectComponents(Result shape, List<BridgeNode> bridges, List<NaturalLoop> loops) {
		List<Component> components = new ArrayList<>();
		for (GraphShapeClassifier.Component component : shape.getComponents()) {
			Set<BlockNode> blocks = component.getBlocks();
			components.add(new Component(
					blocks,
					component.getEntries(),
					component.getExits(),
					component.getLoopStartCount(),
					filterBridges(blocks, bridges),
					filterLoops(blocks, loops)));
		}
		return components;
	}

	private static List<BridgeNode> filterBridges(Set<BlockNode> blocks, List<BridgeNode> bridges) {
		List<BridgeNode> result = new ArrayList<>();
		for (BridgeNode bridge : bridges) {
			if (blocks.contains(bridge.getBlock())) {
				result.add(bridge);
			}
		}
		return result;
	}

	private static List<NaturalLoop> filterLoops(Set<BlockNode> blocks, List<NaturalLoop> loops) {
		List<NaturalLoop> result = new ArrayList<>();
		for (NaturalLoop loop : loops) {
			if (blocks.contains(loop.getHeader()) || blocks.contains(loop.getBackEdge().getSource())) {
				result.add(loop);
			}
		}
		return result;
	}

	private static SyntheticKind detectSyntheticKind(BlockNode block) {
		if (block.getStartOffset() == -1
				&& block.isEmpty()
				&& block.getSuccessors().size() == 1
				&& block.getPredecessors().size() > 1) {
			return SyntheticKind.EMPTY_JOIN_BRIDGE;
		}
		return SyntheticKind.NONE;
	}

	private static boolean hasProtectedBoundary(BlockNode block) {
		if (block.contains(AType.TRY_BLOCK)
				|| block.contains(AType.EXC_HANDLER)
				|| block.contains(AType.EXC_CATCH)
				|| block.contains(AFlag.TRY_ENTER)
				|| block.contains(AFlag.TRY_LEAVE)
				|| block.contains(AFlag.EXC_TOP_SPLITTER)
				|| block.contains(AFlag.EXC_BOTTOM_SPLITTER)) {
			return true;
		}
		for (InsnNode insn : block.getInstructions()) {
			if (insn.getType() == InsnType.MONITOR_ENTER || insn.getType() == InsnType.MONITOR_EXIT) {
				return true;
			}
		}
		return false;
	}

	public enum SyntheticKind {
		NONE,
		EMPTY_JOIN_BRIDGE
	}

	public static final class Node {
		private final BlockNode block;
		private final SyntheticKind syntheticKind;
		private final boolean protectedBoundary;

		private Node(BlockNode block, SyntheticKind syntheticKind, boolean protectedBoundary) {
			this.block = block;
			this.syntheticKind = syntheticKind;
			this.protectedBoundary = protectedBoundary;
		}

		public BlockNode getBlock() {
			return block;
		}

		public SyntheticKind getSyntheticKind() {
			return syntheticKind;
		}

		public boolean isSynthetic() {
			return block.isSynthetic();
		}

		public boolean isEmpty() {
			return block.isEmpty();
		}

		public boolean hasProtectedBoundary() {
			return protectedBoundary;
		}
	}

	public static final class BridgeNode {
		private final BlockNode block;
		private final BlockNode successor;
		private final List<BlockNode> predecessors;

		private BridgeNode(BlockNode block, BlockNode successor, List<BlockNode> predecessors) {
			this.block = block;
			this.successor = successor;
			this.predecessors = Collections.unmodifiableList(new ArrayList<>(predecessors));
		}

		public BlockNode getBlock() {
			return block;
		}

		public BlockNode getSuccessor() {
			return successor;
		}

		public List<BlockNode> getPredecessors() {
			return predecessors;
		}

		public boolean isSynthetic() {
			return block.isSynthetic();
		}
	}

	public static final class NaturalLoop {
		private final BlockNode header;
		private final Edge backEdge;
		private final Set<BlockNode> body;

		private NaturalLoop(BlockNode header, BlockNode backEdgeSource, Set<BlockNode> body) {
			this.header = header;
			this.backEdge = new Edge(backEdgeSource, header);
			this.body = Collections.unmodifiableSet(new LinkedHashSet<>(body));
		}

		public BlockNode getHeader() {
			return header;
		}

		public Edge getBackEdge() {
			return backEdge;
		}

		public Set<BlockNode> getBody() {
			return body;
		}

	}

	public static final class Component {
		private final Set<BlockNode> blocks;
		private final List<Edge> entries;
		private final List<Edge> exits;
		private final int loopStartCount;
		private final List<BridgeNode> bridges;
		private final List<NaturalLoop> naturalLoops;

		private Component(
				Set<BlockNode> blocks,
				List<Edge> entries,
				List<Edge> exits,
				int loopStartCount,
				List<BridgeNode> bridges,
				List<NaturalLoop> naturalLoops) {
			this.blocks = Collections.unmodifiableSet(new LinkedHashSet<>(blocks));
			this.entries = Collections.unmodifiableList(new ArrayList<>(entries));
			this.exits = Collections.unmodifiableList(new ArrayList<>(exits));
			this.loopStartCount = loopStartCount;
			this.bridges = Collections.unmodifiableList(new ArrayList<>(bridges));
			this.naturalLoops = Collections.unmodifiableList(new ArrayList<>(naturalLoops));
		}

		public Set<BlockNode> getBlocks() {
			return blocks;
		}

		public List<Edge> getEntries() {
			return entries;
		}

		public List<Edge> getExits() {
			return exits;
		}

		public int getLoopStartCount() {
			return loopStartCount;
		}

		public boolean isMultiEntry() {
			return entries.size() > 1;
		}

		public List<BridgeNode> getBridges() {
			return bridges;
		}

		public List<NaturalLoop> getNaturalLoops() {
			return naturalLoops;
		}
	}
}
