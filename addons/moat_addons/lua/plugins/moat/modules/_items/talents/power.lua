
TALENT.ID = 12
TALENT.Suffix = "Provident"
TALENT.Name = 'Provident'
TALENT.NameColor = Color(0, 123, 181)
TALENT.Description = 'Each bullet has a 40_ chance to do %s_^ more damage'
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 15, max = 30} -- Damage last bullet can do

TALENT.Melee = false
TALENT.NotUnique = true

/*
function TALENT:OnPlayerHit(victim, attacker, dmgInfo, talent_mods)
	local plyWep = attacker:GetActiveWeapon()
	local currentClip = plyWep:Clip1()
	if (currentClip == 1) then
		local damageIncrease = (self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))) / 100
		local damageToAdd = dmgInfo:GetDamage() * damageIncrease
		dmgInfo:AddDamage(damageToAdd)
	end
end*/

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (math.random() < 0.4) then
		local increase = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * math.min(1, talent_mods[1]) )
		dmginfo:ScaleDamage(1 + (increase / 100))
	end
end
