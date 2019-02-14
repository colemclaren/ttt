
TALENT.ID = 18
TALENT.Name = "Cleanse"
TALENT.NameColor = Color(255, 255, 255)
TALENT.Description = "Each kill has a %s_^ chance to cleanse all your active negative effects."
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 25 , max = 75}	-- Chance to cleanse

TALENT.Melee = true
TALENT.NotUnique = true

local badTalents = {
	["Infected"] = true,
	["Frozen"] = true,
	["Freezing"] = true,
	["Inferno"] = true,
	["Electrified"] = true,
	["Zapped"] = true
}

function TALENT:OnPlayerDeath(victim, inf, attacker, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    if (chance > math.random() * 100) then
        for _, effect in pairs(attacker.ActiveEffects) do
			if (effect.Active and badTalents[effect.Name]) then
				effect:Reset()
			end
		end
    end
end
