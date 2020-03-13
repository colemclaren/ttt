util.AddNetworkString "Moat.Typing"

net.Receive("Moat.Typing", function(_, pl)
	local is = net.ReadBool()

	if (not is and pl.StartedTyping) then
		pl.StartedTyping = nil

		net.Start "Moat.Typing"
			net.WritePlayer(pl)
			net.WriteBool(false)
		net.Broadcast()
	elseif (not pl.StartedTyping) then
		pl.StartedTyping = CurTime()

		net.Start "Moat.Typing"
			net.WritePlayer(pl)
			net.WriteBool(true)
		net.Broadcast()
	else
		if (not pl.StartedTyping or (pl.StartedTyping and CurTime() - pl.StartedTyping >= 1)) then
			net.Start "Moat.Typing"
				net.WritePlayer(pl)
				net.WriteBool(true)
			net.Broadcast()
		end

		pl.StartedTyping = CurTime()
	end
end)