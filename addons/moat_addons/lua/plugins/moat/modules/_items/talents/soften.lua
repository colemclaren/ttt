
TALENT.ID = 28
TALENT.Name = 'Soften'
TALENT.NameColor = Color(100, 90, 100)
TALENT.Description = 'Each hit has a %s_^ chance to make your target take %s_^ more damage for %s^ seconds'
TALENT.Tier = 3
TALENT.LevelRequired = {min = 25, max = 35}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 15, max = 30} -- Chance to trigger
TALENT.Modifications[2] = {min = 10, max = 15} -- Percent damage increase
TALENT.Modifications[3] = {min = 1 , max = 5 } -- Duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(vic, att, info, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (chance > math.random() * 100) then
		local percent = (self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])) / 100
		local duration = self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * talent_mods[3])

		status.Inflict("Soften", {Time = duration, Player = vic, Percent = percent})
	end
end

local STATUS = status.Create "Soften"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Soften", data.Player)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Soften":Invoke(data, data.Time, data.Player)
	end
end

local EFFECT = STATUS:CreateEffect "Soften"
EFFECT.Message = "Softened"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/user_delete.png"
function EFFECT:Init(data)
	local vic = data.Player
	vic.Soften = 1 + data.Percent

	self:CreateEndTimer(data.Time, data)
end

function EFFECT:OnEnd(data)
	if (not IsValid(data.Player)) then return end

	local vic = data.Player
	vic.Soften = nil
end
