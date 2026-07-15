# Neovim 0.12 Renovation Plan

## Purpose

This document is the working plan for renovating this Neovim configuration to
current Neovim 0.12.3 conventions while preserving existing behavior.

The work is not limited to one incident. The Copilot/Node process issue is a
high-priority safety problem inside the broader renovation, but the renovation
also covers LSP setup, plugin debt, duplicated logic, old Vim-era settings,
formatting behavior, statusline behavior, lazy-loading policy, and general
cleanup.

## Current Constraints

- `docs/overview.md` is required by repo instructions but is not present in this
  checkout. If it is later added, read it before further code changes and update
  this plan if needed.
- The worktree is already dirty and most dirty files are renovation work.
- Clearly unrelated local changes, such as nvim-tree width or layout tweaks, must
  be left alone unless the user asks otherwise.
- Verification may start Neovim, including repeated starts, but it must be done
  with process checks so repeated starts cannot accumulate long-lived Node
  children.
- Plain `nvim` currently resolves `/Users/david.reis/.config/nvim` to a Home
  Manager store symlink, not this working tree. Runtime verification of this
  checkout must set `XDG_CONFIG_HOME=/Users/david.reis/src/dre/dotfiles` and use
  temporary cache/state directories until the Home Manager profile is rebuilt or
  activated.
- Avoid speculative cleanup. Remove dependencies and behavior only when there is
  concrete evidence they are unused, replaced, or broken.

## Protected Behavior

These behaviors must not regress:

- Copilot inline suggestions work on the first interactive insert session.
- Repeated `nvim --headless` invocations do not leave Copilot/Node language
  server processes behind.
- Lualine shows a useful Copilot status indicator.
- LSP servers attach to the filetypes this config declares.
- LSP formatting on save continues to work through the shared formatter path.
- Ruff remains allowed to apply Python-specific fix-all behavior on save if that
  behavior is intentionally retained.
- Terraform/OpenTofu docs keybinding and filetype behavior continue to work.
- nvim-tree unrelated UI changes are not reverted.
- Existing commented-out configuration is preserved unless it is directly in the
  task path and demonstrably obsolete.

## Non-Blocking Assumptions

- Neovim 0.12.3 is the target runtime.
- Native `vim.lsp.config()` and `vim.lsp.enable()` are preferred over old
  `require("lspconfig").SERVER.setup()` style.
- `vim.lsp.status` replaces `lsp-status.nvim` for lualine status text.
- `nvim-web-devicons` replaces legacy `vim-devicons`.
- CopilotChat can be lazy-loaded on commands/key use; core Copilot should not be
  lazy-loaded on `InsertEnter` because that misses the first insert event.

## Blocking Assumptions To Clarify Before Changing

- Removing a plugin that provides user-visible commands or mappings not covered
  elsewhere.
- Replacing a language server with another server where semantics differ.
- Removing old custom parser/query logic without confirming native Treesitter
  support covers the same filetypes.
- Changing broad keybinding schemes or leader mappings.
- Changing UI layout preferences unrelated to renovation.
- Adding new dependencies.

## Root Cause: Copilot/Node Process Incident

Observed failure path:

1. `copilot.lua` can start a Node-backed Copilot language server.
2. The plugin schedules client startup after setup.
3. If Copilot is loaded during `nvim --headless`, repeated headless starts can
   spawn repeated Node processes.
4. If shutdown is not clean or the child outlives the parent, memory usage grows
   with each invocation.

Required fix shape:

- Core Copilot may load eagerly in interactive Neovim to preserve autocomplete.
- Core Copilot must be disabled for explicit `--headless` runs.
- Parser installation and other downloader jobs must be disabled for explicit
  `--headless` runs; missing Treesitter parsers should be installed only during
  interactive startup.
- Verification must include repeated Neovim starts plus process-table checks.
- Any lazy-loading change to core Copilot must be rejected unless first-insert
  autocomplete is proven to still work.

## Verification Safety Harness

Use a controlled process check before and after any Neovim startup tests.

Suggested checks:

```sh
ps -axo pid,ppid,command | rg 'copilot|language-server|node'
```

For repeated headless runs:

```sh
XDG_CONFIG_HOME=/Users/david.reis/src/dre/dotfiles \
XDG_CACHE_HOME=/private/tmp/nvim-cache \
XDG_STATE_HOME=/private/tmp/nvim-state \
  nvim --headless +'quitall'
```

Repeat that command several times, then check:

```sh
ps -axo pid,ppid,command | rg 'copilot|language-server|node'
```

Expected result:

- No new `copilot.lua/copilot/js/language-server.js --stdio` processes remain
  after headless runs exit.
- Existing Node processes unrelated to the tested Neovim runs must be identified
  by parent PID and left alone unless explicitly approved for termination.

For interactive Copilot behavior:

```sh
nvim <small test file>
```

Manual checks:

- Enter insert mode once.
- Confirm inline suggestions can appear in that first insert session.
- Confirm lualine Copilot indicator changes from idle/loading/error as status
  notifications arrive.
- Exit Neovim and confirm its Copilot Node child exits.

## Work Phases

### Phase 1: Safety Baseline

Goal: make the repo safe to test repeatedly.

Checklist:

- Add a headless guard for Node-backed interactive-only plugins.
- Add a headless guard for Treesitter parser installation.
- Keep core Copilot eager for interactive sessions.
- Keep CopilotChat command-loaded.
- Verify repeated `--headless` starts do not leave Copilot Node children.
- Verify interactive Copilot first-insert suggestions still work.
- Document the Copilot lazy-loading caveat in code so it is not reverted.

Status:

- Implemented for the working tree.
- Repeated repo-scoped `--headless` starts did not leave new Copilot Node
  children.
- Treesitter parser installation is skipped during explicit headless runs to
  avoid repeated downloader jobs for missing parsers.
- Still requires deployment/activation before plain `nvim` uses this updated
  config instead of the current Home Manager store symlink.

### Phase 2: LSP 0.12 Migration Audit

Goal: remove old nvim-lspconfig setup patterns and align with Neovim 0.12.3.

Checklist:

- Confirm all language servers are registered through `vim.lsp.config()` and
  `vim.lsp.enable()`.
- Remove direct `require("lspconfig")` usage from local LSP configs unless there
  is no native replacement.
- Prefer `root_markers` where native 0.12 root detection covers the case.
- Keep custom `root_dir` functions only where they encode real local behavior,
  such as PlatformIO clangd root reuse.
- Confirm `workspace_required` is used only where a server should not start for
  single files.
- Remove obsolete options such as old `single_file_support` overrides when native
  root behavior replaces them.
- Replace outdated capability field names such as `document_formatting` with
  current capability handling.
- Replace `vim.lsp.set_log_level()` with `vim.lsp.log.set_level()`.

Verification:

- Static search for `require("lspconfig")`.
- Static search for `document_formatting`.
- Start Neovim against representative filetypes and run `:LspInfo` or native
  equivalent inspection.
- Confirm each expected server attaches once.

Status:

- Partially implemented.
- Needs representative runtime verification.

### Phase 3: Filetype And LSP Matching Audit

Goal: ensure declared LSP filetypes actually match Neovim filetypes.

Known issue:

- Neovim 0.12 LSP filetypes are exact strings. Wildcard-style entries such as
  `yaml.*`, `jinja.*`, and `*.jinja` do not match.

Checklist:

- Replace wildcard-style LSP filetypes with explicit concrete filetype names.
- Leave warning comments where this is non-obvious.
- Compare `vim.filetype.add()` custom filetypes against all `lua/lsp/*.lua`
  `filetypes` lists.
- Confirm specialized YAML filetypes use the intended server:
  - `yaml.compose`
  - `yaml.compose.jinja`
  - `yaml.gitlabci`
  - `yaml.jinja`
  - `yaml.ansible`
- Confirm Terraform and OpenTofu filetypes match the selected server policy.

Verification:

- Static search for wildcard-looking LSP filetypes.
- Open representative file names and inspect `:set ft?` plus attached clients.

Status:

- Partially implemented.
- Representative repo-scoped filetype checks pass for Docker Compose, YAML
  Jinja, GitLab CI, Terraform/OpenTofu-related filenames, and React/TypeScript.
- Docker Compose filetype priorities were raised above Neovim's built-in YAML
  detector and documented with a warning comment.
- Still needs full runtime LSP attachment checks for representative real
  projects.

### Phase 4: Formatting Consolidation

Goal: use the shared format-on-save path instead of per-LSP formatting hacks.

Checklist:

- Keep one shared `BufWritePre` formatter.
- Use `client:supports_method("textDocument/formatting", bufnr)`.
- Avoid per-server formatting disables unless there is a clear conflict.
- Keep `format = false` only for servers intentionally superseded by another
  formatter, such as `gopls` when `efm` wraps `golines`/`gofumpt`.
- Review `vim.g.terraform_fmt_on_save`; disable old vim-terraform formatting if
  LSP/shared formatting owns save formatting.
- Keep Ruff fix-all separate only if the desired behavior is code-action based
  and not covered by regular formatting.

Verification:

- Save representative Go, Python, Lua, Markdown, Terraform/OpenTofu files.
- Confirm only one formatter applies.
- Confirm no duplicate edits or format loops occur.

Status:

- Partially implemented.
- Needs runtime save checks.

### Phase 5: Dependency Pruning

Goal: remove superfluous plugins when native Neovim or existing standard plugins
cover the behavior.

Candidates already identified:

- `lsp-status.nvim`: replaced with `vim.lsp.status`.
- `copilot-status.nvim`: replaced with native `copilot.status` notifications.
- `vim-devicons`: replaced with `nvim-web-devicons`.
- `terraformls` Mason install: removed because `tofu_ls` is the selected
  Terraform and OpenTofu server.
- `xolox/vim-misc`: removed; no local config references `xolox#misc` and no
  remaining plugin spec depends on it.
- `pangloss/vim-javascript`: removed; Treesitter handles JavaScript
  highlighting/indentation and the parser install list now explicitly includes
  JavaScript, TypeScript, and TSX.
- `kustomize.nvim`: removed as an unintegrated dependency cluster. The local
  config was only `require("kustomize").setup({})`, and its optional
  dependencies `neo-tree.nvim`, `fyler.nvim`, and `LuaSnip` were not otherwise
  used by active plugin specs.
- `vim-superman`: replaced with a local `:SuperMan` compatibility command that
  delegates to native Neovim `:Man` and keeps the read-only manpage buffer
  behavior.
- `which-key.nvim`: restored as an interactive-only locked dependency because
  `<leader>?` still calls `require("which-key")` and the existing options file
  indicates this was an unintentionally broken user-facing helper.

Further candidates to audit:

- `vim-doge`: keep for now; `<leader>b`, `<Tab>`, and `<S-Tab>` mappings expose
  doc generation and navigation.
- `cmp-ai`: keep for now; `<C-x>` invokes a manual `cmp_ai` completion source.
- `treesitter-terraform-doc.nvim`: keep for now; Terraform buffers map
  `<leader>h` to `:OpenDoc`.

Verification:

- Static search for plugin-provided commands, globals, mappings, and requires.
- Runtime command checks where static evidence is insufficient.
- Remove lockfile entries only when plugin spec is removed.

Status:

- Implemented for the candidates with clear local evidence.
- Further pruning should require a specific replacement or explicit approval,
  because the remaining candidates have active mappings or user-visible
  workflows.

### Phase 6: Statusline Renovation

Goal: preserve useful statusline behavior without deprecated plugins.

Checklist:

- Use `vim.lsp.status` in lualine.
- Keep a real Copilot status icon by subscribing to `copilot.status`.
- Avoid static statusline placeholders that never update.
- Confirm lualine does not require removed plugins at startup.

Verification:

- Open interactive Neovim.
- Confirm lualine renders without errors.
- Trigger LSP progress and Copilot status changes.

Status:

- Partially implemented.
- Needs runtime verification.

### Phase 7: General Lua Cleanup And DRY Pass

Goal: reduce old Vim-era glue while keeping behavior obvious.

Checklist:

- Replace repeated ad hoc root/filetype/config patterns with small shared helpers
  only where there is real duplication.
- Share repeated filetype option tables instead of maintaining separate copies
  for each two-space filetype.
- Keep one LSP config loader and avoid per-language boilerplate.
- Use `vim.api.nvim_get_option_value()` over deprecated buffer option access
  where touched.
- Prefer `vim.fs` and `vim.uv` over old `lspconfig.util` and Vimscript helpers.
- Avoid broad rewrites of keymaps or UI config.
- Preserve comments that document non-obvious behavior.

Verification:

- Lua parse checks for touched files.
- Static search for deprecated APIs.
- Focused runtime smoke checks.

Status:

- Ongoing.
- Filetype option tables have been DRYed for common two-space and YAML-like
  settings, including dotted Neovim filetypes such as `yaml.compose` and
  `typescript.tsx`.
- Deprecated option/highlight APIs in touched helpers were replaced with
  `nvim_get_option_value()`, `nvim_set_option_value()`, `nvim_get_hl()`, and
  `vim.uv`.
- Removed a stale Packer-style `after` mutation from the lazy.nvim spec
  normalization and a duplicate lazy.nvim runtimepath prepend.

## Runtime Smoke Matrix

Use this after static cleanup and before declaring the renovation complete.

| Area | File or command | Expected result |
| --- | --- | --- |
| Headless safety | `nvim --headless +'quitall'` repeated | No leftover Copilot Node child |
| Copilot | Any editable source file | Suggestions work in first insert session |
| Lualine | Interactive startup | No errors, Copilot icon updates |
| Lua LSP | `init.lua` or Lua config | `lua_ls` attaches |
| Python LSP | `.py` file | `pyright` and `ruff` attach as intended |
| Go LSP | `.go` file | `gopls` attaches, save formatting uses intended path |
| Terraform | `.tf`, `.tfvars`, `.tftest.hcl` | `tofu_ls` attaches where intended |
| Docker Compose | `docker-compose.yaml` | compose server attaches |
| YAML Jinja | `*.yaml.j2` | intended YAML/Jinja clients attach |
| GitLab CI | `.gitlab-ci.yml` | GitLab CI server attaches |
| C/C++ | `.c`, `.cpp`, PlatformIO include path | clangd root behavior preserved |

## Definition Of Done

The renovation is complete only when:

- Neovim 0.12.3 starts cleanly in interactive and headless modes.
- Repeated headless starts do not leak Copilot/Node processes.
- Core Copilot works on the first insert session.
- Lualine status behavior is restored without removed status plugins.
- All local LSP configs use current Neovim 0.12 APIs or have documented reasons
  for custom behavior.
- Removed plugins have corresponding lockfile cleanup.
- Representative filetypes attach the intended LSP clients.
- Shared format-on-save works and does not duplicate per-server formatting.
- Comments warn against non-obvious regressions, especially exact LSP filetypes
  and Copilot lazy-loading.
- The final diff is scoped, reviewable, and does not revert unrelated local UI
  changes.
