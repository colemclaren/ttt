TALENT.ID = 39
TALENT.Name = "Swift"
TALENT.NameColor = Color(102, 255, 255)
TALENT.Description = "Reloading is %s_ faster"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 25, max = 200}

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )
	local Mod = self.Modifications[1]
	local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])
	--weapon:SetReloadrate(1 + (1 + weapon:GetReloadrate() / 100) * (1 + mult / 100)) 2.555
	--weapon:SetReloadrate(weapon:GetReloadrate() * (1 + mult / 100)) 0
	--weapon:SetReloadrate(weapon:GetReloadrate() * ((mult / 100) + 1))
	--weapon:SetReloadSpeed(weapon:GetReloadrate() * ((mult / 100) + 1))
	weapon:SetReloadrate(mult)
end