AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.HoldType				= "ar2"

/*---------------------------------------------------------
   Name: SWEP:OnRestore()
   Desc: The game has just been reloaded. This is usually the right place
	   to call the GetNetworked* functions to restore the script's values.
---------------------------------------------------------*/
function SWEP:OnRestore()

	self:ResetVariables()
	
	return true
end

/*---------------------------------------------------------
   Name: SWEP:OnRemove()
   Desc: Called just before entity is deleted.
---------------------------------------------------------*/
function SWEP:OnRemove()
	
	self:ResetVariables()
	
	return true
end

/*---------------------------------------------------------
   Name: SWEP:Equip()
   Desc: A player or NPC has picked the weapon up.
---------------------------------------------------------*/
function SWEP:Equip(NewOwner)

	self:ResetVariables()
	
	return true
end

/*---------------------------------------------------------
   Name: SWEP:OnDrop()
   Desc: Weapon was dropped.
---------------------------------------------------------*/
function SWEP:OnDrop()

	self:ResetVariables()

	return true
end