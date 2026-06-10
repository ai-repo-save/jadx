package jadx.core.dex.regions.structured;

import java.util.Collections;
import java.util.List;

import jadx.api.ICodeWriter;
import jadx.core.codegen.RegionGen;
import jadx.core.dex.nodes.IContainer;
import jadx.core.dex.nodes.IRegion;
import jadx.core.dex.regions.AbstractRegion;
import jadx.core.dex.regions.Region;
import jadx.core.utils.exceptions.CodegenException;

/**
 * Emits coroutine preamble (continuation unwrap + label dispatch) as structured regions.
 */
public final class CoroutineDispatchRegion extends AbstractRegion {

	private final Region preambleRegion;

	public CoroutineDispatchRegion(IRegion parent, Region preambleRegion) {
		super(parent);
		this.preambleRegion = preambleRegion;
	}

	@Override
	public List<IContainer> getSubBlocks() {
		return Collections.unmodifiableList(preambleRegion.getSubBlocks());
	}

	public Region getPreambleRegion() {
		return preambleRegion;
	}

	@Override
	public void generate(RegionGen regionGen, ICodeWriter code) throws CodegenException {
		regionGen.makeRegion(code, preambleRegion);
	}

	@Override
	public String baseString() {
		return "COROUTINE_DISPATCH" + preambleRegion.baseString();
	}
}
