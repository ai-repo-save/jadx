package jadx.core.dex.attributes.nodes;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import jadx.api.plugins.input.data.attributes.IJadxAttribute;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.BlockNode;
public class StructuredCoroutineAttr implements IJadxAttribute {

	private final BlockNode outerHeader;
	private final BlockNode innerHeader;
	private final BlockNode innerExitToOuter;
	private final BlockNode innerResumeEntry;
	private final BlockNode outerResumeEntry;
	private final List<BlockNode> preambleBlocks;
	private final Map<Integer, BlockNode> resumeEntryByLabel;
	private final List<BlockNode> postLoopBlocks;

	public StructuredCoroutineAttr(
			BlockNode outerHeader,
			BlockNode innerHeader,
			BlockNode innerExitToOuter,
			BlockNode innerResumeEntry,
			BlockNode outerResumeEntry,
			List<BlockNode> preambleBlocks,
			Map<Integer, BlockNode> resumeEntryByLabel,
			List<BlockNode> postLoopBlocks) {
		this.outerHeader = outerHeader;
		this.innerHeader = innerHeader;
		this.innerExitToOuter = innerExitToOuter;
		this.innerResumeEntry = innerResumeEntry;
		this.outerResumeEntry = outerResumeEntry;
		this.preambleBlocks = Collections.unmodifiableList(preambleBlocks);
		this.resumeEntryByLabel = Collections.unmodifiableMap(resumeEntryByLabel);
		this.postLoopBlocks = Collections.unmodifiableList(postLoopBlocks);
	}

	public BlockNode getOuterHeader() {
		return outerHeader;
	}

	public BlockNode getInnerHeader() {
		return innerHeader;
	}

	public BlockNode getInnerExitToOuter() {
		return innerExitToOuter;
	}

	public BlockNode getInnerResumeEntry() {
		return innerResumeEntry;
	}

	public BlockNode getOuterResumeEntry() {
		return outerResumeEntry;
	}

	public List<BlockNode> getPreambleBlocks() {
		return preambleBlocks;
	}

	public Map<Integer, BlockNode> getResumeEntryByLabel() {
		return resumeEntryByLabel;
	}

	public List<BlockNode> getPostLoopBlocks() {
		return postLoopBlocks;
	}

	@Override
	public AType<StructuredCoroutineAttr> getAttrType() {
		return AType.STRUCTURED_COROUTINE;
	}
}
