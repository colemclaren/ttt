if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "ai_weapon_base_bow"

SWEP.WorldModel = "models/skyrim/weapons/w_falmerbow.mdl"
SWEP.itemID = "00038340"