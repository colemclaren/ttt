
TALENT.ID = 82
TALENT.Suffix = "the Vulture"
TALENT.Name = "Vulture"
TALENT.NameColor = Color(178, 102, 255)
TALENT.Description = "Players have a %s_^ chance to receive %s ammo after killing a target"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 20, max = 50}	-- Chance to trigger
TALENT.Modifications[2] = {min = 5 , max = 30}	-- Amount of ammo to give

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        local ammo = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])))
        att:GiveAmmo(ammo, inf:GetPrimaryAmmoType(), true)

        net.Start("Moat.Talents.Notify")
            net.WriteUInt(1, 8)
            net.WriteString("Scavenger activated on kill!")
        net.Send(att)
    end
end
