
TALENT.ID = 21
TALENT.Name = 'Desperate Times'
TALENT.NameColor = Color(255,99,71)
TALENT.Description = 'Your weapon will do %s_^ more damage if you are under %s health'
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 20} -- Damage last bullet can do
TALENT.Modifications[2] = {min = 25, max = 75} -- Health

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local health_required = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )

	if (attacker and attacker:Health() <= health_required) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
		dmginfo:ScaleDamage(1 + (increase / 100))
	end
end