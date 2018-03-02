
TALENT.ID = 7

TALENT.Name = "Extended Mag"

TALENT.NameColor = Color( 255, 128, 0 )

TALENT.Description = "Max ammo capacity is increased by %s_"

TALENT.Tier = 2

TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}

TALENT.Modifications[1] = { min = 10, max = 35 }

TALENT.Melee = false

TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )

	if ( weapon.Primary.ClipSize and weapon.Primary.DefaultClip and weapon.Primary.ClipMax ) then

		weapon.Primary.ClipSize = math.Round( weapon.Primary.ClipSize * ( 1 + ( ( self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] ) ) / 100 ) ) )

		weapon.Primary.DefaultClip = weapon.Primary.ClipSize

		weapon.Primary.ClipMax = ( weapon.Primary.DefaultClip * 3 )
		
	end

end