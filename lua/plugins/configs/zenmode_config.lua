local M = {}

function M.custom_setup()
    local status_ok, zenmode = pcall(require, "zen-mode")
    if not status_ok then
        error("[Plugins][zenmode] Unable to load `zen-mode`.")
        return
    end
    zenmode.setup({
        {
            window = {
                backdrop = 0.05,
                width = 70,
                height = 1,
                options = {
                    signcolumn = "no",
                    number = false,
                    relativenumber = true,
                    cursorline = true,
                    cursorcolumn = false,
                    foldcolumn = "0",
                    list = false,
                },
            },
            plugins = {
                options = {
                    enabled = false,
                    ruler = true,
                    showcmd = false,
                },
                twilight = {
                    enabled = true,
                },
                gitsigns = {
                    enabled = false,
                },
            },
            on_open = function(win) end,
            on_close = function() end,
        },
    })
end

return M
