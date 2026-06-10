package jadx.tests.integration.types;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.instructions.args.SSAVar;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.DepthTraversal;
import jadx.core.dex.visitors.IDexTreeVisitor;
import jadx.core.dex.visitors.MoveInlineVisitor;
import jadx.core.dex.visitors.typeinference.BoundEnum;
import jadx.core.dex.visitors.typeinference.TypeBoundConst;
import jadx.core.dex.visitors.typeinference.TypeInferenceVisitor;
import jadx.core.dex.visitors.typeinference.TypeUpdate;
import jadx.core.dex.visitors.typeinference.TypeUpdateResult;
import jadx.tests.api.SmaliTest;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Minimal repro for bug C ({@code TypeUpdate} non-convergence):
 * <ul>
 * <li>{@code moveListener}: {@code REJECT && correctType → CHANGED} launders {@code inBounds} failures</li>
 * <li>{@code InvokeUpdateCallback}: swallows some {@code REJECT}s and keeps queuing</li>
 * <li>{@code rollbackUpdate}: clears {@code updateMap} but not monotonic {@code updateSeq}</li>
 * </ul>
 * At APK scale (many MOVE copies + invoke receivers) the same mechanism yields
 * {@code updateSeq = insnCount * limit + 1}; this fixture stays small and pins the root cause.
 */
public class TestTypeUpdateMoveRejectLaundering extends SmaliTest {

	private static final String FIXTURE_PKG = "typeinference";
	private static final String FIXTURE_NAME = "TestTypeUpdateMoveRejectLaundering";
	private static final String RUN_CLS = FIXTURE_PKG + '.' + FIXTURE_NAME + ".Run";

	@Test
	public void fixtureStaysSmall() {
		disableCompilation();
		MethodNode mth = loadRunMethodBeforeTypeInference();
		assertThat(mth.getInsnsCount()).isLessThan(150);
	}

	@Test
	public void moveListenerLaundersInBoundsRejectToChanged() {
		disableCompilation();
		MethodContext ctx = loadContextBeforeTypeInference();
		assertThat(ctx.moveDests).allMatch(v -> !v.getTypeInfo().getType().isTypeKnown());
		addConflictingUseBounds(ctx.moveDests);

		TypeUpdate typeUpdate = ctx.root.getTypeUpdate();
		TypeUpdateResult result = typeUpdate.applyWithWiderIgnSame(ctx.mth, ctx.paramVar, ctx.paramType);

		assertThat(result).isEqualTo(TypeUpdateResult.CHANGED);
		assertThat(ctx.paramVar.getTypeInfo().getType().getObject())
				.isEqualTo("typeinference.TestTypeUpdateMoveRejectLaundering.Param");
		// MOVE destinations never committed: upstream saw CHANGED instead of REJECT.
		assertThat(ctx.moveDests).allMatch(v -> !v.getTypeInfo().getType().isTypeKnown());
	}

	@Test
	public void withoutConflictingBoundsMoveDestsAreTyped() {
		disableCompilation();
		MethodContext ctx = loadContextBeforeTypeInference();

		TypeUpdateResult result = ctx.root.getTypeUpdate()
				.applyWithWiderIgnSame(ctx.mth, ctx.paramVar, ctx.paramType);

		assertThat(result).isEqualTo(TypeUpdateResult.CHANGED);
		assertThat(ctx.moveDests).allMatch(v -> v.getTypeInfo().getType().isTypeKnown());
	}

	private MethodNode loadRunMethodBeforeTypeInference() {
		return loadContextBeforeTypeInference().mth;
	}

	private MethodContext loadContextBeforeTypeInference() {
		jadxDecompiler = loadFiles(collectFixtureSmaliFiles());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		ClassNode cls = root.resolveClass(RUN_CLS);
		assertThat(cls).isNotNull();
		cls.add(AFlag.DONT_UNLOAD_CLASS);
		root.runPreDecompileStageForClass(cls);
		cls.load();
		runPassesBeforeTypeInference(root, cls);

		MethodNode mth = cls.searchMethodByShortName("run");
		assertThat(mth.getSVars()).isNotEmpty();

		RegisterArg paramReg = mth.getArgRegs().get(0);
		SSAVar paramVar = paramReg.getSVar();
		assertThat(paramVar).isNotNull();
		List<SSAVar> moveDests = collectMoveDests(paramVar);
		assertThat(moveDests).hasSizeGreaterThanOrEqualTo(2);

		ArgType paramType = paramReg.getImmutableType();
		assertThat(paramType).isNotNull();

		return new MethodContext(root, mth, paramVar, paramType, moveDests);
	}

	private static void addConflictingUseBounds(List<SSAVar> moveDests) {
		ArgType conflict = ArgType.object("java.lang.String");
		for (SSAVar moveDest : moveDests) {
			moveDest.getTypeInfo().getBounds().add(
					new TypeBoundConst(BoundEnum.USE, conflict, moveDest.getAssign()));
		}
	}

	private static void runPassesBeforeTypeInference(RootNode root, ClassNode cls) {
		for (IDexTreeVisitor pass : root.getPasses()) {
			// Keep MOVE insns: MoveInlineVisitor removes them before TypeInferenceVisitor runs.
			if (pass instanceof MoveInlineVisitor || pass instanceof TypeInferenceVisitor) {
				break;
			}
			DepthTraversal.visit(pass, cls);
		}
	}

	private static List<SSAVar> collectMoveDests(SSAVar source) {
		List<SSAVar> dests = new ArrayList<>();
		for (RegisterArg use : source.getUseList()) {
			if (use.getParentInsn() != null && use.getParentInsn().getType() == InsnType.MOVE) {
				RegisterArg dest = use.getParentInsn().getResult();
				if (dest != null) {
					dests.add(dest.getSVar());
				}
			}
		}
		return dests;
	}

	private static List<File> collectFixtureSmaliFiles() {
		String rel = "src/test/smali/" + FIXTURE_PKG + "/" + FIXTURE_NAME;
		File smaliDir = new File(rel);
		if (!smaliDir.exists()) {
			smaliDir = new File("jadx-core/" + rel);
		}
		File[] files = smaliDir.listFiles((dir, name) -> name.endsWith(".smali"));
		assertThat(files).as("Smali fixtures in " + smaliDir).isNotNull();
		return Arrays.stream(files).collect(Collectors.toList());
	}

	private static final class MethodContext {
		private final RootNode root;
		private final MethodNode mth;
		private final SSAVar paramVar;
		private final ArgType paramType;
		private final List<SSAVar> moveDests;

		private MethodContext(RootNode root, MethodNode mth, SSAVar paramVar, ArgType paramType, List<SSAVar> moveDests) {
			this.root = root;
			this.mth = mth;
			this.paramVar = paramVar;
			this.paramType = paramType;
			this.moveDests = moveDests;
		}
	}
}
