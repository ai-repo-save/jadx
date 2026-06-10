package jadx.core.dex.regions.structured;

import java.util.ArrayList;
import java.util.List;

import jadx.api.ICodeWriter;
import jadx.core.codegen.ConditionGen;
import jadx.core.codegen.RegionGen;
import jadx.core.dex.attributes.nodes.LoopInfo;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.IContainer;
import jadx.core.dex.nodes.IRegion;
import jadx.core.dex.regions.AbstractRegion;
import jadx.core.dex.regions.Region;
import jadx.core.dex.regions.conditions.IfCondition;
import jadx.core.utils.exceptions.CodegenException;

/**
 * Labeled outer {@code while} whose body is built by {@link jadx.core.dex.visitors.regions.maker.RegionMaker}.
 * Emits {@code continue outer} when an inner loop exits back to the outer header.
 * <p>
 * Multi-entry resume paths and inner loops are handled elsewhere ({@link CoroutineDispatchRegion},
 * {@link jadx.core.dex.visitors.regions.structured.NestedMultiEntryLoopDetector}).
 */
public final class LabeledOuterLoopRegion extends AbstractRegion {

	private static final String OUTER_LABEL = "outer";

	private final LoopInfo outerLoop;
	private final BlockNode outerHeader;
	private final boolean continueOuterAfterBody;
	private final Region bodyRegion;

	public Region getBodyRegion() {
		return bodyRegion;
	}

	public LabeledOuterLoopRegion(
			IRegion parent,
			LoopInfo outerLoop,
			BlockNode outerHeader,
			boolean continueOuterAfterBody,
			Region bodyRegion) {
		super(parent);
		this.outerLoop = outerLoop;
		this.outerHeader = outerHeader;
		this.continueOuterAfterBody = continueOuterAfterBody;
		this.bodyRegion = bodyRegion;
	}

	@Override
	public List<IContainer> getSubBlocks() {
		List<IContainer> blocks = new ArrayList<>();
		blocks.add(outerHeader);
		blocks.addAll(bodyRegion.getSubBlocks());
		return blocks;
	}

	@Override
	public void generate(RegionGen regionGen, ICodeWriter code) throws CodegenException {
		code.startLine(OUTER_LABEL + ": ");
		code.add("while (");
		emitLoopCondition(regionGen, code, outerLoop, outerHeader);
		code.add(") {");
		code.incIndent();
		regionGen.makeRegion(code, bodyRegion);
		if (continueOuterAfterBody) {
			code.startLine("continue " + OUTER_LABEL + ';');
		}
		code.decIndent();
		code.startLine('}');
	}

	private static void emitLoopCondition(RegionGen regionGen, ICodeWriter code, LoopInfo loop, BlockNode header)
			throws CodegenException {
		IfCondition condition = IfCondition.buildLoopWhileCondition(loop, header);
		if (condition != null) {
			new ConditionGen(regionGen).add(code, condition);
		} else {
			code.add("true");
		}
	}

	@Override
	public String baseString() {
		return "LABELED_OUTER_LOOP(outer=" + outerHeader + ')';
	}
}
