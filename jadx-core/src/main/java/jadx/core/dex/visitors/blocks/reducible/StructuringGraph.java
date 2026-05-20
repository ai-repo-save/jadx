package jadx.core.dex.visitors.blocks.reducible;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.Edge;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph.BridgeNode;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph.NaturalLoop;

public final class StructuringGraph {
	private final List<RegionNode> regions;

	private StructuringGraph(List<RegionNode> regions) {
		this.regions = Collections.unmodifiableList(regions);
	}

	public static StructuringGraph build(ControlFlowComponentGraph graph) {
		List<RegionNode> regions = new ArrayList<>();
		for (ControlFlowComponentGraph.Component component : graph.getComponents()) {
			regions.add(buildRegion(component));
		}
		return new StructuringGraph(regions);
	}

	public List<RegionNode> getRegions() {
		return regions;
	}

	public List<RegionNode> getMultiEntryRegions() {
		return regions.stream()
				.filter(region -> region.getKind() == RegionKind.MULTI_ENTRY)
				.collect(Collectors.toList());
	}

	private static RegionNode buildRegion(ControlFlowComponentGraph.Component component) {
		List<RegionEdge> edges = new ArrayList<>();
		for (Edge entry : component.getEntries()) {
			edges.add(new RegionEdge(RegionEdgeKind.COMPONENT_ENTRY, entry));
		}
		for (Edge exit : component.getExits()) {
			edges.add(new RegionEdge(RegionEdgeKind.COMPONENT_EXIT, exit));
		}
		for (BridgeNode bridge : component.getBridges()) {
			edges.add(new RegionEdge(RegionEdgeKind.BRIDGE_TO_HEADER, new Edge(bridge.getBlock(), bridge.getSuccessor())));
			for (BlockNode predecessor : bridge.getPredecessors()) {
				RegionEdgeKind kind = component.getBlocks().contains(predecessor)
						? RegionEdgeKind.BRIDGE_INPUT_FROM_REGION
						: RegionEdgeKind.BRIDGE_INPUT_FROM_OUTSIDE;
				edges.add(new RegionEdge(kind, new Edge(predecessor, bridge.getBlock())));
			}
		}
		for (NaturalLoop loop : component.getNaturalLoops()) {
			edges.add(new RegionEdge(RegionEdgeKind.NATURAL_BACK_EDGE, loop.getBackEdge()));
		}
		return new RegionNode(
				component.isMultiEntry() ? RegionKind.MULTI_ENTRY : RegionKind.SINGLE_ENTRY,
				component.getBlocks(),
				component.getEntries(),
				component.getExits(),
				component.getBridges(),
				component.getNaturalLoops(),
				edges);
	}

	public enum RegionKind {
		SINGLE_ENTRY,
		MULTI_ENTRY
	}

	public enum RegionEdgeKind {
		COMPONENT_ENTRY,
		COMPONENT_EXIT,
		BRIDGE_INPUT_FROM_OUTSIDE,
		BRIDGE_INPUT_FROM_REGION,
		BRIDGE_TO_HEADER,
		NATURAL_BACK_EDGE
	}

	public static final class RegionNode {
		private final RegionKind kind;
		private final Set<BlockNode> blocks;
		private final List<Edge> entries;
		private final List<Edge> exits;
		private final List<BridgeNode> bridges;
		private final List<NaturalLoop> naturalLoops;
		private final List<RegionEdge> edges;

		private RegionNode(
				RegionKind kind,
				Set<BlockNode> blocks,
				List<Edge> entries,
				List<Edge> exits,
				List<BridgeNode> bridges,
				List<NaturalLoop> naturalLoops,
				List<RegionEdge> edges) {
			this.kind = kind;
			this.blocks = Collections.unmodifiableSet(new LinkedHashSet<>(blocks));
			this.entries = Collections.unmodifiableList(new ArrayList<>(entries));
			this.exits = Collections.unmodifiableList(new ArrayList<>(exits));
			this.bridges = Collections.unmodifiableList(new ArrayList<>(bridges));
			this.naturalLoops = Collections.unmodifiableList(new ArrayList<>(naturalLoops));
			this.edges = Collections.unmodifiableList(new ArrayList<>(edges));
		}

		public RegionKind getKind() {
			return kind;
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

		public List<BridgeNode> getBridges() {
			return bridges;
		}

		public List<NaturalLoop> getNaturalLoops() {
			return naturalLoops;
		}

		public List<RegionEdge> getEdges() {
			return edges;
		}
	}

	public static final class RegionEdge {
		private final RegionEdgeKind kind;
		private final Edge edge;

		private RegionEdge(RegionEdgeKind kind, Edge edge) {
			this.kind = kind;
			this.edge = edge;
		}

		public RegionEdgeKind getKind() {
			return kind;
		}

		public Edge getEdge() {
			return edge;
		}
	}
}
