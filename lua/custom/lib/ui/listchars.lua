local M = {}

M.chars = {
    trail = "␠",
    extends = "→",
    precedes = "←",
    nbsp = "␣",
    tab = "␉·",
    eol = "↵",
    lead = "·",
}

M.groups = {
    whitespace = { "trail", "extends", "precedes", "nbsp" },
    tab = { "tab" },
    eol_lead = { "eol", "lead" },
}

function M.compute(enabled)
    local chars = {}

    for group, is_enabled in pairs(enabled) do
        if is_enabled then
            for _, name in ipairs(M.groups[group] or {}) do
                chars[name] = M.chars[name]
            end
        end
    end

    return chars
end

return M
