package jadx.core.codegen.kotlin;

import jadx.api.JadxArgs;
import jadx.core.dex.nodes.RootNode;

public final class KotlinCodegen {

	private KotlinCodegen() {
	}

	public static boolean isKotlinOutput(JadxArgs args) {
		return args.getOutputFormat() == JadxArgs.OutputFormatEnum.KOTLIN;
	}

	public static boolean isKotlinOutput(RootNode root) {
		return isKotlinOutput(root.getArgs());
	}
}
