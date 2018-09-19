
TALENT.ID = 9040
TALENT.Name = "Silenced"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "Your weapon has a %s_^ chance to become silenced each round"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 45, max = 65}
TALENT.Melee = false
TALENT.NotUnique = true

util.AddNetworkString("Talents.Silenced")
--s
function silence_weapon_talent(weapon)
	net.Start("Talents.Silenced")
	net.WriteEntity(weapon)
	net.Broadcast()
end

function TALENT:ModifyWeapon( weapon, talent_mods )
    local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local randomNum = math.Rand(1, 100)
    local applyMod = chanceNum > randomNum

    if (applyMod) then
    	silence_weapon_talent(weapon.Weapon)
    end
end