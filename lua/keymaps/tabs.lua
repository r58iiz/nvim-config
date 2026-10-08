local lib = require("keymaps.lib.map")
local map = lib.map_all

local PREFIX = "<leader>t"
lib.group(PREFIX, "Tabs")

local mappings = {
    { "n", PREFIX .. "n", "<Cmd>tabnew<CR>", "New tab" },
    { "n", PREFIX .. "c", "<Cmd>tabclose<CR>", "Close tab" },
    { "n", PREFIX .. "b", "<Cmd>tab split<CR>", "Open buffer in new tab" },
    { "n", PREFIX .. "]", "gt", "Next tab" },
    { "n", PREFIX .. "[", "gT", "Previous tab" },
    { "n", PREFIX .. ",", "<Cmd>tabmove -1<CR>", "Move tab left" },
    { "n", PREFIX .. ".", "<Cmd>tabmove +1<CR>", "Move tab right" },
}
for i = 1, 4 do
    mappings[#mappings + 1] = { "n", PREFIX .. i, i .. "gt", "Tab " .. i }
end

map(mappings)
