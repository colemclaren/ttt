
TALENT.ID = 5
TALENT.Name = "Sustained"
TALENT.NameColor = Color( 0, 150, 0 )
TALENT.Description = "Killing a target increases your health by %s_ if not max health"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 40 } -- Amount health is increased

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath( victim, inf, attacker, talent_mods )
	if (GetRoundState() ~= ROUND_ACTIVE or MOAT_ACTIVE_BOSS) then return end

	local health_to_add = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	attacker:SetHealth(math.Clamp(attacker:Health() + health_to_add, 0, attacker:GetMaxHealth()))
end