
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
	local pri = weapon.Primary
	local mult = 1 - ( ( self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] ) ) / 100 )

	if (pri.Cone) then
		pri.Cone = pri.Cone * mult
	end

	if (pri.ConeX) then
		pri.ConeX = pri.ConeX * mult
	end

	if (pri.ConeY) then
		pri.ConeY = pri.ConeY * mult
	end
end