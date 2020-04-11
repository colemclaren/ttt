function mlogs:Send(id, cb)
	net.Start("mlogs.net." .. id)
	if (cb) then cb() end
	net.SendToServer()
end

function mlogs:Receive(id, cb)
	net.Receive("mlogs.net." .. id, cb)
end

function mlogs:ReceivePlayer(id, cb)
	net.Receive("mlogs.net." .. id, function()
		local pl = Entity(net.ReadUInt(16))
		if (IsValid(pl)) then cb(pl) end
	end)
end