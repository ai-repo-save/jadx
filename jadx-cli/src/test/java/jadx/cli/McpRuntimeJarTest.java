package jadx.cli;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.stream.Collectors;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class McpRuntimeJarTest {
	private static final Path MCP_RUNTIME_JAR = Path.of("../build/jadx/lib/jadx-mcp-runtime.jar");

	private static final List<String> EXPECTED_INPUT_PLUGINS = List.of(
			"jadx.plugins.input.aab.AabInputPlugin",
			"jadx.plugins.input.apkm.ApkmInputPlugin",
			"jadx.plugins.input.apks.ApksInputPlugin",
			"jadx.plugins.input.dex.DexInputPlugin",
			"jadx.plugins.input.javaconvert.JavaConvertPlugin",
			"jadx.plugins.input.java.JavaInputPlugin",
			"jadx.plugins.kotlin.metadata.KotlinMetadataPlugin",
			"jadx.plugins.kotlin.smap.KotlinSmapPlugin",
			"jadx.plugins.mappings.RenameMappingsPlugin",
			"jadx.plugins.input.smali.SmaliInputPlugin",
			"jadx.plugins.input.xapk.XApkInputPlugin");

	@BeforeAll
	static void jarExists() {
		assertThat(MCP_RUNTIME_JAR)
				.as("Run :jadx-cli:packageMcpRuntime before tests")
				.exists();
	}

	@Test
	void noGuiClasses() throws IOException {
		try (JarFile jar = new JarFile(MCP_RUNTIME_JAR.toFile())) {
			List<String> forbidden = new ArrayList<>();
			jar.stream().map(JarEntry::getName).forEach(name -> {
				if (name.startsWith("jadx/gui/") || name.startsWith("com/formdev/flatlaf/")) {
					forbidden.add(name);
				}
			});
			assertThat(forbidden).isEmpty();
		}
	}

	@Test
	void containsHeadlessDiskCache() throws IOException {
		try (JarFile jar = new JarFile(MCP_RUNTIME_JAR.toFile())) {
			assertThat(jar.getEntry("jadx/api/cache/disk/DiskCodeCache.class")).isNotNull();
			assertThat(jar.getEntry("jadx/api/cache/usage/UsageInfoCache.class")).isNotNull();
			assertThat(jar.getEntry("jadx/api/cache/HeadlessCacheSupport.class")).isNotNull();
		}
	}

	@Test
	void mergesAllInputPluginServices() throws IOException {
		List<String> services = readServiceFile(MCP_RUNTIME_JAR, "META-INF/services/jadx.api.plugins.JadxPlugin");
		assertThat(services).containsExactlyInAnyOrderElementsOf(EXPECTED_INPUT_PLUGINS);
	}

	@Test
	void excludesSwingAndLogbackArtifacts() throws IOException {
		try (JarFile jar = new JarFile(MCP_RUNTIME_JAR.toFile())) {
			List<String> badEntries = jar.stream()
					.map(JarEntry::getName)
					.filter(name -> name.contains("flatlaf")
							|| name.contains("rsyntaxtextarea")
							|| name.contains("logback/"))
					.collect(Collectors.toList());
			assertThat(badEntries).isEmpty();
		}
	}

	private static List<String> readServiceFile(Path jarPath, String entryName) throws IOException {
		// Shadow jar mixes signed and unsigned entries; disable verification when reading.
		try (JarFile jar = new JarFile(jarPath.toFile(), false, JarFile.OPEN_READ)) {
			JarEntry entry = jar.getJarEntry(entryName);
			assertThat(entry).as(entryName).isNotNull();
			try (InputStream in = jar.getInputStream(entry)) {
				String content = new String(in.readAllBytes(), StandardCharsets.UTF_8);
				return content
						.lines()
						.map(String::trim)
						.filter(line -> !line.isEmpty() && !line.startsWith("#"))
						.collect(Collectors.toList());
			}
		}
	}
}
