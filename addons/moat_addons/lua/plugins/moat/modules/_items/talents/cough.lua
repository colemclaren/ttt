TALENT.ID = 25
TALENT.Name = "Cough"
TALENT.NameColor = Color(255, 0, 127)
TALENT.Description = "Each hit has a %s_^ chance to make your target cough with a power of %s^"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 25} -- Chance to trigger
TALENT.Modifications[2] = {min = 50, max = 100} -- Cough power

TALENT.Melee = true
TALENT.NotUnique = false

TALENT.Collection = "Omega Collection"

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
	if (chance > math.random() * 100) then
		local power = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * math.min(1, talent_mods[2]) )
		
		status.Inflict("Cough", {
			Player = victim,
			Power = power,
		})
	end
end

if (SERVER) then
	local STATUS = status.Create "Cough"
	function STATUS:Invoke(data)
		self:CreateEffect "Cough":Invoke(data, data.Time, data.Player)
	end

	local EFFECT = STATUS:CreateEffect "Cough"
	EFFECT.Message = "Coughing"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/user_comment.png"
	function EFFECT:Init(data)
		local amount = math.floor(data.Power / 15) -- 6 times at 100 power, 3 times at 50 power
		self:CreateTimer(1.5, amount, self.Callback, data)
	end

	function EFFECT:Callback(data)
		local vic = data.Player
		if (not IsValid(vic)) then return end
		if (not vic:Alive()) then return end
		
		local power = data.Power
		local angle = vic:GetAngles()
		angle.x = angle.x + (math.Rand(-1, 1) * (power / 12))
		angle.y = angle.y + (math.Rand(-1, 1) * (power / 12))

		vic:SetAngles(angle)
		vic:ScreenShake(power)
		vic:EmitSound("ambient/voices/cough" .. math.random(4) .. ".wav", math.min(300 + power, 511), math.min(100 + (power / 2), 255))
		
		data.Power = power / 1.2
	end
end