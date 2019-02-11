
TALENT.ID = 23
TALENT.Name = 'Speedforce'
TALENT.NameColor = Color(255,255,0)
TALENT.Description = 'Speed is increased by %s_^ for %s seconds after killing a target'
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 15} -- speed percent
TALENT.Modifications[2] = {min = 5, max = 15} -- seconds

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath( victim, inf, attacker, talent_mods )
	local speed = 1 + ((self.Modifications[1].min + (( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1]))/100)
	local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])

	status.Inflict("Speedforce", {Time = sec, Player = attacker, Speed = speed})
end


local STATUS = status.Create "Speedforce"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Speedforce", data.Player)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Speedforce":Invoke(data, data.Time, data.Player)
	end
end

local EFFECT = STATUS:CreateEffect "Speedforce"
EFFECT.Message = "Speedforce"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/group_go.png"
function EFFECT:Init(data)
	local att = data.Player
	att.speedforce = data.Speed
	
	self:CreateEndTimer(data.Time, data)
end

function EFFECT:OnEnd(data)
	if (not IsValid(data.Player)) then return end
	
	local att = data.Player
	att.speedforce = 1
end
