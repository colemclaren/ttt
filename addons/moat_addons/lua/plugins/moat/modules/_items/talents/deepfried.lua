TALENT.ID = 9968
TALENT.Name = "LSD"
TALENT.NameColor = Color(209, 0, 209)
TALENT.Description = "Each hit has a %s_^ chance to fry the target's screen for %s seconds"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 10} -- percent
TALENT.Modifications[2] = {min = 5, max = 20} -- seconds
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Meme Collection"

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then
		return
	end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )
	if (chance > math.random() * 100) then
		local secs = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )
		status.Inflict("LSD", {Time = secs, Player = victim})
	end
end

--
-- Deep Fried Status
--

if (SERVER) then
	util.AddNetworkString "Moat.Talents.DeepFried"

	local STATUS = status.Create "LSD"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Deep Fried", data.Player)
		if (effect) then
			return -- effect:AddTime(data.Time)
		else
			self:CreateEffect"Deep Fried":Invoke(data, data.Time, data.Player)
		end
	end

	local STATUS = status.Create "Fried"
	function STATUS:Invoke(data)
		local effect = self:GetEffectFromPlayer("Deep Fried", data.Player)
		if (effect) then
			return -- effect:AddTime(data.Time)
		else
			self:CreateEffect"Deep Fried":Invoke(data, data.Time, data.Player)
		end
	end

	local EFFECT = STATUS:CreateEffect "Deep Fried"
	EFFECT.Message = "Deep Fried"
	EFFECT.Color = TALENT.NameColor
	EFFECT.Material = "icon16/eye.png"
	function EFFECT:Init(data)
		net.Start "Moat.Talents.DeepFried"
			net.WritePlayer(data.Player)
			net.WriteDouble(data.Time)
		net.Broadcast()

		self:CreateTimer(math.floor(data.Time), math.floor(data.Time) * 2, self.Callback, data)
	end

	function EFFECT:Callback(data)
		local victim = data.Player
		if (not IsValid(victim) or not victim:Alive()) then return end

		victim:ScreenShake(50, 100, 0.5, 100)
	end
end
