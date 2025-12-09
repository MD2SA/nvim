# Manas Configuration

**Why use Vim (and Neovim)?** Move faster, stay on the keyboard, customize workflow for maximum efficiency.

**Why not use Vim (and Neovim)?** Because once you try it, other editors will feel bloated, and you'll miss Vim’s motions everywhere.


This repository contains my custom **Neovim** setup.
It’s largely based on ThePrimeagen’s configuration, with only minor modifications.

This README is meant to give newcomers a brief introduction to what it takes to have a simple yet fully capable Neovim setup.
It also provides guidance for getting started with Vim and highlights some of the most useful plugins for boosting productivity as a developer (in my opinion).

# Neovim System Dependencies

A minimal list of system-level dependencies required for my Neovim setup.

## Required

- `git`
- `gcc` / `clang` – Compiler for native plugins.
- `make` – Needed to build native plugins (e.g., `nvim-treesitter`).
- `ripgrep` (`rg`) – Used by Telescope for fast file searching.
- `PowerShell 7+` – Required on Windows.
- `fd` – Improves performance for Telescope
- `luarocks` – Needed for some Lua plugins (e.g., Plenary).
- `unzip` – Needed by Mason (recommended even if not strictly required).
- `wget` – Needed by Mason (recommended even if not strictly required).

## Optional but Recommended

- `node` – Required for `TSInstallFromGrammar` and some Treesitter features.
- `python3` – Useful for Python-based plugins.

- If something isn’t working, run `:checkhealth` in Neovim to troubleshoot missing dependencies. I may have missed a dependency 😅


# Installation

1. Clone the repository:

```bash
git clone https://github.com/MD2SA/nvim.git ~/.config/nvim
```

2. Open Neovim and install plugins (it usually does this automatically):

```vim
:Lazy sync
```

# Noobie Tips from Manas

- Most things you do in IntelliJ, VSCode, PyCharm, etc., you can do in Neovim—you just need to find the right command.
  - For example, `gd` → **g**oto-**d**efinition (like Ctrl+click in an IDE).
  - `K` → shows documentation or hover info for a word (like hovering in a normal editor).
  - etc etc, never think nvim lacks features, you just haven't discovered them yet

---

## About Learning Vim

- Check out this amazing playlist by ThePrimeagen: [YouTube](https://youtube.com/playlist?list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R&si=qnN2xyK5mZ7I8nyc)
- Bookmark the Vim cheat sheet: [vim.rtorr.com](https://vim.rtorr.com/)

- Focus on practical shortcuts first. Some commands may overlap (e.g., `Bbe` vs `gE`), but **use what feels intuitive**. A good trick is to **associate letters with actions** and understand how commands are "formed":
    - `b` → back (to the beginning of a word)
    - `e` → end (of a word)
    - `ci(` → change inside of "()"
> It doesn’t have to match exact Vim definitions; use what’s easiest to memorize.

- If a movement feels slow, there’s probably a better way. Check AI, cheat sheets, tutorials, forums, or `:help` in Neovim.
- Expect to get stuck at first—it’s normal. Stick to the basics, look up solutions, and gradually you’ll discover faster ways to work.

---

## Using This Config

### **Remaps**
- Lose 30min reading the remaps of this config, start by checking remap.lua and then go to the plugins you may want to use
- <C-u> and <C-d> to move up and down by half screen
- <leader>y for copying to system clipboard
- when autocompletion appears do <C-n> and <C-p> to move up and down on the options
- Feel free to make you own remaps


### **Check errors:**
- Place your cursor on a word and press `<leader>vd` to display diagnostics in a floating box.


### **Harpoon (quick buffer navigation):**
- Add a file: `<C-a>`
- View/edit: `<C-e>`
- Switch buffers: `<C-a>`, `<C-h>`, `<C-s>`, `<C-n>`, `<C-t>`
- Configuration: `lua/manas/lazy/harpoon.lua`
- DO USE this plugin—it’s amazing for managing frequently used files.
<video width="640" height="360" controls>
  <source src="./videos/harpoon.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>


### **Telescope (quick file search):**
- Opens search based on your current directory.
- Example: open Neovim in `~/.config/nvim` → Telescope will search files in that dir.
- Shortcut: `<leader>pf`
- Use partial names—the plugin uses `fd` under the hood, so you don’t need full paths.
- `<leader>` is set to Spacebar by default, but you can change it.


### **Install LSPs, formatters, and linters:**
  1. Run `:Mason` to install the language server for the language you want to use.
     - Example: For TypeScript, search `typescript-language-server` and press `I` to install.
  2. Repeat for any other languages or tools you need.
  3. This is a **one-time setup per language**. You can also preinstall tools by customizing your config.

> ⚠️ Note: The first time you open a file in a new language, you may see errors or missing functionality because Neovim hasn’t yet recognized that language. Once the corresponding LSP is installed and active, these issues will disappear.




# Configuration Structure
```
~/.config/nvim
├── init.lua                        -- Main entry point for Neovim
├── README.md
└── lua/
    └── manas/
        ├── init.lua                -- Core setup: loads set, remap, and lazy_init
        ├── lazy_init.lua           -- Initializes lazy.nvim and plugins
        ├── remap.lua
        ├── set.lua
        └── lazy/
            ├── autotag.lua         -- Auto-closes and renames HTML/XML tags
            ├── snippets.lua        -- Code snippets configuration
            ├── colors.lua          -- Sets color scheme and theme
            ├── harpoon.lua         -- Quick file navigation
            ├── init.lua            -- Plugin entry point + common dependencies
            ├── lsp.lua             -- Language Server Protocol setup
            ├── markdown.lua        -- Enhanced Markdown support
            ├── neogen.lua          -- Automatic code documentation generation
            ├── telescope.lua       -- File search and navigation
            ├── treesitter.lua      -- Advanced syntax highlighting
            ├── trouble.lua         -- Diagnostics panel (errors/warnings)
            └── undotree.lua        -- File undo history manager (may not work on Windows)

```


## Keymaps (from `remap.lua`)

```lua
-- Example mappings
vim.g.mapleader = " " -- <leader> is now " "(spacebar)

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- copy to system clipboard
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- open file tree
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- format entire code based on your lsp configuration
vim.keymap.set("i", "<C-c>", "<Esc>") -- amazing, you also can change for caps lock <CapsLock>


```

## Settings (from `set.lua`)

- General Neovim settings: line numbers, tabs, etc.
- Color and theme settings are managed in `lazy/colors.lua`.


# Little Disclaimer

I love using Vim, but I’m no pro, especially when it comes to configs.
This setup is mostly based on ThePrimeagen’s configuration; I haven’t changed much.

Use it as a starting point to learn and experiment with Neovim, without wasting time on settings you don’t yet understand, while still having a solid foundation. I’ve been using this config for the past year, and it’s been more than enough.
