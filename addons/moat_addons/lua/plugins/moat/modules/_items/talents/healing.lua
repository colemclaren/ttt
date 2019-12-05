
TALENT.ID = 18
TALENT.Name = "Healing"
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = "This weapon's covered in top secret medical cream"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 15 }
TALENT.Modifications[1] = { min = 15, max = 40 } -- Amount health is increased

TALENT.Melee = true
TALENT.NotUnique = false

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() == ROUND_PREP or victim:HasGodMode() or GetGlobal("MOAT_MINIGAME_ACTIVE")) then
		return
	end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	if (chance > math.random() * 100) then
		local hp = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )
		attacker:SetHealth(math.Clamp(attacker:Health() + hp, 0, 150))
	end
end