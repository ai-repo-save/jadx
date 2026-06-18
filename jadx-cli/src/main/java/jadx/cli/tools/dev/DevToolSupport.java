package jadx.cli.tools.dev;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import org.jetbrains.annotations.Nullable;

import jadx.api.JadxArgs;
import jadx.api.JadxArgs.OutputFormatEnum;
import jadx.api.JadxDecompiler;
import jadx.api.impl.NoOpCodeCache;
import jadx.api.impl.SimpleCodeWriter;
import jadx.api.usage.impl.EmptyUsageInfoCache;
import jadx.cli.plugins.JadxFilesGetter;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.utils.exceptions.JadxRuntimeException;
import jadx.plugins.tools.JadxExternalPluginsLoader;

public final class DevToolSupport {

	public enum SmaliNaming {
		/** {@code kotlin.coroutines.Continuation} -> {@code kotlin$coroutines$Continuation.smali} */
		FULL,
		/** {@code com.example.Foo$Bar} -> {@code Foo$Bar.smali} */
		SHORT,
	}

	private DevToolSupport() {
	}

	public static JadxDecompiler openDecompiler(Collection<File> inputs, @Nullable Consumer<JadxArgs> configure) {
		if (inputs.isEmpty()) {
			throw new IllegalArgumentException("At least one input file is required");
		}
		List<File> resolved = new ArrayList<>();
		for (File input : inputs) {
			resolved.add(resolveInput(input.getPath()));
		}
		JadxArgs args = new JadxArgs();
		args.setInputFiles(resolved);
		args.setCodeCache(new NoOpCodeCache());
		args.setUsageInfoCache(new EmptyUsageInfoCache());
		args.setPluginLoader(new JadxExternalPluginsLoader());
		args.setFilesGetter(JadxFilesGetter.INSTANCE);
		args.setCodeWriterProvider(SimpleCodeWriter::new);
		args.setOutputFormat(OutputFormatEnum.KOTLIN);
		if (configure != null) {
			configure.accept(args);
		}
		JadxDecompiler jadx = new JadxDecompiler(args);
		jadx.load();
		return jadx;
	}

	public static RootNode root(JadxDecompiler jadx) {
		return jadx.getRoot();
	}

	public static ClassNode requireClass(RootNode root, String className) {
		ClassNode cls = root.resolveClass(className);
		if (cls == null) {
			cls = root.getClasses().stream()
					.filter(c -> c.getFullName().equals(className)
							|| c.getFullName().endsWith("." + className)
							|| c.getClassInfo().getAliasFullName().endsWith("/" + className.replace('.', '/')))
					.findFirst()
					.orElse(null);
		}
		if (cls == null) {
			throw new IllegalArgumentException("Class not found: " + className);
		}
		return cls;
	}

	public static MethodNode requireMethod(ClassNode cls, @Nullable String methodSpec) {
		if (methodSpec == null || methodSpec.isEmpty()) {
			throw new IllegalArgumentException("Method is required (short id or name)");
		}
		if (methodSpec.contains("(")) {
			MethodNode mth = cls.searchMethodByShortId(methodSpec);
			if (mth == null) {
				throw new IllegalArgumentException("Method not found in " + cls.getFullName() + ": " + methodSpec);
			}
			return mth;
		}
		List<MethodNode> matches = cls.getMethods().stream()
				.filter(m -> m.getName().equals(methodSpec))
				.collect(Collectors.toList());
		if (matches.isEmpty()) {
			throw new IllegalArgumentException("Method not found in " + cls.getFullName() + ": " + methodSpec);
		}
		if (matches.size() > 1) {
			String ids = matches.stream()
					.map(m -> m.getMethodInfo().getShortId())
					.collect(Collectors.joining(", "));
			throw new IllegalArgumentException("Ambiguous method name '" + methodSpec + "'. Use short id. Matches: " + ids);
		}
		return matches.get(0);
	}

	public static void processClass(ClassNode cls) {
		cls.add(AFlag.DONT_UNLOAD_CLASS);
		cls.root().getProcessClasses().forceProcess(cls);
	}

	public static boolean processMethodUntil(MethodNode mth, String visitorName, boolean includeVisitor) {
		mth.add(AFlag.DONT_UNLOAD_CLASS);
		mth.getTopParentClass().add(AFlag.DONT_UNLOAD_CLASS);
		return mth.root().getProcessClasses().processMethodUntilVisitor(mth, visitorName, includeVisitor);
	}

	public static Set<ClassNode> collectClasses(RootNode root, List<String> classNames, boolean includeDeps,
			@Nullable String includePattern) {
		Set<ClassNode> result = new LinkedHashSet<>();
		for (String className : classNames) {
			ClassNode seed = requireClass(root, className);
			collectClassClosure(seed, includeDeps, includePattern, result);
		}
		return result;
	}

	private static void collectClassClosure(ClassNode seed, boolean includeDeps, @Nullable String includePattern,
			Set<ClassNode> result) {
		if (!result.add(seed)) {
			return;
		}
		if (!includeDeps) {
			return;
		}
		for (ClassNode dep : seed.getDependencies()) {
			if (includePattern != null && !matchesPattern(dep.getFullName(), includePattern)) {
				continue;
			}
			collectClassClosure(dep, true, includePattern, result);
		}
	}

	public static boolean matchesPattern(String className, String pattern) {
		if (pattern.endsWith("*")) {
			return className.startsWith(pattern.substring(0, pattern.length() - 1));
		}
		return className.equals(pattern);
	}

	public static String smaliFileName(ClassNode cls, SmaliNaming naming, @Nullable String stripPrefix) {
		String fullName = cls.getFullName();
		String base = fullName;
		if (stripPrefix != null && !stripPrefix.isEmpty()) {
			if (base.startsWith(stripPrefix)) {
				base = base.substring(stripPrefix.length());
			}
		} else if (naming == SmaliNaming.SHORT) {
			int dot = fullName.lastIndexOf('.');
			base = dot == -1 ? fullName : fullName.substring(dot + 1);
		}
		return base.replace('.', '$') + ".smali";
	}

	public static void writeText(Path path, String content) {
		try {
			Files.createDirectories(path.getParent());
			Files.writeString(path, content);
		} catch (Exception e) {
			throw new JadxRuntimeException("Failed to write " + path, e);
		}
	}

	public static Path ensureDir(String dir) {
		Path path = Path.of(dir);
		try {
			Files.createDirectories(path);
		} catch (Exception e) {
			throw new JadxRuntimeException("Failed to create directory: " + dir, e);
		}
		return path;
	}

	private static File resolveInput(String path) {
		Path raw = Path.of(path);
		if (raw.isAbsolute()) {
			File file = raw.toFile();
			if (file.exists()) {
				return file;
			}
			throw inputNotFound(path);
		}
		Path cwd = Path.of(System.getProperty("user.dir"));
		for (Path base : List.of(cwd, cwd.getParent(), cwd.resolve("..").normalize())) {
			if (base == null) {
				continue;
			}
			File file = base.resolve(raw).normalize().toFile();
			if (file.exists()) {
				return file;
			}
		}
		throw inputNotFound(path);
	}

	private static IllegalArgumentException inputNotFound(String path) {
		return new IllegalArgumentException("Input not found: " + path + " (cwd=" + System.getProperty("user.dir") + ")");
	}
}
