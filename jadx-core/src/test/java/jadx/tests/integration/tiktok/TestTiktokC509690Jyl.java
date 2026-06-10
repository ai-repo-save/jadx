package jadx.tests.integration.tiktok;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.nodes.BlockNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.utils.BlockUtils;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.Edge;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph.BridgeNode;
import jadx.core.dex.visitors.blocks.reducible.ControlFlowComponentGraph.NaturalLoop;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier;
import jadx.core.dex.visitors.blocks.reducible.GraphShapeClassifier.Component;
import jadx.core.dex.visitors.blocks.reducible.StructuringGraph;
import jadx.core.dex.visitors.blocks.reducible.StructuringGraph.RegionNode;
import jadx.tests.api.SmaliTest;

import static jadx.tests.api.utils.assertj.JadxAssertions.assertThat;

public class TestTiktokC509690Jyl extends SmaliTest {

	@Test
	public void testLoopHeadersContainConditionInsn() {
		allowWarnInCode();
		enableDeobfuscation();
		MethodNode mth = loadProcessedTargetMethod();
		BlockNode outerHeader = findLoopStart(mth, 0x003e);
		BlockNode innerHeader = findLoopStart(mth, 0x0063);
		InsnNode outerLast = BlockUtils.getLastInsn(outerHeader);
		InsnNode innerLast = BlockUtils.getLastInsn(innerHeader);
		assertThat(outerLast).isNotNull();
		assertThat(innerLast).isNotNull();
		assertThat(outerLast.getType()).isEqualTo(InsnType.IF);
		assertThat(innerLast.getType())
				.as("%s insns=%d succs=%s", innerHeader, innerHeader.getInstructions().size(), innerHeader.getCleanSuccessors())
				.isEqualTo(InsnType.IF);
		assertThat(BlockUtils.getLoopBodyEntry(outerHeader)).isNotNull();
		assertThat(BlockUtils.getLoopBodyEntry(innerHeader)).isNotNull();
	}

	@Test
	public void testSharedEntryComponentShapeIsClassified() {
		args.setOutDir(new File("build/test-cfg/TestTiktokC509690Jyl"));
		args.setRawCFGOutput(true);
		args.setCfgOutput(true);
		allowWarnInCode();
		enableDeobfuscation();

		MethodNode mth = loadProcessedTargetMethod();
		Component sharedLoopComponent = findSharedLoopComponent(mth);
		assertThat(sharedLoopComponent.getLoopStartCount()).isEqualTo(2);
		assertThat(formatEdges(sharedLoopComponent.getEntries()))
				.containsExactly("0x002b->?", "0x0106->?", "0x01cb->?");
		assertThat(formatEdges(sharedLoopComponent.getExits()))
				.containsExactly("0x003e->0x01df", "0x00c5->0x00c7", "0x0103->0x0105");
	}

	@Test
	public void testSharedPhiBridgesMatchTargetOwnershipConflict() {
		args.setOutDir(new File("build/test-cfg/TestTiktokC509690Jyl"));
		args.setRawCFGOutput(true);
		args.setCfgOutput(true);
		allowWarnInCode();
		enableDeobfuscation();

		MethodNode mth = loadProcessedTargetMethod();
		Component sharedLoopComponent = findSharedLoopComponent(mth);

		BlockNode outerHeader = findLoopStart(mth, 0x003e);
		BlockNode innerHeader = findLoopStart(mth, 0x0063);
		BlockNode outerBridge = findBridgeTo(mth, outerHeader, List.of(0x002b, 0x0063, 0x01cb));
		BlockNode innerBridge = findBridgeTo(mth, innerHeader, List.of(0x005f, 0x0106));

		assertThat(formatBlockOffsets(outerBridge.getSuccessors()))
				.containsExactly("0x003e");
		assertThat(formatBlockOffsets(outerBridge.getPredecessors()))
				.containsExactly("0x002b", "0x0063", "0x01cb");
		assertThat(formatBlockOffsets(innerBridge.getSuccessors()))
				.containsExactly("0x0063");
		assertThat(formatBlockOffsets(innerBridge.getPredecessors()))
				.containsExactly("0x005f", "0x0106");

		assertThat(BlockUtils.loopHeaderExitsTo(outerHeader, innerHeader)).isTrue();

		assertThat(sharedLoopComponent.getBlocks())
				.contains(outerHeader, innerHeader, outerBridge, innerBridge);
		assertThat(sharedLoopComponent.getEntries())
				.anySatisfy(edge -> assertEdge(edge, 0x002b, outerBridge));
		assertThat(sharedLoopComponent.getEntries())
				.anySatisfy(edge -> assertEdge(edge, 0x0106, innerBridge));
		assertThat(sharedLoopComponent.getEntries())
				.anySatisfy(edge -> assertEdge(edge, 0x01cb, outerBridge));
	}

	@Test
	public void testControlFlowComponentGraphCapturesTargetFacts() {
		args.setOutDir(new File("build/test-cfg/TestTiktokC509690Jyl"));
		args.setRawCFGOutput(true);
		args.setCfgOutput(true);
		allowWarnInCode();
		enableDeobfuscation();

		MethodNode mth = loadProcessedTargetMethod();
		ControlFlowComponentGraph graph = ControlFlowComponentGraph.build(mth);
		ControlFlowComponentGraph.Component sharedLoopComponent = findSharedComponentGraphComponent(graph);

		assertThat(sharedLoopComponent.getLoopStartCount()).isEqualTo(2);
		assertThat(formatEdges(sharedLoopComponent.getEntries()))
				.containsExactly("0x002b->?", "0x0106->?", "0x01cb->?");
		assertThat(formatEdges(sharedLoopComponent.getExits()))
				.containsExactly("0x003e->0x01df", "0x00c5->0x00c7", "0x0103->0x0105");
		assertThat(formatBridgeFacts(sharedLoopComponent.getBridges()))
				.containsExactly(
						"0x002b,0x0063,0x01cb->?->0x003e",
						"0x005f,0x0106->?->0x0063");
		assertThat(formatNaturalLoopFacts(sharedLoopComponent.getNaturalLoops()))
				.containsExactly(
						"0x0063->0x0063",
						"?->0x003e");
	}

	@Test
	public void testStructuringGraphKeepsBridgeInputsFactual() {
		args.setOutDir(new File("build/test-cfg/TestTiktokC509690Jyl"));
		args.setRawCFGOutput(true);
		args.setCfgOutput(true);
		allowWarnInCode();
		enableDeobfuscation();

		MethodNode mth = loadProcessedTargetMethod();
		ControlFlowComponentGraph componentGraph = ControlFlowComponentGraph.build(mth);
		StructuringGraph structuringGraph = StructuringGraph.build(componentGraph);
		RegionNode sharedLoopRegion = findSharedStructuringRegion(structuringGraph);

		assertThat(sharedLoopRegion.getKind()).isEqualTo(StructuringGraph.RegionKind.MULTI_ENTRY);
		assertThat(formatBridgeFacts(sharedLoopRegion.getBridges()))
				.containsExactly(
						"0x002b,0x0063,0x01cb->?->0x003e",
						"0x005f,0x0106->?->0x0063");
		assertThat(formatRegionEdges(sharedLoopRegion.getEdges()))
				.containsExactly(
						"BRIDGE_INPUT_FROM_OUTSIDE:0x002b->?",
						"BRIDGE_INPUT_FROM_OUTSIDE:0x0106->?",
						"BRIDGE_INPUT_FROM_OUTSIDE:0x01cb->?",
						"BRIDGE_INPUT_FROM_REGION:0x005f->?",
						"BRIDGE_INPUT_FROM_REGION:0x0063->?",
						"BRIDGE_TO_HEADER:?->0x003e",
						"BRIDGE_TO_HEADER:?->0x0063",
						"COMPONENT_ENTRY:0x002b->?",
						"COMPONENT_ENTRY:0x0106->?",
						"COMPONENT_ENTRY:0x01cb->?",
						"COMPONENT_EXIT:0x003e->0x01df",
						"COMPONENT_EXIT:0x00c5->0x00c7",
						"COMPONENT_EXIT:0x0103->0x0105",
						"NATURAL_BACK_EDGE:0x0063->0x0063",
						"NATURAL_BACK_EDGE:?->0x003e");
	}

	private MethodNode loadProcessedTargetMethod() {
		jadxDecompiler = loadFiles(collectFixtureSmaliFiles());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		ClassNode cls = root.getClasses(false).stream()
				.filter(node -> node.getClassInfo().getRawName().replace('/', '.').equals("X.0Jyl"))
				.findFirst()
				.orElseThrow(() -> new AssertionError("Class not found: X.0Jyl"));
		cls.add(AFlag.DONT_UNLOAD_CLASS);
		root.getProcessClasses().forceProcess(cls);

		MethodNode mth = cls.searchMethodByShortName("LIZ");
		assertThat(mth).isNotNull();
		return mth;
	}

	private static Component findSharedLoopComponent(MethodNode mth) {
		List<Component> multiEntry = GraphShapeClassifier.analyze(mth).getMultiEntryComponents();
		List<Component> sharedLoopComponents = multiEntry.stream()
				.filter(component -> component.getLoopStartCount() >= 2 && component.getEntries().size() >= 3)
				.collect(Collectors.toList());
		assertThat(sharedLoopComponents).as("multiEntry=%s", multiEntry).hasSize(1);
		return sharedLoopComponents.get(0);
	}

	private static ControlFlowComponentGraph.Component findSharedComponentGraphComponent(ControlFlowComponentGraph graph) {
		List<ControlFlowComponentGraph.Component> sharedLoopComponents = graph.getMultiEntryComponents().stream()
				.filter(component -> component.getLoopStartCount() >= 2 && component.getEntries().size() >= 3)
				.collect(Collectors.toList());
		assertThat(sharedLoopComponents).hasSize(1);
		return sharedLoopComponents.get(0);
	}

	private static RegionNode findSharedStructuringRegion(StructuringGraph graph) {
		List<RegionNode> sharedLoopRegions = graph.getMultiEntryRegions().stream()
				.filter(region -> region.getNaturalLoops().size() >= 2 && region.getEntries().size() >= 3)
				.collect(Collectors.toList());
		assertThat(sharedLoopRegions).hasSize(1);
		return sharedLoopRegions.get(0);
	}

	private static BlockNode findLoopStart(MethodNode mth, int offset) {
		List<BlockNode> loopStarts = mth.getBasicBlocks().stream()
				.filter(block -> block.getStartOffset() == offset)
				.filter(block -> block.contains(AFlag.LOOP_START))
				.collect(Collectors.toList());
		assertThat(loopStarts).hasSize(1);
		return loopStarts.get(0);
	}

	private static BlockNode findBridgeTo(MethodNode mth, BlockNode header, List<Integer> predecessorOffsets) {
		List<Integer> expectedPredecessorOffsets = predecessorOffsets.stream()
				.sorted()
				.collect(Collectors.toList());
		List<BlockNode> bridges = mth.getBasicBlocks().stream()
				.filter(block -> block.getStartOffset() == -1)
				.filter(block -> block.getSuccessors().size() == 1)
				.filter(block -> block.getSuccessors().get(0) == header)
				.filter(block -> sortedBlockOffsets(block.getPredecessors()).equals(expectedPredecessorOffsets))
				.collect(Collectors.toList());
		assertThat(bridges).hasSize(1);
		return bridges.get(0);
	}

	private static BlockNode findSingleBlockByOffset(MethodNode mth, int offset) {
		List<BlockNode> blocks = mth.getBasicBlocks().stream()
				.filter(block -> block.getStartOffset() == offset)
				.collect(Collectors.toList());
		assertThat(blocks).hasSize(1);
		return blocks.get(0);
	}

	private static List<File> collectFixtureSmaliFiles() {
		File smaliDir = new File("src/test/smali/tiktok/TestTiktokC509690Jyl");
		if (!smaliDir.exists()) {
			smaliDir = new File("jadx-core/src/test/smali/tiktok/TestTiktokC509690Jyl");
		}
		File[] files = smaliDir.listFiles((dir, name) -> name.endsWith(".smali"));
		assertThat(files).as("Smali files not found in " + smaliDir).isNotNull();
		List<File> smaliFiles = Arrays.stream(files)
				.sorted(Comparator.comparing(File::getName))
				.collect(Collectors.toList());
		assertThat(smaliFiles.stream().map(File::getName).collect(Collectors.toList()))
				.containsExactly(
						"C509690Jyl.smali",
						"Stub_02sL.smali",
						"Stub_02xW.smali",
						"Stub_0JZr.smali",
						"Stub_0JZy.smali",
						"Stub_0Jye.smali",
						"Stub_0Jym.smali",
						"Stub_0SnS.smali",
						"Stub_0TwS.smali",
						"Stub_0TyN.smali",
						"Stub_0hdh.smali",
						"Stub_0tKv.smali",
						"Stub_0yOP.smali",
						"Stub_0yTi.smali",
						"Stub_16GD.smali",
						"Stub_16Hu.smali",
						"Stub_Android.smali",
						"Stub_BaseContact.smali",
						"Stub_IMContact.smali",
						"Stub_IMContactApi.smali",
						"Stub_IMUser.smali",
						"Stub_Intrinsics.smali",
						"Stub_TextUtils.smali",
						"Stub_User.smali",
						"Stub_XHelpers.smali");
		return smaliFiles;
	}

	private static List<Integer> sortedBlockStartOffsets(Component component) {
		List<Integer> offsets = component.getBlocks().stream()
				.map(block -> block.getStartOffset())
				.sorted()
				.collect(Collectors.toCollection(ArrayList::new));
		return offsets;
	}

	private static List<Integer> sortedBlockStartOffsets(ControlFlowComponentGraph.Component component) {
		List<Integer> offsets = component.getBlocks().stream()
				.map(block -> block.getStartOffset())
				.sorted()
				.collect(Collectors.toCollection(ArrayList::new));
		return offsets;
	}

	private static List<Integer> sortedBlockStartOffsets(RegionNode region) {
		List<Integer> offsets = region.getBlocks().stream()
				.map(block -> block.getStartOffset())
				.sorted()
				.collect(Collectors.toCollection(ArrayList::new));
		return offsets;
	}

	private static List<Integer> expectedSharedLoopComponentOffsets() {
		return List.of(
				-1, -1, -1,
				0x003e, 0x0042, 0x0044, 0x004e, 0x0050, 0x0052, 0x005d,
				0x005f, 0x005f,
				0x0063, 0x0063, 0x0063, 0x0063, 0x0063,
				0x0067, 0x0069, 0x007d,
				0x007f, 0x007f,
				0x0089,
				0x008b, 0x008b,
				0x00c5, 0x00c8, 0x0103);
	}

	private static List<String> formatBlockOffsets(List<BlockNode> blocks) {
		return blocks.stream()
				.map(block -> formatOffset(block.getStartOffset()))
				.sorted()
				.collect(Collectors.toList());
	}

	private static List<Integer> sortedBlockOffsets(List<BlockNode> blocks) {
		return blocks.stream()
				.map(BlockNode::getStartOffset)
				.sorted()
				.collect(Collectors.toList());
	}

	private static List<String> formatBridgeFacts(List<BridgeNode> bridges) {
		return bridges.stream()
				.map(bridge -> formatBlockOffsets(bridge.getPredecessors()).stream().collect(Collectors.joining(","))
						+ "->" + formatOffset(bridge.getBlock().getStartOffset())
						+ "->" + formatOffset(bridge.getSuccessor().getStartOffset()))
				.sorted()
				.collect(Collectors.toList());
	}

	private static List<String> formatNaturalLoopFacts(List<NaturalLoop> loops) {
		return loops.stream()
				.map(loop -> formatOffset(loop.getBackEdge().getSource().getStartOffset())
						+ "->" + formatOffset(loop.getHeader().getStartOffset()))
				.sorted()
				.collect(Collectors.toList());
	}

	private static List<String> formatRegionEdges(List<StructuringGraph.RegionEdge> edges) {
		return edges.stream()
				.map(edge -> edge.getKind() + ":" + formatEdge(edge.getEdge()))
				.sorted()
				.collect(Collectors.toList());
	}

	private static List<String> formatEdges(List<Edge> edges) {
		return edges.stream()
				.map(TestTiktokC509690Jyl::formatEdge)
				.sorted()
				.collect(Collectors.toList());
	}

	private static String formatEdge(Edge edge) {
		return formatOffset(edge.getSource().getStartOffset()) + "->" + formatOffset(edge.getTarget().getStartOffset());
	}

	private static void assertEdge(Edge edge, int sourceOffset, BlockNode target) {
		assertThat(edge.getSource().getStartOffset()).isEqualTo(sourceOffset);
		assertThat(edge.getTarget()).isSameAs(target);
	}

	private static String formatOffset(int offset) {
		if (offset == -1) {
			return "?";
		}
		return String.format(Locale.ROOT, "0x%04x", offset);
	}
}
