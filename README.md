# Nvim Config

My (opinionated) neovim configuration. Runs on NixOS, Windows and Linux.

---

- [Nvim Config](#nvim-config)
  - [Requirements](#requirements)
    - [Windows](#windows)
    - [Linux (Mutable FS)](#linux-mutable-fs)
    - [NixOS](#nixos)
  - [Notes](#notes)
    - [Mason + uv](#mason--uv)
      - [Reverting to `python3`](#reverting-to-python3)
  - [Structure](#structure)
  - [Plugins](#plugins)
  - [Themes](#themes)
  - [To-Do](#to-do)

---

## Requirements

Some language servers, Treesitter parsers, and formatters require a native toolchain at runtime or during installation. Language servers and formatters can be installed manually or via Mason.

### Windows

- **System utilities**
  - `git`
  - `curl` *(or `wget`)*
  - `tar`
  - `gzip`
  - `unzip`

- **Toolchains**
  - Any C compiler (MSVC / LLVM / GCC etc)
  - `cmake`

- **Treesitter**
  - `tree-sitter` (cli)

- **Mason installers**
  - `node`
  - `python`
  - `go` / `cargo` etc if required

### Linux (Mutable FS)

- **System utilities**
  - `git`
  - `curl` or `wget`
  - `unzip`
  - `tar`
  - `gzip`

- **Toolchains**
  - Any C compiler (CLANG/GCC etc)
  - `cmake`
  - `make`
  - `pkg-config`

- **Treesitter**
  - `tree-sitter` (cli)

- **Mason installers**
  - `node`
  - `python3` *(or `uv` with `KingMichaelPark/mason.nvim` @ `b0827eb6cee026d0ed2fabab081296705a92240e`)*
  - `go` / `cargo` etc if required

### NixOS

- **Plugins (via Nix)**
  - `pkgs.vimPlugins.lazy-nvim`
  - `pkgs.vimPlugins.nvim-treesitter.withAllGrammars`

- **Treesitter**
  - `pkgs.tree-sitter` (cli)

- **Toolchains**
  - `pkgs.gcc` *(or clang)*
  - `pkgs.cmake`
  - `pkgs.gnumake`
  - `pkgs.pkg-config`

- **Mason**
  - `pkgs.git`
  - `pkgs.curl` or `pkgs.wget`
  - `pkgs.unzip`
  - `pkgs.gnutar`
  - `pkgs.gzip`
  - **Installers**
    - `pkgs.nodejs`
    - `pkgs.python3` *(or `pkgs.uv` `KingMichaelPark/mason.nvim` @ `b0827eb6cee026d0ed2fabab081296705a92240e`)*
    - `pkgs.go` / `pkgs.cargo` etc if required

---

## Notes

- [Neovim Tricks](notes/neovim_tricks.md)
- [Plugin Candidates](notes/plugin_candidates.md)

### Mason + uv

This configuration uses `uv` instead of `python3` for Mason installers when
running `KingMichaelPark/mason.nvim` at commit
`b0827eb6cee026d0ed2fabab081296705a92240e`.

This behavior is not supported by upstream Mason and may break on update.

#### Reverting to `python3`

1. Replace `KingMichaelPark/mason.nvim` with `williamboman/mason.nvim` and remove the pinned `commit` in [lua/plugins/init.lua#L260-L266](<https://github.com/r58iiz/nvim-config/blob/ff2d8642b3c4463f7118f2a903bb881a12f47055/lua/plugins/init.lua#L260-L266>)

```diff
            {
                -- [LSP] Mason.nvim
                -- https://github.com/williamboman/mason.nvim
+               "williamboman/mason.nvim",
-               "KingMichaelPark/mason.nvim",
-                commit = "b0827eb6cee026d0ed2fabab081296705a92240e",
                lazy = true,
            },
```

2. Remove the `use_uv` key from [lua/plugins/configs/lsp/lsp_zero_config.lua#L103-L106](<https://github.com/r58iiz/nvim-config/blob/ff2d8642b3c4463f7118f2a903bb881a12f47055/lua/plugins/configs/lsp/lsp_zero_config.lua#L103-L106>)

```diff
        pip = {
            upgrade_pip = true,
-           use_uv = true,
        },
```

---

## Structure

```
.
│
├───after/
│   └───ftplugin/           # Per-filetype settings
│
├───lua/
│   │   autocmds.lua        # Global autocommands
│   │   options.lua         # Neovim options
│   │   plugin_loader.lua   # Custom "plugin loader"
│   │
│   ├───custom/             # Custom logic
│   │   ├───actions/        # Keybinding-driven actions
│   │   ├───commands/       # Commands
│   │   └───lib/            # Reusable internal libraries
│   │       ├───buffer/
│   │       ├───lsp/
│   │       ├───markdown/
│   │       └───renumber/
│   │
│   ├───keymaps/            # All keybindings, grouped by domain
│   │
│   └───plugins/
│       │   init.lua        # Plugin list / lazy.nvim specs
│       │   themes.lua      # Theme plugin definitions
│       │
│       └───configs/        # Per-plugin configuration modules
│           ├───lsp/        # LSP-related plugin configs
│           └───themes/     # Theme-specific configuration
├───init.lua                # Neovim entrypoint
├───plugin_state.json       # Custom plugin state / metadata
└───README.md
```

---

## Plugins

- Active:
  - NeogitOrg/neogit
  - VonHeikemen/lsp-zero.nvim
  - folke/which-key.nvim
  - ggandor/leap.nvim
  - hedyhli/outline.nvim
  - ibhagwan/fzf-lua
  - lervag/vimtex
  - lewis6991/gitsigns.nvim
  - lukas-reineke/indent-blankline.nvim
  - numToStr/Comment.nvim
  - nvim-lualine/lualine.nvim
  - nvim-treesitter/nvim-treesitter
  - nvim-treesitter/nvim-treesitter-textobjects
  - rcarriga/nvim-notify
  - sindrets/diffview.nvim
  - stevearc/conform.nvim
  - stevearc/oil.nvim
  - yorickpeterse/nvim-window

- Not in use (disabled via plugin_loader):
  - RRethy/vim-illuminate
  - akinsho/bufferline.nvim
  - folke/flash.nvim
  - folke/twilight.nvim
  - folke/zen-mode.nvim
  - kevinhwang91/nvim-ufo
  - m4xshen/hardtime.nvim
  - romgrk/barbar.nvim
  - stevearc/quicker.nvim

## Themes

- *Active* morhetz/gruvbox
- AstroNvim/astrotheme
- EdenEast/nightfox.nvim
- HoNamDuong/hybrid.nvim
- bluz71/vim-moonfly-colors
- catppuccin/nvim
- folke/tokyonight.nvim
- marko-cerovac/material.nvim
- navarasu/onedark.nvim
- nyoom-engineering/oxocarbon.nvim
- olimorris/onedarkpro.nvim
- rebelot/kanagawa.nvim
- rose-pine/neovim
- sainnhe/everforest
- slugbyte/lackluster.nvim

---

## To-Do

- Architecture & cleanup
  - [ ] Audit and remove unused plugins, configs, and keymaps
  - [ ] Refactor and normalize configuration structure
  - [ ] Improve error handling across custom modules
  - [ ] Rewrite [plugin_loader.lua](lua/plugin_loader.lua)

- LSP & tooling
  - [ ] Migrate from lsp-zero to native Neovim LSP configuration
  - [x] Configure clang-format
  - [x] Configure lsp-zero correctly
  - [x] Remove null-ls–related files
  - [x] Switch to a new formatter (Conform)

- Documentation
  - [ ] Improve README.md

- Keymaps & UX
  - [x] Fix keymap
  - [x] Implement [definition-peek](<https://github.com/nvimdev/lspsaga.nvim/blob/d027f8b9c7c55e26cf4030c8657a2fc8222ed762/lua/lspsaga/definition.lua#L196>) logic inspired by lspsaga

---
