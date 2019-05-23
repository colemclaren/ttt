local DamageToBlock = {
	[DMG_BURN] = true,
	[DMG_SLASH] = true,
	[DMG_VEHICLE] = true,
	[DMG_BLAST] = true,
	[DMG_PHYSGUN] = true,
	[DMG_CRUSH] = true
}

hook("EntityTakeDamage", function(pl, dmg)
	if (GetGlobal("MOAT_MINIGAME_ACTIVE") or GetRoundState() ~= ROUND_ACTIVE) then
		return
	end

	if (not DamageToBlock[dmg:GetDamageType()]) then
		return
	end


	local att = dmg:GetAttacker()
	if (IsValid(pl) and pl:IsPlayer() and pl:IsActiveTraitor() and IsValid(att) and att:IsPlayer() and att:GetRole() == ROLE_TRAITOR) then
		if (pl == att and dmg:GetDamageType() == DMG_BLAST) then
			return
		end

		return true
	end
end)