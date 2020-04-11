
TALENT.ID = 2
TALENT.Name = "Stability"
TALENT.NameColor = Color( 0, 255, 0 )
TALENT.Description = "Kick is reduced by %s_"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = -15, max = -20 } -- Amount kick is reduced

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon(weapon, talent_mods)
	local Mod = self.Modifications[1]
	local mult = Mod.min + (Mod.max - Mod.min) * math.min(1, talent_mods[1])
	weapon:SetKick(((1 + weapon:GetKick() / 100) * (1 + mult / 100) - 1) * 100)
end