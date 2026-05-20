package jadx.core.dex.visitors.blocks.reducible;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.Edge;
import jadx.core.dex.nodes.MethodNode;

public final class GraphShapeClassifier {
	private GraphShapeClassifier() {
	}

	public static Result analyze(MethodNode mth) {
		return new Analyzer(mth).analyze();
	}

	public static final class Result {
		private final List<Component> components;

		private Result(List<Component> components) {
			this.components = Collections.unmodifiableList(components);
		}

		public List<Component> getComponents() {
			return components;
		}

		public List<Component> getMultiEntryComponents() {
			List<Component> multiEntryComponents = new ArrayList<>();
			for (Component component : components) {
				if (component.isMultiEntry()) {
					multiEntryComponents.add(component);
				}
			}
			return multiEntryComponents;
		}
	}

	public static final class Component {
		private final Set<BlockNode> blocks;
		private final List<Edge> entries;
		private final List<Edge> exits;
		private final int loopStartCount;

		private Component(Set<BlockNode> blocks, List<Edge> entries, List<Edge> exits, int loopStartCount) {
			this.blocks = Collections.unmodifiableSet(blocks);
			this.entries = Collections.unmodifiableList(entries);
			this.exits = Collections.unmodifiableList(exits);
			this.loopStartCount = loopStartCount;
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
	}

	private static final class Analyzer {
		private final List<BlockNode> blocks;
		private final Map<BlockNode, Integer> indexMap = new HashMap<>();
		private final Map<BlockNode, Integer> lowLinkMap = new HashMap<>();
		private final ArrayDeque<BlockNode> stack = new ArrayDeque<>();
		private final Set<BlockNode> onStack = new HashSet<>();
		private final List<Component> components = new ArrayList<>();
		private int nextIndex;

		private Analyzer(MethodNode mth) {
			this.blocks = mth.getBasicBlocks();
		}

		private Result analyze() {
			for (BlockNode block : blocks) {
				if (!indexMap.containsKey(block)) {
					visit(block);
				}
			}
			return new Result(components);
		}

		private void visit(BlockNode block) {
			indexMap.put(block, nextIndex);
			lowLinkMap.put(block, nextIndex);
			nextIndex++;
			stack.push(block);
			onStack.add(block);

			for (BlockNode successor : block.getSuccessors()) {
				if (!indexMap.containsKey(successor)) {
					visit(successor);
					updateLowLink(block, lowLinkMap.get(successor));
				} else if (onStack.contains(successor)) {
					updateLowLink(block, indexMap.get(successor));
				}
			}

			if (lowLinkMap.get(block).equals(indexMap.get(block))) {
				components.add(buildComponent(block));
			}
		}

		private void updateLowLink(BlockNode block, int successorLowLink) {
			int lowLink = lowLinkMap.get(block);
			if (successorLowLink < lowLink) {
				lowLinkMap.put(block, successorLowLink);
			}
		}

		private Component buildComponent(BlockNode root) {
			Set<BlockNode> componentBlocks = new LinkedHashSet<>();
			BlockNode block;
			do {
				block = stack.pop();
				onStack.remove(block);
				componentBlocks.add(block);
			} while (block != root);
			return collectComponentData(componentBlocks);
		}

		private static Component collectComponentData(Set<BlockNode> componentBlocks) {
			List<Edge> entries = new ArrayList<>();
			List<Edge> exits = new ArrayList<>();
			int loopStartCount = 0;
			for (BlockNode block : componentBlocks) {
				if (block.contains(AFlag.LOOP_START)) {
					loopStartCount++;
				}
				for (BlockNode predecessor : block.getPredecessors()) {
					if (!componentBlocks.contains(predecessor)) {
						entries.add(new Edge(predecessor, block));
					}
				}
				for (BlockNode successor : block.getSuccessors()) {
					if (!componentBlocks.contains(successor)) {
						exits.add(new Edge(block, successor));
					}
				}
			}
			return new Component(componentBlocks, entries, exits, loopStartCount);
		}
	}
}
