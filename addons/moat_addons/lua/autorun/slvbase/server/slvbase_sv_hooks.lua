hook.Add("ScaleNPCDamage", "HLR_ScaleNPCDamage_HitGroupCheck", function(npc,hitgroup,dmg)
	if npc.bScripted then npc.lastHitGroupDamage = hitgroup end
end)

hook.Add("PhysgunPickup", "HLR_Physgunpickup", function(ply, ent)
	if IsValid(ent) && ent.OnPickedUp then
		ent:OnPickedUp(ply, 2)
	end
end)

hook.Add("GravGunOnPickedUp", "HLR_Gravgunpickup", function(ply, ent)
	if IsValid(ent) && ent.OnPickedUp then
		ent:OnPickedUp(ply, 1)
	end
end)

hook.Add("PhysgunDrop", "HLR_Physgundrop", function(ply, ent)
	if IsValid(ent) && ent.OnDropped then
		ent:OnDropped(ply, 2)
	end
end)

hook.Add("GravGunOnDropped", "HLR_Gravgundrop", function(ply, ent)
	if IsValid(ent) && ent.OnDropped then
		ent:OnDropped(ply, 1)
	end
end)

hook.Add("EntityTakeDamage", "HLR_BurnDamageUnFreeze", function(ent,dmginfo)
	if IsValid(ent) && (ent:IsPlayer() || ent:IsNPC()) then
		local iPercentFrozen = ent:PercentageFrozen()
		if iPercentFrozen > 0 then
			if dmginfo:IsDamageType(DMG_DIRECT) || dmginfo:IsDamageType(DMG_BURN) then
				ent:UnFreeze(math.Round(dmginfo:GetDamage() *0.5))
			end
		end
	end
end)