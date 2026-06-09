plugins {
	id("jadx-library")
}

dependencies {
	api(project(":jadx-core"))
	implementation("io.get-coursier.util:directories-jni:0.1.4")

	testImplementation(
		project
			.project(":jadx-core")
			.sourceSets
			.getByName("test")
			.output,
	)
	testImplementation("org.apache.commons:commons-lang3:3.20.0")
	testImplementation(project(":jadx-plugins:jadx-dex-input"))
	testImplementation(project(":jadx-plugins:jadx-smali-input"))
	testImplementation(project(":jadx-plugins:jadx-java-convert"))
	testImplementation(project(":jadx-plugins:jadx-java-input"))
	testImplementation("org.eclipse.jdt:ecj") {
		version {
			prefer("3.33.0")
			strictly("[3.33, 3.34[")
		}
	}
}
