
TALENT.ID = 88
TALENT.Suffix = "the Zombie"
TALENT.Name = "Zombie"
TALENT.NameColor = Color(0, 255, 128)
TALENT.Description = "Killing a target regenerates %s_^ health over %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 35}
TALENT.Modifications[2] = {min = 10, max = 35}

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local amt = math.Round(self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1])))
    local sec = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])))

    status.Inflict("Predatory", {Time = sec, Amount = amt, Player = att})
end


if (SERVER) then
	local PREDATORY = status.Create "Predatory"
	function PREDATORY:Invoke(data)
		self:CreateEffect "Predatory":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = PREDATORY:CreateEffect "Predatory"
	EFFECT.Message = "Healing"
	EFFECT.Color = Color(221, 101, 101)
	EFFECT.Material = "icon16/heart_add.png"
	function EFFECT:Init(data)
		self.HealTimer = self:CreateTimer(data.Time, data.Amount, self.HealCallback, data)
	end

	function EFFECT:HealCallback(data)
		local att = data.Player
		if (not IsValid(att)) then return end
		if (att:Team() == TEAM_SPEC) then return end
		if (GetRoundState() ~= ROUND_ACTIVE) then return end

		att:SetHealth(math.Clamp(att:Health() + 1, 0, att:GetMaxHealth()))
	end
end