mlogs.events.hook("EntityFireBullets", function(ent, data)
	if (not IsFirstTimePredicted()) then return end
	if (not ent:IsPlayer()) then return end
	local wep = ent:GetActiveWeapon()
	if (not IsValid(wep)) then return end

	mlogs.log.event(MLOGS_FIRE, {mlogs.PlayerID(ent), mlogs.WeaponID(wep)}, ent:EyePos())
end)