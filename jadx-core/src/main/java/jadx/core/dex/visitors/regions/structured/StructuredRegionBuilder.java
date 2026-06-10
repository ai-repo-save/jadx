package jadx.core.dex.visitors.regions.structured;

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
import jadx.core.dex.attributes.nodes.StructuredCoroutineAttr;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.Edge;
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
		GraphShapeClassifier.Component component = CoroutinePatternDetector.findPrimaryMultiEntryComponent(mth);
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

		List<BlockNode> postLoopBlocks = collectPostLoopBlocks(mth, componentBlocks);
		Set<BlockNode> postLoopSet = new HashSet<>(postLoopBlocks);
		List<BlockNode> preambleBlocks = collectPreambleBlocks(mth, componentBlocks, postLoopSet);
		Map<Integer, BlockNode> resumeEntryByLabel = collectResumeEntries(component, outerHeader, innerHeader);

		StructuredCoroutineAttr attr = new StructuredCoroutineAttr(
				outerHeader,
				innerHeader,
				innerExitToOuter,
				resumeEntryByLabel.get(2),
				resumeEntryByLabel.get(3),
				preambleBlocks,
				resumeEntryByLabel,
				postLoopBlocks);

		Set<BlockNode> preambleStops = new HashSet<>(componentBlocks);
		preambleStops.addAll(postLoopBlocks);

		Set<BlockNode> loopBodyStops = new HashSet<>(postLoopBlocks);
		loopBodyStops.add(outerHeader);
		loopBodyStops.add(innerHeader);
		for (BlockNode block : mth.getBasicBlocks()) {
			if (!componentBlocks.contains(block) && block.getStartOffset() != -1) {
				loopBodyStops.add(block);
			}
		}

		Set<BlockNode> innerBodyStops = new HashSet<>(loopBodyStops);
		if (innerExitToOuter != null) {
			innerBodyStops.add(innerExitToOuter);
		}

		StructuredBlockRegionBuilder preambleBuilder = new StructuredBlockRegionBuilder(mth, preambleStops, false);
		StructuredBlockRegionBuilder outerBodyBuilder = new StructuredBlockRegionBuilder(mth, loopBodyStops, true);
		StructuredBlockRegionBuilder innerBodyBuilder = new StructuredBlockRegionBuilder(mth, innerBodyStops, true);
		Region preambleRegion = preambleBuilder.buildFrom(null, mth.getEnterBlock());

		Region root = new Region(null);
		root.add(new CoroutineDispatchRegion(root, preambleRegion));
		Region outerBodyRegion = outerBodyBuilder.buildFrom(root, BlockUtils.getLoopBodyEntry(outerHeader));
		Region innerBodyRegion = innerBodyBuilder.buildFrom(root, BlockUtils.getLoopBodyEntry(innerHeader));
		root.add(new MultiEntryLoopRegion(
				root,
				outerHeader,
				innerHeader,
				innerExitToOuter,
				innerExitsToOuter,
				outerBodyRegion,
				innerBodyRegion));
		BlockNode postStart = postLoopBlocks.isEmpty() ? null : postLoopBlocks.get(0);
		Region post = preambleBuilder.buildFrom(root, postStart);
		root.add(post);
		mth.addAttr(attr);
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

	private static Map<Integer, BlockNode> collectResumeEntries(
			GraphShapeClassifier.Component component,
			BlockNode outerHeader,
			BlockNode innerHeader) {
		Map<Integer, BlockNode> resumeEntryByLabel = new java.util.HashMap<>();
		for (Edge entry : component.getEntries()) {
			BlockNode source = entry.getSource();
			if (source.getStartOffset() == -1) {
				continue;
			}
			BlockNode target = BlockUtils.followEmptyPath(entry.getTarget());
			if (target == innerHeader) {
				resumeEntryByLabel.put(2, source);
			} else if (target == outerHeader) {
				resumeEntryByLabel.put(3, source);
			}
		}
		return resumeEntryByLabel;
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

	private static List<BlockNode> collectPostLoopBlocks(MethodNode mth, Set<BlockNode> componentBlocks) {
		Set<BlockNode> post = new LinkedHashSet<>();
		for (BlockNode block : mth.getBasicBlocks()) {
			if (componentBlocks.contains(block) || block.getStartOffset() == -1) {
				continue;
			}
			if (isReachableFromComponentExit(block, componentBlocks)) {
				post.add(block);
			}
		}
		return sortBlocks(post);
	}

	private static boolean isReachableFromComponentExit(BlockNode target, Set<BlockNode> componentBlocks) {
		for (BlockNode block : componentBlocks) {
			for (BlockNode successor : block.getSuccessors()) {
				if (successor == target && !componentBlocks.contains(successor)) {
					return true;
				}
			}
		}
		return false;
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
