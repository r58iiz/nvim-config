local M = {}

-- ============================================================================
-- Constants
-- ============================================================================

local SECTIONS = {
    state = "status:",
    themes = "themes:",
}

local STATUS_ICONS = {
    enabled = "🟢",
    disabled = "🔴",
}

local KEYMAPS_TO_DISABLE = { "i", "I", "a", "A", "o", "O", "s", "S", "v", "V", "<C-v>", ":" }

-- ============================================================================
-- State
-- ============================================================================

M.plugin_state = {}
M.theme_state = {}
M.plugins = {}

M.buf = nil
M.win = nil
M.plugin_state_file_path = vim.fn.stdpath("config") .. "/plugin_state.txt"

-- ============================================================================
-- Utility Functions
-- ============================================================================

--- Deep merge two tables
---@param t1 table
---@param t2 table
---@return table
local function deep_merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" and type(t1[k]) == "table" then
            deep_merge(t1[k], v)
        else
            t1[k] = v
        end
    end
    return t1
end

--- Trim whitespace and tabs from a string
---@param s string
---@return string
local function trim(s)
    return s:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\t", "")
end

--- Get line from current buffer at position n
---@param n? number Line number (defaults to cursor position)
---@return number, string Line number and line content
local function get_line(n)
    local pos = n or vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, true)[1]
    return pos, line
end

--- Sort entries by state (enabled first) then alphabetically
---@param tbl table
---@return table
local function sort_entries(tbl)
    local entries = {}

    for name, state in pairs(tbl) do
        table.insert(entries, {
            name = name,
            state = state and 1 or 0,
        })
    end

    table.sort(entries, function(a, b)
        if a.state ~= b.state then
            return a.state > b.state
        end
        return a.name < b.name
    end)

    return entries
end

--- Custom sorter for display lines with status icons
---@param a string
---@param b string
---@return boolean
local function sort_display_lines(a, b)
    local a_enabled = a:match("^%s*" .. STATUS_ICONS.enabled)
    local b_enabled = b:match("^%s*" .. STATUS_ICONS.enabled)

    if a_enabled ~= b_enabled then
        return a_enabled and true or false
    end

    return a:lower() < b:lower()
end

--- Safely read file contents
---@param path string
---@return string|nil
local function read_file(path)
    local file = io.open(path, "r")
    if not file then
        return nil
    end

    local content = file:read("*all")
    file:close()
    return content
end

--- Notify user with consistent formatting
---@param msg string
---@param level? number
local function notify(msg, level)
    vim.notify("[PluginLoader] " .. msg, level or vim.log.levels.INFO)
end

-- ============================================================================
-- Core Plugin Management
-- ============================================================================

--- Ensure lazy.nvim is installed
function M.ensure_lazy_installed()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        notify("Installing lazy.nvim...", vim.log.levels.INFO)

        local out = vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            lazyrepo,
            lazypath,
        })

        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end

    vim.opt.rtp:prepend(lazypath)
end

--- Load and merge plugin configurations
function M.populate_plugin_config()
    local plugins = {}

    -- Load themes
    local ok_themes, themes_module = pcall(require, "plugins.themes")
    if ok_themes then
        for plugin_name, plugin_config in pairs(themes_module) do
            local is_enabled = M.theme_state[plugin_name] or false
            M.theme_state[plugin_name] = is_enabled

            local merged = deep_merge({}, plugin_config)
            merged.cond = is_enabled
            if is_enabled then
                merged.lazy = false
            end

            table.insert(plugins, deep_merge({ plugin_name }, merged))
        end
    end

    -- Load regular plugins
    local ok_plugins, plugins_module = pcall(require, "plugins.init")
    if ok_plugins then
        for plugin_name, plugin_config in pairs(plugins_module) do
            local is_enabled = M.plugin_state[plugin_name] or false
            M.plugin_state[plugin_name] = is_enabled

            local merged = deep_merge({ cond = is_enabled }, plugin_config)
            table.insert(plugins, deep_merge({ plugin_name }, merged))
        end
    end

    M.plugins = plugins
end

--- Initialize lazy.nvim with plugins
function M.load_plugins_via_lazy()
    require("lazy").setup(M.plugins, {
        checker = { enabled = false },
        custom_keys = {
            ["<localleader>t"] = false,
        },
    })
end

-- ============================================================================
-- Persistence
-- ============================================================================

--- Load plugin states from disk
function M.load_persistent_config()
    local file = io.open(M.plugin_state_file_path, "r")

    if not file then
        notify("Config file not found, using defaults", vim.log.levels.WARN)
        return
    end

    local current_section = ""
    local state, value = file:read("n"), file:read("l")

    while value do
        if state == nil then
            current_section = value
        else
            value = trim(value)
            local is_enabled = state == 1

            if current_section == SECTIONS.state then
                M.plugin_state[value] = is_enabled
            elseif current_section == SECTIONS.themes then
                M.theme_state[value] = is_enabled
            end
        end

        state, value = file:read("n"), file:read("l")
    end

    file:close()
end

--- Save plugin states to disk
function M.save_persistent_config()
    local file = io.open(M.plugin_state_file_path, "w")

    if not file then
        local created_file = io.open(M.plugin_state_file_path, "w")
        if not created_file then
            notify("Unable to create config file", vim.log.levels.ERROR)
            return
        end
        created_file:close()
        return M.save_persistent_config()
    end

    file:write(SECTIONS.state .. "\n")
    for _, entry in ipairs(sort_entries(M.plugin_state)) do
        file:write(entry.state .. " " .. entry.name .. "\n")
    end
    file:write("\n")

    file:write(SECTIONS.themes .. "\n")
    for _, entry in ipairs(sort_entries(M.theme_state)) do
        file:write(entry.state .. " " .. entry.name .. "\n")
    end
    file:write("\n")

    file:close()
    M.close_menu()

    notify("Configuration saved!")
end

-- ============================================================================
-- Theme Management
-- ============================================================================

--- Update theme configuration to set active theme
function M.update_theme(theme_name)
    local current_theme = theme_name or vim.g.colors_name or "default"

    for name, _ in pairs(M.theme_state) do
        M.theme_state[name] = (name == current_theme)
    end
end

--- Load the active colorscheme
function M.load_colorscheme()
    local active_theme = ""

    for theme, state in pairs(M.theme_state) do
        if state then
            active_theme = theme
            break
        end
    end

    for i, config in ipairs(M.plugins) do
        if config[1] and config[1]:match(active_theme .. "$") then
            M.plugins[i] = deep_merge(config, {
                cond = true,
                lazy = false,
                priority = 1000,
            })
        end
    end
end

-- ============================================================================
-- UI Management
-- ============================================================================

--- Create floating window for plugin menu
function M.create_floating_window()
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    })

    vim.api.nvim_set_option_value("wrap", false, { win = win })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })

    local opts = { noremap = true, silent = true, buffer = buf }
    for _, key in ipairs(KEYMAPS_TO_DISABLE) do
        vim.keymap.set("n", key, "<nop>", opts)
    end

    M.buf = buf
    M.win = win
end

--- Render plugin list in the floating window
function M.render_plugins()
    local lines = {}

    local plugin_enabled = 0
    local plugin_total = 0
    local theme_total = 0

    local plugin_lines = {}
    for plugin, state in pairs(M.plugin_state) do
        plugin_total = plugin_total + 1
        if state then
            plugin_enabled = plugin_enabled + 1
        end

        local icon = state and STATUS_ICONS.enabled or STATUS_ICONS.disabled
        table.insert(plugin_lines, "\t" .. icon .. " " .. plugin)
    end

    local theme_lines = {}
    for theme, state in pairs(M.theme_state) do
        theme_total = theme_total + 1
        local icon = state and STATUS_ICONS.enabled or STATUS_ICONS.disabled
        table.insert(theme_lines, "\t" .. icon .. " " .. theme)
    end

    table.insert(lines, string.format("(%d/%d) Status:", plugin_enabled, plugin_total))
    table.sort(plugin_lines, sort_display_lines)
    vim.list_extend(lines, plugin_lines)

    table.insert(lines, string.format("(%d) Themes:", theme_total))
    table.sort(theme_lines, sort_display_lines)
    vim.list_extend(lines, theme_lines)

    vim.api.nvim_set_option_value("modifiable", true, { buf = M.buf })
    vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("modifiable", false, { buf = M.buf })
end

--- Open the plugin management menu
function M.open_menu()
    M.create_floating_window()
    M.render_plugins()

    local opts = { noremap = true, silent = true, buffer = M.buf }
    vim.keymap.set("n", "<CR>", function()
        M.toggle_plugin()
    end, opts)
    vim.keymap.set("n", "q", function()
        M.save_persistent_config()
    end, opts)
    vim.keymap.set("n", "c", function()
        M.close_menu()
    end, opts)
    vim.keymap.set("n", "<Esc>", function()
        M.close_menu()
    end, opts)

    if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_set_current_win(M.win)
    else
        notify("Failed to create floating window", vim.log.levels.ERROR)
    end
end

--- Close the plugin menu
function M.close_menu()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_win_close(M.win, false)
    end

    if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
        vim.api.nvim_buf_delete(M.buf, { force = true })
    end

    M.win = nil
    M.buf = nil
end

--- Toggle plugin state on current line
function M.toggle_plugin()
    local _, current_line = get_line()
    current_line = trim(current_line)

    if not (current_line:match("^" .. STATUS_ICONS.enabled) or current_line:match("^" .. STATUS_ICONS.disabled)) then
        return
    end

    local plugin_name = current_line:gsub("[" .. STATUS_ICONS.enabled .. STATUS_ICONS.disabled .. "]", "")
    plugin_name = trim(plugin_name)

    local section_pos, section_line = get_line()
    while section_pos > 0 do
        section_pos = section_pos - 1
        _, section_line = get_line(section_pos)

        if section_line:match(":$") then
            section_line = trim(section_line):lower()
            break
        end
    end

    if section_line == SECTIONS.state then
        M.plugin_state[plugin_name] = not M.plugin_state[plugin_name]
    elseif section_line == SECTIONS.themes then
        M.update_theme(plugin_name)
    end

    M.render_plugins()
end

-- ============================================================================
-- Initialization
-- ============================================================================

--- Start the plugin loader
function M.start()
    M.load_persistent_config()
    M.populate_plugin_config()
    M.ensure_lazy_installed()
    M.load_colorscheme()
    M.load_plugins_via_lazy()
end

--- Setup function for user configuration
---@param opts? table Optional configuration
function M.setup(opts)
    opts = opts or {}

    if opts.config_path then
        M.plugin_state_file_path = opts.config_path
    end

    if opts.status_icons then
        STATUS_ICONS.enabled = opts.status_icons.enabled or STATUS_ICONS.enabled
        STATUS_ICONS.disabled = opts.status_icons.disabled or STATUS_ICONS.disabled
    end

    vim.api.nvim_create_user_command("PluginLoader", function()
        M.open_menu()
    end, { desc = "Open plugin loader menu" })
end

return M
