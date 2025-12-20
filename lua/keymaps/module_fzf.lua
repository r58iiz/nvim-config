local M = {}

function M.call(fn, opts)
    if type(fn) == "function" then
        return fn
    end
    return function()
        require("fzf-lua")[fn](opts)
    end
end

return M
