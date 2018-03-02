if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "ai_weapon_base_bow"

SWEP.WorldModel = "models/skyrim/weapons/draugr/w_draugrbowskinned.mdl"
SWEP.itemID = "000302CA"