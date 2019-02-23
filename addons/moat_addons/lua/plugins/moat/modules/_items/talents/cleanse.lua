
TALENT.ID = 18
TALENT.Name = "Cleanse"
TALENT.NameColor = Color(255, 255, 255)
TALENT.Description = "Each kill has a %s_^ chance to cleanse all your active negative effects and make you immune to them for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 50, max = 85}	-- Chance to cleanse
TALENT.Modifications[2] = {min = 10, max = 15}	-- Immunity time

TALENT.Melee = true
TALENT.NotUnique = true

local badTalents = {
	["Infected"] = true,
	["Frozen"] = true,
	["Freezing"] = true,
	["Inferno"] = true,
	["Electrified"] = true,
	["Zapped"] = true
}

function TALENT:OnPlayerDeath(victim, inf, attacker, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    if (chance > math.random() * 100) then
		local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
		status.Inflict("Cleansed", {Time = sec, Player = attacker})

        for _, effect in pairs(attacker.ActiveEffects) do
			if (effect.Active and badTalents[effect.Name]) then
				effect:Reset()
			end
		end
    end
end


local STATUS = status.Create "Cleansed"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Cleansed", data.Player)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Cleansed":Invoke(data, data.Time, data.Player)
	end
end

local EFFECT = STATUS:CreateEffect "Cleansed"
EFFECT.Message = "Cleansed"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/asterisk_yellow.png"
function EFFECT:Init(data)
	local att = data.Player
	att.Cleansed = true
	
	self:CreateEndTimer(data.Time, data)
end

function EFFECT:OnEnd(data)
	if (not IsValid(data.Player)) then return end
	local att = data.Player

	att.Cleansed = nil
end
