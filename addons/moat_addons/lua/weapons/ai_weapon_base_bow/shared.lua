if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
	
	SWEP.sounds = {
		["Draw"] = "weapons/bow/bow_draw0[1-2].mp3",
		["Sheathe"] = "weapons/bow/bow_sheathe0[1-2].mp3"
	}
end

SWEP.Base = "ai_weapon_base"

SWEP.DelayEquip = 1
SWEP.Primary.Delay = 2