
TALENT.ID = 100
TALENT.Name = "Space Stone"
TALENT.NameColor = Color(0, 50, 255)
TALENT.Description = "You have a %s_^ chance to have low gravity for %s seconds after killing someone with this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20}	-- Chance to trigger
TALENT.Modifications[2] = {min = 5 , max = 20}	-- Effect duration

TALENT.Melee = true
TALENT.NotUnique = false

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    if (GetRoundState() ~= ROUND_ACTIVE or MOAT_ACTIVE_BOSS) then return end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    if (chance > math.random() * 100) then
        local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
        status.Inflict("Space Stone", {Time = sec, Player = att})
    end
end

local STATUS = status.Create "Space Stone"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Low Gravity", data.Player)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Low Gravity":Invoke(data, data.Time, data.Player)
	end
end

local EFFECT = STATUS:CreateEffect "Low Gravity"
EFFECT.Message = "Low Gravity"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/arrow_up.png"
function EFFECT:Init(data)
	local att = data.Player
	att:SetGravity(0.25)
	
	self:CreateEndTimer(data.Time, data)
end

function EFFECT:OnEnd(data)
	if (not IsValid(data.Player)) then return end
	
	local att = data.Player
	att:SetGravity(1)
end

