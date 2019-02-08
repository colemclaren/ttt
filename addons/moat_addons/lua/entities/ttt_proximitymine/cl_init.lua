include('shared.lua')

ENT.PrintName = "Proximity Mine"
ENT.Icon = "vgui/ttt/icon_ttt_proxmine"

net.Receive("TTT_ProxMineWarning", function()
	local idx = net.ReadUInt(16)
	local armed = net.ReadBool()

	if armed then
		local pos = net.ReadVector()
		RADAR.bombs[idx] = {pos=pos, nick="Proximity Mine"}
	else
		RADAR.bombs[idx] = nil
	end

	RADAR.bombs_count = table.Count(RADAR.bombs)
end)
