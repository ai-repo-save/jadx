package jadx.core.dex.attributes.nodes;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.jetbrains.annotations.Nullable;

import jadx.api.plugins.input.data.attributes.IJadxAttribute;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;

public final class MethodDefaultParamsAttr implements IJadxAttribute {

	private final Map<Integer, DefaultValue> defaults;

	private MethodDefaultParamsAttr(Map<Integer, DefaultValue> defaults) {
		this.defaults = defaults;
	}

	public static MethodDefaultParamsAttr getOrCreate(MethodNode mth) {
		MethodDefaultParamsAttr attr = mth.get(AType.METHOD_DEFAULT_PARAMS);
		if (attr == null) {
			attr = new MethodDefaultParamsAttr(new HashMap<>());
			mth.addAttr(attr);
		}
		return attr;
	}

	public void addDefault(int argIndex, MethodNode sourceMth, InsnNode valueInsn) {
		defaults.put(argIndex, new DefaultValue(sourceMth, valueInsn));
	}

	public @Nullable DefaultValue getDefault(int argIndex) {
		return defaults.get(argIndex);
	}

	public Map<Integer, DefaultValue> getDefaults() {
		return Collections.unmodifiableMap(defaults);
	}

	@Override
	public AType<MethodDefaultParamsAttr> getAttrType() {
		return AType.METHOD_DEFAULT_PARAMS;
	}

	@Override
	public String toString() {
		return "METHOD_DEFAULT_PARAMS" + defaults.keySet();
	}

	public static final class DefaultValue {
		private final MethodNode sourceMth;
		private final InsnNode valueInsn;

		public DefaultValue(MethodNode sourceMth, InsnNode valueInsn) {
			this.sourceMth = sourceMth;
			this.valueInsn = valueInsn;
		}

		public MethodNode getSourceMth() {
			return sourceMth;
		}

		public InsnNode getValueInsn() {
			return valueInsn;
		}
	}
}
