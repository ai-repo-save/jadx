package jadx.plugins.kotlin.metadata.model

import jadx.core.dex.instructions.args.ArgType
import jadx.core.dex.nodes.MethodNode

data class SuspendMethodInfo(
	val method: MethodNode,
	val continuationArgIndex: Int,
	val continuationArgType: ArgType,
)
