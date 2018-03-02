if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "ai_weapon_base_sword"

SWEP.WorldModel = "models/skyrim/weapons/draugr/w_draugrsword.mdl"
SWEP.itemID = "0002C66F"