function string:startswith(start)
    return self:sub(1, #start) == start
end

function string:endswith(ending)
    return ending == "" or self:sub(-#ending) == ending
end

function string:replace(old, new)
    local s = self
    local search_start_idx = 1
    while true do
        local start_idx, end_idx = s:find(old, search_start_idx, true)
        if not start_idx then
            break
        end
        local postfix = s:sub(end_idx + 1)
        s = s:sub(1, (start_idx - 1)) .. new .. postfix
        search_start_idx = -1 * postfix:len()
    end
    return s
end

local M = {}

function M.setup_keys()
    local status_ok, whichkey = pcall(require, "which-key")
    if not status_ok then
        error("[Plugins][which-key] Unable to load `which-key`.")
        return
    end

    -- Normal Mappings
    whichkey.add({
        {
            mode = "n",
            {
                { ";", group = "LSP" },
                { ";T", group = "LSP extras" },
                { "<leader>g", group = "Git" },
                { "<leader>c", group = "Custom Plugins" },
                { "<leader>f", group = "Files" },
                { "<leader>t", group = "Tabs" },
                { "<leader>b", group = "Buffers" },
                { "<leader>L", group = "Lazy" },
                { "<leader>z", group = "Zen mode" },
            },
        },
        {
            mode = { "n", "x", "o" },
            { "s", desc = "Leap forward" },
            { "S", desc = "Leap backward" },
        },
    })
end

function M.return_config()
    return {
        preset = "classic",

        ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
        delay = function(ctx)
            return 500
        end,

        notify = true,

        triggers = {
            { "<auto>", mode = "nxso" },
        },

        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = true,
                motions = true,
                text_objects = true,
                windows = true,
                nav = true,
                z = true,
                g = true,
            },
        },

        win = {
            no_overlap = true,
            width = 1,
            height = { min = 4, max = 25 },
            col = 0,
            row = math.huge,
            border = "single",
            position = "bottom",
        },

        layout = {
            width = { min = 20 },
            spacing = 4,
        },

        keys = {
            scroll_down = "<c-d>",
            scroll_up = "<c-u>",
        },

        sort = { "local", "order", "group", "alphanum", "mod" },

        disable = {
            ft = {},
            bt = {},
        },

        debug = false,
    }
end

function M.custom_setup()
    M.setup_keys()
end

return M
