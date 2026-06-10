package jadx.tests.integration.tiktok;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.SuspendFunctionAttr;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.kotlin.coroutine.SuspendFunctionDetector;
import jadx.tests.api.SmaliTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

public class TestSuspendFunctionDetector extends SmaliTest {

	@Test
	public void detectsTiktokLizSuspendSignature() {
		allowWarnInCode();
		MethodNode mth = loadLizMethod();
		assertThat(mth.contains(AType.SUSPEND_FUNCTION)).isTrue();
		SuspendFunctionAttr attr = mth.get(AType.SUSPEND_FUNCTION);
		assertThat(attr.getContinuationArgIndex()).isEqualTo(1);
		assertThat(attr.getSource()).isEqualTo(SuspendFunctionAttr.Source.ENTRY_CAST);

		SuspendFunctionAttr fromDetector = SuspendFunctionDetector.detect(mth);
		assertThat(fromDetector).isNotNull();
		assertThat(fromDetector.getContinuationArgIndex()).isEqualTo(attr.getContinuationArgIndex());
	}

	private MethodNode loadLizMethod() {
		jadxDecompiler = loadFiles(TestTiktokStructuredDecompile.collectFixtureSmaliFiles());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		var cls = root.getClasses(false).stream()
				.filter(node -> node.getClassInfo().getRawName().replace('/', '.').equals("X.0Jyl"))
				.findFirst()
				.orElseThrow();
		cls.add(jadx.core.dex.attributes.AFlag.DONT_UNLOAD_CLASS);
		root.getProcessClasses().forceProcess(cls);
		MethodNode mth = cls.searchMethodByShortName("LIZ");
		assertThat(mth).isNotNull();
		return mth;
	}
}
