package jadx.core.codegen.common;

import jadx.api.JadxArgs;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.api.IMethodGen;
import jadx.core.codegen.java.JavaClassGen;
import jadx.core.codegen.java.JavaMethodGen;
import jadx.core.codegen.kotlin.KotlinClassGen;
import jadx.core.codegen.kotlin.KotlinMethodGen;
import jadx.core.codegen.lang.CodeLanguages;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.MethodNode;

public final class CodeGenFactory {

	private CodeGenFactory() {
	}

	public static IClassGen createClassGen(ClassNode cls, JadxArgs args) {
		if (CodeLanguages.from(args).isKotlin()) {
			return new KotlinClassGen(cls, args);
		}
		return new JavaClassGen(cls, args);
	}

	public static IClassGen createClassGen(ClassNode cls, IClassGen parent) {
		if (parent.getLang().isKotlin()) {
			return new KotlinClassGen(cls, parent);
		}
		return new JavaClassGen(cls, parent);
	}

	public static IClassGen createClassGen(ClassNode cls, IClassGen parent, boolean useImports, boolean fallback,
			boolean showBadCode, jadx.api.args.IntegerFormat integerFormat) {
		if (parent.getLang().isKotlin()) {
			return new KotlinClassGen(cls, parent, useImports, fallback, showBadCode, integerFormat);
		}
		return new JavaClassGen(cls, parent, useImports, fallback, showBadCode, integerFormat);
	}

	public static IMethodGen createMethodGen(IClassGen classGen, MethodNode mth) {
		if (classGen.getLang().isKotlin()) {
			return new KotlinMethodGen(classGen, mth);
		}
		return new JavaMethodGen(classGen, mth);
	}

	public static IMethodGen createFallbackMethodGen(MethodNode mth) {
		IClassGen clsGen = createClassGen(mth.getParentClass(), null, false, true, true,
				jadx.api.args.IntegerFormat.AUTO);
		return createMethodGen(clsGen, mth);
	}
}
