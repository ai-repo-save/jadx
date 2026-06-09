package jadx.api.cache;

import java.nio.file.Path;

import jadx.api.JadxArgs;
import jadx.api.JadxDecompiler;
import jadx.api.cache.disk.BufferCodeCache;
import jadx.api.cache.disk.DiskCodeCache;
import jadx.api.cache.usage.UsageInfoCache;
import jadx.api.plugins.pass.JadxPassInfo;
import jadx.api.plugins.pass.impl.SimpleJadxPassInfo;
import jadx.api.plugins.pass.types.JadxPreparePass;
import jadx.core.dex.nodes.RootNode;

/**
 * Helpers for headless integrations (CLI, MCP) that need disk-backed caches
 * without pulling in the Swing GUI module.
 */
public final class HeadlessCacheSupport {

	private HeadlessCacheSupport() {
	}

	public static void enableDiskUsageCache(JadxArgs args, Path cacheDir) {
		args.setUsageInfoCache(new UsageInfoCache(cacheDir, args.getInputFiles()));
	}

	public static void registerDiskCodeCache(JadxDecompiler decompiler, Path cacheDir) {
		decompiler.addCustomPass(diskCodeCachePass(cacheDir));
	}

	public static JadxPreparePass diskCodeCachePass(Path cacheDir) {
		return new JadxPreparePass() {
			@Override
			public JadxPassInfo getInfo() {
				return new SimpleJadxPassInfo("DiskCodeCacheInit");
			}

			@Override
			public void init(RootNode root) {
				root.getArgs().setCodeCache(new BufferCodeCache(new DiskCodeCache(root, cacheDir)));
			}
		};
	}

	/**
	 * Enable both disk usage cache and disk code cache for a decompiler instance.
	 */
	public static void enableDiskCaches(JadxDecompiler decompiler, Path cacheDir) {
		JadxArgs args = decompiler.getArgs();
		enableDiskUsageCache(args, cacheDir);
		registerDiskCodeCache(decompiler, cacheDir);
	}
}
