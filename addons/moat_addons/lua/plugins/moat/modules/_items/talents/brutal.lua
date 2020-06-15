
TALENT.ID = 6
TALENT.Name = "Brutal"
TALENT.NameColor = Color( 255, 0, 0 )
TALENT.Description = "Headshot damage is increased by %s_ when using this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 11, max = 25 } -- Amount headshot is increased

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:ScalePlayerDamage( victim, attacker, dmginfo, hitgroup, talent_mods )
	if ( hitgroup == HITGROUP_HEAD ) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
		dmginfo:ScaleDamage( 1 + ( increase / 100 ) )
	end
end

