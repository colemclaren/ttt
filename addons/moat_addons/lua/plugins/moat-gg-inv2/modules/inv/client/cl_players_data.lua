--
-- Networked Player Data
--

function mi.PlayersDispatch()
	local p = net.ReadPlayer()
	if (not IsValid(p)) then
		return
	end

	local id = net.ReadByte()
	if (not mi.Players[id]) then
		return
	end

	local name = mi.Players[id].Name
	if (mi.Players[id].Type == 'num') then
		p["Set" .. name](net.ReadUInt(32))
	elseif (mi.Players[id].Type == 'str') then
		p["Set" .. name](net.ReadString())
	end
end
net.Receive("mi.PlayersDispatch", mi.PlayersDispatch)

function mi.PlayersData()
	local p = net.ReadPlayer()
	print("mi.PlayersData", p)

	if (not IsValid(p)) then
		return
	end

	while true do
		local id = net.ReadByte()
		if (id == 0) then
			break
		end

		if (mi.Players[id].Type == 'num') then
			mi.Players[id].Data[p] = net.ReadUInt(32)
		elseif (mi.Players[id].Type == 'str') then
			mi.Players[id].Data[p] = net.ReadString()
		end

		print(p, id, mi.Players[id].Data[p])
	end

	if (p == LocalPlayer()) then
		for i = 1, LocalPlayer():GetSlots() do
			if (not m_Inventory[i]) then
				m_Inventory[i] = {}
			end
		end
	end
end
net.Receive("mi.PlayersData", mi.PlayersData)
/*
function mi.LoadPlayersData()
	net.Start "mi.PlayersData"
	net.SendToServer()
end
hook.Add("InitPostEntity", "mi.LoadPlayersData", mi.LoadPlayersData)
*/