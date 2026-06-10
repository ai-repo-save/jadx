package jadx.core.dex.regions.structured;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import jadx.api.ICodeWriter;
import jadx.core.codegen.RegionGen;
import jadx.core.dex.attributes.nodes.StructuredCoroutineAttr;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.IContainer;
import jadx.core.dex.nodes.IRegion;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.regions.AbstractRegion;
import jadx.core.dex.regions.Region;
import jadx.core.dex.regions.conditions.IfRegion;
import jadx.core.utils.BlockUtils;
import jadx.core.utils.exceptions.CodegenException;

/**
 * Emits coroutine preamble (continuation unwrap + label dispatch) as existing blocks.
 * Resume targets that jump into loops are handled by the preamble if-chain, not by goto.
 */
public final class CoroutineDispatchRegion extends AbstractRegion {

	private final List<BlockNode> preambleBlocks;
	private final Map<Integer, BlockNode> resumeEntryByLabel;

	public CoroutineDispatchRegion(IRegion parent, StructuredCoroutineAttr attr) {
		super(parent);
		this.preambleBlocks = attr.getPreambleBlocks();
		this.resumeEntryByLabel = attr.getResumeEntryByLabel();
	}

	@Override
	public List<IContainer> getSubBlocks() {
		return Collections.unmodifiableList(preambleBlocks);
	}

	public List<BlockNode> getPreambleBlocks() {
		return preambleBlocks;
	}

	public Map<Integer, BlockNode> getResumeEntryByLabel() {
		return resumeEntryByLabel;
	}

	@Override
	public void generate(RegionGen regionGen, ICodeWriter code) throws CodegenException {
		for (BlockNode block : preambleBlocks) {
			emitBlock(regionGen, code, block);
		}
	}

	private void emitBlock(RegionGen regionGen, ICodeWriter code, BlockNode block) throws CodegenException {
		InsnNode lastInsn = BlockUtils.getLastInsn(block);
		if (lastInsn instanceof IfNode) {
			IfRegion ifRegion = new IfRegion(this);
			ifRegion.updateCondition(block);
			IfNode ifInsn = (IfNode) lastInsn;
			if (ifInsn.getThenBlock() != null) {
				Region thenRegion = new Region(ifRegion);
				thenRegion.add(ifInsn.getThenBlock());
				ifRegion.setThenRegion(thenRegion);
			}
			if (ifInsn.getElseBlock() != null && ifInsn.getElseBlock() != ifInsn.getThenBlock()) {
				Region elseRegion = new Region(ifRegion);
				elseRegion.add(ifInsn.getElseBlock());
				ifRegion.setElseRegion(elseRegion);
			}
			regionGen.makeIf(ifRegion, code, true);
			return;
		}
		regionGen.makeSimpleBlock(block, code);
	}

	@Override
	public String baseString() {
		return "COROUTINE_DISPATCH(" + preambleBlocks.size() + " preamble, "
				+ resumeEntryByLabel.size() + " resume entries)";
	}
}
