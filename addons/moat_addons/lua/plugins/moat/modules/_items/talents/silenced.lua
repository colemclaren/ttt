
TALENT.ID = 9040
TALENT.Name = "Silenced"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "Every shot is silenced"
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
	local _weapon = weapon.Weapon

	net.Start("Talents.Silenced")
		net.WriteEntity(_weapon)
	net.Broadcast()

	_weapon.Primary.Sound = silencedSound
end