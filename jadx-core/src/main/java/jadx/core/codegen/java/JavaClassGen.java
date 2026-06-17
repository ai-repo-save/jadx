package jadx.core.codegen.java;

import jadx.api.ICodeWriter;
import jadx.api.JadxArgs;
import jadx.api.args.IntegerFormat;
import jadx.core.codegen.api.IClassGen;
import jadx.core.codegen.common.ClassGenBase;
import jadx.core.dex.info.AccessInfo;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.utils.exceptions.CodegenException;

public final class JavaClassGen extends ClassGenBase {

	public JavaClassGen(ClassNode cls, JadxArgs args) {
		super(cls, args);
	}

	public JavaClassGen(ClassNode cls, IClassGen parent) {
		super(cls, parent);
	}

	public JavaClassGen(ClassNode cls, IClassGen parent, boolean useImports, boolean fallback,
			boolean showBadCode, IntegerFormat integerFormat) {
		super(cls, (ClassGenBase) parent, useImports, fallback, showBadCode, integerFormat);
	}

	@Override
	protected void emitClassDeclaration(ICodeWriter clsCode) {
		AccessInfo[] afHolder = new AccessInfo[1];
		emitCommonClassDeclarationPrefix(clsCode, afHolder);
		AccessInfo af = afHolder[0];
		if (af.isInterface()) {
			if (af.isAnnotation()) {
				clsCode.add('@');
			}
			clsCode.add("interface ");
		} else if (af.isEnum()) {
			clsCode.add(lang.enumClassKeyword());
		} else {
			clsCode.add("class ");
		}
		clsCode.attachDefinition(cls);
		clsCode.add(cls.getClassInfo().getAliasShortName());
		emitClassDeclarationSuffix(clsCode, af);
	}

	@Override
	protected void emitClassBody(ICodeWriter clsCode, boolean printClassName) throws CodegenException {
		emitJavaStyleClassBody(clsCode, printClassName);
	}
}
