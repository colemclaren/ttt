include('shared.lua')

LANG.AddToLanguage("english", "slam_full", "You currently cannot carry SLAM's.")
LANG.AddToLanguage("english", "slam_disarmed", "A SLAM you've planted has been disarmed.")

ENT.PrintName = "M4 SLAM"
ENT.Icon = "vgui/ttt/icon_slam"

net.Receive("TTT_SLAMWarning", function()
	local idx = net.ReadUInt(16)
	local armed = net.ReadBool()

	if armed then
		local pos = net.ReadVector()
		RADAR.bombs[idx] = {pos=pos, nick="SLAM"}
	else
		RADAR.bombs[idx] = nil
	end

	RADAR.bombs_count = table.Count(RADAR.bombs)
end)
