
TALENT.ID = 17
TALENT.Name = "Tug of War"
TALENT.NameColor = Color(200, 200, 200)
TALENT.Description = "Players have a %s_^ chance to be pulled with %sx force when shot with this weapon"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5 , max = 15}	-- Chance to pull
TALENT.Modifications[2] = {min = 10, max = 100}	-- Force of the pull

TALENT.Melee = true
TALENT.NotUnique = true

local angle180 = Angle(0, 180, 0)

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
    if (MOAT_ACTIVE_BOSS) then
        return
    end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    if (chance > math.random() * 100) then
        local force = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
        local v = attacker:GetAimVector()
        v:Rotate(angle180)
        victim:SetVelocity(v * (10 * force))
    end
end