package jadx.plugins.kotlin.metadata.utils

import jadx.core.deobf.NameMapper
import jadx.core.dex.attributes.nodes.RenameReasonAttr
import jadx.core.dex.instructions.args.ArgType
import jadx.core.dex.nodes.ClassNode
import jadx.core.dex.nodes.FieldNode
import jadx.core.dex.nodes.MethodNode
import jadx.core.utils.Utils
import jadx.plugins.kotlin.metadata.model.ClassAliasRename
import jadx.plugins.kotlin.metadata.model.CompanionRename
import jadx.plugins.kotlin.metadata.model.FieldRename
import jadx.plugins.kotlin.metadata.model.MethodArgRename
import jadx.plugins.kotlin.metadata.model.PropertyFlagsInfo
import jadx.plugins.kotlin.metadata.model.SuspendMethodInfo
import kotlin.metadata.KmClass
import kotlin.metadata.KmProperty
import kotlin.metadata.isDelegated
import kotlin.metadata.isLateinit
import kotlin.metadata.isSuspend
import kotlin.metadata.jvm.Metadata

object KotlinMetadataUtils {

	@JvmStatic
	fun getAlias(cls: ClassNode): ClassAliasRename? {
		val annotation = cls.getMetadata() ?: return null
		return getClassAlias(cls, annotation)
	}

	/**
	 * Try to get class info from Kotlin Metadata annotation
	 */
	private fun getClassAlias(cls: ClassNode, annotation: Metadata): ClassAliasRename? {
		val firstValue = annotation.data2.getOrNull(0) ?: return null

		try {
			val clsName = firstValue.trim()
				.takeUnless(String::isEmpty)
				?.let(Utils::cleanObjectName)
				?: return null

			val alias = splitAndCheckClsName(cls, clsName)
			if (alias != null) {
				RenameReasonAttr.forNode(cls).append("from Kotlin metadata")
				return alias
			}
		} catch (e: Exception) {
			LOG.error("Failed to parse kotlin metadata", e)
		}
		return null
	}

	// Don't use ClassInfo facility to not pollute class into cache
	private fun splitAndCheckClsName(originCls: ClassNode, fullClsName: String): ClassAliasRename? {
		if (!NameMapper.isValidFullIdentifier(fullClsName)) {
			return null
		}
		val pkg: String
		val name: String
		val dot = fullClsName.lastIndexOf('.')
		if (dot == -1) {
			pkg = ""
			name = fullClsName
		} else {
			pkg = fullClsName.substring(0, dot)
			name = fullClsName.substring(dot + 1)
		}
		val originClsInfo = originCls.classInfo
		val originName = originClsInfo.shortName
		if (originName == name || name.contains("$") ||
			!NameMapper.isValidIdentifier(name) ||
			countPkgParts(originClsInfo.getPackage()) != countPkgParts(pkg) || pkg.startsWith("java.")
		) {
			return null
		}
		val newClsNode = originCls.root().resolveClass(fullClsName)
		return if (newClsNode != null) {
			// class with alias name already exist
			null
		} else {
			ClassAliasRename(pkg, name)
		}
	}

	private fun countPkgParts(pkg: String): Int {
		if (pkg.isEmpty()) {
			return 0
		}
		var count = 1
		var pos = 0
		while (true) {
			pos = pkg.indexOf('.', pos)
			if (pos == -1) {
				return count
			}
			pos++
			count++
		}
	}

	fun mapMethodArgs(cls: ClassNode, kmCls: KmClass): Map<MethodNode, List<MethodArgRename>> {
		return buildMap {
			kmCls.functions.forEach { kmFunction ->
				val node: MethodNode = cls.searchMethodByShortId(kmFunction.shortId) ?: return@forEach

				val valueParams = kmFunction.valueParameters
				if (valueParams.isEmpty()) {
					return@forEach
				}
				val argRegs = node.argRegs
				val continuationSkip = if (kmFunction.isSuspend && argRegs.size == valueParams.size + 1) 1 else 0
				if (argRegs.size - continuationSkip != valueParams.size) {
					return@forEach
				}
				val aliasList = argRegs.take(valueParams.size).zip(valueParams).map { (rArg, kmValueParameter) ->
					MethodArgRename(rArg = rArg, alias = kmValueParameter.name)
				}
				put(node, aliasList)
			}
		}
	}

	fun mapFields(cls: ClassNode, kmCls: KmClass): List<FieldRename> {
		return kmCls.properties.mapNotNull { kmProperty ->
			val node = cls.searchFieldByShortId(kmProperty.shortId) ?: return@mapNotNull null
			FieldRename(field = node, alias = kmProperty.name)
		}
	}

	fun mapSuspendMethods(cls: ClassNode, kmCls: KmClass): List<SuspendMethodInfo> {
		return kmCls.functions.mapNotNull { kmFunction ->
			if (!kmFunction.isSuspend) {
				return@mapNotNull null
			}
			val node = cls.searchMethodByShortId(kmFunction.shortId) ?: return@mapNotNull null
			val argTypes = node.argTypes
			if (argTypes.isEmpty()) {
				return@mapNotNull null
			}
			val contIdx = argTypes.size - 1
			SuspendMethodInfo(node, contIdx, argTypes[contIdx])
		}
	}

	fun mapPropertyFlags(cls: ClassNode, kmCls: KmClass): List<PropertyFlagsInfo> {
		return kmCls.properties.mapNotNull { kmProperty ->
			val field = cls.searchFieldByShortId(kmProperty.shortId) ?: return@mapNotNull null
			val isLateinit = kmProperty.isLateinit
			val isLazy = kmProperty.isDelegated && isKotlinLazyDelegateType(cls, field)
			if (!isLateinit && !isLazy) {
				return@mapNotNull null
			}
			PropertyFlagsInfo(field, isLateinit, isLazy)
		}
	}

	private fun isKotlinLazyDelegateType(cls: ClassNode, field: FieldNode): Boolean {
		val typeCls = cls.root().resolveClass(field.type) ?: return false
		return implementsKotlinLazy(typeCls)
	}

	private fun implementsKotlinLazy(cls: ClassNode): Boolean {
		if (cls.classInfo.fullName == "kotlin.Lazy") {
			return true
		}
		for (iface in cls.interfaces) {
			if (iface.isObject && iface.`object` == "kotlin.Lazy") {
				return true
			}
		}
		val parent = cls.root().resolveClass(cls.superClass) ?: return false
		return implementsKotlinLazy(parent)
	}

	fun mapCompanion(cls: ClassNode, kmCls: KmClass): CompanionRename? {
		val compName = kmCls.companionObject ?: return null
		val compField = cls.fields.firstOrNull {
			it.name == compName && it.accessFlags.run { isStatic && isFinal && isPublic }
		} ?: return null

		if (compField.type.isObject) {
			val compType = compField.type.`object`
			val compCls = cls.innerClasses.firstOrNull {
				it.classInfo.makeRawFullName() == compType
			} ?: return null

			val isOnlyInit = compField.useIn.size == 1 && compField.useIn[0].methodInfo.isClassInit
			val isEmpty = compCls.run { methods.all { it.isConstructor } && fields.isEmpty() }

			return CompanionRename(
				field = compField,
				cls = compCls,
				hide = isOnlyInit && isEmpty,
			)
		}

		return null
	}
}
