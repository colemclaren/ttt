
TALENT.ID = 13
TALENT.Name = "Trigger Finger"
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
		weapon:SetFirerate(weapon:GetFirerate() + self.Modifications[1].min + (self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1] / 100)
	end
end