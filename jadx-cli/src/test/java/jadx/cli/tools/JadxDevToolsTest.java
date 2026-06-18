package jadx.cli.tools;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import static org.assertj.core.api.Assertions.assertThat;

class JadxDevToolsTest {

	private static final File HELLO_SMALI = new File("src/test/resources/samples/HelloWorld.smali");

	@Test
	void exportSmaliFromHelloWorld(@TempDir Path tempDir) throws Exception {
		assertThat(HELLO_SMALI).exists();

		JadxDev.main(new String[] {
				"export-smali",
				"-i", HELLO_SMALI.getPath(),
				"-o", tempDir.toString(),
				"-c", "smali.HelloWorld",
		});

		Path smali = tempDir.resolve("smali$HelloWorld.smali");
		assertThat(Files.exists(smali)).isTrue();
		assertThat(Files.readString(smali)).contains(".class Lsmali/HelloWorld;");
	}

	@Test
	void inspectMethodHelloWorld() {
		assertThat(HELLO_SMALI).exists();
		JadxDev.main(new String[] {
				"inspect-method",
				"-i", HELLO_SMALI.getPath(),
				"-c", "smali.HelloWorld",
				"-m", "main",
				"--no-code",
				"--insns",
		});
	}

	@Test
	void dumpCfgHelloWorld(@TempDir Path tempDir) {
		assertThat(HELLO_SMALI).exists();
		JadxDev.main(new String[] {
				"dump-cfg",
				"-i", HELLO_SMALI.getPath(),
				"-o", tempDir.toString(),
				"-c", "smali.HelloWorld",
				"-m", "main",
				"--mode", "raw",
		});
		assertThat(tempDir.toFile().listFiles()).isNotEmpty();
	}
}
