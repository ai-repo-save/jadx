package jadx.cli.tools.dev;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.jetbrains.annotations.Nullable;

import com.beust.jcommander.Parameter;
import com.beust.jcommander.Parameters;

import jadx.api.JadxDecompiler;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.DotGraphVisitor;
import jadx.core.utils.exceptions.JadxRuntimeException;

@Parameters(commandDescription = "Dump method control-flow graphs to Graphviz .dot files")
public class DumpCfgTool implements DevSubcommand {

	public enum CfgMode {
		RAW,
		PROCESSED,
		REGIONS,
		ALL
	}

	@Parameter(names = { "-i", "--input" }, description = "APK/DEX/JAR/smali input (repeatable)", required = true)
	private List<String> inputs = new ArrayList<>();

	@Parameter(names = { "-o", "--output" }, description = "Output directory", required = true)
	private String outputDir;

	@Parameter(names = { "-c", "--class" }, description = "Class name", required = true)
	private String className;

	@Parameter(names = { "-m", "--method" }, description = "Method short id or name", required = true)
	private String methodSpec;

	@Parameter(names = { "--mode" }, description = "CFG type: raw, processed, regions, all")
	private CfgMode mode = CfgMode.ALL;

	@Parameter(names = { "--until-visitor" }, description = "Process method until visitor (exclusive) before dumping")
	private @Nullable String untilVisitor;

	@Parameter(names = { "--include-visitor" }, description = "Include --until-visitor pass in processing")
	private boolean includeVisitor;

	@Override
	public String name() {
		return "dump-cfg";
	}

	@Override
	public void run() {
		List<File> inputFiles = inputs.stream().map(File::new).toList();
		try (JadxDecompiler jadx = DevToolSupport.openDecompiler(inputFiles, null)) {
			RootNode root = DevToolSupport.root(jadx);
			ClassNode cls = DevToolSupport.requireClass(root, className);
			DevToolSupport.processClass(cls);
			MethodNode mth = DevToolSupport.requireMethod(cls, methodSpec);
			if (untilVisitor != null) {
				boolean ok = DevToolSupport.processMethodUntil(mth, untilVisitor, includeVisitor);
				if (!ok) {
					throw new IllegalArgumentException("Visitor not found: " + untilVisitor);
				}
				System.out.println("Processed until visitor: " + untilVisitor);
			}
			File out = DevToolSupport.ensureDir(outputDir).toFile();
			dumpGraphs(mth, out);
			System.out.println("CFG written under " + out);
		} catch (Exception e) {
			throw new JadxRuntimeException("dump-cfg failed", e);
		}
	}

	private void dumpGraphs(MethodNode mth, File out) {
		switch (mode) {
			case RAW:
				DotGraphVisitor.dumpRaw().save(out, mth);
				break;
			case PROCESSED:
				DotGraphVisitor.dump().save(out, mth);
				break;
			case REGIONS:
				DotGraphVisitor.dumpRegions().save(out, mth);
				break;
			case ALL:
				DotGraphVisitor.dumpRaw().save(out, mth);
				DotGraphVisitor.dump().save(out, mth);
				DotGraphVisitor.dumpRegions().save(out, mth);
				break;
		}
	}
}
