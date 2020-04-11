TALENT = TALENT or MOAT_TALENTS[16]

TALENT.ID = 16
TALENT.Name = "Vampiric"
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to steal %s_^ of the damage you deal"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40 , max = 60}	-- Chance to trigger
TALENT.Modifications[2] = {min = 25, max = 75}	-- Amount to heal

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, att, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local pct = (self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))) / 100

		att:SetHealth(math.Clamp(att:Health() + math.min(victim:Health(), dmginfo:GetDamage()) * pct, 0, att:GetMaxHealth()))
	end
end