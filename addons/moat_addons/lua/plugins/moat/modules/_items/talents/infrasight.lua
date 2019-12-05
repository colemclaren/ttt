
TALENT.ID = 27
TALENT.Suffix = "Infra-Sight"
TALENT.Name = "Infra-Sight"
TALENT.NameColor = Color(255, 255, 0)
TALENT.Description = "Each hit has a %s_^ chance to mark your target for your teammates to see through walls for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 40}	-- Chance to trigger
TALENT.Modifications[2] = {min = 3 , max = 8}	-- Effect duration

TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(vic, att, dmginfo, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (chance > math.random() * 100) then
		local secs = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])

		status.Inflict("Mark", {Time = secs, Player = vic, Attacker = att})
	end
end


if (SERVER) then
	local STATUS = status.Create "Mark"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Mark", data.Player)
		if (effect) then
			effect:AddTime(data.Time)
		else
			self:CreateEffect "Mark":Invoke(data, false)
		end
	end


	local markColor = {
		[0] = Color(0, 255, 0),	-- Innocent
		[1] = Color(255, 0, 0),	-- Traitor
		[2] = Color(0, 0, 255)	-- Detective
	}

	local EFFECT = STATUS:CreateEffect "Mark"
	function EFFECT:Init(data)
		local att = data.Attacker

		local color = markColor[att:GetRole() or ROLE_INNOCENT]

		net.Start("Moat.Talents.Mark")
		net.WriteEntity(data.Player)
		net.WriteColor(color)
		
		if (att:GetTraitor()) then
			net.Send(GetTraitorFilter())
		elseif (att:GetDetective()) then
			net.Broadcast()
		else
			net.Send(att)
		end

		self:CreateEndTimer(data.Time, data)
	end

	function EFFECT:OnEnd(data)
		if (not IsValid(data.Attacker)) then return end
		if (not IsValid(data.Player)) then return end

		local att = data.Attacker

		net.Start("Moat.Talents.Mark.End")
		net.WriteEntity(data.Player)
		
		if (att:GetTraitor()) then
			net.Send(GetTraitorFilter())
		elseif (att:GetDetective()) then
			net.Broadcast()
		else
			net.Send(att)
		end
	end
end