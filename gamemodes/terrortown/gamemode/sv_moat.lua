util.AddNetworkString "TTTPlayerLoaded"
function TTTPlayerLoaded(_, pl)
	_GetTButtons(pl)
end
net.Receive("TTTPlayerLoaded", TTTPlayerLoaded)

function _CheckForMapSwitch()
           -- Check for mapswitch
    local rounds_left = math.max(0, GetGlobal("ttt_rounds_left") - 1)
    SetGlobalInt("ttt_rounds_left", rounds_left)
 
    local time_left = math.max(0, (GetConVar("ttt_time_limit_minutes"):GetInt() * 60) - CurTime())
    local switchmap = false
    local nextmap = string.upper(game.GetMapNext())
 
    if rounds_left <= 0 then
        LANG.Msg("limit_round", {mapname = nextmap})
        switchmap = true
    elseif time_left <= 0 then
        LANG.Msg("limit_time", {mapname = nextmap})
        switchmap = true
    end
    if switchmap then
        timer.Stop("end2prep")
        MapVote.Start(nil, nil, nil, nil)
    end
end


/*
-- tested on a map with these "broken ents"
-- clean up worked fine lol

local broken_parenting_ents = {
	["move_rope"] = true,
	["keyframe_rope"] = true,
	["info_target"] = true,
	["func_brush"] = true
}

local function _GetStupidEnts()
	_ParentedPreCleanup = {}
	_ParentedPreCleanupCount = 0

	for i = 1, ents.MapCreatedEntsCount do
		local v = ents.MapCreatedEnts[i]
		if (not IsValid(v)) then continue end
		if (not broken_parenting_ents[v:GetClass()] or not (v.GetParent and IsValid(v:GetParent()))) then continue end

		_ParentedPreCleanup[v] = {parent = v:GetParent(), pos = v:GetPos()}
		_ParentedPreCleanupCount = _ParentedPreCleanupCount + 1
	end
end

local function _FixParentedPreCleanup()
	if (not _ParentedPreCleanup) then _GetStupidEnts() end
	if (_ParentedPreCleanupCount and _ParentedPreCleanupCount == 0) then return end

	for k, v in pairs(_ParentedPreCleanup) do
		if (IsValid(k) and IsValid(v.parent)) then
			k:SetParent(nil)
		end
	end
end

local function _FixParentedPostCleanup()
	if (_ParentedPreCleanupCount and _ParentedPreCleanupCount == 0) then return end

	for k, v in pairs(_ParentedPreCleanup) do
		if (IsValid(k) and IsValid(v.parent)) then
			k:SetPos(v.pos)
			k:SetParent(v.parent)
		end
	end
end
*/

local _NOT_IN_CLEANUP_MODE = true
function _CleanUp()
	ServerLog("Starting Cleanup Map\n")

	_WipeReplaceMapItems()

	_NOT_IN_CLEANUP_MODE = false
	game.CleanUpMap(false, {"ttt_map_settings"})
	_NOT_IN_CLEANUP_MODE = true

	ServerLog("Clean Up Map Done\n")
end

_MapEntityStore = _MapEntityStore or {}
local classcheck = function(e, n) return e.class == n end
function _GetMapEntities(n, cf)
	if (_MapEntityStore[n]) then return _MapEntityStore[n].count, _MapEntityStore[n].ents, _MapEntityStore[n].has end
	if (not cf) then cf = classcheck end

	local tbl, tbl2, num = {}, {}, 0
	for i = 1, ents.MapCreatedEntsCount do
		local v = ents.MapCreatedEnts[i]
		if (not v) then continue end
		if (cf(v, n)) then
			num = num + 1
			tbl[num] = v
			tbl2[v.id] = num
		end
	end

	_MapEntityStore[n] = {}
	_MapEntityStore[n].count = num
	_MapEntityStore[n].ents = tbl
	_MapEntityStore[n].has = tbl2

	return num, tbl, tbl2
end

function _FireRoundStateTrigger(func, ent, r, data)
	if (r == ROUND_PREP or r == ROUND_ACTIVE) then
		func(ent, r == ROUND_PREP and "RoundPreparation" or "RoundStart", ent)
	elseif (r == ROUND_POST) then
		func(ent, "RoundEnd", ent, tostring(data))
	end
end

function _TriggerRoundStateOutputs(r, param)
    r = r or GetRoundState()

	local n, e = _GetMapEntities "ttt_map_settings"
	if (n == 0) then return end

	for i = 1, n do
		if (e[i].trigger) then
			_FireRoundStateTrigger(e[i].trigger, e[i].ent, r, param)
		end
	end
end

util.AddNetworkString "TTT_TraitorButton"
util.AddNetworkString "TTT_TraitorButtons"

_TRAITOR_BUTTONS = {}
_TRAITOR_BUTTONS_COUNT = 0

function _GetTButtons(pl)
	local n, e = _TRAITOR_BUTTONS_COUNT, _TRAITOR_BUTTONS
	if (n == 0) then return end

	local amt, tbl = 0, {}
	for i = 1, n do
		if (IsValid(e[i])) then
			amt = amt + 1
			tbl[amt] = e[i]:EntIndex()
		end
	end

	net.Start "TTT_TraitorButtons"
		net.WriteUInt(amt, 16)
		for i = 1, amt do
			net.WriteUInt(tbl[i], 16)
		end
	return IsValid(pl) and net.Send(pl) or net.Broadcast()
end

function _CreateTButton(ent)
	if (not IsValid(ent)) then return end
	if (_TRAITOR_BUTTONS[ent]) then return end
	_TRAITOR_BUTTONS_COUNT = _TRAITOR_BUTTONS_COUNT + 1
	_TRAITOR_BUTTONS[_TRAITOR_BUTTONS_COUNT] = ent

	if (GetRoundState() == ROUND_ACTIVE) then
		net.Start "TTT_TraitorButton"
			net.WriteUInt(ent:EntIndex(), 16)
		net.Broadcast()
	
		return
	end
end


hl2_item_replace = {
    ["item_ammo_pistol"] = "item_ammo_pistol_ttt",
    ["item_box_buckshot"] = "item_box_buckshot_ttt",
    ["item_ammo_smg1"] = "item_ammo_smg1_ttt",
    ["item_ammo_357"] = "item_ammo_357_ttt",
    ["item_ammo_357_large"] = "item_ammo_357_ttt",
    ["item_ammo_revolver"] = "item_ammo_revolver_ttt",
    ["item_ammo_ar2"] = "item_ammo_pistol_ttt",
    ["item_ammo_ar2_large"] = "item_ammo_smg1_ttt",
    ["item_ammo_smg1_grenade"] = "weapon_zm_pistol",
    ["item_battery"] = "item_ammo_357_ttt",
    ["item_healthkit"] = "weapon_zm_shotgun",
    ["item_suitcharger"] = "weapon_zm_mac10",
    ["item_ammo_ar2_altfire"] = "weapon_zm_mac10",
    ["item_rpg_round"] = "item_ammo_357_ttt",
    ["item_ammo_crossbow"] = "item_box_buckshot_ttt",
    ["item_healthvial"] = "weapon_zm_molotov",
    ["item_healthcharger"] = "item_ammo_revolver_ttt",
    ["item_ammo_crate"] = "weapon_ttt_confgrenade",
    ["item_item_crate"] = "ttt_random_ammo",
    ["weapon_smg1"] = "weapon_zm_mac10",
    ["weapon_shotgun"] = "weapon_zm_shotgun",
    ["weapon_ar2"] = "weapon_ttt_m16",
    ["weapon_357"] = "weapon_zm_rifle",
    ["weapon_crossbow"] = "weapon_zm_pistol",
    ["weapon_rpg"] = "weapon_zm_sledge",
    ["weapon_slam"] = "item_ammo_pistol_ttt",
    ["weapon_frag"] = "weapon_zm_revolver",
    ["weapon_crowbar"] = "weapon_zm_molotov",
	["weapon_zm_improvised"] = true
}

_RagdollStorage = {}
_RagdollStorageCount = 0
function _RemoveCorpses()
	_RagdollStorage = _RagdollStorage or {}
	if (_RagdollStorageCount == 0) then return end

	for i = 1, _RagdollStorageCount do
		local v = _RagdollStorage[i]
		if (IsValid(v)) then v:Remove() end
	end

	_RagdollStorageCount = 0
	_RagdollStorage = {}
end


function _ReplaceMapItem(e, n, t)
	if (not IsValid(e)) then return end
	if (e:GetPos() == vector_origin and not t) then
		timer.Simple(0, function() _ReplaceMapItem(e, n, true) end)
		return
	end

	if (isbool(n)) then e:Remove() return end
    e:SetSolid(SOLID_NONE)

    local ent = ents.Create(n)
    ent:SetPos(e:GetPos())
    ent:SetAngles(e:GetAngles())
    ent:Spawn()
    ent:Activate()
    ent:PhysWake()

    e:Remove()
end

_MapItemsForReplacement = {}
_MapItemsForReplacementCount = 0

function _ReplaceMapItems()
	if (_MapItemsForReplacementCount == 0) then return end

	for i = 1, _MapItemsForReplacementCount do
		_ReplaceMapItem(_MapItemsForReplacement[i].old, _MapItemsForReplacement[i].new)
	end
end

function _WipeReplaceMapItems()
	_MapItemsForReplacement = {}
	_MapItemsForReplacementCount = 0

	_TRAITOR_BUTTONS = {}
	_TRAITOR_BUTTONS_COUNT = 0
end

function _ReplaceOnCreated(s, ent)
	if (_NOT_IN_CLEANUP_MODE) then return end
    if (not IsValid(ent)) then return end
	if (not hl2_item_replace[ent:GetClass()]) then return end

	_MapItemsForReplacementCount = _MapItemsForReplacementCount + 1
	_MapItemsForReplacement[_MapItemsForReplacementCount] = {old = ent, new = hl2_item_replace[ent:GetClass()]}
end
GM.OnEntityCreated = _ReplaceOnCreated

local function _PlaceWeapon(swep, pos, ang)
	swep = swep.ClassName or swep.Classname or "Unknown Weapon"
    local ent = ents.Create(swep)
	if (not IsValid(ent)) then return end

    pos.z = pos.z + 3
    ent:SetPos(pos)
    ent:SetAngles(VectorRand():Angle())
    ent:Spawn()

    -- Create some associated ammo (if any)
    if ent.AmmoEnt then
        for i = 1, math.random(0, 3) do
            local ammo = ents.Create(ent.AmmoEnt)

            if IsValid(ammo) then
                pos.z = pos.z + 2
                ammo:SetPos(pos)
                ammo:SetAngles(VectorRand():Angle())
                ammo:Spawn()
                ammo:PhysWake()
            end
        end
    end

    return ent
end

local function _PlaceWeaponsAtEnts(s, n)
    local weps, weps_count = ents.TTT.GetSpawnableSWEPs()
	if (not weps or weps_count == 0) then return end

    local max = GetConVar("ttt_weapon_spawn_count"):GetInt()
    if (max == 0) then
        max = game.MaxPlayers()
        max = max + math.max(3, 0.33 * max)
    end

    local num, w = 0
	for i = 1, n do
		local spot = s[i]
		if (not spot or not spot.pos or not spot.ang) then continue end
		w = weps[math.random(weps_count)] or weps[math.random(weps_count)] or weps[math.random(weps_count)] -- 3 times the charm?? uwu
		if (not w) then w = weps[1] end

		if (util.IsInWorld(spot.pos)) then
			local spawned = _PlaceWeapon(w, spot.pos, spot.ang)
			num = IsValid(spawned) and num + 1 or num

			if (IsValid(spawned) and spawned.IsGrenade) then
                w = weps[math.random(weps_count)] or weps[math.random(weps_count)] or weps[math.random(weps_count)]

                if (w) then
                    _PlaceWeapon(w, spot.pos, spot.ang)
                end
			end
		end

		if (num > max) then return end
	end

	MsgN("Placed " .. num .. " weapon(s).")
end

local css_spot_classes = {
	["info_player_terrorist"] = true,
	["info_player_counterterrorist"] = true,
	["hostage_entity"] = true
}
local function _PlaceExtraWeaponsForCSS()
	MsgN "Weaponless CSS-like map detected. Placing extra guns."
	local count, spots = _GetMapEntities("_PlaceExtraWeaponsForCSS", function(e)
		return css_spot_classes[e.class]
	end)
	if (not count or count == 0) then return end

	_PlaceWeaponsAtEnts(spots, count)
end

local tf2_spot_classes = {
	["info_player_teamspawn"] = true,
	["team_control_point"] = true,
	["team_control_point_master"] = true,
	["team_control_point_round"] = true,
	["item_ammopack_full"] = true,
	["item_ammopack_medium"] = true,
	["item_ammopack_small"] = true,
	["item_healthkit_full"] = true,
	["item_healthkit_medium"] = true,
	["item_healthkit_small"] = true,
	["item_teamflag"] = true,
	["game_intro_viewpoint"] = true,
	["info_observer_point"] = true
}
local function _PlaceExtraWeaponsForTF2()
    MsgN "Weaponless TF2-like map detected. Placing extra guns."
	local count, spots = _GetMapEntities("_PlaceExtraWeaponsForTF2", function(e)
		return tf2_spot_classes[e.class]
	end)
	if (not count or count == 0) then return end

	_PlaceWeaponsAtEnts(spots, count)
end

local function _WepCheck()
	return _WE_HAVE_MAP_WEAPONS
end

local function _TTTCheck()
	return (_GetMapEntities("info_player_deathmatch") > 0)
end

local function _CSSCheck()
	return (_GetMapEntities("info_player_counterterrorist") > 0)
end

local function _TF2Check()
	return (_GetMapEntities("info_player_teamspawn") > 0)
end

function _PlaceExtraWeapons(import)
	if (import) then
		MsgN "Import file detected. Attempting to run it."
		ents.TTT.ProcessImportScript() -- will optimize later
		return
	end

    if (_WepCheck()) then MsgN "Weapons detected. Not placing any extra." return end
	if (_TTTCheck()) then MsgN "TTT spawn points detected. Not placing any extra weapons." return end
	if (_CSSCheck()) then
		_PlaceExtraWeaponsForCSS()
		return
	end
	if (_TF2Check()) then
		_PlaceExtraWeaponsForTF2()
	end
end

--[[

CLIENT SIDE
-- idk i just dont like how this looks lol
-- hacky fixes arent real fixes, they're just avoiding the real problem
if (true) then return end

globalreplacement.types = {"Angle", "Bool", "Entity", "Float", "Int", "String", "Vector"}
globalreplacement.vars = {}

for k, v in pairs(globalreplacement.types) do
	globalreplacement.vars[v] = {}

	_G["SetGlobal" .. v] = function(n, val)
		globalreplacement.vars[v][n] = val
	end

	_G["GetGlobal" .. v] = function(n, val)
		if (globalreplacement.vars[v][n] == nil) then return val end
		return globalreplacement.vars[v][n]
	end
	
	net.Receive("globalreplacement." .. v, function()
		local str, val = net.ReadString()
		assert(str, "Attempt to set global with no string?")

		if (v == "Int") then
			val = net.ReadInt(32)
		else
			val = net["Read" .. v]()
		end

		globalreplacement.vars[v][str] = val
	end)
end

net.Receive("globalreplacement.sync", function()
	local t = net.ReadString()
	local s = net.ReadString()

	globalreplacement.vars[t] = s
end)

net.Start("globalreplacement.sync")
net.SendToServer()



SERVER SIDE
-- idk i just dont like how this looks lol
-- hacky fixes arent real fixes, they're just avoiding the real problem
if (true) then return end

util.AddNetworkString "globalreplacement.sync"

globalreplacement.types = {"Angle", "Bool", "Entity", "Float", "Int", "String", "Vector"}
globalreplacement.vars = {}

local function setglobalnil(v, n)
	net.Start "globalreplacement.sync"
		net.WriteString(v)
		net.WriteString(n)
	net.Broadcast()
end

for k, v in pairs(globalreplacement.types) do
	util.AddNetworkString("globalreplacement." .. v)
	globalreplacement.vars[v] = {}

	_G["SetGlobal" .. v] = function(n, val)
		globalreplacement.vars[v][n] = val
		if (val == nil) then setglobalnil(v, n) return end

		net.Start("globalreplacement." .. v)
			net.WriteString(n)
			if (v == "Int") then
				net.WriteInt(val, 32)
			else
				net["Write" .. v](val)
			end
		net.Broadcast()
	end

	_G["GetGlobal" .. v] = function(n, val)
		if (globalreplacement.vars[v][n] == nil) then return val end
		return globalreplacement.vars[v][n]
	end
end

net.Receive("globalreplacement.sync", function(_, pl)
	for k, v in pairs(globalreplacement.vars) do
		for id, val in pairs(v) do
			net.Start("globalreplacement." .. k)
				net.WriteString(id)
				if (v == "Int") then
					net.WriteInt(val, 32)
				else
					net["Write" .. v](val)
				end
			net.Send(pl)
		end
	end
end)
]]