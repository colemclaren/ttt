
TALENT.ID = 1
TALENT.Name = "Close Quarters"
TALENT.NameColor = Color( 0, 255, 255 )
TALENT.Description = "Damage is increased by +%s_^ when closer than %s feet to the target"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 } -- Amount damage is increased by
TALENT.Modifications[2] = { min = 8, max = 13 } -- Amount of feet

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )
	local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	local range = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )
	local max_dist = range * 50
	
	if (victim:GetPos():DistToSqr(attacker:GetPos()) <= (max_dist * max_dist)) then
		dmginfo:ScaleDamage(1 + (increase / 100))
	end
end

