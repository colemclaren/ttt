--[[
    MySQLOO wrapper interface
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
    __tostring = function(self) return escaped_tbl[self] end
}

local type_escape = {
    number = tostring,
    string = function(s, db) 
        return string.format("\"%s\"", db:escape(s))
    end,
    ["nil"] = function() return "NULL" end,
    boolean = tostring,
    sql_escaped = function(d) return d end
}

function data:Escape(d)
    assert(type_escape[type(d)], "No type escaping function")
    local dat = newproxy()
    debug.setmetatable(dat, escaped_mt)
    escaped_tbl[dat] = type_escape[type(d)](d, self.mysqloo)
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
    local data = ...
    -- q = "select ?1, ?2! as ass, ?3 as vomit;"
    if (type(data) ~= "table") then
        data = {...}
    end

    local index = 1
    return (q:gsub("([^%%])%?(.-)(%!?)([#, %)%(\"';])", function(noescape, id, raw, rest)
        local escape = raw ~= "!" 
        if (id == "") then
            id = index
            index = index + 1
        end

        local dat = data[tonumber(id)] or data[tostring(id)] or nil
        if (escape) then
            dat = self:Escape(dat)
        end
        dat = tostring(dat)

        return string.format("%s%s%s", noescape, dat, rest == "#" and "" or rest)
    end)).."\n"
end

function data:Query(q, succ, err)
    local dbq = self.mysqloo:query(q)
    if (succ) then
        dbq.onSuccess = function(self, data) succ(data, self) end
    end
    if (err) then
        dbq.onError = err
    end

    dbq:start()
end

return function(db)
    return setmetatable({mysqloo = db}, mt)
end