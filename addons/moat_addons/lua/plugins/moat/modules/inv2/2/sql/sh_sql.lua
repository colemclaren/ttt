if (SERVER) then
    AddCSLuaFile "sql_sqlite.lua"
    return
end

MOAT_INV.SQL = include "sql_sqlite.lua"()

timer.Simple(0, function()
    hook.Run "InventoryPrepare"
end)