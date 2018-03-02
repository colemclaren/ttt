
TALENT.ID = 10

TALENT.Name = "Frost"

TALENT.NameColor = Color( 100, 100, 255 )

TALENT.NameEffect = "frost"

TALENT.Description = "Each hit has a %s_^ chance to freeze the target for %s seconds, slowing their speed by ^%s_ percent, and applying 2 damage every ^%s seconds"

TALENT.Tier = 3

TALENT.LevelRequired = { min = 25, max = 30 }

TALENT.Modifications = {}

TALENT.Modifications[1] = { min = 5, max = 10 } // Chance to freeze

TALENT.Modifications[2] = { min = 15, max = 30 } // Freeze time

TALENT.Modifications[3] = { min = 25, max = 50 } // Frozen Speed time

TALENT.Modifications[4] = { min = 5, max = 8 } // Frozen Damage Delay

TALENT.Melee = false

TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then return end

	local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	local randomNum = math.Rand( 1, 100 )
	local applyMod = chanceNum > randomNum

	if (applyMod) then
		local frozenTime = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
		
		local frozenSpeed = (self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * talent_mods[3])) / 100
		
		local frozenDelay = self.Modifications[4].min + ((self.Modifications[4].max - self.Modifications[4].min) * talent_mods[4])
		
		victim.frozenInfo = {att = dmginfo:GetAttacker(), infl = dmginfo:GetInflictor()}
		victim:moatFreeze(frozenTime, frozenSpeed, frozenDelay)
	end
end