package jadx.core.dex.visitors.regions.structured;

import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.regions.Region;
import jadx.core.dex.visitors.AbstractVisitor;
import jadx.core.dex.visitors.JadxVisitor;
import jadx.core.dex.visitors.regions.RegionMakerVisitor;
import jadx.core.utils.exceptions.JadxException;

@JadxVisitor(
		name = "StructuredRegionMakerVisitor",
		desc = "Build structured coroutine regions (dispatch preamble + labeled outer loop)",
		runBefore = RegionMakerVisitor.class
)
public class StructuredRegionMakerVisitor extends AbstractVisitor {

	@Override
	public void visit(MethodNode mth) throws JadxException {
		if (mth.isNoCode() || mth.getBasicBlocks().isEmpty() || mth.contains(AType.JADX_ERROR)) {
			return;
		}
		Region structuredRegion = StructuredRegionBuilder.build(mth);
		if (structuredRegion == null) {
			return;
		}
		mth.setRegion(structuredRegion);
	}

	public static boolean isStructured(MethodNode mth) {
		return StructuredRegionUtils.isStructuredMethod(mth);
	}
}
