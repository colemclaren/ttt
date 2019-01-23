
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

local silencedSound = Sound("weapons/usp/usp1.wav")

function TALENT:ModifyWeapon( weapon, talent_mods )
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	local applyMod = chance > math.random() * 100

	local _weapon = weapon.Weapon
	local _owner = _weapon:GetOwner()
	local _class = _weapon:GetClass()

	if not silence_prep_cache[_owner] then
		silence_prep_cache[_owner] = {}
	end

	if silence_prep_cache[_owner][_class] then
		applyMod = silence_prep_cache[_owner][_class]
	else
		silence_prep_cache[_owner][_class] = applyMod
	end

	if (applyMod) then
		net.Start("Talents.Silenced")
			net.WriteEntity(_weapon)
		net.Broadcast()

		_weapon.Primary.Sound = silencedSound
	end
end