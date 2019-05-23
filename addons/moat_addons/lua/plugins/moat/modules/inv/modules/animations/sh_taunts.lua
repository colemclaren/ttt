hook.Add("TTTPrepareRound", "moat.reset.anims.taunts.prep", function()
	local pls = player.GetAll()
	
	for i = 1, #pls do
		if (not pls[i]:IsValid()) then continue end
		
		pls[i]:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
	end
end)

if (SERVER) then
	util.AddNetworkString "moat.reset.anims.taunts"

	hook.Add("PlayerSpawn", "moat.reset.anims.taunts", function(pl)
    	if (pl:IsSpec() or GetRoundState() ~= ROUND_PREP or (GetGlobal("ttt_round_end") - CurTime()) < 60) then return end

		pl:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
		
		net.Start("moat.reset.anims.taunts")
		net.WriteEntity(pl)
		net.Broadcast()
	end)

	return
end

net.Receive("moat.reset.anims.taunts", function()
	local ent = net.ReadEntity()

	if (ent:IsValid()) then
		ent:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
	end
end)