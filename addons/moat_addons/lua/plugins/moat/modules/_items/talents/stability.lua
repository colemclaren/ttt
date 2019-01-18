
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
	if (weapon.Primary.Recoil) then
		weapon.Primary.Recoil = weapon.Primary.Recoil * ( 1 + ( ( self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] ) ) / 100 ) )
	end
end