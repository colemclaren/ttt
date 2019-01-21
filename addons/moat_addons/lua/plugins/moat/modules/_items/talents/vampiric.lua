TALENT.ID = 156
TALENT.Name = "Vampiric"
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to steal %s_^ of the damage you deal"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 20 , max = 40}	-- Chance to trigger
TALENT.Modifications[2] = {min = 15, max = 30}	-- Amount to heal

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, att, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (chance > math.random() * 100) then
		local pct = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]) / 100

		att:SetHealth(math.Clamp(att:Health() + math.max(victim:Health(), dmginfo:GetDamage()) * pct, 0, att:GetMaxHealth()))
	end
end