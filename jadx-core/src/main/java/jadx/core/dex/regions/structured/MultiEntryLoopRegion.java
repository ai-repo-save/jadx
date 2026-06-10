package jadx.core.dex.regions.structured;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import jadx.api.ICodeWriter;
import jadx.core.codegen.ConditionGen;
import jadx.core.codegen.RegionGen;
import jadx.core.dex.regions.conditions.IfCondition;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.instructions.InsnType;
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
 * Nested loops with an inner-exit-to-outer-header edge (continue outer).
 * Suspend resume entries into loop headers are emitted as guarded blocks, not goto.
 */
public final class MultiEntryLoopRegion extends AbstractRegion {

	private static final String OUTER_LABEL = "outer";

	private final BlockNode outerHeader;
	private final BlockNode innerHeader;
	private final BlockNode innerExitToOuter;
	private final BlockNode innerResumeEntry;
	private final BlockNode outerResumeEntry;
	private final List<BlockNode> outerBodyBlocks;
	private final List<BlockNode> innerBodyBlocks;
	private final Set<BlockNode> emittedBlocks;

	public MultiEntryLoopRegion(
			IRegion parent,
			BlockNode outerHeader,
			BlockNode innerHeader,
			BlockNode innerExitToOuter,
			BlockNode innerResumeEntry,
			BlockNode outerResumeEntry,
			List<BlockNode> outerBodyBlocks,
			List<BlockNode> innerBodyBlocks) {
		super(parent);
		this.outerHeader = outerHeader;
		this.innerHeader = innerHeader;
		this.innerExitToOuter = innerExitToOuter;
		this.innerResumeEntry = innerResumeEntry;
		this.outerResumeEntry = outerResumeEntry;
		this.outerBodyBlocks = Collections.unmodifiableList(outerBodyBlocks);
		this.innerBodyBlocks = Collections.unmodifiableList(innerBodyBlocks);
		this.emittedBlocks = new HashSet<>();
	}

	@Override
	public List<IContainer> getSubBlocks() {
		List<IContainer> blocks = new ArrayList<>();
		blocks.add(outerHeader);
		blocks.addAll(outerBodyBlocks);
		blocks.add(innerHeader);
		blocks.addAll(innerBodyBlocks);
		if (innerExitToOuter != null) {
			blocks.add(innerExitToOuter);
		}
		return blocks;
	}

	@Override
	public void generate(RegionGen regionGen, ICodeWriter code) throws CodegenException {
		code.startLine(OUTER_LABEL + ": ");
		emitOuterHeaderCondition(regionGen, code);

		code.incIndent();
		emitBlocks(regionGen, code, outerBodyBlocks);
		emitInnerLoop(regionGen, code);
		code.decIndent();
		code.startLine('}');
	}

	private void emitInnerLoop(RegionGen regionGen, ICodeWriter code) throws CodegenException {
		code.startLine("while (");
		emitIfCondition(regionGen, code, innerHeader);
		code.add(") {");
		code.incIndent();
		emitBlocks(regionGen, code, innerBodyBlocks);
		code.decIndent();
		code.startLine('}');
		if (innerExitToOuter != null) {
			code.startLine("continue " + OUTER_LABEL + ';');
		}
	}

	private void emitOuterHeaderCondition(RegionGen regionGen, ICodeWriter code) throws CodegenException {
		code.add("while (");
		emitIfCondition(regionGen, code, outerHeader);
		code.add(") {");
	}

	private static void emitIfCondition(RegionGen regionGen, ICodeWriter code, BlockNode header) throws CodegenException {
		InsnNode condInsn = BlockUtils.getLastInsn(header);
		if (condInsn instanceof IfNode) {
			new ConditionGen(regionGen).add(code, IfCondition.fromIfNode((IfNode) condInsn));
		} else {
			code.add("true");
		}
	}

	private void emitBlocks(RegionGen regionGen, ICodeWriter code, List<BlockNode> blocks) throws CodegenException {
		for (BlockNode block : blocks) {
			if (!emittedBlocks.add(block)) {
				continue;
			}
			if (block == outerHeader || block == innerHeader) {
				continue;
			}
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
		return "MULTI_ENTRY_LOOP(outer=" + outerHeader + ", inner=" + innerHeader + ')';
	}
}
