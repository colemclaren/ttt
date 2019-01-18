
TALENT.ID = 3

TALENT.Name = "Inferno"

TALENT.NameColor = Color( 255, 0, 0 )

TALENT.NameEffect = "fire"

TALENT.Description = "Each hit has a %s_^ chance to ignite the target for %s seconds and apply 1 damage every 0.2 seconds"

TALENT.Tier = 3

TALENT.LevelRequired = { min = 25, max = 30 }

TALENT.Modifications = {}

TALENT.Modifications[1] = { min = 5, max = 10 } -- Chance to ignite

TALENT.Modifications[2] = { min = 4, max = 8 } -- Ignite time

TALENT.Melee = true

TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )

	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then return end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )

	local random_num = math.Rand( 1, 100 )

	local apply_mod = chance > random_num

	local ignite_time = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )

	if (apply_mod) then

		victim:Ignite(ignite_time)

		victim.ignite_info = {att = dmginfo:GetAttacker(), infl = dmginfo:GetInflictor()}

		timer.Simple(ignite_time + 0.1, function()
			if IsValid(victim) then
				victim.ignite_info = nil
			end
		end)

	end

end