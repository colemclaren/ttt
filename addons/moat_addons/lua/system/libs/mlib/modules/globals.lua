----
-- Add all of your global variable keys to the table below if you just want to forget about them :)
-- Simply creates a proper net receiver for each global.
----

local DefaultGlobals = {
	["ttt_highlight_admins"] = "Bool",
	["ttt_round_end"] = "Float",
	["ttt_haste_end"] = "Float",
	["ttt_rounds_left"] = "Int",
	["ttt_detective"] = "Bool",
	["ttt_haste"] = "Bool",
	["ttt_time_limit_minutes"] = "Int",
	["ttt_locational_voice"] = "Bool",
	["ttt_idle_limit"] = "Int",
	["ttt_voice_drain"] = "Bool",
	["ttt_voice_drain_normal"] = "Float",
	["ttt_voice_drain_admin"] = "Float",
	["ttt_voice_drain_recharge"] = "Float",
	["ttt_karma"] = "Bool"
}

----
-- No lazy developers beyond this point !!
----

local ProperlyNetwork = {}
for id, kind in pairs(DefaultGlobals) do
	if (SERVER) then
		util.AddNetworkString("SetGlobal" .. kind .. ":" .. id)
	end

	if (not ProperlyNetwork[kind]) then
		ProperlyNetwork[kind] = {Count = 0}
	end

	ProperlyNetwork[kind].Count = ProperlyNetwork[kind].Count + 1
	ProperlyNetwork[kind][ProperlyNetwork[kind].Count] = id
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

local function RegisterGlobalClass(name, default, write, read, valid)
	Lookup.Count = Lookup.Count + 1

	local data = {
		ID = Lookup.Count,
		Name = name,
		Stored = {}
	}

	data.Default = default
	data.Write = function(var) return write(var) end
	data.Read = function() return read() end
	data.Valid = type(valid) == "string" and function(var)
		return type(var) == valid 
	end or function(var) return valid[type(var)] end

	Globals[name] = data

	Lookup[Lookup.Count] = name
	Lookup[name] = Lookup.Count
end

-- SetGlobalAngle/GetGlobalAngle
RegisterGlobalClass("Angle", Angle(0, 0, 0), WriteAngle, ReadAngle, "Angle")

-- SetGlobalBool/GetGlobalBool
RegisterGlobalClass("Bool", false, WriteBool, ReadBool, {["boolean"] = true, ["nil"] = true})

-- SetGlobalEntity/GetGlobalEntity
RegisterGlobalClass("Entity", NULL, function(var)
	return WriteUInt(IsValid(var) and var:EntIndex() or 0, 12)
end, function(var) return Entity(ReadUInt(12) or -1) end, {["Entity"] = true, ["Player"] = true})

-- SetGlobalFloat/GetGlobalFloat
RegisterGlobalClass("Float", 0, WriteFloat, ReadFloat, "number")

-- SetGlobalInt/GetGlobalInt
RegisterGlobalClass("Int",  0, function(var)
	return WriteInt(var, 32) end, 
function() return ReadInt(32) end, "number")

-- SetGlobalString/GetGlobalString
RegisterGlobalClass("String", "", WriteString, ReadString, "string")

-- SetGlobalVector/GetGlobalVector
RegisterGlobalClass("Vector", Vector(0, 0, 0), WriteVector, ReadVector, "Vector")


----
-- Begin our detours
----

if (SERVER) then
	util.AddNetworkString "LoadGlobalVariables"
	for kind, _ in pairs(Globals) do
		util.AddNetworkString("SetGlobal" .. kind)
	end

	local function UpdateGlobalVariable(kind, key, val, int)
		Internal[Globals[kind].Stored[key].Index].Value = val
		Globals[kind].Stored[key].Value = val

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

		Internal.Cache[key] = val
	end

	local function CreateGlobalVariable(kind, key, val, int)
		Internal.Count = Internal.Count + 1
		Internal[Internal.Count] = {
			Value = val,
			Kind = kind,
			Key = key
		}

		Globals[kind].Stored[key] = {Index = Internal.Count}

		return UpdateGlobalVariable(kind, key, val, int)
	end

	local function SetGlobalVariable(kind, key, val, int)
		assert(Globals[kind].Valid(val), "Attempt to call SetGlobal" .. kind .. " with an invalid data type!")
		if (Globals[kind].Stored[key] == nil) then
			return CreateGlobalVariable(kind, key, val, int)
		end

		if (Globals[kind].Stored[key].Value == val) then
			return
		end

		return UpdateGlobalVariable(kind, key, val, int)
	end

	function SetGlobalAngle(key, val)
		SetGlobalVariable("Angle", key, val)
	end

	function SetGlobalBool(key, val)
		SetGlobalVariable("Bool", key, val)
	end

	function SetGlobalEntity(key, val)
		SetGlobalVariable("Entity", key, val)
	end

	function SetGlobalFloat(key, val)
		SetGlobalVariable("Float", key, val)
	end

	function SetGlobalInt(key, val)
		SetGlobalVariable("Int", key, val)
	end

	function SetGlobalString(key, val)
		SetGlobalVariable("String", key, val)
	end

	function SetGlobalVector(key, val)
		SetGlobalVariable("Vector", key, val)
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

	net.Receive("LoadGlobalVariables", function(_, pl)
		if (pl.HasGlobalVariables) then return end
		pl.HasGlobalVariables = true

		SendGlobalVariables(1, Internal, {
			start = function(int)
				Start "LoadGlobalVariables"
			end,
			write = function(var)
				WriteUInt(Globals[var.Kind].ID, 3)
				WriteString(var.Key)
				Globals[var.Kind].Write(var.Value)
			end,
			send = function() net.Send(pl) end,
			check = function(var) return type(var.Value) ~= "nil" end
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
			local Key = ProperlyNetwork[kind][i]

			net.Receive(NetworkID .. ":" .. Key, function()
				SetGlobalVariable(kind,  ProperlyNetwork[kind][i], info.Read())
			end)

			Internal.Cache[Key] = info.Default
		end
	end

	net.Receive("LoadGlobalVariables", function()
		while (ReadBool()) do
			local kind = Lookup[ReadUInt(3)]
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
-- Added a GetGlobal function for faster lookups.
-- ** Cache for DefaultGlobals starts with type default (like normal GetGlobal behavior)
----

function GetGlobal(key)
	return Internal.Cache[key]
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