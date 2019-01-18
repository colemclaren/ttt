
TALENT.ID = 86
TALENT.Name = "Fracture"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Limb damage is increased by %s_ when using this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 30 } -- Amount headshot is increased

TALENT.Melee = true
TALENT.NotUnique = true

local da_hitgroups = {
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_HEAD] = true,
	[HITGROUP_GEAR] = true
}

function TALENT:ScalePlayerDamage(victim, attacker, dmginfo, hitgroup, talent_mods)
	if (not da_hitgroups[hitgroup]) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
		dmginfo:ScaleDamage( 1 + ( increase / 100 ) )
	end
end