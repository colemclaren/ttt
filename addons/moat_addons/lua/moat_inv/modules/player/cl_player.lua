function MOAT_INV.SendStats()
	local p = net.ReadEntity()
	if (not IsValid(p)) then return end
	while true do
		local chr = net.ReadByte()
		if (chr == 0) then
			break
		end
		MOAT_INV.Stats[string.char(chr)].ply_data[p] = net.ReadUInt(32)
	end
end
net.Receive("MOAT_INV.SendStats", MOAT_INV.SendStats)

function MOAT_INV.StatsRegistered()
	net.Start "MOAT_INV.SendStats"
	net.SendToServer()
end
hook.Add("MOAT_INV.Initialized", "MOAT_INV.StatsRegistered", MOAT_INV.StatsRegistered)