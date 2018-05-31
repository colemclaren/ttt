util.AddNetworkString "_SetGlobalSync"
util.AddNetworkString "_SetGlobalFloat"
util.AddNetworkString "_SetGlobalInt"
util.AddNetworkString "_SetGlobalBool"

function _SetGlobalFloat(str, val)
	assert(TTT_GLOBALS[str], "need to add global to whitelist in sh_moat")
	if (TTT_GLOBALS_SAVE[str] == val) then return end
	TTT_GLOBALS_SAVE[str] = val

	net.Start "_SetGlobalFloat"
		net.WriteString(str)
		net.WriteFloat(val)
	net.Broadcast()
end

function _SetGlobalInt(str, val)
	assert(TTT_GLOBALS[str], "need to add global to whitelist in sh_moat")
	if (TTT_GLOBALS_SAVE[str] == val) then return end
	TTT_GLOBALS_SAVE[str] = val

	net.Start "_SetGlobalInt"
		net.WriteString(str)
		net.WriteInt(val, 32)
	net.Broadcast()
end

function _SetGlobalBool(str, val)
	assert(TTT_GLOBALS[str], "need to add global to whitelist in sh_moat")
	if (TTT_GLOBALS_SAVE[str] == val) then return end
	TTT_GLOBALS_SAVE[str] = val

	net.Start "_SetGlobalBool"
		net.WriteString(str)
		net.WriteBool(val)
	net.Broadcast()
end

function _SyncTTTGlobals(pl)
	if (not IsValid(pl)) then return end

	net.Start "_SetGlobalSync"

	for k, v in pairs(TTT_GLOBALS) do
		net.WriteString(k)

		if (TTT_GLOBALS_SAVE[k] == nil) then
			net.WriteBool(false)
			continue
		end

		if (v == "Bool") then
			net.WriteBool(true)
			net.WriteBool(TTT_GLOBALS_SAVE[k])
			continue
		elseif (v == "Int") then
			net.WriteBool(true)
			net.WriteInt(TTT_GLOBALS_SAVE[k], 32)
			continue
		elseif (v == "Float") then
			net.WriteBool(true)
			net.WriteFloat(TTT_GLOBALS_SAVE[k])
			continue
		end

		net.WriteBool(false)
	end

	net.Send(pl)
end

util.AddNetworkString "TTTPlayerLoaded"
function TTTPlayerLoaded(_, pl)
	_SyncTTTGlobals(pl)
	_GetTButtons(pl)
end
net.Receive("TTTPlayerLoaded", TTTPlayerLoaded)

function _CheckForMapSwitch()
           -- Check for mapswitch
    local rounds_left = math.max(0, GetGlobalInt("ttt_rounds_left", 6) - 1)
    _SetGlobalInt("ttt_rounds_left", rounds_left)
 
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

function _CleanUp()
	ServerLog("Starting Cleanup Map\n")

	_FixParentedPreCleanup()
	game.CleanUpMap()
	_FixParentedPostCleanup()

	ServerLog("Clean Up Map Done\n")
end

_MapEntityStore = _MapEntityStore or {}
function _GetMapEntities(n)
	if (_MapEntityStore[n]) then return _MapEntityStore[n].count, _MapEntityStore[n].ents, _MapEntityStore[n].has end

	local tbl, tbl2, num = {}, {}, 0
	for i = 1, ents.MapCreatedEntsCount do
		local v = ents.MapCreatedEnts[i]
		if (IsValid(v) and v:GetClass() == n) then
			num = num + 1
			tbl[num] = v
			tbl2[v] = num
		end
	end

	_MapEntityStore[n] = {}
	_MapEntityStore[n].ents = tbl
	_MapEntityStore[n].has = tbl2
	_MapEntityStore[n].count = num

	return num, tbl, tbl2
end


function _TriggerRoundStateOutputs(r, param)
    r = r or GetRoundState()

	local n, e = _GetMapEntities("ttt_map_settings")
	if (not n or n == 0) then return end

	for i = 1, n do
		if (IsValid(e[i])) then e[i]:RoundStateTrigger(r, param) end
	end
end

util.AddNetworkString "TTT_TraitorButton"
util.AddNetworkString "TTT_TraitorButtons"

_TRAITOR_BUTTONS = {}
_TRAITOR_BUTTONS_COUNT = 0

function _GetTButtons(pl)
	local n, e = _TRAITOR_BUTTONS_COUNT, _TRAITOR_BUTTONS
	if (not n or n == 0) then return end
	if (not IsValid(pl)) then return end

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
	return pl and net.Send(pl) or net.Broadcast()
end

function _CreateTButton(ent)
	if (not IsValid(ent)) then return end
	if (_TRAITOR_BUTTONS[ent]) then return end

	_TRAITOR_BUTTONS_COUNT = _TRAITOR_BUTTONS_COUNT + 1
	_TRAITOR_BUTTONS[ent] = ent

	net.Start "TTT_TraitorButton"
		net.WriteUInt(ent:EntIndex(), 16)
	net.Broadcast()
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

function _ReplaceMapItem(e, n)
	if (e:GetPos() == vector_origin) then return end
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

function _ReplaceOnCreated(s, ent)
    if (not IsValid(ent)) then return end
	if (not hl2_replace[ent:GetClass()]) then return end

	_ReplaceMapItem(ent, hl2_item_replace[ent:GetClass()])
end
GM.OnEntityCreated = _ReplaceOnCreated


function _SetShouldReplaceEntities(b)
	GM.OnEntityCreated = function() end
	if (b) then GM.OnEntityCreated = _ReplaceOnCreated end
end







local function _PlaceWeapon(swep, pos, ang)
    local ent = ents.Create(cls)
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
end

local function _PlaceExtraWeaponsForCSS()
    MsgN("Weaponless TF2-like map detected. Placing extra guns.")
    if (_CSSWeaponSpots) then
		PlaceWeaponsAtEnts(_CSSWeaponSpots[1], _CSSWeaponSpots[2])
		return
	end

	local spots_classes = {
		["info_player_terrorist"] = true,
		["info_player_counterterrorist"] = true,
		["hostage_entity"] = true
	}
	
	local spots, num = {}, 0
	for i = 1, ents.MapCreatedEntsCount do
		local v = ents.MapCreatedEnts[i]
		if (not IsValid(v)) then continue end
		if (spots_classes[v:GetClass()]) then
			num = num + 1
			spots[num] = {pos = v:GetPos(), ang = v:GetAngles()}
		end
	end

	_CSSWeaponSpots = {}
	_CSSWeaponSpots[1] = spots
	_CSSWeaponSpots[2] = num

	PlaceWeaponsAtEnts(spots, num)
end

local function _PlaceExtraWeaponsForTF2()
    MsgN("Weaponless TF2-like map detected. Placing extra guns.")
    if (_TF2WeaponSpots) then
		PlaceWeaponsAtEnts(_TF2WeaponSpots[1], _TF2WeaponSpots[2])
		return
	end

	local spots_classes = {
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
	
	local spots, num = {}, 0
	for i = 1, ents.MapCreatedEntsCount do
		local v = ents.MapCreatedEnts[i]
		if (not IsValid(v)) then continue end
		if (spots_classes[v:GetClass()]) then
			num = num + 1
			spots[num] = {pos = v:GetPos(), ang = v:GetAngles()}
		end
	end

	_TF2WeaponSpots = {}
	_TF2WeaponSpots[1] = spots
	_TF2WeaponSpots[2] = num

	PlaceWeaponsAtEnts(spots, num)
end

local function _WepCheck()
	if (_WepCheckCache ~= nil) then return _WepCheckCache end

	_WepCheckCache = false
	for i = 1, ents.MapCreatedEntsCount do
		local v = ents.MapCreatedEnts[i]
		if (not IsValid(v)) then continue end
		if (v.AutoSpawnable and not IsValid(v:GetOwner())) then
			_WepCheckCache = true
			break
		end
	end

	return _WepCheckCache
end

local function _TTTCheck()
	if (_TTTCheckCache ~= nil) then return _TTTCheckCache end

	_TTTCheckCache = false
	local n = _GetMapEntities("info_player_deathmatch")
	if (n == 0) then return _TTTCheckCache end

	_TTTCheckCache = true
	return _TTTCheckCache
end

local function _CSSCheck()
	if (_CSSCheckCache ~= nil) then return _CSSCheckCache end

	_CSSCheckCache = false
	local n = _GetMapEntities("info_player_counterterrorist")
	if (n == 0) then return _CSSCheckCache end

	_CSSCheckCache = true
	return _CSSCheckCache
end

local function _TF2Check()
	if (_TF2CheckCache ~= nil) then return _TF2CheckCache end

	_TF2CheckCache = false
	local n = _GetMapEntities("info_player_teamspawn")
	if (n == 0) then return _TF2CheckCache end

	_TF2CheckCache = true
	return _TF2CheckCache
end

function _PlaceExtraWeapons(import)
	if (import) then
		ents.TTT.ProcessImportScript()
		return
	end

    if (_WepCheck()) then return end
	if (_TTTCheck()) then return end
	if (_CSSCheck()) then
		PlaceExtraWeaponsForCSS()
		return
	end
	if (_TF2Check()) then
		PlaceExtraWeaponsForTF2()
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