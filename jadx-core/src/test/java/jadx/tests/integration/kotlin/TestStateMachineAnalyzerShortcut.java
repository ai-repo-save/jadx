package jadx.tests.integration.kotlin;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.jupiter.api.Test;

import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.kotlin.coroutine.StateMachineAnalyzer;
import jadx.tests.api.SmaliKotlinTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

/**
 * Regression for StateMachineAnalyzer false positives on non-coroutine Kotlin bytecode.
 *
 * ShortcutPublisher.publishDynamicShortcuts contains {@code invoke-static {}, X1()V} (index overflow helper)
 * which must not be treated as {@code getCOROUTINE_SUSPENDED()} (void vs Object-returning marker).
 */
public class TestStateMachineAnalyzerShortcut extends SmaliKotlinTest {

	@Test
	public void nonCoroutineMethodHasNoStateMachine() {
		allowWarnInCode();
		ClassNode cls = getClassNodeFromSmali("kotlin/simpleshortcut/widget$ShortcutPublisher",
				"com.josski.simpleshortcut.widget.ShortcutPublisher");
		MethodNode mth = cls.searchMethodByShortName("publishDynamicShortcuts");
		assertThat(mth).isNotNull();
		assertThat(mth.contains(AType.JADX_ERROR)).isFalse();
		assertThat(mth.contains(AType.STATE_MACHINE)).isFalse();
		assertThat(StateMachineAnalyzer.diagnose(mth)).isEqualTo("no-suspended-marker");
		assertThat(StateMachineAnalyzer.analyze(mth)).isNull();
		assertThat(cls)
				.code()
				.contains("fun publishDynamicShortcuts")
				.doesNotContain("JADX ERROR")
				.doesNotContain("Method not decompiled");
	}

	@Test
	public void coroutineLambdaInvokeSuspendDoesNotThrow() {
		allowWarnInCode();
		ClassNode cls = getClassNodeFromFiles(collectSimpleShortcutSmali(), "com.josski.simpleshortcut.widget.a");
		MethodNode mth = cls.searchMethodByShortName("invokeSuspend");
		assertThat(mth).isNotNull();
		assertThat(mth.contains(AType.JADX_ERROR)).isFalse();
		assertThat(StateMachineAnalyzer.analyze(mth)).isNull();
	}

	@Test
	public void suspendRepositoryMethodDetectsStateMachine() {
		allowWarnInCode();
		ClassNode cls = getClassNodeFromFiles(collectSimpleShortcutSmali(),
				"com.josski.simpleshortcut.data.ShortcutRepository");
		MethodNode mth = cls.searchMethodByShortId("insert(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;");
		assertThat(mth).isNotNull();
		assertThat(mth.contains(AType.JADX_ERROR)).isFalse();
		assertThat(StateMachineAnalyzer.diagnose(mth)).isEqualTo("ok");
		assertThat(mth.contains(AType.STATE_MACHINE)).isTrue();
	}

	private static List<File> collectSimpleShortcutSmali() {
		File dir = new File("src/test/smali/kotlin/simpleshortcut");
		String[] names = dir.list((d, name) -> name.endsWith(".smali"));
		return Stream.of(names).map(n -> new File(dir, n)).collect(Collectors.toList());
	}
}
