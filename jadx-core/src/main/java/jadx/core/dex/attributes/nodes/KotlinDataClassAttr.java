package jadx.core.dex.attributes.nodes;

import java.util.Collections;
import java.util.List;

import jadx.api.plugins.input.data.attributes.IJadxAttribute;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.ClassNode;
import jadx.core.dex.nodes.FieldNode;
import jadx.core.dex.nodes.MethodNode;

public final class KotlinDataClassAttr implements IJadxAttribute {

	private final MethodNode primaryConstructor;
	private final List<FieldNode> primaryCtorFields;

	private KotlinDataClassAttr(MethodNode primaryConstructor, List<FieldNode> primaryCtorFields) {
		this.primaryConstructor = primaryConstructor;
		this.primaryCtorFields = primaryCtorFields;
	}

	public static KotlinDataClassAttr getOrCreate(ClassNode cls, MethodNode primaryConstructor, List<FieldNode> primaryCtorFields) {
		KotlinDataClassAttr attr = cls.get(AType.KOTLIN_DATA_CLASS);
		if (attr == null) {
			attr = new KotlinDataClassAttr(primaryConstructor, primaryCtorFields);
			cls.addAttr(attr);
		}
		return attr;
	}

	public MethodNode getPrimaryConstructor() {
		return primaryConstructor;
	}

	public List<FieldNode> getPrimaryCtorFields() {
		return primaryCtorFields;
	}

	public boolean isPrimaryCtorField(FieldNode field) {
		return primaryCtorFields.contains(field);
	}

	@Override
	public AType<KotlinDataClassAttr> getAttrType() {
		return AType.KOTLIN_DATA_CLASS;
	}

	@Override
	public String toString() {
		return "KOTLIN_DATA_CLASS{fields=" + primaryCtorFields.size() + '}';
	}

	public static List<FieldNode> emptyFields() {
		return Collections.emptyList();
	}
}
