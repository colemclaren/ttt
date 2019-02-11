TALENT = TALENT or MOAT_TALENTS[155]

TALENT.ID = 155
TALENT.Name = "Leech"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to heal %s^ health over %s seconds"
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5 , max = 15}	-- Chance to trigger
TALENT.Modifications[2] = {min = 15, max = 40}	-- Amount to heal
TALENT.Modifications[3] = {min = 30, max = 50}	-- Duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, att, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (chance > math.random() * 100) then
		local amt = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]))
		local sec = math.Round(self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * talent_mods[3]))

		status.Inflict("Leech", {Time = sec, Amount = amt, Player = att})
	end
end


local PREDATORY = status.Create "Leech"
function PREDATORY:Invoke(data)
	if (MOAT_ACTIVE_BOSS) then
		local amount_already = 0

		for _, eff in pairs(data.Player.ActiveEffects) do
			if (eff.Active and eff.Name == "Leech") then
				amount_already = amount_already + 1
				if (amount_already >= 10) then
					return
				end
			end
		end
	end

	self:CreateEffect "Leech":Invoke(data, data.Time, data.Player)
end

local EFFECT = PREDATORY:CreateEffect "Leech"
EFFECT.Message = "Leeching"
EFFECT.Color = Color(0, 255, 0)
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
