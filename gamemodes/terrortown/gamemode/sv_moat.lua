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

local stb = {}
function _GetTButtons(pl)
	local n, e, h = _GetMapEntities("ttt_traitor_button")
	if (next(stb)) then
		for k, v in pairs(stb) do
			if (not IsValid(v)) then continue end
			if (h[v]) then continue end

			n = n + 1
			e[n] = v

			stb[k] = nil
		end
	end

	if (not n or n == 0) then return end

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
	local n, e, h = _GetMapEntities("ttt_traitor_button")
	if (n > 0 and h and h[ent]) then return end
	stb[ent] = ent

	net.Start "TTT_TraitorButton"
		net.WriteEntity(ent)
	net.Broadcast()
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