TALENT.ID = 9969
TALENT.Suffix = "Juan"
TALENT.Name = "Juan"
TALENT.NameColor = Color(255, 119, 0)
TALENT.Description = "Damage is increased by %s_^ but you only have 1 bullet per clip"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 1, max = 1}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 25, max = 75}
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Omega Collection"

function TALENT:ModifyWeapon(weapon, talent_mods)
	if (weapon.Primary.ClipSize and weapon.Primary.DefaultClip and weapon.Primary.ClipMax) then
		local original = weapon.Primary.ClipSize

		weapon.Primary.ClipSize = 1
		weapon.Primary.DefaultClip = original * 3
		weapon.Primary.ClipMax = 1
	end
end

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	dmginfo:ScaleDamage(1 + (increase / 100))
end