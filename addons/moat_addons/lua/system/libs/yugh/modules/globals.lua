----
-- This file DETOURS base Global Garry's Mod Functions
-- Change the map 2 apply it
----

if (GetGlobal) then
	return
end

----
-- Add all of your global variable keys to the table below if you just want to forget about them :)
-- Simply creates a proper net receiver for each global.
----

-- Save players from unnecessary networking
local DefaultGlobals = {
	["MOAT_MINIGAME_ACTIVE"] = "Str",
	
	["ttt_highlight_admins"] = {"Bool", true},
	["ttt_detective"] = {"Bool", true},
	["ttt_haste"] = {"Bool", true},
	["ttt_round_end"] = {"Float", -1},
	["ttt_haste_end"] = {"Float", -1},
	["ttt_rounds_left"] = "Int",
	["ttt_time_limit_minutes"] = "Int",
	["ttt_locational_voice"] = "Bool",
	["ttt_idle_limit"] = "Int",
	["ttt_voice_drain"] = "Bool",
	["ttt_voice_drain_normal"] = "Float",
	["ttt_voice_drain_admin"] = "Float",
	["ttt_voice_drain_recharge"] = "Float",
	["ttt_karma"] = "Bool",
}

----
-- No lazy developers beyond this point !!
----

local ProperlyNetwork = {}
for id, info in pairs(DefaultGlobals) do
	local key, def = info

	if (type(info) == "table") then
		key, def = info[1], info[2]
	end

	if (not ProperlyNetwork[key]) then
		ProperlyNetwork[key] = {Count = 0}
	end

	ProperlyNetwork[key].Count = ProperlyNetwork[key].Count + 1
	ProperlyNetwork[key][ProperlyNetwork[key].Count] = {id, def}
end

----
-- Pointlessly localize things
----

local WriteBool, ReadBool, WriteBit = net.WriteBool, net.ReadBool, net.WriteBit
local ReadString, WriteString = net.ReadString, net.WriteString
local WriteVector, ReadVector = net.WriteVector, net.ReadVector
local Start, Broadcast = net.Start, SERVER and net.Broadcast
local WriteFloat, ReadFloat = net.WriteFloat, net.ReadFloat
local WriteAngle, ReadAngle = net.WriteAngle, net.ReadAngle
local WriteUInt, ReadUInt = net.WriteUInt, net.ReadUInt
local Send = SERVER and net.Send or net.SendToServer
local WriteInt, ReadInt = net.WriteInt, net.ReadInt
local BytesWritten = net.BytesWritten
local Simple = timer.Simple
local IsValid = IsValid
local Entity = Entity

----
-- Register the global types
----

local Globals = {}
local Lookup = {Count = 0}
local Internal = {
	Cache = {},
	Count = 0
}

local BitCount = 4 -- bitcount for # global classes (increase this if u add more)
local function RegisterGlobalClass(name, default, write, read, set, valid)
	Lookup.Count = Lookup.Count + 1
	local data = {
		ID = Lookup.Count,
		Name = name,
		Stored = {}
	}

	data.Default = default
	data.Read = function() return read() end
	data.Write = function(var) return write(var) end
	data.Set = (type(set) == "function" and valid) and set or function(val) return val end

	valid = valid or set

	data.Valid = (type(valid) == "string") and function(val)
		return (type(val) == valid)
	end or (type(valid) == "table") and function(val)
		return (valid[type(val)])
	end or (type(valid) == "function") and valid or function() return true end

	Globals[name] = data

	Lookup[Lookup.Count] = name
	Lookup[name] = Lookup.Count
end

-- SetGlobalAngle/GetGlobalAngle
RegisterGlobalClass("Angle", Angle(0, 0, 0), WriteAngle, ReadAngle, "Angle")

-- SetGlobalBool/GetGlobalBool
RegisterGlobalClass("Bool", false, WriteBool, ReadBool, {["boolean"] = true, ["nil"] = true})

-- SetGlobalEntity/GetGlobalEntity
RegisterGlobalClass("Entity", NULL, function(val)
	return WriteUInt(IsValid(val) and val:EntIndex() or 0, 12)
end, function() return Entity(ReadUInt(12) or -1) end, {["Entity"] = true, ["Player"] = true})

-- SetGlobalFloat/GetGlobalFloat
RegisterGlobalClass("Float", 0, WriteFloat, ReadFloat, "number")

-- SetGlobalInt/GetGlobalInt
RegisterGlobalClass("Int",  0, function(val)
	return WriteInt(val, 32) end, 
function() return ReadInt(32) end, "number")

-- SetGlobalString/GetGlobalString
RegisterGlobalClass("String", "", WriteString, ReadString, "string")

-- SetGlobalVector/GetGlobalVector
RegisterGlobalClass("Vector", Vector(0, 0, 0), WriteVector, ReadVector, "Vector")

----
-- New lazy Shorthand String function meant ONLY for global cache use (bottom of file)
-- Perfect for expensive checks on string globals that won't persist
----

-- SetGlobalStr/GetGlobalStr
RegisterGlobalClass("Str", false, function(val)
	return WriteString(not val and "" or tostring(val))
end, ReadString, function(val) 
	return (val and tostring(val))
end, {["boolean"] = true, ["string"] = true, ["nil"] = true})


----
-- Begin our detours
----

if (SERVER) then
	local function SetGlobalServerVariable(kind, key, val)
		Internal[Globals[kind].Stored[key].Index].Value = val
		Globals[kind].Stored[key].Value = val

		Internal.Cache[key] = val

		return val
	end

	local function CreateGlobalVariable(kind, key, val)
		Internal.Count = Internal.Count + 1
		Internal[Internal.Count] = {Value = val, Kind = kind, Key = key}
		Globals[kind].Stored[key] = {Index = Internal.Count, Value = val}

		return SetGlobalServerVariable(kind, key, val)
	end

	local function NetworkGlobalVariable(kind, key, val)
		if (DefaultGlobals[key]) then
			Start("SetGlobal" .. kind .. ":" .. key)
				Globals[kind].Write(val)
			Broadcast()
		else
			Start("SetGlobal" .. kind)
				WriteString(key)
				Globals[kind].Write(val)
			Broadcast()
		end

		return val
	end

	local function SetGlobalVariable(kind, key, val)
		assert(Globals[kind].Valid(val), "Attempt to call SetGlobal" .. kind .. " with an non valid data type!")

		val = Globals[kind].Set(val)

		if (Globals[kind].Stored[key] == nil) then
			CreateGlobalVariable(kind, key, val)

			return NetworkGlobalVariable(kind, key, val)
		end

		if (Globals[kind].Stored[key].Value == val) then
			return nil
		end

		SetGlobalServerVariable(kind, key, val)

		return NetworkGlobalVariable(kind, key, val)
	end

	function SetGlobalAngle(key, val)
		return SetGlobalVariable("Angle", key, val)
	end

	function SetGlobalBool(key, val)
		return SetGlobalVariable("Bool", key, val)
	end

	function SetGlobalEntity(key, val)
		return SetGlobalVariable("Entity", key, val)
	end

	function SetGlobalFloat(key, val)
		return SetGlobalVariable("Float", key, val)
	end

	function SetGlobalInt(key, val)
		return SetGlobalVariable("Int", key, val)
	end

	function SetGlobalString(key, val)
		return SetGlobalVariable("String", key, val)
	end

	function SetGlobalVector(key, val)
		return SetGlobalVariable("Vector", key, val)
	end

	function SetGlobalStr(key, val)
		return SetGlobalVariable("Str", key, val)
	end

	util.AddNetworkString "LoadGlobalVariables"
	for kind, info in pairs(Globals) do
		util.AddNetworkString("SetGlobal" .. kind)

		if (not ProperlyNetwork[kind]) then
			continue
		end
		
		for i = 1, ProperlyNetwork[kind].Count do
			local key, def = ProperlyNetwork[kind][i][1], info.Default

			if (ProperlyNetwork[kind][i][2] ~= nil) then
				def = ProperlyNetwork[kind][i][2]
			end

			util.AddNetworkString("SetGlobal" .. kind .. ":" .. key)

			CreateGlobalVariable(kind, key, def)
		end
	end

	----
	-- Sync globals for new players super fast
	----

	local TickInterval = engine.TickInterval()
	local BytesLimit = 30000 * TickInterval

	local function SendGlobalVariables(int, data, args)
		int = int or 1

		if (not data[int]) then return end
		if (not args.check(data[int], int)) then 
			int = int + 1 

			return SendGlobalVariables(int, data, args)
		end

		args.start(int, data[int])
			while (data[int]) do
				if (not args.check(data[int], int)) then int = int + 1 continue end

				WriteBit(1)
				args.write(data[int], int)

				int = int + 1

				if (BytesWritten() >= BytesLimit) then
					Simple(0, function() SendGlobalVariables(int, data, args) end)
					break
				end
			end
			WriteBit(0)
		args.send(int, BytesWritten() >= BytesLimit)
	end

	local Security = {}
	net.Receive("LoadGlobalVariables", function(_, pl)
		if (Security[pl]) then return end
		Security[pl] = true

		SendGlobalVariables(1, Internal, {
			start = function(int)
				Start "LoadGlobalVariables"
			end,
			write = function(var)
				WriteUInt(Globals[var.Kind].ID, BitCount)
				WriteString(var.Key)
				Globals[var.Kind].Write(var.Value)
			end,
			send = function() net.Send(pl) end,
			check = function(var)
				if (not Globals[var.Kind].Valid(var.Value)) then
					return false
				end

				return (DefaultGlobals[var.Key] == nil) or (Globals[var.Kind].Default ~= var.Value)
			end
		})
	end)
else
	----
	-- Client receives globals from server
	----

	local function SetGlobalVariable(kind, key, val)
		Globals[kind].Stored[key] = val
		Internal.Cache[key] = val
	end

	for kind, info in pairs(Globals) do
		local NetworkID = "SetGlobal" .. kind

		net.Receive(NetworkID, function()
			local key = ReadString()

			SetGlobalVariable(kind, key, info.Read())
		end)

		if (not ProperlyNetwork[kind]) then
			continue
		end
		
		for i = 1, ProperlyNetwork[kind].Count do
			local Key = ProperlyNetwork[kind][i][1]

			net.Receive(NetworkID .. ":" .. Key, function()

				SetGlobalVariable(kind,  Key, info.Read())
			end)

			Internal.Cache[Key] = info.Default
		end
	end

	
	net.Receive("LoadGlobalVariables", function()
		while (ReadBool()) do
			local kind = Lookup[ReadUInt(BitCount)]
			local key = ReadString()
			local val = Globals[kind].Read()

			SetGlobalVariable(kind, key, val)
		end
	end)

	hook.Add("InitPostEntity", "LoadGlobalVariables", function()
		Start "LoadGlobalVariables" Send()
	end)
end


----
-- GetGlobal detours
----

local function GetGlobalVariable(kind, key, default)
	if (Globals[kind].Stored[key] == nil) then
		if (default == nil) then
			default = Globals[kind].Default
		end
	
		return default
	end

	if (CLIENT) then return Globals[kind].Stored[key] end
	return Globals[kind].Stored[key].Value
end

function GetGlobalAngle(key, default)
	return GetGlobalVariable("Angle", key, default)
end

function GetGlobalBool(key, default)
	return GetGlobalVariable("Bool", key, default)
end

function GetGlobalEntity(key, default)
	return GetGlobalVariable("Entity", key, default)
end

function GetGlobalFloat(key, default)
	return GetGlobalVariable("Float", key, default)
end

function GetGlobalInt(key, default)
	return GetGlobalVariable("Int", key, default)
end

function GetGlobalString(key, default)
	return GetGlobalVariable("String", key, default)
end

function GetGlobalVector(key, default)
	return GetGlobalVariable("Vector", key, default)
end

function GetGlobalStr(key, default)
	return GetGlobalVariable("Str", key, default)
end

----
-- New GetGlobal function for faster lookups / expensive checking (draw hooks, etc)
-- ** Cache for DefaultGlobals starts with type default (like normal GetGlobal behavior)
----

function GetGlobal(key)
	return Internal.Cache[key]
end