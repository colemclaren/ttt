
TALENT.ID = 9040
TALENT.Name = "Silenced"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "Each round, your weapon has a %s_^ chance to become silenced"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 100, max = 200} -- Chance to trigger

TALENT.Melee = false
TALENT.NotUnique = true

util.AddNetworkString("Talents.Silenced")

silence_prep_cache = {}
hook.Add("TTTBeginRound","ClearSilenced",function()
	silence_prep_cache = {}
end)

function TALENT:ModifyWeapon( weapon, talent_mods )
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local shouldApply = chance > math.random() * 100
	
	if not silence_prep_cache[weapon.Weapon:GetOwner()] then
		silence_prep_cache[weapon.Weapon:GetOwner()] = {}
	end

	if silence_prep_cache[weapon.Weapon:GetOwner()][weapon.Weapon:GetClass()] then
		applyMod = silence_prep_cache[weapon.Weapon:GetOwner()][weapon.Weapon:GetClass()]
	else
		silence_prep_cache[weapon.Weapon:GetOwner()][weapon.Weapon:GetClass()] = applyMod
	end

    if (applyMod) then
    	net.Start("Talents.Silenced")
			net.WriteEntity(weapon)
		net.Broadcast()
		
		weapon.Primary.Sound = Sound("weapons/usp/usp1.wav")
    end
end