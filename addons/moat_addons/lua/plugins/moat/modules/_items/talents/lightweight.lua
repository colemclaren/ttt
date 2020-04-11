
TALENT.ID = 24
TALENT.Suffix = "the Feather"
TALENT.Name = "Feather"
TALENT.NameColor = Color(175,238,238)
TALENT.Description = "Weight is reduced by %s_^"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = -5, max = -15} -- weight

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )
	local Mod = self.Modifications[1]
	weapon:SetWeightMod(weapon:GetWeightMod() + Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1]))
end