package jadx.core.dex.visitors.kotlin.coroutine;

import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.KotlinCoroutineAttr;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.AbstractVisitor;
import jadx.core.dex.visitors.JadxVisitor;
import jadx.core.dex.visitors.regions.structured.StructuredRegionMakerVisitor;
import jadx.core.utils.exceptions.JadxException;

@JadxVisitor(
		name = "KotlinCoroutineVisitor",
		desc = "Detect Kotlin coroutine state machines and build label/suspend model",
		runBefore = StructuredRegionMakerVisitor.class
)
public class KotlinCoroutineVisitor extends AbstractVisitor {

	@Override
	public void visit(MethodNode mth) throws JadxException {
		if (mth.isNoCode() || mth.getBasicBlocks().isEmpty() || mth.contains(AType.JADX_ERROR)) {
			return;
		}
		if (mth.contains(AType.KOTLIN_COROUTINE)) {
			return;
		}
		KotlinCoroutineAttr attr = KotlinCoroutineAnalyzer.analyze(mth);
		if (attr != null) {
			mth.addAttr(attr);
		}
	}

	@Override
	public String getName() {
		return "KotlinCoroutineVisitor";
	}
}
