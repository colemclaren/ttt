
TALENT.ID = 7
TALENT.Suffix = "the Heavy"
TALENT.Name = "Heavy"
TALENT.NameColor = Color( 255, 128, 0 )
TALENT.Description = "Max ammo capacity is increased by %s_"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 40 } -- Ammo increased by

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon(weapon, talent_mods)
	local Mod = self.Modifications[1]
	local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])
	weapon:SetMagazine(((1 + weapon:GetMagazine() / 100) * (1 + mult / 100) - 1) * 100)
end