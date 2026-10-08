-- Modes used for keymaps
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c"

local lib = require("keymaps.lib.map")

require("keymaps.general")
require("keymaps.editing")
require("keymaps.clipboard")
require("keymaps.navigation")
require("keymaps.windows")
require("keymaps.buffers")
require("keymaps.tabs")
require("keymaps.terminal")
require("keymaps.find")
require("keymaps.git")
require("keymaps.text")
require("keymaps.view")
require("keymaps.plugins")

lib.flush_groups()
