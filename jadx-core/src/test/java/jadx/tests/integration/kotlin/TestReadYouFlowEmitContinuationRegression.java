package jadx.tests.integration.kotlin;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
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
 * <p>Two related failures on the same {@code invokeSuspend}:
 * <ul>
 *   <li>{@link jadx.core.dex.visitors.ModVisitor#removeCheckCast} narrows immutable {@code this}
 *       from {@code Continuation} to concrete {@code emit$1} (needs kotlin stdlib + outer
 *       {@code SuspendLambda} context in fixture)</li>
 *   <li>Invoke codegen drops the second {@code emit(Z, Continuation)} argument (after ModVisitor)</li>
 * </ul>
 */
public class TestReadYouFlowEmitContinuationRegression extends SmaliKotlinTest {

	private static final String EMIT_CLS =
			"me.ash.reader.ui.page.home.flow.PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1";

	private static final String INVOKE_SUSPEND =
			"invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;";

	@Test
	public void flowEmitModVisitorDoesNotNarrowImmutableThis() {
		allowWarnInCode();
		MethodNode mth = loadInvokeSuspend();
		assertThat(mth.contains(AType.JADX_ERROR))
				.as("ModVisitor.removeCheckCast must not fail on immutable Continuation `this`")
				.isFalse();
		assertThat(mth)
				.code()
				.doesNotContain("pass: ModVisitor")
				.doesNotContain("Can't change immutable type kotlin.coroutines.Continuation")
				.doesNotContain("Method not decompiled")
				.doesNotContain("UnsupportedOperationException");
	}

	@Test
	public void flowEmitContinuationImplDecompiles() {
		allowWarnInCode();
		MethodNode mth = loadInvokeSuspend();
		assertThat(mth.contains(AType.JADX_ERROR)).isFalse();
		assertThat(mth)
				.code()
				.contains("invokeSuspend")
				.contains("emit")
				.contains("this")
				.doesNotContain("UnsupportedOperationException")
				.doesNotContain("Method not decompiled")
				.contains("emit(false, this)");
	}

	private MethodNode loadInvokeSuspend() {
		jadxDecompiler = loadFiles(collectFixtureSmali());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		ClassNode cls = root.resolveClass(EMIT_CLS);
		assertThat(cls).as("class %s", EMIT_CLS).isNotNull();
		cls.add(AFlag.DONT_UNLOAD_CLASS);
		root.getProcessClasses().forceProcess(cls);
		MethodNode mth = cls.searchMethodByShortId(INVOKE_SUSPEND);
		assertThat(mth).as("method %s#%s", EMIT_CLS, INVOKE_SUSPEND).isNotNull();
		return mth;
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
