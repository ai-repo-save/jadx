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
import jadx.core.dex.attributes.nodes.StructuredCoroutineAttr;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.regions.Region;
import jadx.core.dex.regions.structured.CoroutineDispatchRegion;
import jadx.core.dex.regions.structured.MultiEntryLoopRegion;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier;
import jadx.core.dex.visitors.regions.maker.StructuredBlockRegionBuilder;

public final class StructuredRegionBuilder {
	private StructuredRegionBuilder() {
	}

	public static @Nullable Region build(MethodNode mth) {
		GraphShapeClassifier.Component component = CoroutinePatternDetector.findPrimaryMultiEntryComponent(mth);
		if (component == null || !matchesSharedLoopShape(component)) {
			return null;
		}
		BlockNode outerHeader = findHeaderBlock(mth, 0x003e);
		BlockNode innerHeader = findHeaderBlock(mth, 0x0063);
		BlockNode innerExitToOuter = findBlockByOffset(mth, 0x0067);
		BlockNode innerResumeEntry = findBlockByOffset(mth, 0x0106);
		BlockNode outerResumeEntry = findBlockByOffset(mth, 0x01cb);
		if (outerHeader == null || innerHeader == null || innerExitToOuter == null) {
			return null;
		}

		Set<BlockNode> componentBlocks = component.getBlocks();
		Set<BlockNode> innerBlocks = collectInnerLoopBlocks(mth, innerHeader);
		List<BlockNode> outerBodyBlocks = new ArrayList<>();
		List<BlockNode> innerBodyBlocks = new ArrayList<>();
		for (BlockNode block : sortBlocks(componentBlocks)) {
			if (block == outerHeader || block == innerHeader) {
				continue;
			}
			if (block.getStartOffset() == -1) {
				continue;
			}
			if (innerBlocks.contains(block)) {
				innerBodyBlocks.add(block);
			} else {
				outerBodyBlocks.add(block);
			}
		}

		List<BlockNode> postLoopBlocks = collectPostLoopBlocks(mth, componentBlocks);
		Set<BlockNode> postLoopSet = new HashSet<>(postLoopBlocks);
		List<BlockNode> preambleBlocks = collectPreambleBlocks(mth, componentBlocks, postLoopSet);
		Map<Integer, BlockNode> resumeEntryByLabel = new java.util.HashMap<>();
		if (innerResumeEntry != null) {
			resumeEntryByLabel.put(2, innerResumeEntry);
		}
		if (outerResumeEntry != null) {
			resumeEntryByLabel.put(3, outerResumeEntry);
		}

		StructuredCoroutineAttr attr = new StructuredCoroutineAttr(
				outerHeader,
				innerHeader,
				innerExitToOuter,
				innerResumeEntry,
				outerResumeEntry,
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

		StructuredBlockRegionBuilder preambleBuilder = new StructuredBlockRegionBuilder(mth, preambleStops);
		StructuredBlockRegionBuilder loopBodyBuilder = new StructuredBlockRegionBuilder(mth, loopBodyStops);
		Region preambleRegion = preambleBuilder.buildFrom(null, mth.getEnterBlock());

		Region root = new Region(null);
		root.add(new CoroutineDispatchRegion(root, preambleRegion));
		Region outerBodyRegion = loopBodyBuilder.buildFromBlocks(root, outerBodyBlocks);
		Region innerBodyRegion = loopBodyBuilder.buildFromBlocks(root, innerBodyBlocks);
		root.add(new MultiEntryLoopRegion(
				root,
				outerHeader,
				innerHeader,
				innerExitToOuter,
				outerBodyRegion,
				innerBodyRegion));
		Region post = preambleBuilder.buildFromBlocks(root, postLoopBlocks);
		root.add(post);
		mth.addAttr(attr);
		return root;
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

	private static Set<BlockNode> collectInnerLoopBlocks(MethodNode mth, BlockNode innerHeader) {
		Set<BlockNode> blocks = new HashSet<>();
		for (BlockNode block : mth.getBasicBlocks()) {
			for (LoopInfo loop : block.getAll(AType.LOOP)) {
				if (loop.getStart() == innerHeader) {
					blocks.addAll(loop.getLoopBlocks());
				}
			}
		}
		return blocks;
	}

	private static List<BlockNode> sortBlocks(Set<BlockNode> blocks) {
		List<BlockNode> sorted = new ArrayList<>(blocks);
		sorted.sort(Comparator.comparingInt(BlockNode::getStartOffset));
		return sorted;
	}

	private static @Nullable BlockNode findHeaderBlock(MethodNode mth, int offset) {
		for (BlockNode block : mth.getBasicBlocks()) {
			if (block.getStartOffset() == offset) {
				return block;
			}
		}
		return null;
	}

	private static boolean matchesSharedLoopShape(GraphShapeClassifier.Component component) {
		return component.getLoopStartCount() >= 2 && component.getEntries().size() >= 3;
	}

	private static @Nullable BlockNode findBlockByOffset(MethodNode mth, int offset) {
		for (BlockNode block : mth.getBasicBlocks()) {
			if (block.getStartOffset() == offset) {
				return block;
			}
		}
		return null;
	}
}
