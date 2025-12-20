-- Modes used for keymaps
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c"

local km = require("keymaps.utils")

require("keymaps.core")
require("keymaps.buffers")
require("keymaps.tabs")
require("keymaps.terminal")
require("keymaps.custom")
require("keymaps.visual")
require("keymaps.insert")

require("keymaps.plugin_lazy")
km.if_enabled("ibhagwan/fzf-lua", "keymaps.git")
km.if_enabled("ibhagwan/fzf-lua", "keymaps.files")
km.if_enabled("ggandor/leap.nvim", "keymaps.plugin_leap")
km.if_enabled("folke/zen-mode.nvim", "keymaps.plugin_zen")
km.if_enabled("hedyhli/outline.nvim", "keymaps.plugin_outline")
km.if_enabled("yorickpeterse/nvim-window", "keymaps.plugin_window")
