package jadx.core.codegen.lang;

import jadx.api.JadxArgs;
import jadx.core.dex.nodes.RootNode;

public final class CodeLanguages {

	private static final CodeLanguage JAVA = new JavaCodeLanguage();
	private static final CodeLanguage KOTLIN = new KotlinCodeLanguage();

	private CodeLanguages() {
	}

	public static CodeLanguage from(JadxArgs args) {
		return args.getOutputFormat() == JadxArgs.OutputFormatEnum.KOTLIN ? KOTLIN : JAVA;
	}

	public static CodeLanguage from(RootNode root) {
		return from(root.getArgs());
	}
}
