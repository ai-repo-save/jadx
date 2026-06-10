package jadx.tests.integration.tiktok;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.StateMachineAttr;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.kotlin.coroutine.StateMachineAnalyzer;
import jadx.tests.api.SmaliTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

public class TestStateMachineAnalyzer extends SmaliTest {

	@Test
	public void detectsTiktokLizStateMachine() {
		allowWarnInCode();
		MethodNode mth = loadLizMethod();
		assertThat(StateMachineAnalyzer.diagnose(mth)).isEqualTo("ok");
		assertThat(mth.contains(AType.STATE_MACHINE)).isTrue();

		StateMachineAttr attr = mth.get(AType.STATE_MACHINE);
		assertThat(attr.getLabelField().getType()).isEqualTo(jadx.core.dex.instructions.args.ArgType.INT);
		assertThat(attr.getLabelToResumeBlock()).containsKeys(0, 1, 2, 3);
		assertThat(attr.getSuspendPoints()).isNotEmpty();
		assertThat(attr.getSuspendPoints().stream().map(p -> p.getLabel())).contains(2, 3);
	}

	@Test
	public void standaloneAnalyzerMatchesVisitor() {
		allowWarnInCode();
		MethodNode mth = loadLizMethod();
		StateMachineAttr fromVisitor = mth.get(AType.STATE_MACHINE);
		StateMachineAttr fromAnalyzer = StateMachineAnalyzer.analyze(mth);
		assertThat(fromAnalyzer).isNotNull();
		assertThat(fromAnalyzer.getLabelToResumeBlock()).isEqualTo(fromVisitor.getLabelToResumeBlock());
		assertThat(fromAnalyzer.getSuspendPoints().size()).isEqualTo(fromVisitor.getSuspendPoints().size());
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
