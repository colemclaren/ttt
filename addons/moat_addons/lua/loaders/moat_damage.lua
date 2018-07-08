hook.Add("TTTPrepareRound", "moat.reset.anims.taunts.prep", function()
	local pls = player.GetAll()
	
	for i = 1, #pls do
		if (not pls[i]:IsValid()) then continue end
		
		pls[i]:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
	end
end)

if (SERVER) then
	util.AddNetworkString "moat.damage"
	util.AddNetworkString "moat.damage.reset"
	AddCSLuaFile()

	util.AddNetworkString "moat.reset.anims.taunts"
	hook.Add("PlayerSpawn", "moat.reset.anims.taunts", function(pl)
    	if (pl:IsSpec() or GetRoundState() ~= ROUND_PREP or (GetGlobalFloat("ttt_round_end", 0) - CurTime()) < 60) then return end

		pl:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
		
		net.Start("moat.reset.anims.taunts")
		net.WriteEntity(pl)
		net.Broadcast()
	end)

	return
end

local draw = draw
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local scrw = ScrW

local ur_damage = 0
local dwhite = Color(255, 255, 255, 255)
local dshadow = Color(0, 0, 0, 35)

net.Receive("moat.reset.anims.taunts", function()
	local ent = net.ReadEntity()

	if (ent:IsValid()) then
		ent:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
	end
end)

hook.Add("HUDPaint", "moat.damage", function()
	if (ur_damage > 0) then
		draw_SimpleTextOutlined("Your Damage: " .. ur_damage, "DermaLarge", scrw()/2, 150, dwhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, dshadow)
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