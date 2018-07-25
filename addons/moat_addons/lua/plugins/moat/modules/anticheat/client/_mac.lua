// this file isn't ran
// just unobfuscated version of mac.lua

local setmetatable = _G.setmetatable

local function readonly(tab)
    return setmetatable({}, {
        __index = tab,
        __newindex = function() end,
        __metatable = true
    })
end

local g = readonly{
    pairs = _G.pairs,
    ipairs = _G.ipairs,
    type = _G.type,
    LocalPlayer = _G.LocalPlayer,
    ConVarExists = _G.ConVarExists,
    GetConVarNumber = _G.GetConVarNumber,
    CurTime = _G.CurTime,
    tostring = _G.tostring,
    isfunction = _G.isfunction,
    istable = _G.istable,
    isstring = _G.isstring,
    require = _G.require,
    rawset = _G.rawset,
    rawget = _G.rawget,
    HTTP = _G.HTTP,
    ScrH = _G.ScrH,
    ScrW = _G.ScrW
}

local timer = readonly{
    Destroy = _G.timer.Destroy,
    Remove = _G.timer.Remove,
    Create = _G.timer.Create,
    Simple = _G.timer.Simple
}

local table = readonly{
    insert = _G.table.insert
}

local net = readonly{
    Start = _G.net.Start,
    WriteTable = _G.net.WriteTable,
    ReadString = _G.net.ReadString,
    SendToServer = _G.net.SendToServer,
    Receive = _G.net.Receive
}

local debug = readonly{
    getinfo = _G.debug.getinfo,
    getupvalue = _G.debug.getupvalue
}

local string = readonly{
    dump = _G.string.dump,
    find = _G.string.find,
    lower = _G.string.lower
}

local render = readonly{
    Capture = _G.render.Capture
}

local concommand = readonly{
    GetTable = _G.concommand.GetTable
}

local hook = readonly{
    GetTable = _G.hook.GetTable
}

local util = readonly{
    TableToJSON = _G.util.TableToJSON,
    Base64Encode = _G.util.Base64Encode
}

g.require"hash"

local hash = readonly{
    SHA256 = _G.hash.SHA256
}

g.rawset(_G, "_SCRIPT", "poop")
g.rawset(_G.debug, "setlocal", function() end)
g.rawset(_G.debug, "getlocal", function() end)
g.rawset(_G.debug, "setupvalue", function() end)
g.rawset(_G, "RunStringEx", function() end)
--g.rawset(_G, "CompileString", function() end)
g.rawset(_G, "CompileFile", function() end)
--g.rawset(_G, "rawset", function() end)
--g.rawset(_G, "rawget", function() end)

local function hashfunc(func)
    local info = debug.getinfo(func)

    return hash.SHA256(info.short_src .. info.source .. info.what)
end

local bad_terms = {"cheat", "hack", "bypass", "nospread", "aim", "exploit"}

local function isbadstring(str)
    str = string.lower(str)

    for k, v in g.ipairs(bad_terms) do
        if string.find(str, v) then return true end
    end

    return false
end

local detections = {}
local to_scan = {}
local timer_id = g.tostring{}

local function detect(reason)
    table.insert(detections, reason)
end

local function scan(callback)
    table.insert(to_scan, callback)
end

timer.Create(timer_id, 60, 0, function()
    for k, v in g.ipairs(to_scan) do
        v()
    end

    if (#detections > 0) then
        net.Start"moat.verify"
        net.WriteTable(detections)
        net.SendToServer()
        timer.Remove(timer_id)
    end
end)

local protected_libs = {"debug", "render", "cvars", "concommand", "timer", "file", "net", "table", "hook", "jit", "hash"}
local protected_functions = {"GetConVar", "GetConVarNumber", "GetConVarString", "RunConsoleCommand", "setfenv", "getfenv", "rawset", "RunString", "RunStringEx", "CompileString", "CompileFile"}
local lib_lookup = {}
local g_lookup = {}

for _, name in g.ipairs(protected_libs) do
    lib_lookup[name] = {}

    for k, v in g.pairs(g.rawget(_G, name)) do
        if g.isfunction(v) then
            lib_lookup[name][k] = hashfunc(v)
        end
    end
end

for k, v in g.ipairs(protected_functions) do
    g_lookup[v] = hashfunc(g.rawget(_G, v))
end

scan(function()
    for _, lib in g.ipairs(protected_libs) do
        for k, v in g.pairs(g.rawget(_G, lib)) do
            if g.isfunction(v) and (lib_lookup[lib][k] ~= nil) and (hashfunc(v) ~= lib_lookup[lib][k]) then
                detect(3)
                break
            end
        end
    end
end)

scan(function()
    for k, v in g.pairs(g_lookup) do
        if (hashfunc(g.rawget(_G, k)) ~= v) then
            detect(3)
            break
        end
    end
end)

--local protected_convars = {{"sv_allowcslua", 4, 0}, {"sv_cheats", 5, 0}, {"host_timescale", 8, 1}, {"mat_wireframe", 9, 0}, {"mat_fullbright", 10, 0}}
local protected_convars = {{"sv_allowcslua", 4, 0}, {"sv_cheats", 5, 0}, {"host_timescale", 8, 1}, {"mat_wireframe", 9, 0}}

scan(function()
    for k, v in g.ipairs(protected_convars) do
        if (not g.ConVarExists(v[1])) or (g.GetConVarNumber(v[1]) ~= v[3]) then
            detect(v[2])
        end
    end
end)

local bad_convars = {{"SmegHack_Panic", 22}}

scan(function()
    for k, v in g.ipairs(bad_convars) do
        if (g.ConVarExists(v[1])) then
            detect(v[2])
        end
    end
end)

scan(function()
    if (_G["_SCRIPT"] ~= "poop") then
        detect(6)
    end
end)

scan(function()
    if (_G["Lenny"] ~= nil) then
        detect(7)
    end
end)

scan(function()
    if (_G["GDAAP_CLIENT_INTERFACE"] ~= nil) then
        detect(21)
    end
end)

local bad_commands = {
    ["phack_lua_reload"] = 11,
    ["mapex_dancin"] = 12,
    ["mapex_esp"] = 12,
    ["mapex_allents"] = 12,
    ["mapex_wall"] = 12,
    ["sasha_menu"] = 13,
    ["0_u_found"] = 14,
    ["external"] = 15,
    ["aspire_reload"] = 16,
    ["aspire_reload"] = 16,
    ["cs_unload"] = 17,
    ["cs_load"] = 17,
    ["cs_load"] = 17,
    ["xhack_menu"] = 18
}

scan(function()
    for k, v in g.pairs(concommand.GetTable()) do
        if bad_commands[k:lower()] then
            detect(bad_commands[k:lower()])
        elseif isbadstring(k) then
            detect(19)
            break
        end
    end
end)

scan(function()
    for _, hooks in g.pairs(hook.GetTable()) do
        for k, v in g.pairs(hooks) do
            if g.isstring(k) and isbadstring(k) then
                detect(20)
                break
            end
        end
    end
end)