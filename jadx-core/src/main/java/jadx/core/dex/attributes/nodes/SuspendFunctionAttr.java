package jadx.core.dex.attributes.nodes;

import jadx.api.plugins.input.data.attributes.IJadxAttribute;
import jadx.core.dex.attributes.AType;
import jadx.core.dex.instructions.args.ArgType;

/**
 * Marks a JVM method as a Kotlin {@code suspend fun} (CPS lowereding), detected from signature
 * and/or method-entry continuation cast — not from region shape.
 */
public final class SuspendFunctionAttr implements IJadxAttribute {

	public enum Source {
		/** Last parameter type is (or extends) {@code kotlin.coroutines.Continuation}. */
		SIGNATURE,
		/** Obfuscated / stripped metadata: {@code instanceof} + {@code check-cast} on continuation impl at entry. */
		ENTRY_CAST,
	}

	private final ArgType continuationArgType;
	private final int continuationArgIndex;
	private final Source source;

	public SuspendFunctionAttr(ArgType continuationArgType, int continuationArgIndex, Source source) {
		this.continuationArgType = continuationArgType;
		this.continuationArgIndex = continuationArgIndex;
		this.source = source;
	}

	public ArgType getContinuationArgType() {
		return continuationArgType;
	}

	public int getContinuationArgIndex() {
		return continuationArgIndex;
	}

	public Source getSource() {
		return source;
	}

	@Override
	public AType<SuspendFunctionAttr> getAttrType() {
		return AType.SUSPEND_FUNCTION;
	}
}
