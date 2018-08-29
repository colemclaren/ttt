if (SERVER) then
    AddCSLuaFile "sql_sqlite.lua"
    return
end

mi.SQL = include "sql_sqlite.lua"()

timer.Simple(0, function()
    hook.Run "InventoryPrepare"
end)