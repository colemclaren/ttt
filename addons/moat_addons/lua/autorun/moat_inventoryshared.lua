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

for k, v in pairs(file.Find("moat_items/moat_hats/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile("moat_items/moat_hats/" .. v)
    end

    include("moat_items/moat_hats/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Hat")
    end
end

for k, v in pairs(file.Find("moat_items/moat_masks/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile("moat_items/moat_masks/" .. v)
    end

    include("moat_items/moat_masks/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Mask")
    end
end

for k, v in pairs(file.Find("moat_items/moat_body/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile("moat_items/moat_body/" .. v)
    end

    include("moat_items/moat_body/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Body")
    end
end

for k, v in pairs(file.Find("moat_items/moat_models/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile("moat_items/moat_models/" .. v)
    end

    include("moat_items/moat_models/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Model")
    end
end

for k, v in pairs(file.Find("moat_items/moat_effects/*.lua", "LUA")) do
    ITEM = {}

    if (SERVER) then
        AddCSLuaFile("moat_items/moat_effects/" .. v)
    end

    include("moat_items/moat_effects/" .. v)

    if (CLIENT) then
        m_AddCosmeticItem(ITEM, "Effect")
    end
end

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

if (SERVER) then
    util.AddNetworkString("moat_chat_msg")

    local pl = FindMetaTable("Player")

    function pl:MoatChat(str)
        net.Start("moat_chat_msg")
        net.WriteString(str)
        net.Send(self)
    end
else
    net.Receive("moat_chat_msg", function(l)
        local str = net.ReadString()

        chat.AddText(Material("icon16/information.png"), Color(255, 0, 0), str)
    end)
end