
TALENT.ID = 29
TALENT.Name = "Armour Piercing"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Each hit has a %s_^ chance to pierce armour, dealing extra damage to armoured opponents"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 40, max = 60 } -- Percent chance to ignore armour

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (chance > math.random() * 100) then
		victim.ArmourPierced = (victim.ArmourPierced or 0) + 1 -- Will ignore the armour check later
	end
end
