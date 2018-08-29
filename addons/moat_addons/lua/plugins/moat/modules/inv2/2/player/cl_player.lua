function mi.SendStats()
	local p = net.ReadEntity()
	if (not IsValid(p)) then return end
	while true do
		local chr = net.ReadByte()
		if (chr == 0) then
			break
		end
		mi.Stats[string.char(chr)].ply_data[p] = net.ReadUInt(32)
	end
end
net.Receive("mi.SendStats", mi.SendStats)

function mi.StatsRegistered()
	net.Start "mi.SendStats"
	net.SendToServer()
end
hook.Add("InitPostEntity", "mi.StatsRegistered", mi.StatsRegistered)