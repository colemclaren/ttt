TALENT.ID = 155
TALENT.Name = "Leech"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to heal %s^ health over %s seconds"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 15}
TALENT.Modifications[2] = {min = 15, max = 40}
TALENT.Modifications[3] = {min = 30, max = 50}
TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, att, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local random_num = math.random() * 100
    local apply_mod = chance > random_num

    if (apply_mod) then
    	local amt = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]))
    	local sec = math.Round(self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * talent_mods[3]))

    	net.Start("Moat.Talents.Notify")
    	net.WriteUInt(2, 8)
    	net.WriteString("Leech activated on hit!")
    	net.Send(att)

    	local da_name = "leech" .. att:EntIndex() .. SysTime()

    	timer.Create(da_name, sec/amt, amt, function()
        	if (not att:IsValid() or (att:IsValid() and att:Team() == TEAM_SPEC)) then return end
        	if (GetRoundState() ~= ROUND_ACTIVE) then timer.Remove(da_name) return end

        	att:SetHealth(math.Clamp(att:Health() + 1, 0, att:GetMaxHealth()))
    	end)
	end
end