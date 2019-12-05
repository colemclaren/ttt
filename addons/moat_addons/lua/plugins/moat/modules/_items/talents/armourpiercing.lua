
TALENT.ID = 29
TALENT.Suffix = "Penetration"
TALENT.Name = "Penetration"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Detectives and traitors under armor equipment are defenseless to bullets"
TALENT.Tier = 1
TALENT.LevelRequired = { min = 5, max = 10 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 40, max = 60 } -- Percent chance to ignore armour

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (true) then -- if (chance > math.random() * 100) then
		-- Will ignore the armour check later
		victim.ArmourPierced = true
	end
end
