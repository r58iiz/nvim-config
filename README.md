# Nvim Config

- [Nvim Config](#nvim-config)
  - [Structure](#structure)
  - [Plugins](#plugins)
  - [Themes](#themes)
  - [Notes](#notes)
  - [Todo](#todo)
  - [Cool Plugins](#cool-plugins)

---

## Structure

```
nvim
│   .editorconfig
│   .gitattributes
│   .gitignore
│   .stylua.toml
│   init.lua
│   plugin_state_COPY.txt
│   README.md
│
├───after
│   └───ftplugin
│           c.lua
│           markdown.lua
│           nix.lua
│           ts.lua
│
└───lua
    │   autocmds.lua
    │   options.lua
    │   plugin_loader.lua
    │
    ├───custom
    │   │   debugging_helpers.lua
    │   │
    │   ├───commands
    │   │       change_tabsize.lua
    │   │       format_markdown_table.lua
    │   │       peek_definition.lua
    │   │       renumber.lua
    │   │
    │   └───lib
    │       ├───buffer
    │       │       filetype.lua
    │       │       tabsize.lua
    │       │
    │       ├───lsp
    │       │       peek_definition.lua
    │       │
    │       ├───markdown
    │       │       table_formatter.lua
    │       │
    │       └───renumber
    │               engine.lua
    │               rule.lua
    │
    ├───keymaps
    │       buffers.lua
    │       core.lua
    │       custom.lua
    │       files.lua
    │       git.lua
    │       helpers.lua
    │       init.lua
    │       insert.lua
    │       lsp.lua
    │       module_fzf.lua
    │       plugin_lazy.lua
    │       plugin_leap.lua
    │       plugin_outline.lua
    │       plugin_window.lua
    │       plugin_zen.lua
    │       tabs.lua
    │       terminal.lua
    │       utils.lua
    │       visual.lua
    │
    └───plugins
        │   init.lua
        │   themes.lua
        │
        └───configs
            │   barbar_config.lua
            │   bufferline_config.lua
            │   comment_config.lua
            │   diffview_config.lua
            │   flash_keys_config.lua
            │   gitsigns_config.lua
            │   illuminate_config.lua
            │   indentblankline_config.lua
            │   lualine_config.lua
            │   nvim_ufo_config.lua
            │   oil_config.lua
            │   treesitter_config.lua
            │   twilight_config.lua
            │   vimtex_config.lua
            │   whichkey_config.lua
            │   zenmode_config.lua
            │
            ├───lsp
            │       cmp_config.lua
            │       conform_config.lua
            │       diagnostics.lua
            │       lsp_zero_config.lua
            │
            └───themes
                    astrotheme_config.lua
                    catppuccin_config.lua
                    kanagawa_config.lua
                    material_config.lua
                    nordic_config.lua
                    rosepine_config.lua
                    tokyonight_config.lua
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

- [Neovim Tricks](neovim_tricks.md)

---

## Todo

- [ ] Migrate from lsp-zero to inbuilt lsp
- [x] Remove null-ls related files
- [x] Fix keymap
- [x] Configure clang-format
- [x] Get a new formatter
- [x] Configure lsp-zero properly
- [ ] Finish README.md
- [ ] Remove all the ones I don't use
- [ ] Cleanup and refactor all configs
- [ ] Proper error handling
- [ ] Maybe these could be moved to the file themselves?
- [ ] Actually learn Lua
- [ ] Implement <https://github.com/nvimdev/lspsaga.nvim/blob/d027f8b9c7c55e26cf4030c8657a2fc8222ed762/lua/lspsaga/definition.lua#L196>

---

## Cool Plugins

- [ ] <https://github.com/akinsho/toggleterm.nvim>
- [ ] <https://github.com/cshuaimin/ssr.nvim/>
- [ ] <https://github.com/danymat/neogen>
- [ ] <https://github.com/elihunter173/dirbuf.nvim>
- [ ] <https://github.com/folke/persistence.nvim>
- [ ] <https://github.com/gbprod/yanky.nvim>
- [ ] <https://github.com/iamcco/markdown-preview.nvim>
- [ ] <https://github.com/karb94/neoscroll.nvim>
- [ ] <https://github.com/kosayoda/nvim-lightbulb>
- [ ] <https://github.com/monaqa/dial.nvim>
- [ ] <https://github.com/mvllow/modes.nvim>
- [ ] <https://github.com/nvzone/floaterm>
- [ ] <https://github.com/nvzone/typr>
- [ ] <https://github.com/rmagatti/goto-preview>
- [ ] <https://github.com/shellRaining/hlchunk.nvim>
- [ ] <https://github.com/stefandtw/quickfix-reflector.vim>
- [ ] <https://github.com/stevearc/overseer.nvim>
- [ ] <https://github.com/tamago324/lir.nvim>
- [ ] <https://github.com/ThePrimeagen/refactoring.nvim>

---
