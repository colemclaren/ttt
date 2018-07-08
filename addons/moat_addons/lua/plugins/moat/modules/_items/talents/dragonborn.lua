TALENT.ID = 83
TALENT.Name = "Dragonborn"
TALENT.NameColor = Color(255, 255, 255)
TALENT.Description = "Players have a %s_^ chance to be thrown with %sx force when shot with this weapon"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 15}
TALENT.Modifications[2] = {min = 10, max = 100}
TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
    if (GetRoundState() ~= ROUND_ACTIVE or MOAT_ACTIVE_BOSS) then return end

    local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local randomNum = math.Rand(1, 100)
    local applyMod = chanceNum > randomNum

    if (applyMod) then
        local force = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])

        victim:SetVelocity(attacker:GetAimVector() * (100 * force))
    end
end