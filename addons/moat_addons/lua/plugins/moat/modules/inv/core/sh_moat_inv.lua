MOAT_VIP = {"vip", "credibleclub", "trialstaff", "moderator", "admin", "senioradmin", "headadmin", "communitylead"}
local pl = FindMetaTable("Player")

function pl:IsStaff()
    return table.HasValue(MOAT_VIP, self:GetUserGroup()) and self:GetUserGroup() ~= "vip" and self:GetUserGroup() ~= "credibleclub"
end

if (CLIENT) then
    COSMETIC_ITEMS = {}

    function m_AddCosmeticItem(item_tbl, item_kind)
        local tbl = item_tbl
        tbl.Kind = item_kind
        --table.insert( COSMETIC_ITEMS, tbl )
        COSMETIC_ITEMS[tbl.ID] = tbl

        if (tbl.Model) then
            util.PrecacheModel(tbl.Model)
        end
    end

    function m_GetCosmeticItemFromEnum(item_id)
        return table.Copy(COSMETIC_ITEMS[item_id])
    end
end

local itemdir = "plugins/moat/modules/_items/items/"
for k, v in pairs(file.Find(itemdir .. "hats/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile(itemdir .. "hats/" .. v)
    end

    include(itemdir .. "hats/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Hat")
    end
end

for k, v in pairs(file.Find(itemdir .. "masks/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile(itemdir .. "masks/" .. v)
    end

    include(itemdir .. "masks/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Mask")
    end
end

for k, v in pairs(file.Find(itemdir .. "body/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile(itemdir .. "body/" .. v)
    end

    include(itemdir .. "body/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Body")
    end
end

for k, v in pairs(file.Find(itemdir .. "models/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile(itemdir .. "models/" .. v)
    end

    include(itemdir .. "models/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Model")
    end
end

for k, v in pairs(file.Find(itemdir .. "effects/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile(itemdir .. "effects/" .. v)
    end

    include(itemdir .. "effects/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Effect")
    end
end

if (SERVER) then
	include(itemdir .. "paints/load.lua")
end
include(itemdir .. "paints/load.lua")

moat_TerroristModels = {}
moat_TerroristModels["models/player/arctic.mdl"] = ""
moat_TerroristModels["models/player/guerilla.mdl"] = ""
moat_TerroristModels["models/player/leet.mdl"] = ""
moat_TerroristModels["models/player/phoenix.mdl"] = ""

function m_IsTerroristModel(mdl)
    local pos = Vector(0, 0, 0)

    if (moat_TerroristModels[mdl]) then
        pos = Vector(0, 0, 2)
    end

    return pos
end

if (SERVER) then
    SetGlobalString("ttt_default_playermodel", "")

    timer.Simple(5, function()
        SetGlobalString("ttt_default_playermodel", tostring(GAMEMODE.playermodel))
    end)
end