mlogs.chat = mlogs.chat or {}

function mlogs.chat.write(args)
	local num = #args
	net.WriteUInt(num, 8)
	if (num == 0) then return end

	for i = 1, num do
		local col = IsColor(args[i])
		net.WriteBool(col)

		if (not col) then
			net.WriteString(tostring(args[i]))
		else
			net.WriteColor(args[i])
		end
	end
end

function mlogs.chat.broadcast(...)
	local args = {...}

	mlogs:Broadcast("chat", function()
		mlogs.chat.write(args)
	end)

	MsgC(unpack(args))
	MsgC "\n"
end

function mlogs.chat.send(pl, ...)
	local args = {...}

	mlogs:Send("chat", pl, function()
		mlogs.chat.write(args)
	end)

	MsgC(unpack(args))
	MsgC "\n"
end

function mlogs.chat.staff(...)
	local staff = mlogs:GetStaff()
	if (not next(staff)) then return end

	mlogs.chat.send(staff, ...)
end