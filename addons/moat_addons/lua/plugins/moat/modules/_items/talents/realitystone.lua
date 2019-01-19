
TALENT.ID = 101
TALENT.Name = "Reality Stone"
TALENT.NameColor = Color(255, 50, 50)
TALENT.Description = "You have a %s_^ chance to go transparent for %s seconds after killing someone with this weapon"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20}	-- Chance to trigger
TALENT.Modifications[2] = {min = 5 , max = 20}	-- Transparent time

TALENT.Melee = true
TALENT.NotUnique = false

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    if (GetRoundState() ~= ROUND_ACTIVE or MOAT_ACTIVE_BOSS or MOAT_MINIGAME_OCCURING) then return end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    if (chance > math.random() * 100) then
        local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
		status.Inflict("Reality Stone", {Time = sec, Player = att})
    end
end

local STATUS = status.Create "Reality Stone"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Transparent", data.Player)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Transparent":Invoke(data, data.Time, data.Player)
	end
end

local EFFECT = STATUS:CreateEffect "Transparent"
EFFECT.Message = "Transparent"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/layers.png"
function EFFECT:Init(data)
	local att = data.Player
	att:SetRenderMode(RENDERMODE_TRANSALPHA)
    att:SetColor(Color(255,255,255,50))
	
	self:CreateEndTimer(data.Time, data)
end

function EFFECT:OnEnd(data)
	if (not IsValid(data.Player)) then return end
	
	local att = data.Player
	att:SetRenderMode(RENDERMODE_NORMAL)
	att:SetColor(Color(255,255,255,255))
end
