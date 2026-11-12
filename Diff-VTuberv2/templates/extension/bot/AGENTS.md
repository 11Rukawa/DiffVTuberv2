# AGENTS.md

Release checklist for this Diff-VTuberv2 bot extension. How to write one:
[docs/personas.md](../../../docs/personas.md) and [docs/extensions.md](../../../docs/extensions.md).
`pnpm describe:extension <dir>` and `pnpm check:extension <dir>` run from the root of a Diff-VTuberv2
checkout; `<dir>` is this package's directory.

- [ ] **Contract version**: `diffVTuberv2.api` equals the bot version on the `Contracts:` line that
  `check:extension` prints. A package with any other value does not load.
- [ ] **Self-description**: after changing default Worlds, the Persona's tools, Memory or prompt templates, run `pnpm describe:extension <dir>`.
  `diffVTuberv2.describe` names the written file and `files` ships it.
- [ ] **Tags**: `diffVTuberv2.tags` lists every tag in 扩展索引配置 whose "when"
  fits, notice and warning tags included.
- [ ] **CHANGELOG.md** has a `## <version>` section for the version being published.
- [ ] **`os`**: set the npm `os` field when the package runs only on some platforms.
- [ ] **`pnpm check:extension <dir>`** passes. Its "Before publishing" section reports the items
  above for this package.
- [ ] **Requests to the maintainers** (tag changes, certification, a replacement package, appeals)
  are issues in 扩展索引配置, in the plain-text format that
  `check:extension` prints and the 扩展索引配置 describes.
