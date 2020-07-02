local DamageToBlock = {
	[DMG_BURN] = true,
	[DMG_SLASH] = true,
	[DMG_VEHICLE] = true,
	[DMG_BLAST] = true,
	[DMG_PHYSGUN] = true,
	[DMG_CRUSH] = true,
	[DMG_FALL] = true
}

hook("EntityTakeDamage", function(pl, dmg)
	if (GetGlobal("MOAT_MINIGAME_ACTIVE") or GetRoundState() ~= ROUND_ACTIVE) then
		return
	end

	if (not DamageToBlock[dmg:GetDamageType()]) then
		return
	end

	if (dmg:GetDamageType() == DMG_FALL and ((pl.BlockFallDamage and pl.BlockFallDamage > CurTime()) or (IsValid(pl:GetActiveWeapon()) and pl:GetActiveWeapon():GetClass() == "weapon_ttt_thunder_thighs"))) then
		return true
	end

	local att = dmg:GetAttacker()
	if (IsValid(pl) and pl:IsPlayer() and (pl:IsActiveRole(ROLE_JESTER) or pl:IsActiveTraitor()) and IsValid(att) and att:IsPlayer() and att:GetRole() == ROLE_TRAITOR) then
		if (pl:IsActiveTraitor() and pl == att and dmg:GetDamageType() == DMG_BLAST) then
			return
		end

		return true
	end
end)