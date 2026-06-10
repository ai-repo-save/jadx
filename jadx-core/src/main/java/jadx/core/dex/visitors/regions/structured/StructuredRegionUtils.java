package jadx.core.dex.visitors.regions.structured;

import java.util.concurrent.atomic.AtomicBoolean;

import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.regions.structured.MultiEntryLoopRegion;
import jadx.core.utils.RegionUtils;

/**
 * Helpers for methods whose region tree was built by {@link StructuredRegionBuilder}.
 */
public final class StructuredRegionUtils {

	private StructuredRegionUtils() {
	}

	public static boolean hasMultiEntryLoopRegion(MethodNode mth) {
		if (mth.getRegion() == null) {
			return false;
		}
		AtomicBoolean found = new AtomicBoolean();
		RegionUtils.visitRegions(mth, mth.getRegion(), region -> {
			if (region instanceof MultiEntryLoopRegion) {
				found.set(true);
				return false;
			}
			return true;
		});
		return found.get();
	}

	public static boolean isStructuredMethod(MethodNode mth) {
		return mth.getRegion() != null && hasMultiEntryLoopRegion(mth);
	}
}
