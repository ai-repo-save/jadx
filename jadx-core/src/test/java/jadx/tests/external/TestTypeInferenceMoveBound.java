package jadx.tests.external;

import java.io.File;

import org.junit.jupiter.api.Test;

import jadx.api.JadxArgs;
import jadx.api.JadxDecompiler;
import jadx.api.JadxInternalAccess;
import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.nodes.RootNode;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Regression for type inference loop on R8-obfuscated ConstraintWidget.addToSolver (t.d.b).
 * Applying immutable parameter type triggered invoke generic back-propagation across 30+ virtual
 * calls, causing rollback/retry cycles until the update budget was exhausted.
 */
public class TestTypeInferenceMoveBound {

	@Test
	public void noTypeInferenceOverflowOnTdMethodB() {
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

			assertThat(mth.getSVars()).isNotEmpty();
			assertThat(mth.contains(AType.JADX_ERROR)).isFalse();
		}
	}
}
