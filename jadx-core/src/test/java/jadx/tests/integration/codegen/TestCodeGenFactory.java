package jadx.tests.integration.codegen;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jadx.api.JavaClass;
import jadx.api.JadxArgs.OutputFormatEnum;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.api.IMethodGen;
import jadx.core.codegen.common.CodeGenFactory;
import jadx.core.codegen.common.MethodGenBase;
import jadx.api.JavaClass;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.tests.api.SmaliTest;

import static jadx.api.args.IntegerFormat.AUTO;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;

/**
 * Regression for {@link CodeGenFactory} null-parent construction paths (fallback / inner class).
 */
public class TestCodeGenFactory extends SmaliTest {

	@BeforeEach
	@Override
	public void init() {
		super.init();
		disableCompilation();
	}

	@Test
	public void fallbackMethodGenKotlinOutput() {
		getArgs().setOutputFormat(OutputFormatEnum.KOTLIN);
		assertFallbackMethodGenWorks(true);
	}

	@Test
	public void fallbackMethodGenJavaOutput() {
		getArgs().setOutputFormat(OutputFormatEnum.JAVA);
		assertFallbackMethodGenWorks(false);
	}

	private void assertFallbackMethodGenWorks(boolean kotlin) {
		ClassNode cls = getClassNodeFromSmali();
		MethodNode mth = cls.searchMethodByShortName("test");
		assertThat(mth).isNotNull();

		assertThatCode(() -> {
			IMethodGen mthGen = MethodGenBase.getFallbackMethodGen(mth);
			assertThat(mthGen.getClassGen().getLang().isKotlin()).isEqualTo(kotlin);
		}).doesNotThrowAnyException();
	}

	@Test
	public void createClassGenNullParentUsesRootArgsKotlin() {
		getArgs().setOutputFormat(OutputFormatEnum.KOTLIN);
		ClassNode cls = getClassNodeFromSmali();
		IClassGen classGen = CodeGenFactory.createClassGen(cls, null, false, true, true, AUTO);
		assertThat(classGen.getLang().isKotlin()).isTrue();
	}

	@Test
	public void createClassGenNullParentUsesRootArgsJava() {
		getArgs().setOutputFormat(OutputFormatEnum.JAVA);
		ClassNode cls = getClassNodeFromSmali();
		IClassGen classGen = CodeGenFactory.createClassGen(cls, null, false, true, true, AUTO);
		assertThat(classGen.getLang().isKotlin()).isFalse();
	}

	@Test
	public void createClassGenWithParentGenForInnerClass() {
		getArgs().setOutputFormat(OutputFormatEnum.KOTLIN);
		ClassNode outer = getClassNodeFromSmaliFiles("inner", "TestAnonymousClass14", "OuterCls");
		ClassNode inner = outer.getInnerClasses().stream()
				.filter(c -> "TestCls".equals(c.getClassInfo().getShortName()))
				.findFirst()
				.orElseThrow();

		IClassGen outerGen = CodeGenFactory.createClassGen(outer, getArgs());
		assertThatCode(() -> CodeGenFactory.createClassGen(inner, outerGen.getParentGen()))
				.doesNotThrowAnyException();
	}

	@Test
	public void simpleShortcutFixtureNoCodegenParentNull() {
		getArgs().setOutputFormat(OutputFormatEnum.KOTLIN);
		jadxDecompiler = loadFiles(collectSimpleShortcutSmali());
		List<ClassNode> classes = jadxDecompiler.getClasses().stream()
				.map(JavaClass::getClassNode)
				.collect(Collectors.toList());
		classes.forEach(cls -> cls.add(AFlag.DONT_UNLOAD_CLASS));
		classes.forEach(ClassNode::decompile);
		for (ClassNode cls : classes) {
			assertThat(cls.getCode().getCodeStr())
					.as("class %s", cls.getFullName())
					.doesNotContain("because \"parent\" is null");
		}
	}

	private static List<File> collectSimpleShortcutSmali() {
		File primary = new File("src/test/smali/kotlin/simpleshortcut");
		final File smaliDir = primary.exists() ? primary : new File("jadx-core/src/test/smali/kotlin/simpleshortcut");
		String[] names = smaliDir.list((d, name) -> name.endsWith(".smali"));
		assertThat(names).as("Smali fixtures in %s", smaliDir).isNotNull().isNotEmpty();
		return Stream.of(names).map(n -> new File(smaliDir, n)).collect(Collectors.toList());
	}
}
