local lib = require("keymaps.lib.map")
local map = lib.map_all
local plugins = require("keymaps.lib.plugins")

local PREFIX = "<leader>c"
lib.group(PREFIX .. "z", "Center cursor")
lib.group(PREFIX .. "l", "List chars")

local function center(mode)
    return function()
        require("custom.actions.center_cursor").toggle({ mode = mode })
    end
end

local function listchars(kind)
    return function()
        require("custom.actions.listchars").toggle(kind)
    end
end

map({
    { "n", PREFIX .. "zz", center("both"), "Toggle center cursor (Both)" },
    { "n", PREFIX .. "zi", center("insert"), "Toggle center cursor (Ins)" },
    { "n", PREFIX .. "zn", center("normal"), "Toggle center cursor (Norm)" },

    { "n", PREFIX .. "lw", listchars("whitespace"), "Toggle whitespace chars" },
    { "n", PREFIX .. "lt", listchars("tab"), "Toggle tab chars" },
    { "n", PREFIX .. "le", listchars("eol_lead"), "Toggle EOL/lead chars" },
    {
        "n",
        PREFIX .. "la",
        function()
            require("custom.actions.listchars").disable_all()
        end,
        "Disable all listchars",
    },
})

if plugins.enabled("folke/zen-mode.nvim") then
    lib.group("<leader>z", "Zen")
    map({ { "n", "<leader>zz", "<Cmd>ZenMode<CR>", "Zen mode" } })
end

if plugins.enabled("folke/twilight.nvim") then
    map({ { "n", "<leader>zt", "<Cmd>Twilight<CR>", "Twilight" } })
end

if plugins.enabled("hedyhli/outline.nvim") then
    map({ { "n", ";O", "<Cmd>Outline<CR>", "Toggle outline" } })
end
