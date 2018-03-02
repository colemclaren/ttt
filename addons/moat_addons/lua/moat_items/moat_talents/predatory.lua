TALENT.ID = 88
TALENT.Name = "Predatory"
TALENT.NameColor = Color(0, 255, 128)
TALENT.Description = "Killing a target regenerates %s_^ health over %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 35}
TALENT.Modifications[2] = {min = 10, max = 35}
TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end

    local amt = math.Round(self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1]))
    local sec = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]))

    net.Start("Moat.Talents.Notify")
    net.WriteUInt(2, 8)
    net.WriteString("Predatory activated on kill!")
    net.Send(att)

    local da_name = "predatory" .. att:EntIndex() .. SysTime()

    timer.Create(da_name, sec/amt, amt, function()
        if (not att:IsValid() or (att:IsValid() and att:Team() == TEAM_SPEC)) then return end
        if (GetRoundState() ~= ROUND_ACTIVE) then timer.Remove(da_name) return end

        att:SetHealth(math.Clamp(att:Health() + 1, 0, att:GetMaxHealth()))
    end)
end