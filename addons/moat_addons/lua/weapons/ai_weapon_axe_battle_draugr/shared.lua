if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "ai_weapon_base_axe_battle"

SWEP.WorldModel = "models/skyrim/weapons/draugr/w_draugrbattleaxe.mdl"
SWEP.itemID = "0001CB64"