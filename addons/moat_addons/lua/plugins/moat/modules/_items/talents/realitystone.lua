TALENT.ID = 101
TALENT.Name = "Reality Stone"
TALENT.NameColor = Color(255, 50, 50)
TALENT.Description = "You have a %s_^ chance to go transparent for %s seconds after killing someone with this weapon"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20}
TALENT.Modifications[2] = {min = 5, max = 20}
TALENT.Melee = true
TALENT.NotUnique = false

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
	local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])

	if (chanceNum > math.random() * 100) then
		status.Inflict("Reality Stone", {
			Time = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]),
			Player = att
		})
	end
end


local STATUS = status.Create "Reality Stone"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Invisible", data.Player)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Invisible":Invoke(data, data.Time, data.Player)
	end
end

local EFFECT = STATUS:CreateEffect "Invisible"
EFFECT.Message = "Invisible"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/contrast_low.png"
function EFFECT:Init(data)
	self:CreateEndTimer(data.Time, data)
	local att = data.Player
	if (not IsValid(att)) then return end

	att:SetRenderMode(RENDERMODE_TRANSALPHA)
	att:SetColor(Color(255, 255, 255, 50))
	D3A.Chat.SendToPlayer2(att, Color(0, 255, 0), "You are now transparent for ", Color(255, 0, 0), data.Time or "0", Color(0, 255, 0), " seconds!")
end

function EFFECT:OnEnd(data)
	local att = data.Player
	if (not IsValid(att)) then return end

	att:SetRenderMode(RENDERMODE_NORMAL)
	att:SetColor(Color(255, 255, 255, 255))
	D3A.Chat.SendToPlayer2(att, Color(255, 0, 0), "You are no longer transparent!")
end
