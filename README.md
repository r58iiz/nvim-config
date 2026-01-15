# Nvim Config

- [Nvim Config](#nvim-config)
  - [Structure](#structure)
  - [Plugins](#plugins)
  - [Themes](#themes)
  - [Notes](#notes)
  - [Todo](#todo)

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

## Notes

- [Neovim Tricks](notes/neovim_tricks.md)
- [Plugin Candidates](notes/plugin_candidates.md)

---

## Todo

- Architecture & cleanup
  - [ ] Audit and remove unused plugins, configs, and keymaps
  - [ ] Refactor and normalize configuration structure
  - [ ] Improve error handling across custom modules

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
