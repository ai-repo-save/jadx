package jadx.core.dex.visitors.kotlin.coroutine;

import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.StateMachineAttr;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.AbstractVisitor;
import jadx.core.dex.visitors.JadxVisitor;
import jadx.core.dex.visitors.regions.structured.StructuredRegionMakerVisitor;
import jadx.core.utils.exceptions.JadxException;

@JadxVisitor(
		name = "StateMachineVisitor",
		desc = "Extract Kotlin CPS state-machine model (label dispatch + suspend sites)",
		runBefore = StructuredRegionMakerVisitor.class
)
public class StateMachineVisitor extends AbstractVisitor {

	@Override
	public void visit(MethodNode mth) throws JadxException {
		if (mth.isNoCode() || mth.getBasicBlocks().isEmpty() || mth.contains(AType.JADX_ERROR)) {
			return;
		}
		if (mth.contains(AType.STATE_MACHINE)) {
			return;
		}
		StateMachineAttr attr = StateMachineAnalyzer.analyze(mth);
		if (attr != null) {
			mth.addAttr(attr);
		}
	}

	@Override
	public String getName() {
		return "StateMachineVisitor";
	}
}
