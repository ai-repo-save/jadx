package jadx.core.dex.regions.structured;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jadx.api.ICodeWriter;
import jadx.core.codegen.ConditionGen;
import jadx.core.codegen.RegionGen;
import jadx.core.dex.regions.conditions.IfCondition;
import jadx.core.dex.instructions.IfNode;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.IContainer;
import jadx.core.dex.nodes.IRegion;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.regions.AbstractRegion;
import jadx.core.dex.regions.Region;
import jadx.core.utils.BlockUtils;
import jadx.core.utils.exceptions.CodegenException;

/**
 * Nested loops with an inner-exit-to-outer-header edge (continue outer).
 */
public final class MultiEntryLoopRegion extends AbstractRegion {

	private static final String OUTER_LABEL = "outer";

	private final BlockNode outerHeader;
	private final BlockNode innerHeader;
	private final BlockNode innerExitToOuter;
	private final Region outerBodyRegion;
	private final Region innerBodyRegion;

	public Region getOuterBodyRegion() {
		return outerBodyRegion;
	}

	public Region getInnerBodyRegion() {
		return innerBodyRegion;
	}

	public MultiEntryLoopRegion(
			IRegion parent,
			BlockNode outerHeader,
			BlockNode innerHeader,
			BlockNode innerExitToOuter,
			Region outerBodyRegion,
			Region innerBodyRegion) {
		super(parent);
		this.outerHeader = outerHeader;
		this.innerHeader = innerHeader;
		this.innerExitToOuter = innerExitToOuter;
		this.outerBodyRegion = outerBodyRegion;
		this.innerBodyRegion = innerBodyRegion;
	}

	@Override
	public List<IContainer> getSubBlocks() {
		List<IContainer> blocks = new ArrayList<>();
		blocks.add(outerHeader);
		blocks.addAll(outerBodyRegion.getSubBlocks());
		blocks.add(innerHeader);
		blocks.addAll(innerBodyRegion.getSubBlocks());
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
		regionGen.makeRegion(code, outerBodyRegion);
		emitInnerLoop(regionGen, code);
		code.decIndent();
		code.startLine('}');
	}

	private void emitInnerLoop(RegionGen regionGen, ICodeWriter code) throws CodegenException {
		code.startLine("while (");
		emitIfCondition(regionGen, code, innerHeader);
		code.add(") {");
		code.incIndent();
		regionGen.makeRegion(code, innerBodyRegion);
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

	@Override
	public String baseString() {
		return "MULTI_ENTRY_LOOP(outer=" + outerHeader + ", inner=" + innerHeader + ')';
	}
}
