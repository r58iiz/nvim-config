local M = {}

local home = vim.env.HOME or vim.env.USERPROFILE

-- Collapse long paths: /home/user/projects/foo/bar → ~/p/f/bar
local function shorten_path(path)
    if not path then
        return ""
    end

    path = path:gsub("^" .. vim.pesc(home), "~")

    local parts = vim.split(path, "/", { trimempty = true })
    if #parts <= 1 then
        return path
    end

    for i = 1, #parts - 1 do
        parts[i] = parts[i]:sub(1, 1)
    end

    return table.concat(parts, "/")
end

function M.custom_setup()
    local ok, oil = pcall(require, "oil")
    if not ok then
        error("[Plugins][oil] Failed to load `oil`.")
        return
    end

    oil.setup({
        default_file_explorer = true,

        view_options = {
            show_hidden = true,
            is_always_hidden = function(name)
                return name == ".git"
            end,
        },

        float = {
            padding = 2,
            max_width = 80,
            max_height = 30,
            border = "rounded",
            win_options = { winblend = 0 },
        },

        buf_options = {
            buflisted = false,
        },

        win_options = {
            wrap = false,
            signcolumn = "no",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "n",
        },

        columns = {
            "icon",
            "permissions",
            "size",
        },

        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        watch_for_changes = true,

        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
        },

        use_default_keymaps = true,

        sort = {
            directories_first = true,
        },

        preview = {
            width = 0.4,
            min_width = 40,
        },
    })

    local function update_statusline()
        local dir = require("oil").get_current_dir()
        if dir then
            vim.opt_local.statusline = " Oil: " .. shorten_path(dir)
        end
    end

    vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "DirChanged" }, {
        pattern = "oil",
        callback = update_statusline,
    })
end

return M
