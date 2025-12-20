function dump_(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = "\"" .. k .. "\""
            end
            s = s .. "[" .. k .. "] = " .. (dump_(v or "nil")) .. ","
        end
        s = s .. "} "
        return print(s)
    else
        return tostring(o)
    end
end

local DebugHelper = {}

-- Helper function to print dicts
function DebugHelper:dump(o)
    dump_(o)
end

return DebugHelper
