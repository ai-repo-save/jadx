package jadx.core.dex.visitors.regions.structured;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.LoopInfo;
import jadx.core.dex.attributes.nodes.LoopLabelAttr;
import jadx.core.dex.attributes.nodes.StateMachineAttr;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.regions.Region;
import jadx.core.dex.regions.structured.CoroutineDispatchRegion;
import jadx.core.dex.regions.structured.MultiEntryLoopRegion;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier;
import jadx.core.dex.visitors.regions.maker.StructuredBlockRegionBuilder;
import jadx.core.utils.BlockUtils;

public final class StructuredRegionBuilder {
	private StructuredRegionBuilder() {
	}

	public static @Nullable Region build(MethodNode mth) {
		StateMachineAttr stateMachine = mth.get(AType.STATE_MACHINE);
		if (stateMachine == null) {
			return null;
		}
		if (!NestedMultiEntryLoopDetector.matches(mth)) {
			return null;
		}
		GraphShapeClassifier.Component component = NestedMultiEntryLoopDetector.findPrimaryMultiEntryComponent(mth);
		if (component == null || !matchesSharedLoopShape(component)) {
			return null;
		}

		Set<BlockNode> componentBlocks = component.getBlocks();
		LoopInfo outerLoop;
		LoopInfo innerLoop;
		LoopInfo[] componentLoops = findComponentLoopPair(mth, componentBlocks);
		if (componentLoops == null) {
			return null;
		}
		outerLoop = componentLoops[0];
		innerLoop = componentLoops[1];

		BlockNode outerHeader = outerLoop.getStart();
		BlockNode innerHeader = innerLoop.getStart();
		BlockNode innerExitToOuter = findInnerExitBlock(outerHeader, innerLoop);
		boolean innerExitsToOuter = innerExitToOuter != null
				|| BlockUtils.loopHeaderExitsTo(outerHeader, innerHeader);
		if (!innerExitsToOuter) {
			return null;
		}

		List<BlockNode> postLoopBlocks = collectPostLoopBlocks(mth, componentBlocks, outerHeader);
		Set<BlockNode> postLoopSet = new HashSet<>(postLoopBlocks);
		List<BlockNode> preambleBlocks = collectPreambleBlocks(mth, componentBlocks, postLoopSet);
		Map<Integer, BlockNode> resumeEntryByLabel = stateMachine.getLabelToResumeBlock();
		Integer innerResumeLabel = findLabelForHeader(resumeEntryByLabel, innerHeader);
		Integer outerResumeLabel = findLabelForHeader(resumeEntryByLabel, outerHeader);

		Set<BlockNode> preambleStops = new HashSet<>(componentBlocks);
		preambleStops.addAll(postLoopBlocks);

		Set<BlockNode> loopBodyStops = new HashSet<>(postLoopBlocks);
		loopBodyStops.add(outerHeader);
		for (BlockNode block : mth.getBasicBlocks()) {
			if (!componentBlocks.contains(block) && block.getStartOffset() != -1) {
				loopBodyStops.add(block);
			}
		}

		StructuredBlockRegionBuilder preambleBuilder = new StructuredBlockRegionBuilder(mth, preambleStops, false);
		StructuredBlockRegionBuilder loopBodyBuilder = new StructuredBlockRegionBuilder(mth, loopBodyStops, false);
		Region preambleRegion = preambleBuilder.buildFrom(null, mth.getEnterBlock());

		LoopLabelAttr outerLabel = new LoopLabelAttr(outerLoop);
		outerHeader.addAttr(outerLabel);

		Region root = new Region(null);
		root.add(new CoroutineDispatchRegion(root, preambleRegion));
		Region loopBodyRegion = loopBodyBuilder.buildFrom(root, BlockUtils.getLoopBodyEntry(outerHeader));
		root.add(new MultiEntryLoopRegion(
				root,
				outerLoop,
				outerHeader,
				innerExitsToOuter,
				loopBodyRegion));
		BlockNode postStart = postLoopBlocks.isEmpty() ? null : postLoopBlocks.get(0);
		Set<BlockNode> postStops = new HashSet<>(componentBlocks);
		postStops.add(outerHeader);
		for (BlockNode block : mth.getBasicBlocks()) {
			if (!componentBlocks.contains(block) && block.getStartOffset() != -1 && !postLoopSet.contains(block)) {
				postStops.add(block);
			}
		}
		StructuredBlockRegionBuilder postBuilder = new StructuredBlockRegionBuilder(mth, postStops, false);
		Region post = postBuilder.buildFrom(root, postStart);
		root.add(post);
		return root;
	}

	/**
	 * Find nested outer/inner loops in a multi-entry component.
	 * {@link LoopInfo#getParentLoop()} is not reliable here: natural loops may overlap without strict block containment.
	 *
	 * @return [outer, inner] or null
	 */
	private static @Nullable LoopInfo[] findComponentLoopPair(MethodNode mth, Set<BlockNode> componentBlocks) {
		List<LoopInfo> componentLoops = new ArrayList<>();
		for (LoopInfo loop : mth.getLoops()) {
			if (componentBlocks.contains(loop.getStart())) {
				componentLoops.add(loop);
			}
		}
		for (LoopInfo inner : componentLoops) {
			BlockNode innerHeader = inner.getStart();
			for (LoopInfo outer : componentLoops) {
				if (inner == outer) {
					continue;
				}
				if (BlockUtils.loopHeaderExitsTo(outer.getStart(), innerHeader)) {
					return new LoopInfo[] { outer, inner };
				}
			}
		}
		return null;
	}

	private static @Nullable BlockNode findInnerExitBlock(BlockNode outerHeader, LoopInfo innerLoop) {
		for (BlockNode block : innerLoop.getLoopBlocks()) {
			if (block == innerLoop.getStart()) {
				continue;
			}
			for (BlockNode succ : block.getSuccessors()) {
				if (BlockUtils.resolvesToHeader(outerHeader, succ)) {
					return block;
				}
			}
		}
		return null;
	}

	private static @Nullable Integer findLabelForHeader(Map<Integer, BlockNode> resumeEntryByLabel, BlockNode header) {
		for (Map.Entry<Integer, BlockNode> entry : resumeEntryByLabel.entrySet()) {
			BlockNode target = BlockUtils.followEmptyPath(entry.getValue());
			if (target == header || BlockUtils.resolvesToHeader(header, target)) {
				return entry.getKey();
			}
		}
		return null;
	}

	private static List<BlockNode> collectPreambleBlocks(
			MethodNode mth,
			Set<BlockNode> componentBlocks,
			Set<BlockNode> postLoopBlocks) {
		List<BlockNode> preamble = new ArrayList<>();
		for (BlockNode block : mth.getBasicBlocks()) {
			if (componentBlocks.contains(block) || postLoopBlocks.contains(block)) {
				continue;
			}
			if (block.getStartOffset() == -1) {
				continue;
			}
			preamble.add(block);
		}
		preamble.sort(Comparator.comparingInt(BlockNode::getStartOffset));
		return preamble;
	}

	private static List<BlockNode> collectPostLoopBlocks(
			MethodNode mth,
			Set<BlockNode> componentBlocks,
			BlockNode outerHeader) {
		BlockNode postEntry = findOuterLoopPostEntry(outerHeader, componentBlocks);
		if (postEntry == null) {
			return List.of();
		}
		Set<BlockNode> post = new LinkedHashSet<>();
		collectOutsideComponent(post, postEntry, componentBlocks);
		return sortBlocks(post);
	}

	private static @Nullable BlockNode findOuterLoopPostEntry(BlockNode outerHeader, Set<BlockNode> componentBlocks) {
		InsnNode lastInsn = BlockUtils.getLastInsn(outerHeader);
		if (!(lastInsn instanceof IfNode)) {
			return null;
		}
		IfNode ifInsn = (IfNode) lastInsn;
		for (BlockNode branch : new BlockNode[] { ifInsn.getThenBlock(), ifInsn.getElseBlock() }) {
			BlockNode target = BlockUtils.followEmptyPath(branch);
			if (target != null && !componentBlocks.contains(target)) {
				return target;
			}
		}
		return null;
	}

	private static void collectOutsideComponent(Set<BlockNode> post, BlockNode start, Set<BlockNode> componentBlocks) {
		ArrayDeque<BlockNode> queue = new ArrayDeque<>();
		Set<BlockNode> visited = new HashSet<>();
		queue.add(start);
		while (!queue.isEmpty()) {
			BlockNode block = queue.poll();
			if (!visited.add(block) || componentBlocks.contains(block) || block.getStartOffset() == -1) {
				continue;
			}
			post.add(block);
			for (BlockNode succ : block.getSuccessors()) {
				if (!componentBlocks.contains(succ)) {
					queue.add(succ);
				}
			}
		}
	}

	private static List<BlockNode> sortBlocks(Set<BlockNode> blocks) {
		List<BlockNode> sorted = new ArrayList<>(blocks);
		sorted.sort(Comparator.comparingInt(BlockNode::getStartOffset));
		return sorted;
	}

	private static boolean matchesSharedLoopShape(GraphShapeClassifier.Component component) {
		return component.getLoopStartCount() >= 2 && component.getEntries().size() >= 3;
	}
}
