local function parse_args(args_str, line1, line2)
    args_str = vim.trim(args_str or "")

    if args_str == "" then
        return nil, "usage: Renumber /pattern/[l] [step] [pad]"
    end

    local pattern, flags, rest = args_str:match("^/(.+)/(l?)%s*(.*)")
    if not pattern then
        return nil, "pattern must be wrapped in /slashes/ — e.g. /\\d\\+/"
    end

    local parts = vim.split(vim.trim(rest), "%s+", { trimempty = true })
    local step = tonumber(parts[1]) or 1
    local pad = tonumber(parts[2]) or 0
    local is_lua = (flags == "l")

    if step == 0 then
        return nil, "step cannot be 0"
    end

    return {
        pattern = pattern,
        is_vim_regex = not is_lua,
        step = step,
        pad = pad,
        first = line1,
        last = line2,
    },
        nil
end

return parse_args
