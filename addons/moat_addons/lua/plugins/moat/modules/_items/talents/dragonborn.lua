
TALENT.ID = 83
TALENT.Suffix = "the DRAGON"
TALENT.Name = "Dragonborn"
TALENT.NameColor = Color(255, 255, 255)
TALENT.Description = "Players have a %s_^ chance to be thrown with %sx force when shot with this weapon"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5 , max = 15}	-- Chance to push
TALENT.Modifications[2] = {min = 10, max = 100}	-- Force of the push

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
    if (MOAT_ACTIVE_BOSS) then
        return
    end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        local force = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2]))

        victim:SetVelocity(attacker:GetAimVector() * (100 * force))
        victim.was_pushed = {
            att = attacker,
            t = CurTime() + 5,
            wep = attacker:GetActiveWeapon():GetClass()
        }
    end
end