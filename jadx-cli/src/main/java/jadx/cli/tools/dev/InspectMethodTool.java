package jadx.cli.tools.dev;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.jetbrains.annotations.Nullable;

import com.beust.jcommander.Parameter;
import com.beust.jcommander.Parameters;

import jadx.api.ICodeWriter;
import jadx.api.JadxDecompiler;
import jadx.api.JadxArgs.OutputFormatEnum;
import jadx.api.impl.SimpleCodeWriter;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.IContainer;
import jadx.core.dex.nodes.IRegion;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.regions.Region;
import jadx.core.utils.exceptions.JadxRuntimeException;

@Parameters(commandDescription = "Inspect a method: decompiled code, smali, insns, regions, attrs")
public class InspectMethodTool implements DevSubcommand {

	@Parameter(names = { "-i", "--input" }, description = "APK/DEX/JAR/smali input (repeatable)", required = true)
	private List<String> inputs = new ArrayList<>();

	@Parameter(names = { "-c", "--class" }, description = "Class name", required = true)
	private String className;

	@Parameter(names = { "-m", "--method" }, description = "Method short id or name", required = true)
	private String methodSpec;

	@Parameter(names = { "--java" }, description = "Decompile as Java instead of Kotlin")
	private boolean javaOutput;

	@Parameter(names = { "--no-code" }, description = "Skip decompiled source output")
	private boolean noCode;

	@Parameter(names = { "--smali" }, description = "Print class smali")
	private boolean smali;

	@Parameter(names = { "--insns" }, description = "Print processed insn list by basic block")
	private boolean insns;

	@Parameter(names = { "--regions" }, description = "Print region tree")
	private boolean regions;

	@Parameter(names = { "--attrs" }, description = "Print method attributes")
	private boolean attrs;

	@Parameter(names = { "--errors" }, description = "Print JADX errors/warnings on method")
	private boolean errors;

	@Parameter(names = { "--until-visitor" }, description = "Process method until visitor (exclusive) before inspection")
	private @Nullable String untilVisitor;

	@Parameter(names = { "--include-visitor" }, description = "Include --until-visitor pass in processing")
	private boolean includeVisitor;

	@Override
	public String name() {
		return "inspect-method";
	}

	@Override
	public void run() {
		List<File> inputFiles = inputs.stream().map(File::new).toList();
		try (JadxDecompiler jadx = DevToolSupport.openDecompiler(inputFiles, args -> {
			if (javaOutput) {
				args.setOutputFormat(OutputFormatEnum.JAVA);
			}
		})) {
			RootNode root = DevToolSupport.root(jadx);
			ClassNode cls = DevToolSupport.requireClass(root, className);
			DevToolSupport.processClass(cls);
			MethodNode mth = DevToolSupport.requireMethod(cls, methodSpec);
			if (untilVisitor != null) {
				boolean ok = DevToolSupport.processMethodUntil(mth, untilVisitor, includeVisitor);
				if (!ok) {
					throw new IllegalArgumentException("Visitor not found: " + untilVisitor);
				}
				System.out.println("=== processed until: " + untilVisitor + " ===");
			}
			if (!noCode) {
				printHeader("decompiled", mth.getMethodInfo().getFullId());
				System.out.println(mth.getCodeStr());
			}
			if (smali) {
				printHeader("smali", cls.getFullName());
				System.out.println(cls.getDisassembledCode());
			}
			if (insns) {
				printInsns(mth);
			}
			if (regions) {
				printHeader("regions", mth.getMethodInfo().getFullId());
				System.out.println(formatRegions(mth));
			}
			if (attrs) {
				printHeader("attrs", mth.getMethodInfo().getFullId());
				System.out.println(mth.getAttributesString());
			}
			if (errors) {
				printHeader("errors", mth.getMethodInfo().getFullId());
				if (mth.contains(AType.JADX_ERROR)) {
					System.out.println(mth.get(AType.JADX_ERROR));
				}
				mth.getAttributesStringsList().stream()
						.filter(s -> s.contains("WARN") || s.contains("ERROR"))
						.forEach(System.out::println);
			}
		} catch (Exception e) {
			throw new JadxRuntimeException("inspect-method failed", e);
		}
	}

	private static void printInsns(MethodNode mth) {
		printHeader("insns", mth.getMethodInfo().getFullId());
		List<BlockNode> blocks = mth.getBasicBlocks();
		if (blocks == null) {
			System.out.println("(no basic blocks)");
			return;
		}
		for (BlockNode block : blocks) {
			System.out.println("B:" + block.getCId() + " " + block);
			for (InsnNode insn : block.getInstructions()) {
				System.out.println("  " + insn);
			}
		}
	}

	private static String formatRegions(MethodNode mth) {
		Region mthRegion = mth.getRegion();
		if (mthRegion == null) {
			return "(no regions)";
		}
		ICodeWriter cw = new SimpleCodeWriter();
		cw.startLine('|').add(mth.toString());
		formatRegion(mthRegion, cw, "|  ");
		return cw.finish().getCodeStr();
	}

	private static void formatRegion(IRegion region, ICodeWriter cw, String indent) {
		cw.startLine(indent).add(region.toString());
		String childIndent = indent + "|  ";
		for (IContainer container : region.getSubBlocks()) {
			if (container instanceof IRegion) {
				formatRegion((IRegion) container, cw, childIndent);
			} else {
				cw.startLine(childIndent).add(container.toString());
			}
		}
	}

	private static void printHeader(String section, String title) {
		System.out.println();
		System.out.println("=== " + section + ": " + title + " ===");
	}
}
