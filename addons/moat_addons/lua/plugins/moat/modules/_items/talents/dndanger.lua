
TALENT.ID = 14
TALENT.Suffix = "Endanger"
TALENT.Name = 'Endanger'
TALENT.NameColor = Color(41, 171, 135)
TALENT.Description = 'Damage is increased by %s_^ when more than %s feet from the target'
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20} -- Percent of damage increased by range
TALENT.Modifications[2] = {min = 25, max = 40} -- Feet Difference

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then return end

	local range = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
	local max_dist = range * 50

	if (victim:GetPos():DistToSqr(attacker:GetPos()) >= (max_dist * max_dist)) then
		local damageIncrease = (self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])) / 100
		dmginfo:ScaleDamage(1 + damageIncrease)
	end
end

