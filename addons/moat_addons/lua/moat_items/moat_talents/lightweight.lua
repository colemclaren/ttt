
TALENT.ID = 24

TALENT.Name = 'Lightweight'

TALENT.NameColor = Color(175,238,238)

TALENT.Description = "Weight is reduced by %s_^"

TALENT.Tier = 1

TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}

TALENT.Modifications[1] = {min = -5, max = -15} -- weight

TALENT.Melee = false

TALENT.NotUnique = true

function TALENT:ModifyWeapon( weapon, talent_mods )
	if (weapon.weight_mod) then
		weapon.weight_mod = weapon.weight_mod * ( 1 + ( ( self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] ) ) / 100 ) )
	else
		weapon.weight_mod = 1 + ( ( self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] ) ) / 100 )
	end
	weapon:SetNWFloat("weight_mod", weapon.weight_mod)
end