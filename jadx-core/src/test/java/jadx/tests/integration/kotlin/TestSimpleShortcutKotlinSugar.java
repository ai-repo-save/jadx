package jadx.tests.integration.kotlin;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jadx.api.JavaClass;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.nodes.ClassNode;
import jadx.tests.api.SmaliKotlinTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

/**
 * Kotlin syntax-sugar targets derived from SimpleShortcut v0.0.3 (release APK smali fixtures).
 * These tests intentionally assert not-yet-implemented output and MUST fail until sugar support lands.
 *
 * Smali fixtures: {@code src/test/smali/kotlin/simpleshortcut/} (exported via test-fixtures script, not in repo).
 * Release R8 build does not retain {@code DeeplinkLauncher}, {@code ShortcutViewModel}, or {@code SortMode} as named classes.
 */
public class TestSimpleShortcutKotlinSugar extends SmaliKotlinTest {

	private static final String PKG = "com.josski.simpleshortcut";
	private static final String FIXTURE = "simpleshortcut";

	private List<ClassNode> appClasses;

	@BeforeEach
	@Override
	public void init() {
		super.init();
		allowWarnInCode();
		jadxDecompiler = loadFiles(collectFixtureSmali());
		appClasses = jadxDecompiler.getClasses().stream()
				.map(JavaClass::getClassNode)
				.filter(c -> c.getFullName().startsWith(PKG))
				.collect(Collectors.toList());
		// Decompile without IntegrationTest.checkCode — fixture has known JADX errors unrelated to sugar tests.
		appClasses.forEach(cls -> cls.add(AFlag.DONT_UNLOAD_CLASS));
		appClasses.forEach(ClassNode::decompile);
	}

	@Test
	public void dataClassKeyword() {
		assertThat(load("data.Shortcut"))
				.code()
				.containsOne("data class Shortcut");
	}

	@Test
	public void dataClassPrimaryConstructorProperties() {
		assertThat(load("data.Shortcut"))
				.code()
				.containsOne("data class Shortcut(")
				.contains("val id: String");
	}

	@Test
	public void defaultParameterInInterface() {
		assertThat(load("data.ShortcutDao"))
				.code()
				.contains("now: Long = System.currentTimeMillis()")
				.doesNotContain("now: Long = j =");
	}

	@Test
	public void copyWithNamedArguments() {
		assertThat(load("data.Shortcut"))
				.code()
				.containsPattern("fun copy\\([^)]*id: String = ");
	}

	@Test
	public void companionObjectFactoryMethod() {
		assertThat(load("data.ShortcutDatabase"))
				.code()
				.containsPattern("companion object \\{[\\s\\S]*fun getDatabase");
	}

	@Test
	public void dataClassPrimaryConstructorDefaultParameters() {
		assertThat(load("data.Shortcut"))
				.code()
				.containsPattern("data class Shortcut\\([^)]*rank: Int = ");
	}

	@Test
	public void objectSingleton() {
		assertThat(load("widget.ShortcutPublisher"))
				.code()
				.containsOne("object ShortcutPublisher");
	}

	@Test
	public void suspendFunctionInDao() {
		assertThat(load("data.ShortcutDao"))
				.code()
				.contains("suspend fun insert");
	}

	@Test
	public void suspendFunctionInRepository() {
		assertThat(load("data.ShortcutRepository"))
				.code()
				.contains("suspend fun insert");
	}

	@Test
	public void lazyPropertyDelegate() {
		assertThat(load("SimpleShortcutApp"))
				.code()
				.contains("by lazy {")
				.doesNotContain("by lazy =");
	}

	@Test
	public void lateinitProperty() {
		assertThat(load("MainActivity"))
				.code()
				.contains("lateinit var");
	}

	@Test
	public void innerClassKeyword() {
		assertThat(load("widget.WidgetConfigActivity"))
				.code()
				.contains("inner class ShortcutPickerAdapter");
	}

	@Test
	public void companionObjectMigrationObject() {
		assertThat(load("data.ShortcutDatabase"))
				.code()
				.containsPattern("object : Migration");
	}

	private ClassNode load(String relativeCls) {
		return searchCls(appClasses, PKG + '.' + relativeCls);
	}

	private List<File> collectFixtureSmali() {
		File primaryDir = new File("src/test/smali/kotlin/" + FIXTURE);
		final File smaliDir = primaryDir.exists() ? primaryDir : new File("jadx-core/src/test/smali/kotlin/" + FIXTURE);
		String[] names = smaliDir.list((dir, name) -> name.endsWith(".smali"));
		if (names == null || names.length == 0) {
			throw new AssertionError("Smali fixtures not found in " + smaliDir);
		}
		return Stream.of(names).map(n -> new File(smaliDir, n)).collect(Collectors.toList());
	}
}
