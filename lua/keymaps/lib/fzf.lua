local M = {}

---@param fn string|function  fzf-lua picker name, or a custom function
---@param opts? table|function  picker options; a function is evaluated on each call
function M.call(fn, opts)
    if type(fn) == "function" then
        return fn
    end
    return function()
        local o = type(opts) == "function" and opts() or opts
        require("fzf-lua")[fn](o)
    end
end

return M
