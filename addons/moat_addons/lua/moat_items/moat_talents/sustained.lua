
TALENT.ID = 5

TALENT.Name = "Sustained"

TALENT.NameColor = Color( 0, 150, 0 )

TALENT.Description = "Killing a target increases your health by %s_ if not max health"

TALENT.Tier = 2

TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}

TALENT.Modifications[1] = { min = 15, max = 40 } // Amount health is increased

TALENT.Melee = true

TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )
	if (GetRoundState() == ROUND_ACTIVE and not MOAT_ACTIVE_BOSS and (victim:Health() - dmginfo:GetDamage() <= 0) ) then

		local health_to_add = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )

		local max_health = attacker:GetMaxHealth()

		local cur_health = attacker:Health()

		local new_health = math.Clamp( cur_health + health_to_add, 0, max_health )

		attacker:SetHealth( new_health )

	end

end