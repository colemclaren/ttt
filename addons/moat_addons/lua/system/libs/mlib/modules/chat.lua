local net_Broadcast = net.Broadcast
local net_Start     = net.Start
local to_string     = tostring
local net_Send      = net.Send
local is_str        = isstring 
local is_num        = isnumber
local is_col        = IsColor
local col_white     = Color(255, 255, 255)

chat = chat or {}

----
-- Clientside Reading
----

if (CLIENT) then
	chat.Send = chat.AddText
	
	local function Read()
		local num = net.ReadUInt(8)
		if (num == 0) then
			return
		end
	
		local args, c = {}, 0
		for i = 1, num do
			if (net.ReadBool()) then
				c = c + 1
				args[c] = net.ReadColor()
			else
				c = c + 1
				args[c] = net.ReadString()
			end
		end

		return args, c
	end

	net.Receive("mlib.chat", function()
		local args = Read()
		if (not args or not next(args)) then
			return
		end

		chat.AddText(col_white, unpack(args))
	end)

	return
end

----
-- Serverside Sending
----

util.AddNetworkString "mlib.chat"

local function Send(...)
	local a = mlib.Args(...)
	if (a.n <= 0) then
		return
	end

	local s, n, send = {}, 0, net_Send
	for i = 1, a.n do
		if (is_str(a[i]) or is_num(a[i]) or is_col(a[i])) then
			n = n + 1
			s[n] = a[i]

			if (i == 1) then
				send = net_Broadcast
			end
		end
	end

	if (n == 0) then
		return
	end

	net_Start "mlib.chat"
		net.WriteUInt(n, 8)

	for i = 1, n do
		local clr = is_col(s[i])
		net.WriteBool(is_col(s[i]))

		if (clr) then
			net.WriteColor(s[i])
		else
			net.WriteString(to_string(s[i]))
		end
	end

	MsgC(unpack(s))
	MsgC "\n"

	return send(a[1])
end

chat = setmetatable({
	Send = Send
}, {__call = function(s, ...) return s.Send(...) end})