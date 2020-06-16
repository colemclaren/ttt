
include "deepfried.lua"
TALENT.Tier = 1
TALENT.ID = 9971
TALENT.Name = "Deep Fried XL"
TALENT.NameColor = Color(209, 0, 209)
TALENT.Description = "Each hit has a %s_^ chance to fry the target's screen for %s seconds"
TALENT.LevelRequired = {min = 1, max = 1}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 10}
TALENT.Modifications[2] = {min = 25, max = 50}
TALENT.NotUnique = false
TALENT.Melee = true
TALENT.Collection = "Omega Collection"

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then
		return
	end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		local secs = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		status.Inflict("Deep Fried", {Time = secs, Player = victim})
	end
end