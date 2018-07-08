TALENT.ID = 102
TALENT.Name = "Power Stone"
TALENT.NameColor = Color(128,0,128)
TALENT.Description = "Each shot has a %s_^ chance to deal double damage"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 1, max = 4}
TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods )
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then return end
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	local random_num = math.Rand(1, 100)
	local apply_mod = chance > random_num
	if (apply_mod) then
        dmginfo:ScaleDamage(2)
	end
end