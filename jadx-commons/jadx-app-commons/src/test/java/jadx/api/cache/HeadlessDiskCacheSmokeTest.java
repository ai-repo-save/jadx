package jadx.api.cache;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import jadx.api.JadxDecompiler;
import jadx.api.usage.IUsageInfoData;
import jadx.tests.api.IntegrationTest;

import static org.assertj.core.api.Assertions.assertThat;

class HeadlessDiskCacheSmokeTest extends IntegrationTest {

	@TempDir
	Path cacheDir;

	@Test
	void diskUsageCachePersists() throws IOException {
		disableCompilation();
		getClassNode(HeadlessDiskCacheSmokeTest.class);

		try (JadxDecompiler decompiler = new JadxDecompiler(getArgs())) {
			HeadlessCacheSupport.enableDiskUsageCache(decompiler.getArgs(), cacheDir);
			decompiler.load();
			IUsageInfoData usageData = decompiler.getArgs().getUsageInfoCache().get(decompiler.getRoot());
			assertThat(usageData).isNotNull();
		}
		assertThat(Files.isRegularFile(cacheDir.resolve("usage"))).isTrue();
	}

	@Test
	void diskCodeCacheWithDecompiler() throws IOException {
		disableCompilation();
		getClassNode(HeadlessDiskCacheSmokeTest.class);

		try (JadxDecompiler decompiler = new JadxDecompiler(getArgs())) {
			HeadlessCacheSupport.enableDiskCaches(decompiler, cacheDir);
			decompiler.load();
			assertThat(decompiler.getClasses()).isNotEmpty();
			assertThat(Files.isDirectory(cacheDir.resolve("code"))).isTrue();
		}
	}
}
