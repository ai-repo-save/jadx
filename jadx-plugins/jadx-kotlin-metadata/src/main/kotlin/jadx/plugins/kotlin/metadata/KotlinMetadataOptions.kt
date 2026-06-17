package jadx.plugins.kotlin.metadata

import jadx.api.plugins.options.impl.BasePluginOptionsBuilder
import jadx.plugins.kotlin.metadata.KotlinMetadataPlugin.Companion.PLUGIN_ID

class KotlinMetadataOptions : BasePluginOptionsBuilder() {
	var isClassAlias: Boolean = true
		private set
	var isMethodArgs: Boolean = true
		private set
	var isFields: Boolean = true
		private set
	var isCompanion: Boolean = true
		private set
	var isDataClass: Boolean = true
		private set
	var isObjectClass: Boolean = true
		private set
	var isSuspendFun: Boolean = true
		private set
	var isToString: Boolean = true
		private set
	var isGetters: Boolean = true
		private set

	override fun registerOptions() {
		boolOption(CLASS_ALIAS_OPT)
			.description("rename class alias")
			.defaultValue(true)
			.setter { isClassAlias = it }

		boolOption(METHOD_ARGS_OPT)
			.description("rename function arguments")
			.defaultValue(true)
			.setter { isMethodArgs = it }

		boolOption(FIELDS_OPT)
			.description("rename fields")
			.defaultValue(true)
			.setter { isFields = it }

		boolOption(COMPANION_OPT)
			.description("rename companion object")
			.defaultValue(true)
			.setter { isCompanion = it }

		boolOption(DATA_CLASS_OPT)
			.description("add data class modifier")
			.defaultValue(true)
			.setter { isDataClass = it }

		boolOption(OBJECT_CLASS_OPT)
			.description("add object declaration modifier")
			.defaultValue(true)
			.setter { isObjectClass = it }

		boolOption(SUSPEND_FUN_OPT)
			.description("restore suspend fun modifier")
			.defaultValue(true)
			.setter { isSuspendFun = it }

		boolOption(TO_STRING_OPT)
			.description("rename fields using toString")
			.defaultValue(true)
			.setter { isToString = it }

		boolOption(GETTERS_OPT)
			.description("rename simple getters to field names")
			.defaultValue(true)
			.setter { isGetters = it }
	}

	fun isPreparePassNeeded(): Boolean = isClassAlias

	fun isDecompilePassNeeded(): Boolean =
		isMethodArgs || isFields || isCompanion || isDataClass || isObjectClass || isSuspendFun || isToString || isGetters

	companion object {
		const val CLASS_ALIAS_OPT = "$PLUGIN_ID.class-alias"
		const val METHOD_ARGS_OPT = "$PLUGIN_ID.method-args"
		const val FIELDS_OPT = "$PLUGIN_ID.fields"
		const val COMPANION_OPT = "$PLUGIN_ID.companion"
		const val DATA_CLASS_OPT = "$PLUGIN_ID.data-class"
		const val OBJECT_CLASS_OPT = "$PLUGIN_ID.object-class"
		const val SUSPEND_FUN_OPT = "$PLUGIN_ID.suspend-fun"
		const val TO_STRING_OPT = "$PLUGIN_ID.to-string"
		const val GETTERS_OPT = "$PLUGIN_ID.getters"
	}
}
