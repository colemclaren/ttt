--
-- Networked Player Data
--

util.AddNetworkString "mi.PlayersDispatch"
util.AddNetworkString "mi.PlayersData"

function mi.PlayersDispatch(_, pl)
	local p = net.ReadPlayer()
	if (not IsValid(p)) then
		return
	end

	local id = net.ReadByte()
	if (not mi.Players[id]) then
		return
	end

	local name = mi.Players[id].Name
	net.Start "mi.PlayersDispatch"
		net.WritePlayer(p)
		net.WriteUInt(p["Get" .. name](), 32)
	net.Send(pl)
end
net.Receive("mi.PlayersDispatch", mi.PlayersDispatch)

function mi:NetworkPlayersData(pl, to)
	net.Start "mi.PlayersData"
		net.WritePlayer(pl)

		for id, data in pairs(mi.Players) do
			net.WriteByte(id)
			if (data.Type == 'num') then
				net.WriteUInt(data.Data[pl], 32)
			elseif (data.Type == 'str') then
				net.WriteString(data.Data[pl])
			end
		end

		net.WriteByte(0)

	return to and net.Send(to) or net.Broadcast()
end

function mi.PlayersData(_, pl)
	for _, p in ipairs(player.GetAll()) do
		mi:NetworkPlayersData(p, pl)
	end
end
net.Receive("mi.PlayersData", mi.PlayersData)