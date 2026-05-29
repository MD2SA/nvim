# Manas Neovim Configuration

Personal Neovim configuration focused on a fast keyboard-driven workflow, sensible defaults, LSP support, completion, fuzzy search, diagnostics, and quick file navigation.

The setup is intentionally small and readable. It is based on ideas from ThePrimeagen's configuration, with changes for my own workflow and a cleaner module layout.

For a quick look at the setup, see the [Previews](#previews) section.

## Requirements

Install these system dependencies before opening Neovim for the first time:

- `neovim` 0.12 or newer
- `git`
- `curl`
- `unzip`
- `tar`
- `gzip`
- `make`
- `gcc` or `clang`
- `tree-sitter` CLI 0.26.1 or newer
- `ripgrep` (`rg`)
- `node` and `npm`
- Java 21 or newer

Optional, but useful:

- `fd`, for faster Telescope file finding
- `python3`, for Python projects and Neovim Python provider support
- `7zip`, if archive extraction fails on Windows

Why these are needed:

- `lazy.nvim` bootstraps plugins with `git`
- `mason.nvim` installs LSP servers and needs download/archive tools such as `curl`, `unzip`, `tar`, and `gzip`
- `nvim-treesitter` installs parsers with the `tree-sitter` CLI and a C compiler
- `LuaSnip` builds `jsregexp` with `make` and a C compiler
- Telescope uses `ripgrep` for grep-based searches
- Mason installs `pyright`, which uses `node`/`npm`
- The configured Java LSP (`jdtls`) needs Java 21 or newer

If something does not load correctly, run `:checkhealth` inside Neovim. It usually points directly to missing binaries, broken providers, or plugin issues.

On Windows, using a package manager makes setup and cleanup much easier. Good options include:

- Scoop: <https://scoop.sh/>
- Chocolatey: <https://chocolatey.org/>
- Winget: <https://learn.microsoft.com/windows/package-manager/winget/>

Before choosing one, read its installation instructions and make sure the tools it installs are added to your system `PATH`. Neovim can only call commands like `git`, `rg`, `tree-sitter`, compilers, and language servers if they are available from your terminal.

For example, with Scoop you can install most dependencies with:

```powershell
scoop install git neovim gcc make ripgrep fd unzip curl tree-sitter nodejs-lts python openjdk21
```

Recent Windows versions include `tar`; if `:checkhealth` reports archive issues, install `7zip` as well.

## Installation

Clone this repository into Neovim's config directory.

Linux/macOS:

```bash
git clone https://github.com/MD2SA/nvim.git ~/.config/nvim
```

Windows PowerShell:

```powershell
git clone https://github.com/MD2SA/nvim.git "$env:LOCALAPPDATA\nvim"
```

Start Neovim:

```bash
nvim
```

Plugins are managed with `lazy.nvim`. On first launch, plugins should install automatically. If needed, run:

```vim
:Lazy sync
```

## Windows Notes

Neovim and much of its plugin ecosystem are primarily designed with Unix-like environments in mind, so Windows support may require some additional care.

This configuration was created and tested on Linux. While the config itself should remain mostly portable, compatibility issues on Windows are more likely to come from Neovim, plugins, Treesitter parsers, LSP/toolchain installations, shell commands, or native builds.

## What's Included

- Core editor options: line numbers, indentation, search behavior, undo files, and UI settings
- Global keymaps for movement, clipboard usage, window navigation, quickfix navigation, and common edits
- Autocommands for yank highlighting, trailing whitespace cleanup, filetype-specific settings, and LSP keymaps
- Plugin management through `lazy.nvim`
- LSP setup through `mason.nvim`, `mason-lspconfig.nvim`, and `nvim-lspconfig`
- Completion with `nvim-cmp`, `LuaSnip`, and friendly snippets
- Fuzzy finding with Telescope
- Syntax highlighting with Treesitter
- Diagnostics navigation with Trouble
- Quick file navigation with Harpoon
- Theme configuration with Rose Pine

## Structure

```text
~/.config/nvim
├── init.lua
├── lazy-lock.json
├── README.md
└── lua/
    └── manas/
        ├── init.lua
        ├── lazy_init.lua
        ├── core/
        │   ├── autocmds.lua
        │   ├── keymaps.lua
        │   └── options.lua
        └── plugins/
            ├── autotag.lua
            ├── cmp.lua
            ├── colors.lua
            ├── editorconfig.lua
            ├── harpoon.lua
            ├── lsp.lua
            ├── telescope.lua
            ├── treesitter.lua
            ├── trouble.lua
            └── undotree.lua
```

Main entry points:

- `init.lua` loads `lua/manas/init.lua`
- `lua/manas/init.lua` loads core options, keymaps, autocommands, and plugin setup
- `lua/manas/lazy_init.lua` bootstraps `lazy.nvim` and imports `lua/manas/plugins`
- `lua/manas/core/` contains editor behavior
- `lua/manas/plugins/` contains plugin specs and plugin-specific keymaps

## Keymaps

The leader key is `Space`.

Core keymaps live in `lua/manas/core/keymaps.lua`.

| Keymap | Mode | Action                                                  |
| --- | --- |---------------------------------------------------------|
| `<leader>pv` | Normal | Open netrw file explorer                                |
| `<C-d>` / `<C-u>` | Normal | Move half-page down/up and center cursor                |
| `n` / `N` | Normal | Next/previous search result and center cursor           |
| `<leader>y` | Normal/Visual | Yank (copy) to system clipboard                         |
| `<leader>Y` | Normal | Yank (copy) line to system clipboard                    |
| `<leader>p` | Visual | Paste over selection without replacing current register |
| `<leader>d` | Normal/Visual | Delete without replacing current register               |
| `<leader>s` | Normal | Start substitution for word under cursor                |
| `<leader>x` | Normal | Make current file executable                            |
| `<leader>cn` / `<leader>cp` | Normal | Next/previous quickfix item                             |
| `<M-h/j/k/l>` | Normal | Move between windows                                    |
| `<M-+>` / `<M-->` | Normal | Resize window width                                     |
| `<M-J>` / `<M-K>` | Normal | Resize window height                                    |

LSP keymaps are attached per buffer in `lua/manas/core/autocmds.lua`.

| Keymap | Action |
| --- | --- |
| `gd` | Go to definition |
| `<leader>vgd` | Go to definition in a vertical split |
| `<leader>sgd` | Go to definition in a horizontal split |
| `K` | Show hover documentation |
| `<leader>vws` | Search workspace symbols |
| `<leader>vd` | Open diagnostic float |
| `<leader>vca` | Code action |
| `<leader>f` | Format buffer |
| `<leader>vrr` | References |
| `<leader>vrn` | Rename symbol |
| `<C-h>` | Signature help in insert mode |
| `[d` / `]d` | Previous/next diagnostic |

Plugin keymaps are defined next to the plugin that owns them:

- Telescope: `lua/manas/plugins/telescope.lua`
- Harpoon: `lua/manas/plugins/harpoon.lua`
- Trouble: `lua/manas/plugins/trouble.lua`
- Undotree: `lua/manas/plugins/undotree.lua`

## Common Workflows

### Find Files

Telescope searches from the current working directory.

| Keymap | Action |
| --- | --- |
| `<leader>pf` | Find files |
| `<C-p>` | Find Git-tracked files |
| `<leader>ps` | Grep from prompt |
| `<leader>pws` | Grep word under cursor |
| `<leader>pWs` | Grep WORD under cursor |
| `<leader>vh` | Search help tags |

### Navigate Frequent Files

Harpoon is useful for keeping a small working set of files available.

| Keymap | Action |
| --- | --- |
| `<leader>a` | Add current file to Harpoon |
| `<C-e>` | Open Harpoon menu |
| `<C-h>` | Open Harpoon file 1 |
| `<C-s>` | Open Harpoon file 2 |
| `<C-n>` | Open Harpoon file 3 |
| `<C-t>` | Open Harpoon file 4 |

### Diagnostics

Trouble provides a diagnostics panel.

| Keymap | Action |
| --- | --- |
| `<leader>tt` | Toggle diagnostics panel |
| `[t` | Previous Trouble item |
| `]t` | Next Trouble item |

## Language Servers

LSP configuration lives in `lua/manas/plugins/lsp.lua`.

The current default servers are:

- `jdtls`
- `lua_ls`
- `pyright`
- `clangd`

Mason installs those servers automatically through `mason-lspconfig`. To add another language server, update the `servers` table in `lua/manas/plugins/lsp.lua`.

For manual management, open:

```vim
:Mason
```

## Learning Vim

Start with the commands that remove the most friction from daily editing:

- `gd` to jump to definitions
- `K` to inspect documentation
- `ci(`, `ci"`, and similar text objects to change inside delimiters
- `b`, `e`, `w`, `0`, `^`, and `$` for basic movement
- `/` for search and `n` / `N` for navigation

Useful references:

- ThePrimeagen Vim playlist: <https://youtube.com/playlist?list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R>
- Vim cheat sheet: <https://vim.rtorr.com/>
- Built-in help: `:help`

## Previews

<table>
  <tr>
    <td width="50%" align="center">
      <strong>General</strong><br />
      <img src="https://github.com/user-attachments/assets/d022dcd1-96ed-47d1-ba6a-d258208364d6" width="100%" />
    </td>
    <td width="50%" align="center">
      <strong>Telescope</strong><br />
      <img src="https://github.com/user-attachments/assets/b7e742e2-d024-4a74-8474-c53d7e510ab9" width="100%" />
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <strong>Undotree</strong><br />
      <img src="https://github.com/user-attachments/assets/0924c672-facd-4b0a-8b0a-343b4d43c53b" width="100%" />
    </td>
    <td width="50%" align="center">
      <strong>Harpoon</strong><br />
      <img src="https://github.com/user-attachments/assets/df90d441-a77a-4d34-864c-1a2367a33897" width="100%" />
    </td>
  </tr>
</table>

> [!NOTE]
> The screenshots reflect my personal setup. Colorschemes and most of the configuration can be customized to suit your preferences.

## Notes

This is a personal config, not a framework. It is meant to be easy to read, copy from, and change. The best way to adapt it is to start with `lua/manas/core/keymaps.lua`, then move through the plugin files one by one.
