package jadx.tests.integration.kotlin;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jadx.api.CommentsLevel;
import jadx.api.JadxArgs;
import jadx.api.JadxArgs.OutputFormatEnum;
import jadx.api.JadxDecompiler;
import jadx.api.JavaClass;
import jadx.tests.api.IntegrationTest;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * APK-level regression: codegen factory null-parent must not inflate error count.
 */
public class TestSimpleShortcutApkCodegenRegression extends IntegrationTest {

	private static final String APK_URL =
			"https://github.com/firdausmntp/SimpleShortcut/releases/download/v0.0.3/SimpleShortcut-v0.0.3.apk";
	private static final File APK_FILE = new File("build/tmp/SimpleShortcut-v0.0.3.apk");

	/**
	 * Upper bound for known region/block failures in kotlinx + AndroidX after codegen regression fix.
	 * CLI {@code jadx --show-bad-code} reports ~26 errors on this APK.
	 */
	private static final int ERROR_BUDGET = 30;

	@BeforeAll
	static void ensureApk() throws IOException {
		if (APK_FILE.exists()) {
			return;
		}
		APK_FILE.getParentFile().mkdirs();
		try (InputStream in = new URL(APK_URL).openStream()) {
			Files.copy(in, APK_FILE.toPath(), StandardCopyOption.REPLACE_EXISTING);
		}
	}

	@BeforeEach
	@Override
	public void init() {
		super.init();
		disableCompilation();
	}

	@Test
	public void kotlinDecompileErrorBudget() {
		decompileApkAndAssert(OutputFormatEnum.KOTLIN);
	}

	@Test
	public void javaDecompileErrorBudget() {
		decompileApkAndAssert(OutputFormatEnum.JAVA);
	}

	private void decompileApkAndAssert(OutputFormatEnum format) {
		JadxArgs jadxArgs = getArgs();
		jadxArgs.setOutputFormat(format);
		jadxArgs.getInputFiles().clear();
		jadxArgs.getInputFiles().add(APK_FILE);
		jadxArgs.setSkipResources(true);
		jadxArgs.setSkipFilesSave(true);
		jadxArgs.setShowInconsistentCode(true);
		jadxArgs.setRunDebugChecks(false);
		jadxArgs.setCommentsLevel(CommentsLevel.INFO);

		try (JadxDecompiler jadx = new JadxDecompiler(jadxArgs)) {
			jadx.load();
			jadx.saveSources();
			assertThat(jadx.getErrorsCount())
					.as("decompile error count (%s)", format)
					.isLessThanOrEqualTo(ERROR_BUDGET);
			for (JavaClass cls : jadx.getClasses()) {
				String code = cls.getCodeInfo().getCodeStr();
				assertThat(code)
						.as("class %s", cls.getFullName())
						.doesNotContain("because \"parent\" is null");
			}
		}
	}
}
