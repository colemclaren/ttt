
TALENT.ID = 8
TALENT.Name = "Steroids"
TALENT.NameColor = Color( 255, 0, 0 )
TALENT.Description = "Damage is increased by %s_^ for %s seconds after killing with this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 15 } -- Percent damage is increased by
TALENT.Modifications[2] = { min = 9, max = 12 }	-- Damage time

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(victim, _, attacker, talent_mods)
	status.Inflict("Steroids", {
		Player = attacker,
		Weapon = attacker:GetActiveWeapon(),
		Time = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])),
		Percent = 1 + ((self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / 100)
	})
end


if (SERVER) then
	local STATUS = status.Create "Steroids"
	function STATUS:Invoke(data)
		self:CreateEffect "Damaging":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = STATUS:CreateEffect "Damaging"
	EFFECT.Message = "Damaging"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/anchor.png"
	function EFFECT:Init(data)
		local curWeapon = data.Weapon.Primary

		if (not curWeapon.BaseDamage) then
			curWeapon.BaseDamage = curWeapon.Damage
		end

		curWeapon.AdrenalineStacks = (curWeapon.AdrenalineStacks or 0) + 1
		curWeapon.Damage = curWeapon.BaseDamage + (curWeapon.AdrenalineStacks * data.Percent)

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Weapon)) then return end

		local curWeapon = data.Weapon.Primary

		curWeapon.AdrenalineStacks = math.max(curWeapon.AdrenalineStacks - 1, 0)
		curWeapon.Damage = curWeapon.BaseDamage * (data.Percent ^ curWeapon.AdrenalineStacks)
	end
end