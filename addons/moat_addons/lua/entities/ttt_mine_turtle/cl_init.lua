include('shared.lua')

LANG.AddToLanguage("english", "mine_turtle_full", "You currently cannot carry more Mine Turtle's")
LANG.AddToLanguage("english", "mine_turtle_disarmed", "A Mine Turtle you've planted has been disarmed.")

ENT.PrintName = "Mine Turtle"
ENT.Icon = "vgui/ttt/icon_mine_turtle"

net.Receive("TTT_MineTurtleWarning", function()
	local idx = net.ReadUInt(16)
	local armed = net.ReadBool()

	if armed then
		local pos = net.ReadVector()
		RADAR.bombs[idx] = {pos=pos, nick="Mine Turtle"}
	else
		RADAR.bombs[idx] = nil
	end

	RADAR.bombs_count = table.Count(RADAR.bombs)
end)
