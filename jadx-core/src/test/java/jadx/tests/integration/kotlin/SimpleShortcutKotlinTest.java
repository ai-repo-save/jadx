package jadx.tests.integration.kotlin;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.stream.Stream;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jadx.api.JadxArgs.OutputFormatEnum;
import jadx.core.dex.nodes.ClassNode;
import jadx.tests.api.IntegrationTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;
import static org.junit.jupiter.api.Assumptions.assumeTrue;

/**
 * Regression test for Kotlin output using a real Kotlin APK (SimpleShortcut).
 * APK is not committed; place it at {@code test-fixtures/apk/simpleshortcut-0.0.3.apk}
 * or set env {@code JADX_KOTLIN_TEST_APK}.
 */
public class SimpleShortcutKotlinTest extends IntegrationTest {

	private static final String MAIN_ACTIVITY = "com.josski.simpleshortcut.MainActivity";
	private static final String SHORTCUT = "com.josski.simpleshortcut.data.Shortcut";

	@BeforeEach
	@Override
	public void init() {
		super.init();
		getArgs().setOutputFormat(OutputFormatEnum.KOTLIN);
		getArgs().setSkipResources(true);
		disableCompilation();
		allowWarnInCode();
	}

	@Test
	public void testMainActivityKotlinSyntax() {
		File apk = findTestApk();
		assumeTrue(apk != null, "SimpleShortcut APK not found (see test-fixtures/apk/)");

		ClassNode cls = getClassNodeFromFiles(Collections.singletonList(apk), MAIN_ACTIVITY);
		assertThat(cls)
				.code()
				.contains("class MainActivity")
				.doesNotContain("public final class")
				.doesNotContain("@Override")
				.doesNotContain("@Metadata")
				.doesNotContain(" throws ")
				.contains("val ")
				.containsPattern("val \\w+: Int")
				.contains("override fun")
				.contains("obj: Any");
	}

	@Test
	public void testShortcutDataClassFields() {
		File apk = findTestApk();
		assumeTrue(apk != null, "SimpleShortcut APK not found (see test-fixtures/apk/)");

		ClassNode cls = getClassNodeFromFiles(Collections.singletonList(apk), SHORTCUT);
		assertThat(cls)
				.code()
				.contains("class Shortcut")
				.doesNotContain("public final")
				.contains("private val ");
	}

	private static File findTestApk() {
		String envPath = System.getenv("JADX_KOTLIN_TEST_APK");
		Stream<Path> candidates = Stream.of(
				Paths.get("../../test-fixtures/apk/simpleshortcut-0.0.3.apk"),
				Paths.get("../test-fixtures/apk/simpleshortcut-0.0.3.apk"),
				Paths.get("test-fixtures/apk/simpleshortcut-0.0.3.apk"));
		if (envPath != null) {
			candidates = Stream.concat(Stream.of(Paths.get(envPath)), candidates);
		}
		return candidates
				.map(Path::toAbsolutePath)
				.filter(Files::isRegularFile)
				.map(Path::toFile)
				.findFirst()
				.orElse(null);
	}
}
