
TALENT.ID = 4
TALENT.Name = "Accurate"
TALENT.NameColor = Color( 150, 0, 0 )
TALENT.Description = "Accuracy is increased by %s_"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 25 } -- Amount accuracy is increased

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )
	local Mod = self.Modifications[1]
	weapon:SetAccuracy(weapon:GetAccuracy() + Mod.min + (Mod.max - Mod.min) * talent_mods[1])
end