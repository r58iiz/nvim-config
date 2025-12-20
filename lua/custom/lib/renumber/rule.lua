local Rule = {}
Rule.__index = Rule

function Rule.new(spec)
    assert(type(spec) == "table", "rule spec must be a table")
    assert(type(spec.name) == "string", "rule.name is required")
    assert(type(spec.pattern) == "string", "rule.pattern is required")

    local self = setmetatable({}, Rule)

    self.name = spec.name
    self.pattern = spec.pattern
    self.pad = spec.pad or 0
    self.is_vim_regex = spec.is_vim_regex or false

    if self.is_vim_regex then
        self.regex = vim.regex(self.pattern)
    end

    return self
end

function Rule:line_has_match(line)
    if self.regex then
        return self.regex:match_str(line) ~= nil
    end
    return line:find(self.pattern) ~= nil
end

function Rule:find_first_number(line)
    if self.regex then
        local s, e = self.regex:match_str(line)
        if s then
            local match = line:sub(s + 1, e)
            return tonumber(match), s + 1, e
        end
    else
        local s, e = line:find(self.pattern)
        if s then
            local match = line:sub(s, e)
            return tonumber(match), s, e
        end
    end
    return nil
end

function Rule:format_number(n)
    if self.pad > 0 then
        return string.format("%0" .. self.pad .. "d", n)
    end
    return tostring(n)
end

function Rule:init_counter(line)
    local num = self:find_first_number(line)
    return num or 1
end

function Rule:replace_first(line, replacement)
    if type(replacement) == "number" then
        replacement = self:format_number(replacement)
    end

    local _, s, e = self:find_first_number(line)
    if s then
        return line:sub(1, s - 1) .. replacement .. line:sub(e + 1)
    end
    return line
end

return Rule
