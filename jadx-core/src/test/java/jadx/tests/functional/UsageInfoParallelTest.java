package jadx.tests.functional;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Test;

import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.tests.api.SmaliTest;

import static org.assertj.core.api.Assertions.assertThat;

class UsageInfoParallelTest extends SmaliTest {

	private static final String SMALI_CLS = "types.TestTypeResolver5";

	@Test
	public void parallelMatchesSerialUsageGraph() {
		disableCompilation();
		int parallelThreads = Math.max(2, Runtime.getRuntime().availableProcessors() / 2);

		getArgs().setThreadsCount(1);
		ClassNode serialCls = getClassNodeFromSmali("types/TestTypeResolver5", SMALI_CLS);
		String serial = usageSnapshot(serialCls.root());
		jadxDecompiler.close();
		jadxDecompiler = null;

		getArgs().setThreadsCount(parallelThreads);
		ClassNode parallelCls = getClassNodeFromSmali("types/TestTypeResolver5", SMALI_CLS);
		String parallel = usageSnapshot(parallelCls.root());

		assertThat(parallel).isEqualTo(serial);
	}

	private static String usageSnapshot(RootNode root) {
		StringBuilder sb = new StringBuilder();
		List<ClassNode> classes = root.getClasses();
		classes.sort(Comparator.comparing(ClassNode::getRawName));
		for (ClassNode cls : classes) {
			sb.append(cls.getRawName()).append('|');
			sb.append(sortedClassNames(cls.getDependencies())).append('|');
			sb.append(sortedClassNames(cls.getUseIn())).append('|');
			for (MethodNode mth : cls.getMethods()) {
				sb.append(mth.getMethodInfo().getShortId()).append(':');
				sb.append(sortedMethodNames(mth.getUseIn())).append(':');
				sb.append(sortedMethodNames(mth.getUsed())).append(';');
			}
			sb.append('\n');
		}
		return sb.toString();
	}

	private static String sortedClassNames(List<ClassNode> nodes) {
		if (nodes == null || nodes.isEmpty()) {
			return "";
		}
		return nodes.stream()
				.map(ClassNode::getFullName)
				.sorted()
				.collect(Collectors.joining(","));
	}

	private static String sortedMethodNames(List<MethodNode> nodes) {
		if (nodes == null || nodes.isEmpty()) {
			return "";
		}
		return nodes.stream()
				.map(m -> m.getMethodInfo().getShortId())
				.sorted()
				.collect(Collectors.joining(","));
	}

	private static String sortedMethodNames(java.util.Set<MethodNode> nodes) {
		if (nodes == null || nodes.isEmpty()) {
			return "";
		}
		return nodes.stream()
				.map(m -> m.getMethodInfo().getShortId())
				.sorted()
				.collect(Collectors.joining(","));
	}
}
