local to_string     = tostring
local is_str        = isstring 
local is_num        = isnumber
local is_col        = IsColor

comments = comments or {}

----
-- Clientside Commenting
----

if (CLIENT) then
	local function Read()
		local num = net.ReadUInt(8)
		if (num == 0) then
			return
		end
	
		local args, c = {}, 0
		for i = 1, num do
			if (net.ReadBit() == 1) then
				c = c + 1
				args[c] = net.ReadColor()
			else
				c = c + 1
				args[c] = net.ReadString()
			end
		end

		return args, c
	end

	net.Receive("yugh.comments", function()
		local args, n = Read()
		if (not args or not next(args)) then
			return
		end

		MsgC(unpack(args))
		MsgC "\n"

		if (n == 0 or not IsValid(LocalPlayer())) then
			return moat.error(unpack(args))
		end

		chat.AddText(unpack(args))
	end)

	return
end

----
-- Serverside Commenting
----

util.AddNetworkString "yugh.comments"

local function Send(...)
	local a = yugh.Args(...)
	if (a.n <= 0) then
		return
	end

	local s, n, send = {}, 0, net.Send
	for i = 1, a.n do
		if (is_str(a[i]) or is_num(a[i]) or is_col(a[i])) then
			n = n + 1
			s[n] = a[i]

			if (i == 1) then
				send = net.Broadcast
			end
		end
	end

	if (n == 0) then
		return
	end

	net.Start "yugh.comments"
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

comments = setmetatable({
	Receive = Read,
	Send = Send
}, {__call = function(s, ...) return s.Send(...) end})