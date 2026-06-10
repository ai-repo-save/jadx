package jadx.tests.integration.others;

import org.junit.jupiter.api.Test;

import jadx.tests.api.SmaliKotlinTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

public class TestInsnsBeforeSuperKotlin extends SmaliKotlinTest {

	@Test
	public void test() {
		allowWarnInCode();
		assertThat(getClassNodeFromSmaliFiles("others", "TestInsnsBeforeSuper", "B"))
				.code()
				.containsOne("checkNull(str);")
				.containsOne("super(str);")
				.containsOne("constructor(str: String)");
	}
}
