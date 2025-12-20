local M = {}

local placeholder_counter = 0

local function make_placeholder()
    placeholder_counter = placeholder_counter + 1
    local n = placeholder_counter
    local result = ""
    while n > 0 do
        local remainder = (n - 1) % 26
        result = string.char(65 + remainder) .. result
        n = math.floor((n - 1) / 26)
    end
    return string.format("__RN%s__", result)
end

function M.apply(lines, rules, opts)
    opts = opts or {}
    local step = opts.step or 1
    local counters = {}
    local replacements = {}

    placeholder_counter = 0

    for i, line in ipairs(lines) do
        for _, rule in ipairs(rules) do
            if rule:line_has_match(line) then
                if not counters[rule.name] then
                    counters[rule.name] = rule:init_counter(line)
                end

                local placeholder = make_placeholder()
                local formatted = rule:format_number(counters[rule.name])

                replacements[placeholder] = formatted

                line = rule:replace_first(line, placeholder)
                counters[rule.name] = counters[rule.name] + step
            end
        end

        lines[i] = line
    end

    for i, line in ipairs(lines) do
        for placeholder, value in pairs(replacements) do
            line = line:gsub(placeholder, value)
        end
        lines[i] = line
    end

    return lines
end

return M
