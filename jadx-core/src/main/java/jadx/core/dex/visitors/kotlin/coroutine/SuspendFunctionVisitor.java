package jadx.core.dex.visitors.kotlin.coroutine;

import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.SkipMethodArgsAttr;
import jadx.core.dex.attributes.nodes.SuspendFunctionAttr;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.AbstractVisitor;
import jadx.core.dex.visitors.JadxVisitor;
import jadx.core.utils.exceptions.JadxException;

@JadxVisitor(
		name = "SuspendFunctionVisitor",
		desc = "Detect Kotlin suspend functions from JVM signature / entry cast",
		runBefore = StateMachineVisitor.class
)
public class SuspendFunctionVisitor extends AbstractVisitor {

	@Override
	public void visit(MethodNode mth) throws JadxException {
		if (mth.contains(AType.JADX_ERROR) || mth.contains(AType.SUSPEND_FUNCTION)) {
			return;
		}
		SuspendFunctionAttr attr = SuspendFunctionDetector.detect(mth);
		if (attr != null) {
			mth.addAttr(attr);
			SkipMethodArgsAttr.skipArg(mth, attr.getContinuationArgIndex());
		}
	}

	@Override
	public String getName() {
		return "SuspendFunctionVisitor";
	}
}
