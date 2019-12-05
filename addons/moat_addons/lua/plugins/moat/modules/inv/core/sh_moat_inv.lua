MOAT_VIP = {"vip", "mvp", "hoodninja", "trialstaff", "moderator", "admin", "senioradmin", "headadmin", "communitylead"}
local pl = FindMetaTable("Player")

local MOAT_TALENT_FOLDER = "plugins/moat/modules/_items/talents"
MOAT_TALENTS = {}

function m_AddTalent(talent_tbl)
	if (talent_tbl.Name and not talent_tbl.NameExact) then
		talent_tbl.Name = string.Title(talent_tbl.Name)
	end

	if (talent_tbl.Description and not talent_tbl.DescExact) then
		talent_tbl.Description = string.Grammarfy(talent_tbl.Description, not (talent_tbl.Description:EndsWith"!" or talent_tbl.Description:EndsWith"?" or talent_tbl.Description:EndsWith"."))
	end

    MOAT_TALENTS[talent_tbl.ID] = talent_tbl
end

function m_InitializeTalents()
	for k, v in pairs(file.Find(MOAT_TALENT_FOLDER .. "/*.lua", "LUA")) do
		TALENT = {}
		if (SERVER) then
			AddCSLuaFile(MOAT_TALENT_FOLDER .. "/" .. v)
		end

		include(MOAT_TALENT_FOLDER .. "/" .. v)

		m_AddTalent(TALENT)
	end
end

m_InitializeTalents()

concommand.Add("_reloadtalents", function(pl)
	if (IsValid(pl)) then return end
	m_InitializeTalents()
end)

local talent_cache = {}

function m_GetTalentFromEnum(tenum)
    if (tenum and talent_cache[tenum]) then
        return talent_cache[tenum]
    end

    local tbl = {}

    for k, v in pairs(MOAT_TALENTS) do
        if (v.ID == tenum) then
            tbl = table.Copy(v)
        end
    end

    tbl.OnPlayerDeath = nil
    tbl.OnPlayerHit = nil
    tbl.OnWeaponSwitch = nil
    tbl.ScalePlayerDamage = nil
    tbl.ModifyWeapon = nil
    tbl.OnWeaponFired = nil
	tbl.SuppressBullet = nil
    tbl.OnBeginRound = nil

    if (tenum) then talent_cache[tenum] = tbl end

    return tbl
end

local talent_cache2 = {}

function m_GetTalentFromEnumWithFunctions(tenum)
    if (tenum and talent_cache2[tenum]) then
        return talent_cache2[tenum]
    end

    local tbl = {}

    for k, v in pairs(MOAT_TALENTS) do
        if (v.ID == tenum) then
            tbl = table.Copy(v)
        end
    end

    if (tenum) then talent_cache2[tenum] = tbl end

    return tbl
end

function GetItemTalents(tb, funcs)
	local Talents = {}

	if (not tb.t) then
		return Talents
	end

    for k, v in ipairs(tb.t) do
		Talents[k] = (not funcs) and m_GetTalentFromEnum(v.e)
			or m_GetTalentFromEnumWithFunctions(v.e)

		if (tb.s.l and tb.s.l >= v.l) then
			Talents[k].Active = true
		end
	end

    return Talents
end

if (CLIENT) then
    COSMETIC_ITEMS = {}
	MOAT_BODY_ITEMS = {}
    function m_AddCosmeticItem(item_tbl, item_kind)
        local tbl = item_tbl
        tbl.Kind = item_kind
        --table.insert( COSMETIC_ITEMS, tbl )
        COSMETIC_ITEMS[tbl.ID] = tbl

        if (tbl.Model) then
            util.PrecacheModel(tbl.Model)
        end

		if (item_kind == "Body") then
			MOAT_BODY_ITEMS[tbl.ID] = true 
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

local v2 = Vector(0, 0, 2)

function m_IsTerroristModel(mdl)
    return moat_TerroristModels[mdl] and v2 or vector_origin
end

if (SERVER) then
    SetGlobalString("ttt_default_playermodel", "")

    timer.Simple(5, function()
        SetGlobalString("ttt_default_playermodel", tostring(GAMEMODE.playermodel))
    end)
end