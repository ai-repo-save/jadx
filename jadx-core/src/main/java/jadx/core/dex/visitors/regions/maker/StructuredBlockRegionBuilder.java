package jadx.core.dex.visitors.regions.maker;

import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.IContainer;
import jadx.core.dex.nodes.IRegion;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.regions.Region;
import jadx.core.utils.BlockUtils;

/**
 * Builds structured regions for coroutine/multi-entry loop methods without full RegionMaker overflow.
 */
public final class StructuredBlockRegionBuilder {
	private final MethodNode mth;
	private final Set<BlockNode> stopBlocks;
	private final RegionMaker regionMaker;
	private final IfRegionMaker ifMaker;

	public StructuredBlockRegionBuilder(MethodNode mth, Collection<BlockNode> stopBlocks) {
		this(mth, stopBlocks, true);
	}

	public StructuredBlockRegionBuilder(MethodNode mth, Collection<BlockNode> stopBlocks, boolean skipLoops) {
		this.mth = mth;
		this.stopBlocks = Set.copyOf(stopBlocks);
		this.regionMaker = new RegionMaker(mth).setSkipLoops(skipLoops);
		this.ifMaker = new IfRegionMaker(mth, regionMaker);
		this.regionMaker.getStack().addExits(this.stopBlocks);
	}

	public Region buildFrom(IRegion parent, @Nullable BlockNode start) {
		if (start == null || stopBlocks.contains(start)) {
			return new Region(parent);
		}
		regionMaker.clearBlockProcessedState(start);
		RegionStack stack = regionMaker.getStack();
		stack.push(parent);
		Region region = regionMaker.makeRegion(start);
		stack.pop();
		region.setParent(parent);
		return region;
	}

	public Region buildFromBlocks(IRegion parent, List<BlockNode> blocks) {
		Region region = new Region(parent);
		for (BlockNode block : blocks) {
			if (stopBlocks.contains(block)) {
				continue;
			}
			IContainer container = buildBlockContainer(region, block);
			if (container != null) {
				region.add(container);
			}
		}
		return region;
	}

	private @Nullable IContainer buildBlockContainer(IRegion parent, BlockNode block) {
		InsnNode lastInsn = BlockUtils.getLastInsn(block);
		if (lastInsn != null && lastInsn.getType() == InsnType.IF) {
			Region tmp = new Region(parent);
			RegionStack stack = regionMaker.getStack();
			stack.push(tmp);
			ifMaker.process(tmp, block, (IfNode) lastInsn, stack);
			stack.pop();
			List<IContainer> subBlocks = tmp.getSubBlocks();
			if (subBlocks.isEmpty()) {
				return null;
			}
			return subBlocks.get(0);
		}
		return block;
	}
}
