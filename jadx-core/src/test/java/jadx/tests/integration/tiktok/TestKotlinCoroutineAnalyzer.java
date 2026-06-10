package jadx.tests.integration.tiktok;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.attributes.nodes.KotlinCoroutineAttr;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.kotlin.coroutine.KotlinCoroutineAnalyzer;
import jadx.tests.api.SmaliTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

public class TestKotlinCoroutineAnalyzer extends SmaliTest {

	@Test
	public void detectsTiktokLizStateMachine() {
		allowWarnInCode();
		MethodNode mth = loadLizMethod();
		assertThat(KotlinCoroutineAnalyzer.diagnose(mth)).isEqualTo("ok");
		assertThat(mth.contains(AType.KOTLIN_COROUTINE)).isTrue();

		KotlinCoroutineAttr attr = mth.get(AType.KOTLIN_COROUTINE);
		assertThat(attr.getLabelField().getType()).isEqualTo(jadx.core.dex.instructions.args.ArgType.INT);
		assertThat(attr.getLabelToResumeBlock()).containsKeys(0, 1, 2, 3);
		assertThat(attr.getSuspendPoints()).isNotEmpty();
		assertThat(attr.getSuspendPoints().stream().map(p -> p.getLabel())).contains(2, 3);
	}

	@Test
	public void standaloneAnalyzerMatchesVisitor() {
		allowWarnInCode();
		MethodNode mth = loadLizMethod();
		KotlinCoroutineAttr fromVisitor = mth.get(AType.KOTLIN_COROUTINE);
		KotlinCoroutineAttr fromAnalyzer = KotlinCoroutineAnalyzer.analyze(mth);
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
