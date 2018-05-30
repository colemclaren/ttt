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
end
net.Receive("TTTPlayerLoaded", TTTPlayerLoaded)


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