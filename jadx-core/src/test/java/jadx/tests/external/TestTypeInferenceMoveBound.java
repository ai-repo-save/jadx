package jadx.tests.external;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import jadx.api.JadxArgs;
import jadx.api.JadxDecompiler;
import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.instructions.args.SSAVar;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Regression for type inference loop on R8-obfuscated ConstraintWidget.addToSolver (t.d.b).
 */
public class TestTypeInferenceMoveBound {

	@Test
	public void infersConcreteParamTypeOnTdMethodB() {
		JadxArgs args = new JadxArgs();
		args.getInputFiles().add(new File("../test-fixtures/apk/simpleshortcut-0.0.3.apk"));
		args.setSkipFilesSave(true);
		args.setSkipResources(true);
		args.setDeobfuscationOn(false);

		try (JadxDecompiler decompiler = new JadxDecompiler(args)) {
			decompiler.load();
			RootNode root = JadxInternalAccess.getRoot(decompiler);
			ClassNode cls = root.resolveClass("t.d");
			cls.add(AFlag.DONT_UNLOAD_CLASS);
			cls.getCode();

			MethodNode mth = cls.getMethods().stream()
					.filter(m -> m.getName().equals("b"))
					.findFirst()
					.orElseThrow();

			assertThat(mth.contains(AType.JADX_ERROR)).isFalse();

			SSAVar paramVar = mth.getSVars().stream()
					.filter(v -> v.getRegNum() == 58 && v.getVersion() == 0)
					.findFirst()
					.orElseThrow();

			assertThat(paramVar.getTypeInfo().getType().getObject()).isEqualTo("s.e");
			assertThat(paramVar.getTypeInfo().getType().isTypeKnown()).isTrue();

			List<SSAVar> moveDests = new ArrayList<>();
			for (RegisterArg use : paramVar.getUseList()) {
				InsnNode insn = use.getParentInsn();
				if (insn != null && insn.getType() == InsnType.MOVE) {
					RegisterArg dest = insn.getResult();
					if (dest != null) {
						moveDests.add(dest.getSVar());
					}
				}
			}
			assertThat(moveDests).hasSize(5);
			assertThat(moveDests).allMatch(v -> v.getTypeInfo().getType().getObject().equals("s.e"));

			long unknownCount = mth.getSVars().stream()
					.filter(v -> !v.getTypeInfo().getType().isTypeKnown())
					.count();
			assertThat(unknownCount).isZero();

			assertThat(cls.getCode().getCodeStr()).contains("void b(s.e");
		}
	}
}
