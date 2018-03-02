if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "ai_weapon_base_bow"

SWEP.WorldModel = "models/skyrim/weapons/w_glassbowskinned.mdl"
SWEP.itemID = "000139A5"