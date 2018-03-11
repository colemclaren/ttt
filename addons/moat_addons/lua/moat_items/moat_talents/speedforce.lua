
TALENT.ID = 23

TALENT.Name = 'Speedforce'

TALENT.NameColor = Color(255,255,0)

TALENT.Description = 'Speed is increased by %s_^ for %s seconds after killing a target'

TALENT.Tier = 2

TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}

TALENT.Modifications[1] = {min = 5, max = 15} -- speed percent
TALENT.Modifications[2] = {min = 5, max = 15} -- seconds

TALENT.Melee = false

TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )
	if (GetRoundState() == ROUND_ACTIVE and not MOAT_ACTIVE_BOSS and (victim:Health() - dmginfo:GetDamage() <= 0)) then
		local speed = 1 + ((self.Modifications[1].min + (( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1]))/100)

		attacker:SetNWFloat("speedforce", speed)

		local speed_secs = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])

		timer.Simple(speed_secs, function()
			attacker:SetNWFloat("speedforce", 1)
		end)
	end
end