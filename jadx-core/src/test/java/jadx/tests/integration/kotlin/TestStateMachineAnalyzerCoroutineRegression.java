package jadx.tests.integration.kotlin;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.kotlin.coroutine.StateMachineAnalyzer;
import jadx.tests.api.SmaliKotlinTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

/**
 * State-machine detection targets from SimpleShortcut v0.0.3 release APK (kotlinx-coroutines / Room).
 * Smali exported to {@code src/test/smali/kotlin/coroutine-regression/} — no APK in tests.
 *
 * <p>These tests assert {@link StateMachineAnalyzer} recognizes each CPS shape (via
 * {@link StateMachineAnalyzer#diagnose} and {@link StateMachineAnalyzer#analyze}), even when the
 * method already carries {@code JADX_ERROR} from unrelated region passes.
 * <ul>
 *   <li>{@code p3.y.n} — {@code ReceiveChannel.consume} ({@code Channels.common.kt})</li>
 *   <li>{@code s3.q0.c} — {@code StateFlowImpl.collect} ({@code StateFlow.kt})</li>
 *   <li>{@code t3.f0.m} — {@code MutexImpl.lockSuspend} ({@code Mutex.kt})</li>
 *   <li>{@code androidx.room.d.invokeSuspend} — Room-generated coroutine lambda</li>
 * </ul>
 */
public class TestStateMachineAnalyzerCoroutineRegression extends SmaliKotlinTest {

	@Test
	public void channelConsumeDetectsStateMachine() {
		allowWarnInCode();
		MethodNode mth = loadMethod("p3.y", "n(Ls3/f;Lr3/j;ZLz2/e;)Ljava/lang/Object;");
		assertThat(StateMachineAnalyzer.diagnose(mth)).isEqualTo("ok");
		assertThat(StateMachineAnalyzer.analyze(mth)).isNotNull();
	}

	@Test
	public void stateFlowCollectDetectsStateMachine() {
		allowWarnInCode();
		MethodNode mth = loadMethod("s3.q0", "c(Ls3/f;Lz2/e;)Ljava/lang/Object;");
		assertThat(StateMachineAnalyzer.diagnose(mth)).isEqualTo("ok");
		assertThat(StateMachineAnalyzer.analyze(mth)).isNotNull();
	}

	@Test
	public void mutexLockSuspendDetectsStateMachine() {
		allowWarnInCode();
		MethodNode mth = loadMethod("t3.f0", "m(Lt3/f0;Ls3/f;Lz2/e;)V");
		assertThat(StateMachineAnalyzer.diagnose(mth)).isEqualTo("ok");
		assertThat(StateMachineAnalyzer.analyze(mth)).isNotNull();
	}

	@Test
	public void roomCoroutineLambdaDetectsStateMachine() {
		allowWarnInCode();
		MethodNode mth = loadMethod("androidx.room.d", "invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;");
		assertThat(StateMachineAnalyzer.diagnose(mth)).isEqualTo("ok");
		assertThat(StateMachineAnalyzer.analyze(mth)).isNotNull();
	}

	private MethodNode loadMethod(String clsName, String shortId) {
		jadxDecompiler = loadFiles(collectFixtureSmali());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		ClassNode cls = root.resolveClass(clsName);
		assertThat(cls).as("class %s", clsName).isNotNull();
		cls.add(AFlag.DONT_UNLOAD_CLASS);
		root.getProcessClasses().forceProcess(cls);
		MethodNode mth = cls.searchMethodByShortId(shortId);
		assertThat(mth).as("method %s#%s", clsName, shortId).isNotNull();
		return mth;
	}

	private static List<File> collectFixtureSmali() {
		File primaryDir = new File("src/test/smali/kotlin/coroutine-regression");
		final File smaliDir = primaryDir.exists() ? primaryDir
				: new File("jadx-core/src/test/smali/kotlin/coroutine-regression");
		String[] names = smaliDir.list((dir, name) -> name.endsWith(".smali"));
		if (names == null || names.length == 0) {
			throw new AssertionError("Smali fixtures not found in " + smaliDir);
		}
		return Stream.of(names).map(n -> new File(smaliDir, n)).collect(Collectors.toList());
	}
}
