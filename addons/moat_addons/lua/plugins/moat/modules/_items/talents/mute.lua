
TALENT.ID = 39
TALENT.Name = "Mute"
TALENT.NameColor = Color( 255, 0, 0 )
TALENT.Description = "Each hit has a %s_^ chance to mute the target for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 }	-- Chance to mute
TALENT.Modifications[2] = { min = 4, max = 8 }	-- Mute time

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (MOAT_ACTIVE_BOSS) then return end
	if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	if (chance > math.random() * 100) then
		status.Inflict("Muted", {
			Victim = victim,
			Time = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )
		})
	end
end

local STATUS = status.Create "Muted"
function STATUS:Invoke(data)
	local effect = self:GetEffectFromPlayer("Muted", data.Victim)
	if (effect) then
		effect:AddTime(data.Time)
	else
		self:CreateEffect "Muted":Invoke(data, data.Time, data.Victim)
	end
end

local EFFECT = STATUS:CreateEffect "Muted"
EFFECT.Message = "Muted"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/sound_mute.png"
function EFFECT:Init(data)
	local victim = data.Victim

	victim.Talent_Muted = true
	self:CreateEndTimer(data.Time, data)
end

function EFFECT:OnEnd(data)
	if (not IsValid(data.Victim)) then return end
	local victim = data.Victim

	victim.Talent_Muted = nil
end
