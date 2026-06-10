package jadx.tests.integration.tiktok;

import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.regions.structured.MultiEntryLoopRegion;
import jadx.core.utils.RegionUtils;
import jadx.tests.api.SmaliTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

public class TestTiktokStructuredDecompile extends SmaliTest {

	@Test
	public void testLizUsesStructuredRegions() {
		allowWarnInCode();
		enableDeobfuscation();
		MethodNode mth = loadProcessedTargetMethod();
		assertThat(mth.contains(AType.STRUCTURED_COROUTINE)).isTrue();
		assertThat(mth.getRegion()).isNotNull();
		AtomicReference<MultiEntryLoopRegion> loopRegion = new AtomicReference<>();
		RegionUtils.visitRegions(mth, mth.getRegion(), region -> {
			if (region instanceof MultiEntryLoopRegion) {
				loopRegion.set((MultiEntryLoopRegion) region);
				return false;
			}
			return true;
		});
		assertThat(loopRegion.get()).isNotNull();
		assertThat(loopRegion.get().getOuterBodyRegion().getSubBlocks().size()
				+ loopRegion.get().getInnerBodyRegion().getSubBlocks().size())
				.as("structured loop body regions")
				.isGreaterThan(0);
	}

	@Test
	public void testLizDecompilesWithoutRegionOverflow() {
		allowWarnInCode();
		enableDeobfuscation();
		jadxDecompiler = loadFiles(collectFixtureSmaliFiles());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		ClassNode cls = root.getClasses(false).stream()
				.filter(node -> node.getClassInfo().getRawName().replace('/', '.').equals("X.0Jyl"))
				.findFirst()
				.orElseThrow();
		cls.add(jadx.core.dex.attributes.AFlag.DONT_UNLOAD_CLASS);
		root.getProcessClasses().generateCode(cls);

		String code = cls.getCode().getCodeStr();
		assertThat(code)
				.doesNotContain("JadxOverflowException")
				.doesNotContain("Regions count limit reached")
				.doesNotContain("UnsupportedOperationException(\"Method not decompiled")
				.doesNotContain("Method dump skipped")
				.contains("outer:")
				.contains("continue outer");
	}

	private MethodNode loadProcessedTargetMethod() {
		jadxDecompiler = loadFiles(collectFixtureSmaliFiles());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		ClassNode cls = root.getClasses(false).stream()
				.filter(node -> node.getClassInfo().getRawName().replace('/', '.').equals("X.0Jyl"))
				.findFirst()
				.orElseThrow(() -> new AssertionError("Class not found: X.0Jyl"));
		cls.add(jadx.core.dex.attributes.AFlag.DONT_UNLOAD_CLASS);
		root.getProcessClasses().forceProcess(cls);

		MethodNode mth = cls.searchMethodByShortName("LIZ");
		assertThat(mth).isNotNull();
		return mth;
	}

	private static List<File> collectFixtureSmaliFiles() {
		File smaliDir = new File("src/test/smali/tiktok/TestTiktokC509690Jyl");
		if (!smaliDir.exists()) {
			smaliDir = new File("jadx-core/src/test/smali/tiktok/TestTiktokC509690Jyl");
		}
		File[] files = smaliDir.listFiles((dir, name) -> name.endsWith(".smali"));
		assertThat(files).as("Smali files not found in " + smaliDir).isNotNull();
		return Arrays.stream(files)
				.sorted(Comparator.comparing(File::getName))
				.collect(Collectors.toList());
	}
}
