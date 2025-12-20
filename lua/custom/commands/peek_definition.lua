local peek = require("custom.lib.lsp.peek_definition")

local M = {}

function M.peek_definition()
    peek.peek_definition(0)
end

return M
