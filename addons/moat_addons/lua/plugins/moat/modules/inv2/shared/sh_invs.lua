MOAT_VIP = {"vip", "mvp", "hoodninja", "trialstaff", "moderator", "admin", "senioradmin", "headadmin", "communitylead", "owner", "techartist", "audioengineer", "softwareengineer", "gamedesigner", "creativedirector"}
local pl = FindMetaTable("Player")
local MOAT_TALENT_FOLDER = "plugins/moat/modules/inv2/data"
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
	local files	= {
		"accurate.lua",
		"adrenalinerush.lua",
		"armourpiercing.lua",
		"bostonbasher.lua",
		"brutal.lua",
		"centermass.lua",
		"click.lua",
		"closequarters.lua",
		"contagious.lua",
		"cough.lua",
		"debility.lua",
		"deepfried.lua",
		"deepfried2xl.lua",
		"desperatetimes.lua",
		"dragonborn.lua",
		"dual.lua",
		"explosive.lua",
		"extendedmag.lua",
		"fortified.lua",
		"fracture.lua",
		"frost.lua",
		"inferno.lua",
		"infrasight.lua",
		"doglover.lua",
		"laser.lua",
		"lifesteal.lua",
		"lightweight.lua",
		"limited2.lua",
		"limited3.lua",
		"limited4t1.lua",
		"limited4t2.lua",
		"limited4t3.lua",
		"limited6t1.lua",
		"limited6t2.lua",
		"limited6t3.lua",
		"medicality.lua",
		"meticulous.lua",
		"paintball.lua",
		"power.lua",
		"powerstone.lua",
		"predatory.lua",
		"prepared.lua",
		"realitystone.lua",
		"replenish.lua",
		"rickross.lua",
		"scavenger.lua",
		"silenced.lua",
		"snowballs.lua",
		"spacestone.lua",
		"speedforce.lua",
		"stability.lua",
		"strengthinnumbers.lua",
		"sustained.lua",
		"tesla.lua",
		"triggerfinger.lua",
		"tugofwar.lua",
		"vampiric.lua",
		"visionary.lua",
		"lospanchos.lua",
		"vineyard.lua",
		"swift.lua",
		"icecream.lua"
	}
	
	-- local lol = ""
	-- for k, v in ipairs(files) do
	-- 	TALENT = {}
	-- 	if (SERVER) then
	-- 		AddCSLuaFile(MOAT_TALENT_FOLDER .. "/" .. v)
	-- 	end

	-- 	include(MOAT_TALENT_FOLDER .. "/" .. v)

	-- 	local file_str = file.Read(MOAT_TALENT_FOLDER .. "/" .. v, "LUA")
	-- 	lol = lol .. "\nTALENT = {}\n"
	-- 	lol = lol .. file_str

    -- 	if (SERVER) then
	-- 		MsgC(Color(255, 255, 0), "[mInventory] Loaded Talent: " .. TALENT.Name .. "\n")
	-- 	end

    -- 	m_AddTalent(TALENT)
	-- 	lol = lol .. "\nm_AddTalent(TALENT)\n"
	-- end

	-- file.Write("mi_collect_output/talents_old.txt", lol)

	if (SERVER) then
		AddCSLuaFile(MOAT_TALENT_FOLDER .. "/talents.lua")
	end

    include(MOAT_TALENT_FOLDER .. "/talents.lua")
end

m_InitializeTalents()

function GetItemTalents(tb, funcs)
	local Talents = {}

	if (not tb.t) then
		return Talents
	end

    for k, v in ipairs(tb.t) do
		Talents[k] = (not funcs) and m_GetTalentFromEnum(v.e or 21)
			or m_GetTalentFromEnumWithFunctions(v.e or 21)

		if (not tb.s) then
			tb.s = {l = 1, x = 0}
		elseif (not tb.s.l or not tb.s.x) then
			tb.s.x = tb.s.x or 0
			tb.s.l = 1
		end

		if (tb.s and tb.s.l and tb.s.l >= v.l) then
			Talents[k].Active = true
		end
	end

    return Talents
end

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

moat_TerroristModels = {}
moat_TerroristModels["models/player/arctic.mdl"] = ""
moat_TerroristModels["models/player/guerilla.mdl"] = ""
moat_TerroristModels["models/player/leet.mdl"] = ""
moat_TerroristModels["models/player/phoenix.mdl"] = ""

local v2 = Vector(0, 0, 2)

function m_IsTerroristModel(mdl)
    return moat_TerroristModels[mdl] and v2 or vector_origin
end