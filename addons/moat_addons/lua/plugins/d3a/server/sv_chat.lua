D3A.Chat = {}

util.AddNetworkString("D3A.Chat")
util.AddNetworkString("D3A.AdminChat")
util.AddNetworkString("D3A.Chat2")

function D3A.Chat.AdminChat(pl, Text)
	if (!pl:HasAccess(D3A.Config.StaffChat)) then
		if (hook.Run("NonAdminChatted", pl, Text) == true) then -- true to suppress, anything else obviously to not
			return
		end
	end
	
	local rf = {}
	
	for k, v in ipairs(player.GetAll()) do
		if (v:HasAccess(D3A.Config.StaffChat) or v == pl) then
			table.insert(rf, v)
		end
	end
	
	net.Start("D3A.AdminChat")
		net.WriteString(tostring(pl:HasAccess("t")))
		net.WriteString(pl:Name())
		net.WriteString(string.Trim(Text))
	net.Send(rf)
end

function D3A.Chat.SendToPlayer(pl, Text, Type)
	if (type(pl) != "table") and (!pl:IsPlayer()) then
		print(Text)
	end
	
	Type = Type or "NORM"
	
	net.Start("D3A.Chat")
		net.WriteString(Text)
		net.WriteString(Type)
	net.Send(pl)
end

function D3A.Chat.Broadcast(Text, Type)
	Type = Type or "NORM"
	
	net.Start("D3A.Chat")
		net.WriteString(Text)
		net.WriteString(Type)
	net.Broadcast()
end

function D3A.Chat.BroadcastStaff(Text, Type)
	Type = Type or "NORM"
	
	local rf = {}
	for _, v in ipairs(player.GetAll()) do if (v:HasAccess("t")) then table.insert(rf, v) end end
	net.Start("D3A.Chat")
		net.WriteString(Text)
		net.WriteString(Type)
	net.Send(rf)
end

function D3A.Chat.Broadcast2(...)
	local args = {...}

	if (args[1] and (isentity(args[1]) or (istable(args[1]) and args[1].rcon))) then
		local info = args[1]
		table.remove(args, 1)

		if (istable(info) and info.rcon) then
			MOAT_RCON:Post(info, args)
		end
	end

	net.Start("D3A.Chat2")
		net.WriteBool(false)
		net.WriteTable(args)
	net.Broadcast()

	MsgC(unpack(args))
	MsgC("\n")
end

function D3A.Chat.SendToPlayer2(pl, ...)
	MsgC(...)
	MsgC("\n")

	local instigator

	if (pl and istable(pl) and pl.rcon) then
		MOAT_RCON:Post(pl, {...})
		return
	elseif (pl and istable(pl) and pl.to) then
		instigator = pl.instigator
		pl = pl.to
	end

	if (not IsValid(pl)) then 
		return
	end

	net.Start("D3A.Chat2")
		if (IsValid(instigator)) then
			net.WriteBool(true)
			net.WriteEntity(instigator)
		else
			net.WriteBool(false)
		end
		net.WriteTable({...})
	net.Send(pl)
end

function D3A.Chat.BroadcastStaff2(...)
	local rf = {}
	for _, v in ipairs(player.GetAll()) do if (v:HasAccess("t")) then table.insert(rf, v) end end

	net.Start("D3A.Chat2")
		net.WriteBool(false)
		net.WriteTable({...})
	net.Send(rf)

	MsgC(...)
	MsgC("\n")
end
