
TALENT.ID = 11
TALENT.Name = 'Meticulous'
TALENT.NameColor = Color(205, 127, 50)
TALENT.Description = "After killing a target with this weapon, the magazine has a %s_^ chance to refill completely"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 30} -- Chance to refill first clip

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(victim, _, attacker, talent_mods)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
	if (chance > math.random() * 100) then
		local plyWep = attacker:GetActiveWeapon()
		local maxClip1 = plyWep:GetMaxClip1()
		plyWep:SetClip1(maxClip1 + 1) -- +1 because otherwise it doesn't fill it all the way.

		net.Start('moatNotifyMeticulous')
			net.WriteInt(maxClip1, 32)
		net.Send(attacker)
	end
end
