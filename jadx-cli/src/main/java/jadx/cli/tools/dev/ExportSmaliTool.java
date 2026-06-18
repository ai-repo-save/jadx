package jadx.cli.tools.dev;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.jetbrains.annotations.Nullable;

import com.beust.jcommander.Parameter;
import com.beust.jcommander.Parameters;

import jadx.api.JadxDecompiler;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.utils.exceptions.JadxRuntimeException;

@Parameters(commandDescription = "Export selected classes as .smali files (for regression fixtures)")
public class ExportSmaliTool implements DevSubcommand {

	@Parameter(names = { "-i", "--input" }, description = "APK/DEX/JAR/smali input (repeatable)", required = true)
	private List<String> inputs = new ArrayList<>();

	@Parameter(names = { "-o", "--output" }, description = "Output directory", required = true)
	private String outputDir;

	@Parameter(names = { "-c", "--class" }, description = "Class name (repeatable)", required = true)
	private List<String> classes = new ArrayList<>();

	@Parameter(names = { "--include-deps" }, description = "Also export direct/transitive class dependencies")
	private boolean includeDeps;

	@Parameter(names = { "--include-pattern" }, description = "With --include-deps: only follow deps matching prefix (e.g. kotlin.)")
	private @Nullable String includePattern;

	@Parameter(names = { "--naming" }, description = "Smali file naming: full (pkg$Cls) or short (Cls)")
	private DevToolSupport.SmaliNaming naming = DevToolSupport.SmaliNaming.FULL;

	@Parameter(names = { "--strip-prefix" }, description = "Strip package prefix before naming (e.g. com.example.app.)")
	private @Nullable String stripPrefix;

	@Parameter(names = { "--list-classes" }, description = "List class names from input and exit")
	private boolean listClasses;

	@Override
	public String name() {
		return "export-smali";
	}

	@Override
	public void run() {
		List<File> inputFiles = inputs.stream().map(File::new).toList();
		try (JadxDecompiler jadx = DevToolSupport.openDecompiler(inputFiles, null)) {
			RootNode root = DevToolSupport.root(jadx);
			if (listClasses) {
				root.getClasses().forEach(cls -> System.out.println(cls.getFullName()));
				return;
			}
			Path out = DevToolSupport.ensureDir(outputDir);
			Set<ClassNode> exportSet = DevToolSupport.collectClasses(root, classes, includeDeps, includePattern);
			for (ClassNode cls : exportSet) {
				String smali = cls.getDisassembledCode();
				String fileName = DevToolSupport.smaliFileName(cls, naming, stripPrefix);
				Path target = out.resolve(fileName);
				DevToolSupport.writeText(target, smali);
				System.out.println("Wrote " + target + " (" + cls.getFullName() + ")");
			}
			System.out.println("Exported " + exportSet.size() + " class(es) to " + out);
		} catch (Exception e) {
			throw new JadxRuntimeException("export-smali failed", e);
		}
	}
}
