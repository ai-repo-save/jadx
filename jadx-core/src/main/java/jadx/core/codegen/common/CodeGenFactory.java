package jadx.core.codegen.common;

import org.jetbrains.annotations.Nullable;

import jadx.api.JadxArgs;
import jadx.api.args.IntegerFormat;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.api.IMethodGen;
import jadx.core.codegen.java.JavaClassGen;
import jadx.core.codegen.java.JavaMethodGen;
import jadx.core.codegen.kotlin.KotlinClassGen;
import jadx.core.codegen.kotlin.KotlinMethodGen;
import jadx.core.codegen.lang.CodeLanguage;
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

	public static IClassGen createClassGen(ClassNode cls, @Nullable IClassGen parent) {
		if (isKotlin(cls, parent)) {
			return new KotlinClassGen(cls, parent);
		}
		return new JavaClassGen(cls, parent);
	}

	public static IClassGen createClassGen(ClassNode cls, @Nullable IClassGen parent, boolean useImports, boolean fallback,
			boolean showBadCode, IntegerFormat integerFormat) {
		if (isKotlin(cls, parent)) {
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
		ClassNode cls = mth.getParentClass();
		IClassGen clsGen = createClassGen(cls, null, false, true, true, IntegerFormat.AUTO);
		return createMethodGen(clsGen, mth);
	}

	/**
	 * Resolve output language: use parent when present, otherwise {@link JadxArgs} from root
	 * (same convention as {@link ClassGenBase#getParentGen()} returning {@code this} for top-level).
	 */
	private static CodeLanguage resolveLang(ClassNode cls, @Nullable IClassGen parent) {
		if (parent != null) {
			return parent.getLang();
		}
		return CodeLanguages.from(cls.root());
	}

	private static boolean isKotlin(ClassNode cls, @Nullable IClassGen parent) {
		return resolveLang(cls, parent).isKotlin();
	}
}
