package jadx.core.dex.attributes.nodes;

import jadx.api.plugins.input.data.attributes.IJadxAttribute;
import jadx.core.dex.attributes.AType;

/**
 * Kotlin-specific field flags for Kotlin output format.
 */
public final class KotlinFieldFlagsAttr implements IJadxAttribute {

	private boolean lateinit;
	private boolean lazyDelegate;

	public boolean isLateinit() {
		return lateinit;
	}

	public void setLateinit(boolean lateinit) {
		this.lateinit = lateinit;
	}

	public boolean isLazyDelegate() {
		return lazyDelegate;
	}

	public void setLazyDelegate(boolean lazyDelegate) {
		this.lazyDelegate = lazyDelegate;
	}

	public static KotlinFieldFlagsAttr getOrCreate(jadx.core.dex.nodes.FieldNode field) {
		KotlinFieldFlagsAttr attr = field.get(AType.KOTLIN_FIELD_FLAGS);
		if (attr == null) {
			attr = new KotlinFieldFlagsAttr();
			field.addAttr(attr);
		}
		return attr;
	}

	@Override
	public AType<KotlinFieldFlagsAttr> getAttrType() {
		return AType.KOTLIN_FIELD_FLAGS;
	}

	@Override
	public String toString() {
		return "KOTLIN_FIELD_FLAGS{lateinit=" + lateinit + ", lazy=" + lazyDelegate + '}';
	}
}
