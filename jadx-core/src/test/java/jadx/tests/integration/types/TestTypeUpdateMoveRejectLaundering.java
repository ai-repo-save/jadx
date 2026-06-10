package jadx.tests.integration.types;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Test;

import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.instructions.args.SSAVar;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;
import jadx.core.dex.visitors.DepthTraversal;
import jadx.core.dex.visitors.IDexTreeVisitor;
import jadx.core.dex.visitors.typeinference.ITypeBound;
import jadx.core.dex.visitors.typeinference.TypeInferenceVisitor;
import jadx.core.dex.visitors.typeinference.TypeUpdate;
import jadx.core.dex.visitors.typeinference.TypeUpdateResult;
import jadx.tests.api.SmaliTest;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Minimal repro for bug C ({@code TypeUpdate} non-convergence) on the <b>normal</b> pass pipeline
 * (including {@link jadx.core.dex.visitors.MoveInlineVisitor}).
 * <p>
 * MOVE copies survive because each branch assigns {@code v0} and the merge block uses {@code v0}
 * in a PHI ({@code MoveInlineVisitor} skips inlining when the move result is used in PHI).
 * One branch also calls {@code Helper.useString(String)} with the same register, so
 * {@link TypeInferenceVisitor#initTypeBounds} yields incompatible USE bounds on the PHI result
 * without any test-side bound injection.
 */
public class TestTypeUpdateMoveRejectLaundering extends SmaliTest {

	private static final String FIXTURE_PKG = "typeinference";
	private static final String FIXTURE_NAME = "TestTypeUpdateMoveRejectLaundering";
	private static final String RUN_CLS = FIXTURE_PKG + '.' + FIXTURE_NAME + ".Run";

	@Test
	public void moveSurvivesMoveInlineVisitorBecauseOfPhi() {
		disableCompilation();
		MethodContext ctx = loadContextBeforeTypeInference();

		assertThat(countMoveInsns(ctx.mth)).as("MOVE must survive normal MoveInlineVisitor (PHI use)").isPositive();
		assertThat(ctx.moveDests).isNotEmpty();
		assertThat(ctx.phiVar.isUsedInPhi()).isTrue();
	}

	@Test
	public void phiMergeProducesConflictingBoundsWithoutInjection() {
		disableCompilation();
		MethodContext ctx = loadContextBeforeTypeInference();
		initTypeBounds(ctx.root, ctx.mth);

		assertThat(hasConflictingBounds(ctx.phiVar)).isTrue();
	}

	@Test
	public void moveListenerLaundersInBoundsRejectToChanged() {
		disableCompilation();
		MethodContext ctx = loadContextBeforeTypeInference();
		initTypeBounds(ctx.root, ctx.mth);
		assertThat(ctx.phiVar.getTypeInfo().getType().isTypeKnown()).isFalse();

		TypeUpdate typeUpdate = ctx.root.getTypeUpdate();
		TypeUpdateResult result = typeUpdate.applyWithWiderIgnSame(ctx.mth, ctx.paramVar, ctx.paramType);

		assertThat(result).isEqualTo(TypeUpdateResult.CHANGED);
		assertThat(ctx.paramVar.getTypeInfo().getType().getObject())
				.isEqualTo("typeinference.TestTypeUpdateMoveRejectLaundering.Param");
		// PHI/move chain never committed: upstream saw CHANGED instead of REJECT.
		assertThat(ctx.phiVar.getTypeInfo().getType().isTypeKnown()).isFalse();
	}

	@Test
	public void fullTypeInferencePassOnConflictMethod() {
		disableCompilation();
		MethodContext ctx = loadContextWithTypeInference("run");

		assertThat(countMoveInsns(ctx.mth)).isPositive();
		assertThat(ctx.mth.contains(AType.JADX_ERROR)).isFalse();
		assertThat(ctx.paramVar.getTypeInfo().getType().isTypeKnown()).isTrue();
		// Normal TypeInferenceVisitor run: PHI copy stays unknown when branches disagree.
		assertThat(ctx.phiVar.getTypeInfo().getType().isTypeKnown()).isFalse();
	}

	@Test
	public void fullTypeInferencePassOnParamOnlyPhiMethod() {
		disableCompilation();
		MethodContext ctx = loadContextWithTypeInference("runParamPhiOnly");

		assertThat(ctx.mth.contains(AType.JADX_ERROR)).isFalse();
		assertThat(ctx.phiVar.getTypeInfo().getType().isTypeKnown()).isTrue();
	}

	@Test
	public void paramOnlyPhiGetsTypedWithSamePipeline() {
		disableCompilation();
		MethodContext ctx = loadContextBeforeTypeInference("runParamPhiOnly");
		initTypeBounds(ctx.root, ctx.mth);

		assertThat(hasConflictingBounds(ctx.phiVar)).isFalse();

		TypeUpdateResult result = ctx.root.getTypeUpdate()
				.applyWithWiderIgnSame(ctx.mth, ctx.paramVar, ctx.paramType);

		assertThat(result).isEqualTo(TypeUpdateResult.CHANGED);
		assertThat(ctx.phiVar.getTypeInfo().getType().isTypeKnown()).isTrue();
	}

	private MethodContext loadContextBeforeTypeInference() {
		return loadContextBeforeTypeInference("run");
	}

	private MethodContext loadContextWithTypeInference(String mthName) {
		MethodContext ctx = loadContextBeforeTypeInference(mthName);
		TypeInferenceVisitor visitor = new TypeInferenceVisitor();
		visitor.init(ctx.root);
		DepthTraversal.visit(visitor, ctx.mth);
		return ctx;
	}

	private MethodContext loadContextBeforeTypeInference(String mthName) {
		jadxDecompiler = loadFiles(collectFixtureSmaliFiles());
		RootNode root = JadxInternalAccess.getRoot(jadxDecompiler);
		ClassNode cls = root.resolveClass(RUN_CLS);
		assertThat(cls).isNotNull();
		cls.add(AFlag.DONT_UNLOAD_CLASS);
		root.runPreDecompileStageForClass(cls);
		cls.load();
		runPassesBeforeTypeInference(root, cls);

		MethodNode mth = cls.searchMethodByShortName(mthName);
		assertThat(mth.getSVars()).isNotEmpty();

		RegisterArg paramReg = mth.getArgRegs().get(0);
		SSAVar paramVar = paramReg.getSVar();
		assertThat(paramVar).isNotNull();

		List<SSAVar> moveDests = collectMoveDests(mth);
		SSAVar phiVar = findPhiMergedParamCopy(mth);
		ArgType paramType = paramReg.getImmutableType();
		assertThat(paramType).isNotNull();

		return new MethodContext(root, mth, paramVar, paramType, moveDests, phiVar);
	}

	private static void runPassesBeforeTypeInference(RootNode root, ClassNode cls) {
		for (IDexTreeVisitor pass : root.getPasses()) {
			if (pass instanceof TypeInferenceVisitor) {
				break;
			}
			DepthTraversal.visit(pass, cls);
		}
	}

	private static void initTypeBounds(RootNode root, MethodNode mth) {
		try {
			TypeInferenceVisitor visitor = new TypeInferenceVisitor();
			visitor.init(root);
			Method assignImmutable = TypeInferenceVisitor.class.getDeclaredMethod("assignImmutableTypes", MethodNode.class);
			assignImmutable.setAccessible(true);
			assignImmutable.invoke(visitor, mth);
			Method initBounds = TypeInferenceVisitor.class.getDeclaredMethod("initTypeBounds", MethodNode.class);
			initBounds.setAccessible(true);
			initBounds.invoke(visitor, mth);
		} catch (ReflectiveOperationException e) {
			throw new AssertionError("Failed to init type bounds like TypeInferenceVisitor", e);
		}
	}

	private static long countMoveInsns(MethodNode mth) {
		return mth.getBasicBlocks().stream()
				.flatMap(block -> block.getInstructions().stream())
				.filter(insn -> insn.getType() == InsnType.MOVE)
				.count();
	}

	private static List<SSAVar> collectMoveDests(MethodNode mth) {
		List<SSAVar> dests = new ArrayList<>();
		for (SSAVar ssaVar : mth.getSVars()) {
			InsnNode parentInsn = ssaVar.getAssign().getParentInsn();
			if (parentInsn != null && parentInsn.getType() == InsnType.MOVE) {
				dests.add(ssaVar);
			}
		}
		return dests;
	}

	/**
	 * {@code v0} at the merge block: PHI of per-branch {@code move-object v0, p0} copies.
	 */
	private static SSAVar findPhiMergedParamCopy(MethodNode mth) {
		return mth.getSVars().stream()
				.filter(SSAVar::isUsedInPhi)
				.filter(v -> v.getAssign().getParentInsn() != null)
				.filter(v -> {
					InsnNode insn = v.getAssign().getParentInsn();
					return insn.getType() == InsnType.MOVE
							&& insn.getArg(0).isRegister()
							&& ((RegisterArg) insn.getArg(0)).contains(AFlag.METHOD_ARGUMENT);
				})
				.findFirst()
				.orElseGet(() -> mth.getSVars().stream()
						.filter(SSAVar::isUsedInPhi)
						.findFirst()
						.orElseThrow());
	}

	private static boolean hasConflictingBounds(SSAVar ssaVar) {
		List<ArgType> boundTypes = ssaVar.getTypeInfo().getBounds().stream()
				.map(ITypeBound::getType)
				.filter(t -> t != null && t.isTypeKnown())
				.distinct()
				.toList();
		if (boundTypes.size() < 2) {
			return false;
		}
		boolean hasParam = boundTypes.stream()
				.anyMatch(t -> "typeinference.TestTypeUpdateMoveRejectLaundering.Param".equals(t.getObject()));
		boolean hasString = boundTypes.stream()
				.anyMatch(t -> "java.lang.String".equals(t.getObject()));
		return hasParam && hasString;
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
		private final SSAVar phiVar;

		private MethodContext(RootNode root, MethodNode mth, SSAVar paramVar, ArgType paramType,
				List<SSAVar> moveDests, SSAVar phiVar) {
			this.root = root;
			this.mth = mth;
			this.paramVar = paramVar;
			this.paramType = paramType;
			this.moveDests = moveDests;
			this.phiVar = phiVar;
		}
	}
}
