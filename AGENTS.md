# AGENTS.md

## Cursor Cloud specific instructions

### Repository layout

This workspace is a **fork** of the upstream JADX project:

| Remote | URL | Role |
|--------|-----|------|
| `origin` | `https://github.com/ai-repo-save/jadx` | This fork (push target) |
| `upstream` | `https://github.com/skylot/jadx` | Official JADX repository |

Default branch: `master` on both remotes.

To sync upstream changes into the fork:

```bash
git fetch upstream master
git checkout master
git merge upstream/master
git push origin master
```

Fork-only commits (e.g. `AGENTS.md`, local test fixtures) are preserved on top of upstream merges.

### Product overview

JADX is a Dex-to-Java decompiler for Android. The repo ships a CLI (`jadx`) and a Swing desktop GUI (`jadx-gui`). There is no web server or Docker stack.

### Prerequisites

- **JDK 17+** to build from source (runtime requires Java 11+ 64-bit). The cloud VM ships OpenJDK 21.
- **Gradle wrapper** (`./gradlew`) — no system Gradle install required.
- Network access for Maven Central / Google Maven during builds.

### Common commands

| Task | Command |
|------|---------|
| Full CI-equivalent build + tests | `./gradlew build dist` |
| Build distribution only | `./gradlew dist` |
| Run CLI | `build/jadx/bin/jadx -d <out-dir> <input.apk\|.dex\|.smali>` |
| Run GUI | `build/jadx/bin/jadx-gui` |
| CLI version | `build/jadx/bin/jadx --version` |

Built launchers land in `build/jadx/bin/`. CI also sets `JADX_BUILD_JAVA_VERSION=11` when compiling with a newer JDK; this is optional for local builds on JDK 21.

### Services

| Service | Required? | Notes |
|---------|-----------|-------|
| JDK + Gradle | **Yes** | Only hard dependency for build, test, and CLI |
| Display (X11) | GUI only | `DISPLAY` is set on the cloud VM; use `xvfb-run` if headless |
| ADB (`localhost:5037`) | Optional | Smali debugger feature in `jadx-gui` only |

### Gotchas

- First `./gradlew` run downloads Gradle 9.4.1 and resolves many Maven dependencies; expect several minutes on a cold cache.
- `build dist` runs Spotless, Checkstyle, Error Prone, and the full JUnit 5 suite (~650+ integration tests in `jadx-core`). A successful `build` means tests passed.
- Test sample binaries (e.g. `test-samples/hello.dex`) are referenced in tests but may not be present in a sparse checkout; use `jadx-cli/src/test/resources/samples/HelloWorld.smali` for a quick CLI smoke test.
- `jadx-gui` is a Swing app — it will not work in a purely headless shell without a virtual framebuffer.

### Lint / quality gates

Quality checks run as part of `./gradlew build` (Spotless formatting, Checkstyle, Error Prone). There is no separate lint script beyond Gradle tasks.
