local IsValid = IsValid
local Entity = Entity
local Color = Color
local WriteUInt = net.WriteUInt
local ReadUInt = net.ReadUInt
local ReadInt = net.ReadInt
local ReadString = net.ReadString
local WriteBit = net.WriteBit
local ReadBit = net.ReadBit
local BytesWritten = net.BytesWritten
local Start = net.Start
local Send = SERVER and net.Send or net.SendToServer
local Broadcast = SERVER and net.Broadcast
net.Receives = net.Receivers or {}

---------------------
-- Networking Main --
---------------------

function net.Receive(name, func)
	net.Receives[name] = func

	local id = util.NetworkStringToID(name)
	if (id) then
		net.Receives[id] = func
	end
end

function net.Incoming(len, pl)
	local i = net.ReadHeader()

	if (not net.Receives[i]) then
		local str = util.NetworkIDToString(i)
		if (not str or not net.Receives[str]) then
			return
		end

		net.Receives[i] = net.Receives[str]
	end

	net.Receives[i](len - 16, pl)
end

------------------------
-- Networking Numbers --
------------------------

function net.WriteByte(int) int = int or 0 WriteUInt(int, 8) end
function net.ReadByte()
	return ReadUInt(8)
end

function net.WriteShort(int) int = int or 0 WriteUInt(int, 16) end
function net.ReadShort()
	return ReadUInt(16)
end

function net.WriteLong(int) int = int or 0 WriteUInt(int, 32) end
function net.ReadLong()
	return ReadUInt(32)
end

-------------------------
-- Networking Booleans --
-------------------------

------------------------
-- Networking Strings --
------------------------

-------------------------
-- Networking Entities --
-------------------------

function net.WriteEntity(ent)
	if (IsValid(ent)) then
		WriteUInt(ent:EntIndex() or 0, 12)
	else
		WriteUInt(0, 12)
	end
end

function net.ReadEntity()
	local i = ReadUInt(12)
	if (not i) then return end

	return Entity(i)
end

------------------------
-- Networking Players --
------------------------

function net.WritePlayer(pl)
	if (IsValid(pl)) then
		WriteUInt(pl:EntIndex(), 8)
	else
		WriteUInt(0, 8)
	end
end

function net.ReadPlayer()
	local i = ReadUInt(8)
	if (not i) then return end

	return Entity(i)
end

-----------------------
-- Networking Colors --
-----------------------

function net.WriteColor(c)
	c = c or {}
	c.r = c.r or 255
	c.g = c.g or 255
	c.b = c.b or 255

	WriteUInt(c.r, 8)
	WriteUInt(c.g, 8)
	WriteUInt(c.b, 8)
end

function net.ReadColor(c)
	return Color(ReadUInt(8), ReadUInt(8), ReadUInt(8))
end

function net.WriteColorA(c)
	c = c or {}
	c.r = c.r or 255
	c.g = c.g or 255
	c.b = c.b or 255
	c.a = c.a or 255

	WriteUInt(c.r, 8)
	WriteUInt(c.g, 8)
	WriteUInt(c.b, 8)
	WriteUInt(c.a, 8)
end

function net.ReadColorA(c)
	return Color(ReadUInt(8), ReadUInt(8), ReadUInt(8), ReadUInt(8))
end

------------------------
-- Networking Helpers --
------------------------

local TickInterval = engine.TickInterval()
local MaxBytes = 30000 * TickInterval
local Simple = timer.Simple
local IntervalFull = function()
	return BytesWritten() >= MaxBytes
end

NetIterate = function(int, data, args)
	int = int or 1

	if (not data[int]) then
		return args.finished()
	end

	if (not args.check(data[i], int)) then
		int = int + 1

		return NetIterate(int, data, args)
	end

	args.start(int, data[int])

		while (data[int]) do
			if (not args.check(data[int], int)) then
				int = int + 1

				continue
			end

			WriteBit(1)
			args.write(data[int], int)

			int = int + 1

			if (IntervalFull()) then
				Simple(0, function()
					NetIterate(int, data, args)
				end)

				break
			end
		end

		WriteBit(0)

	args.send(int, IntervalFull())

	if (not data[int]) then
		return args.finished()
	end
end

function net.WriteArray(data, start_func, write_func, send_func, finished_func, check_func)
	return NetIterate(1, data, {
		start = isstring(start_func) and function() Start(start_func) end or start_func,
		write = write_func or function() end,
		send = send_func or function() end,
		finished = finished_func or function() end,
		check = check_func or function() return true end,
	})
end

function net.ReadArray(int, func)
	int = int or 1

	while (net.ReadBool()) do
		func(int)
		int = int + 1
	end
end

local WriteEntity = net.WriteEntity
local ReadEntity = net.ReadEntity
local WritePlayer = net.WritePlayer
local ReadPlayer = net.ReadPlayer
local Deliver = function(pl) if (not pl and SERVER) then Broadcast() else Send(pl) end end
local AddTable = function(tb, pre) for i = 1, #tb do util.AddNetworkString((pre or "") .. tb[i]) end end

function net.Add(str, tb)
	if (tb) then
		AddTable(str, tb)
	elseif (istable(str)) then
		AddTable(str)
	else
		return util.AddNetworkString(str)
	end
end

function net.Do(str, cb, pl)
	Start(str)
	if (cb) then cb() end
	Deliver(pl)
end

function net.ReceiveEntity(str, func)
	net.Receives[str] = function(_, pl)
		if (IsValid(ReadEntity())) then func(pl) end
	end
end

function net.ReceivePlayer(str, func)
	net.Receives[str] = function(_, pl)
		local ply = ReadPlayer()
		if (IsValid(ply)) then func(ply, pl) end
	end
end

function net.SendPlayer(str, pl, func, send)
	Start(str)
	WritePlayer(pl)

	if (func and send) then
		func()
		send()
	else
		func()
	end
end

function net.SendEntity(str, pl, func, send)
	Start(str)
	WriteEntity(pl)

	if (func and send) then
		func()
		send()
	else
		func()
	end
end

local Lines = {
	"Wobbling to 299%",
	"TTT REQUIRES MORE MINERALS",
	"Untap, Upkeep, Draw",
	"Traveling to Hanamura",
	"TIME'S UP - LET'S DO THIS!",
	"This inventory receiving is a lie",
	"They see me inventory receiving, They waiting",
	"Start your engines",
	"Skipping cutscenes",
	"Shuffling the deck",
	"Reviving dead memes",
	"Returning the slab",
	"Recombobulating Discombobulators",
	"now with scratch and sniff",
	"Now with 100% more Screenshare!",
	"Dropping in Pochinki",
	"Looking for the power button",
	"Look behind you",
	"Locating cole",
	"Receiving your digital hug inventory",
	"Receiving Inventory Simulation",
	"Jumping to hyperspace",
	"Is this thing on?",
	"Initiating launch sequence",
	"Initializing socialization",
	"If you are reading this, you can read",
	"I swear it's around here somewhere...",
	"i need healing",
	"how do i turn this thing on",
	"Receiving inventory machine broke",
	"Get ready for a surprise!",
	"Finishing this senta...",
	"Dusting the cobwebs",
	"Do you even notice these?",
	"Opening the inventory receival bay doors",
	"Moat is my city",
	"Disconnecting from Reality",
	"Charging spirit bomb",
	"Charging Limit Break",
	"Calibrating flux capacitors",
	"Buckle up!",
	"Assembling Voltron",
	"Are we there yet?",
	"A brawl is surely brewing!",
	"RECEIVING INVENTORY 001: ARP 303 Saw",
	"*Elevator Music Plays*",
	"Researching cheat codes",
	"Wizard needs food badly",
	"Decrypting Engrams",
	"And now for something completely different",
	"Stopping to smell the flowers",
	"Achieving Nirvana",
	"Managing Inventory"
}

function net.Line()
	return Lines[math.random(52)]
end

function net.Jump(messageName, messageStart)
	if (net.BytesWritten() and net.BytesWritten() > 0) then
		timer.Simple(0, function()
			net.Start(messageName)
			messageStart()
		end)
	end
end