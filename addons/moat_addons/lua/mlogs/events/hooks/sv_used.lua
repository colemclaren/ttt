/*mlogs.events.hook("EntityFireBullets", function(ent, data)
	if (not IsFirstTimePredicted()) then return end
	if (not ent:IsPlayer()) then return end
	local wep = ent:GetActiveWeapon()
	if (not IsValid(wep)) then return end

	mlogs.log.event(MLOGS_SHOT, {
		["player_id1"] = mlogs.PlayerID(ent),
		["weapon_id"] = mlogs.WeaponID(wep)
	}, ent:EyePos())
end)

mlogs.events.hook("StartCommand", function(pl, cmd)
	if (not IsFirstTimePredicted()) then return end
	if (pl:Team() == TEAM_SPEC) then return end
	if (not cmd:KeyDown(IN_ATTACK)) then return end
	local wep = pl:GetActiveWeapon()
	if (not IsValid(wep)) then return end

	mlogs.log.event(MLOGS_SHOT, {
		["player_id1"] = mlogs.PlayerID(pl),
		["weapon_id"] = mlogs.WeaponID(wep)
	}, pl:EyePos())
end)*/

local weps = weapons.GetList()
for k, v in ipairs(weps) do
	if (not v.ClassName) then continue end
	if (v.ClassName == "weapon_tttbase") then continue end
	
	local t = weapons.GetStored(v.ClassName)
	if (t.__PrimaryAttack) then continue end
	t.__PrimaryAttack = t.PrimaryAttack
	t.PrimaryAttack = function(self)
		if (IsValid(self.Owner)) then
			mlogs.log.event(MLOGS_SHOT, {
				["player_id1"] = mlogs.PlayerID(self.Owner),
				["weapon_id"] = mlogs.WeaponID(self)
			}, self.Owner:EyePos())
		end

		self.__PrimaryAttack(self)
	end
end

/*
mlogs.events.hook("PlayerUse", function(ent, data)
	if (not IsFirstTimePredicted()) then return end
	if (not ent:IsPlayer()) then return end
	local wep = ent:GetActiveWeapon()
	if (not IsValid(wep)) then return end

	mlogs.log.event(MLOGS_USED, {
		["player_id1"] = mlogs.PlayerID(ent), 
		["weapon_id"] = mlogs.WeaponID(wep)
	}, ent:EyePos())
end)
*/