
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
	weapon:SetKick(weapon:GetKick() + Mod.min + (Mod.max - Mod.min) * talent_mods[1])
end