package jadx.plugins.kotlin.metadata.model

import jadx.core.dex.nodes.FieldNode

data class PropertyFlagsInfo(
	val field: FieldNode,
	val isLateinit: Boolean,
	val isLazyDelegate: Boolean,
)
