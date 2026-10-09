local M = {}

function M.apply(lines, rules, opts)
    opts = opts or {}
    local step = opts.step or 1
    local counters = {}
    local result = {}

    for i, line in ipairs(lines) do
        -- {s, e, replacement}.
        local edits = {}

        for _, rule in ipairs(rules) do
            if rule:line_has_match(line) then
                if not counters[rule.name] then
                    counters[rule.name] = rule:init_counter(line)
                end

                local _, s, e = rule:find_first_number(line)
                if s then
                    table.insert(edits, {
                        s = s,
                        e = e,
                        replacement = rule:format_number(counters[rule.name]),
                    })
                    counters[rule.name] = counters[rule.name] + step
                end
            end
        end

        -- Apply edits right-to-left
        table.sort(edits, function(a, b)
            return a.s > b.s
        end)
        for _, edit in ipairs(edits) do
            line = line:sub(1, edit.s - 1) .. edit.replacement .. line:sub(edit.e + 1)
        end

        result[i] = line
    end

    return result
end

return M
