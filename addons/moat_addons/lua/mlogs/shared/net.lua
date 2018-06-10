mlogs.net = mlogs.net or {}

if (CLIENT) then
	function mlogs.SendToServer(id, cb)
		net.Start("mlogs.net." .. id)
		if (cb) then cb() end
		net.SendToServer()
	end

	function mlogs.Receive(id, cb)
		net.Receive("mlogs.net." .. id, cb)
	end

	function mlogs.ReceivePlayer(id, cb)
		net.Receive("mlogs.net." .. id, function()
			local pl = Entity(net.ReadUInt(16))
			if (IsValid(pl)) then cb(pl) end
		end)
	end

	return
end

function mlogs.net:Load(id)
	util.AddNetworkString("mlogs.net." .. id)
end

function mlogs.Receive(id, cb)
	net.Receive("mlogs.net." .. id, function(_, p)
		cb(p)
	end)
end

function mlogs.Send(id, pl, cb)
	net.Start("mlogs.net." .. id)
	if (cb) then cb() end
	net.Send(pl)
end

function mlogs.Broadcast(id, cb)
	net.Start("mlogs.net." .. id)
	if (cb) then cb() end
	net.Broadcast()
end