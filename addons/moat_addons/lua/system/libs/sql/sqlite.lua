--[[
    SQLite wrapper interface
]]

local data = {}
local mt = {
    __index = data,
    __newindex = data
}

local escaped_tbl = setmetatable({}, {__mode = "k"})
local escaped_mt = {
    TypeID = -1001,
    MetaName = "sql_escaped",
    __tostring = function(self) return tostring(escaped_tbl[self]) end
}

local type_escape = {
    Player = function(s)
        return s:SteamID64()
    end,
    number = tostring,
    string = function(s) 
        return string.format("\"%s\"", sql.SQLStr(s))
    end,
    ["nil"] = function() return "NULL" end,
    boolean = tostring,
    sql_escaped = function(d) return d end,
}

function data:Escape(d)
    assert(type_escape[type(d)], "No type escaping function")
    local dat = newproxy()
    debug.setmetatable(dat, escaped_mt)
    escaped_tbl[dat] = type_escape[type(d)](d)
    return dat
end

function data:Raw(d)
    local dat = newproxy()
    debug.setmetatable(dat, escaped_mt)
    escaped_tbl[dat] = d
    return dat
end

function data:Function(name, ...)
    local dat = newproxy()
    debug.setmetatable(dat, escaped_mt)
    escaped_tbl[dat] = self:CreateQuery(name.."("..string.rep("?, ", select("#", ...)):sub(1, -3)..")", ...)
    return dat
end

function data:CreateQuery(q, ...)
    local d = type(...) ~= "table" and {...} or ...
    local idx = 1

    return (q:gsub("(%%?)%?(!?)([%w_]*)", function(skip, raw, id)
        if (skip == "%") then return end
        if (id == "") then
            idx, id = idx + 1, d[idx]
        else
            id = d[id]
        end

		return raw ~= "!" and tostring(self:Escape(id)) or id
    end))
end

function data:Query(q, succ, err)
    local d = sql.Query(q)
    if (d == false) then
        if (err) then
            return err(sql.LastError())
        else
            error(sql.LastError())
        end
    end
    if (d ~= false and succ) then
        return succ(d)
    end
end

return function()
    return setmetatable({}, mt)
end