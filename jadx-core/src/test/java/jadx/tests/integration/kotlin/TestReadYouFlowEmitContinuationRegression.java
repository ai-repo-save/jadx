package jadx.tests.integration.kotlin;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.jupiter.api.Test;

import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.tests.api.SmaliKotlinTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

/**
 * Read You 0.16.1 regression: Kotlin Flow {@code emit} {@link kotlin.coroutines.jvm.internal.ContinuationImpl}.
 *
 * <p>Bytecode pattern (smali fixture from {@code PullToSyncIndicatorKt$...$emit$1}):
 * <pre>
 *   label |= 0x80000000
 *   this$0.emit(false, this)   // pass continuation impl as Continuation arg
 * </pre>
 *
 * <p>Minimal fixture proves invoke codegen drops the second {@code emit} argument ({@code this} as
 * {@code Continuation}). Full APK may additionally hit ModVisitor {@code removeCheckCast} on the
 * same method; that path is not required for this test to fail.
 */
public class TestReadYouFlowEmitContinuationRegression extends SmaliKotlinTest {

	private static final String EMIT_CLS =
			"me.ash.reader.ui.page.home.flow.PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1";

	@Test
	public void flowEmitContinuationImplDecompiles() {
		allowWarnInCode();
		ClassNode cls = getClassNodeFromFiles(collectFixtureSmali(), EMIT_CLS);
		MethodNode mth = cls.searchMethodByShortId("invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;");
		assertThat(mth).isNotNull();
		assertThat(mth.contains(AType.JADX_ERROR)).isFalse();
		// invokeSuspend must pass `this` as Continuation to emit(Z, Continuation)
		assertThat(mth)
				.code()
				.contains("invokeSuspend")
				.contains("emit")
				.contains("this")
				.doesNotContain("UnsupportedOperationException")
				.doesNotContain("Method not decompiled")
				.contains("emit(false, this)");
	}

	private static List<File> collectFixtureSmali() {
		File primaryDir = new File("src/test/smali/kotlin/readyou-flow-emit-regression");
		final File smaliDir = primaryDir.exists() ? primaryDir
				: new File("jadx-core/src/test/smali/kotlin/readyou-flow-emit-regression");
		String[] names = smaliDir.list((dir, name) -> name.endsWith(".smali"));
		if (names == null || names.length == 0) {
			throw new AssertionError("Smali fixtures not found in " + smaliDir);
		}
		return Stream.of(names).map(n -> new File(smaliDir, n)).collect(Collectors.toList());
	}
}
