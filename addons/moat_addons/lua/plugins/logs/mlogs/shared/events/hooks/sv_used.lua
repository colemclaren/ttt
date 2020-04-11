mlogs.events.hook("PlayerUse", function(pl, ent)
	if (not IsFirstTimePredicted()) then return end
	if (not IsValid(ent)) then return end

	if (IsValid(pl.MLOGS_USED) and pl.MLOGS_USED == ent and pl.MLOGS_USED_TIME and pl.MLOGS_USED_TIME > CurTime() - 2) then
		return
	end

	pl.MLOGS_USED_TIME = CurTime()
	pl.MLOGS_USED = ent

	mlogs.log.event(MLOGS_USED, {
		["player_id1"] = mlogs.PlayerID(pl),
		["str_info"] = ent:GetClass()
	}, ent:EyePos())
end)

mlogs.events.hook("EntityFireBullets", function(ent, data)
	if (not IsFirstTimePredicted()) then return end
	if (not ent:IsPlayer()) then return end
	local wep = ent:GetActiveWeapon()
	if (not IsValid(wep)) then return end

	mlogs.log.event(MLOGS_SHOT, {
		["player_id1"] = mlogs.PlayerID(ent),
		["weapon_id"] = mlogs.WeaponID(wep)
	}, ent:EyePos())
end)

local function LogPrimaryAttack(t)
	if (t.__PrimaryAttack) then return end
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

local weps = weapons.GetList()
for k, v in ipairs(weps) do
	if (not v.ClassName) then continue end
	local t = weapons.GetStored(v.ClassName)
	if (t.Kind == WEAPON_UNARMED) then continue end
	if (t.Kind == WEAPON_HEAVY or t.Kind == WEAPON_PISTOL) then continue end
	if (t.Base == "weapon_tttbase") then
		LogPrimaryAttack(t)
	end
end