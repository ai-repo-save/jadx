package jadx.core.codegen.kotlin;

import jadx.api.JadxArgs;
import jadx.core.codegen.lang.CodeLanguages;
import jadx.core.dex.nodes.RootNode;

public final class KotlinCodegen {

	private KotlinCodegen() {
	}

	public static boolean isKotlinOutput(JadxArgs args) {
		return CodeLanguages.from(args).isKotlin();
	}

	public static boolean isKotlinOutput(RootNode root) {
		return CodeLanguages.from(root).isKotlin();
	}
}
