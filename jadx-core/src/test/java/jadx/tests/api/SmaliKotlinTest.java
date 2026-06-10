package jadx.tests.api;

import org.junit.jupiter.api.BeforeEach;

import jadx.api.JadxArgs.OutputFormatEnum;

/**
 * Smali integration tests with Kotlin output format.
 */
public abstract class SmaliKotlinTest extends SmaliTest {

	@BeforeEach
	@Override
	public void init() {
		super.init();
		getArgs().setOutputFormat(OutputFormatEnum.KOTLIN);
		disableCompilation();
	}
}
