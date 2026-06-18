# JADX developer scripts

Shell wrappers around `jadx-dev` (Java CLI in `jadx-cli`). Use these when building
regression smali fixtures or debugging decompiler passes — no full `dist` required.

## Prerequisites

- JDK 17+
- Run from repository root (scripts invoke `./gradlew :jadx-cli:jadxDev`)

## Quick start

```bash
chmod +x scripts/*.sh   # once, if needed

# List decompiler pass names (for --until-visitor)
./scripts/jadx-dev.sh list-visitors

# Export smali for test fixtures
./scripts/export-smali.sh \
  -i /path/to/app.apk \
  -o jadx-core/src/test/smali/kotlin/my-fixture \
  -c 'com.example.Foo$Bar' \
  --include-deps --include-pattern 'kotlin.' \
  --naming full

# Dump CFG after ModVisitor
./scripts/dump-cfg.sh \
  -i jadx-cli/src/test/resources/samples/HelloWorld.smali \
  -o /tmp/cfg-out \
  -c smali.HelloWorld \
  -m main \
  --until-visitor ModVisitor

# Inspect one method (Kotlin output by default)
./scripts/inspect-method.sh \
  -i jadx-core/src/test/smali/kotlin/readyou-flow-emit-regression \
  -c 'me.ash.reader.ui.page.home.flow.PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1' \
  -m invokeSuspend \
  --insns --attrs --errors
```

Input `-i` accepts APK, DEX, JAR, or a directory / single `.smali` file (same as `jadx` CLI).

## Commands

| Command | Purpose |
|---------|---------|
| `export-smali` | Write selected classes as `.smali` files |
| `dump-cfg` | Write Graphviz `.dot` CFG (raw / processed / regions) |
| `inspect-method` | Print decompiled code, optional smali/insns/regions/attrs |
| `list-visitors` | Print visitor pass names and order |

Run `./scripts/jadx-dev.sh <command> --help` for flags.

## Smali naming for fixtures

| `--naming` | Example class → file |
|------------|----------------------|
| `full` (default) | `kotlin.coroutines.Continuation` → `kotlin$coroutines$Continuation.smali` |
| `short` | `com.example.Foo$Bar` → `Foo$Bar.smali` |

Use `--strip-prefix com.myapp.` with `full` to drop a long application package prefix.

`--include-deps` pulls transitive `ClassNode` dependencies. Combine with
`--include-pattern kotlin.` to add kotlin stdlib stubs without the whole APK.

## CFG output layout

`dump-cfg` writes under `<output>/<class>_graphs/`:

- `*.(raw.)dot` — basic blocks with (raw) instructions
- `*.regions.dot` — region-based CFG (after region building)

Render with [Graphviz](https://graphviz.org/): `dot -Tpng -O file.dot`

## Direct Gradle invocation

```bash
./gradlew -q :jadx-cli:jadxDev "-PjadxDevToolArgs=list-visitors"
```

## Typical regression workflow

1. Reproduce on APK: `./scripts/inspect-method.sh -i app.apk -c ... -m ... --errors`
2. Export minimal smali: `./scripts/export-smali.sh -i app.apk -o ... -c ... --include-deps --include-pattern kotlin.`
3. Add `jadx-core` integration test loading the smali directory
4. If a pass breaks: `./scripts/dump-cfg.sh ... --until-visitor <PassName>` and compare `.dot` files
