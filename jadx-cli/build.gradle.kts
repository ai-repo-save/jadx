plugins {
	id("jadx-java")
	id("jadx-library")
	id("application")

	// use shadow only for application scripts, jar will be copied from jadx-gui
	id("com.gradleup.shadow") version "8.3.8"
}

dependencies {
	implementation(project(":jadx-core"))
	implementation(project(":jadx-plugins-tools"))
	implementation(project(":jadx-commons:jadx-app-commons"))

	runtimeOnly(project(":jadx-plugins:jadx-dex-input"))
	runtimeOnly(project(":jadx-plugins:jadx-java-input"))
	runtimeOnly(project(":jadx-plugins:jadx-java-convert"))
	runtimeOnly(project(":jadx-plugins:jadx-smali-input"))
	runtimeOnly(project(":jadx-plugins:jadx-rename-mappings"))
	runtimeOnly(project(":jadx-plugins:jadx-kotlin-metadata"))
	runtimeOnly(project(":jadx-plugins:jadx-kotlin-source-debug-extension"))
	runtimeOnly(project(":jadx-plugins:jadx-xapk-input"))
	runtimeOnly(project(":jadx-plugins:jadx-aab-input"))
	runtimeOnly(project(":jadx-plugins:jadx-apkm-input"))
	runtimeOnly(project(":jadx-plugins:jadx-apks-input"))

	implementation("org.jcommander:jcommander:2.0")
	implementation("ch.qos.logback:logback-classic:1.5.32")
	implementation("com.google.code.gson:gson:2.13.2")
}

application {
	applicationName = "jadx"
	mainClass.set("jadx.cli.JadxCLI")
	applicationDefaultJvmArgs =
		listOf(
			"-XX:+IgnoreUnrecognizedVMOptions",
			"-Xms256M",
			"-XX:MaxRAMPercentage=70.0",
			"-XX:ParallelGCThreads=3",
			// disable zip checks (#1962)
			"-Djdk.util.zip.disableZip64ExtraFieldValidation=true",
			// Foreign API access for 'directories' library (Windows only)
			"--enable-native-access=ALL-UNNAMED",
		)
	applicationDistribution.from("$rootDir") {
		include("README.md")
		include("NOTICE")
		include("LICENSE")
	}
}

tasks.shadowJar {
	// shadow jar not needed
	configurations = listOf()
}

val mcpRuntimeExcludes =
	listOf(
		"jadx-gui",
		"flatlaf",
		"rsyntax",
		"j2v8",
		"graphviz",
		"logback",
	)

val mcpRuntimeClasspath by configurations.creating {
	isCanBeConsumed = false
	isCanBeResolved = true
	extendsFrom(configurations.getByName("runtimeClasspath"))
}

val packageMcpRuntime by tasks.registering(com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar::class) {
	group = "jadx"
	description = "Build headless runtime jar for MCP (no GUI/Swing)"

	archiveBaseName.set("jadx-mcp-runtime")
	archiveClassifier.set("")
	archiveVersion.set("")

	configurations = listOf(mcpRuntimeClasspath)
	mergeServiceFiles()
	duplicatesStrategy = DuplicatesStrategy.EXCLUDE
	isZip64 = true

	dependencies {
		exclude { details ->
			val name = details.moduleName.lowercase()
			mcpRuntimeExcludes.any { exclude -> name.contains(exclude) }
		}
	}

	exclude("ch/qos/logback/**")
	exclude("META-INF/*.SF", "META-INF/*.DSA", "META-INF/*.RSA", "META-INF/*.EC")

	destinationDirectory.set(rootProject.layout.buildDirectory.dir("jadx/lib"))
}

tasks.test {
	dependsOn(packageMcpRuntime)
}

val jadxDevToolArgs: String? by project

tasks.register<JavaExec>("jadxDev") {
	group = "jadx-dev"
	description = "Run jadx developer tools (export-smali, dump-cfg, inspect-method, list-visitors)"
	classpath = sourceSets.main.get().runtimeClasspath
	mainClass.set("jadx.cli.tools.JadxDev")
	if (jadxDevToolArgs != null) {
		args(jadxDevToolArgs!!.trim().split(Regex("\\s+")))
	}
}
