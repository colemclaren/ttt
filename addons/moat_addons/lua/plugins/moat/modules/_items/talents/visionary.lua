
TALENT.ID = 81
TALENT.Name = "Visionary"
TALENT.NameColor = Color(255, 255, 0)
TALENT.Description = "After killing a player, you have a %s_^ chance to see players within %s^ feet through walls for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 40}	-- Chance to trigger
TALENT.Modifications[2] = {min = 10, max = 100}	-- Player distance
TALENT.Modifications[3] = {min = 3 , max = 10}	-- Effect duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (chance > math.random() * 100) then
		local feet = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
		local secs = self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * talent_mods[3])

		status.Inflict("Visionary", {Time = secs, Player = att, Radius = feet})
	end
end


local STATUS = status.Create "Visionary"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Visionary", data.Player)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Visionary":Invoke(data, data.Time, data.Player)
	end
end

local EFFECT = STATUS:CreateEffect "Visionary"
EFFECT.Message = "Visionary"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/eye.png"
function EFFECT:Init(data)
	local att = data.Player

	net.Start("Moat.Talents.Visionary")
	net.WriteDouble(data.Time)
	net.WriteDouble(data.Radius)
	net.Send(att)

	self:CreateEndTimer(data.Time, data)
end

function EFFECT:OnEnd(data)
	if (not IsValid(data.Player)) then return end

	local att = data.Player

	net.Start("Moat.Talents.Visionary")
	net.WriteDouble(0)
	net.WriteDouble(0)
	net.Send(att)
end
