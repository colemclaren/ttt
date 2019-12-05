
TALENT.ID = 13
TALENT.Suffix = "the Trigger"
TALENT.Name = "Trigger"
TALENT.NameColor = Color( 255, 51, 153 )
TALENT.Description = "Firerate is increased by %s_"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 7.99, max = 25 } -- Amount firerate is increased

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:ModifyWeapon(weapon, talent_mods)
	if (weapon.Primary.Delay) then
		local Mod = self.Modifications[1]
		local mult = Mod.min + (Mod.max - Mod.min) * talent_mods[1]

		weapon:SetFirerate((1 - (1 - weapon:GetFirerate() / 100) * (1 - mult / 100)) * 100)
	end
end