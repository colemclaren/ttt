if (SERVER) then
	util.AddNetworkString "moat.damage"
	util.AddNetworkString "moat.damage.reset"

	return
end

local draw = draw
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local scrw = ScrW
ur_damage = ur_damage or 0
local dwhite = Color(255, 255, 255, 255)
local dshadow = Color(0, 0, 0, 35)

hook.Add("HUDPaint", "moat.damage", function()
	if (ur_damage > 0) then
		-- draw_SimpleTextOutlined("Your Damage: " .. ur_damage, "DermaLarge", scrw()/2, 150, dwhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, dshadow)
	end
end)

hook.Add("TTTPrepareRound", "moat.damage.reset", function()
	ur_damage = 0
end)

net.Receive("moat.damage", function()
	ur_damage = ur_damage + net.ReadUInt(16)
end)

net.Receive("moat.damage.reset", function()
	ur_damage = 0
end)