SWEP.PrintName			= "Plasma Grenade"	
SWEP.Author				= "Slade Xanthas / TTT: Viveret"
SWEP.Instructions		= "Left click to throw, right click to toss."
SWEP.Category			= "TTT"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Base				= "weapon_tttbasegrenade"
SWEP.PrintName			= "Plasma Grenade"	
SWEP.Kind				= WEAPON_NADE
SWEP.CanBuy 			= { ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.InLoadoutFor 		= nil
SWEP.LimitedStock 		= false
SWEP.EquipMenuData = {
   type = "Plasmanade",
   desc = "Not a Halo weapon"
};
SWEP.AllowDrop 			= true
SWEP.IsSilent 			= false
SWEP.NoSights 			= false
SWEP.AutoSpawnable 		= false
SWEP.HoldType			= "grenade"

SWEP.ClassName			= "plasmanade"			
SWEP.Slot				= 3
SWEP.SlotPos			= 1
		
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false
SWEP.UseHands			= true

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Icon 				= "vgui/ttt/icon_nades"
SWEP.ViewModel			= "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_flashbang.mdl"


function SWEP:GetGrenadeName()
   return "plasmanade_proj"
end

--[[function SWEP:PreDrawViewModel( vm, wep, ply )
	vm:SetMaterial( "models/alyx/emptool_glow" )
end

--[[function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	if ( IsValid( vm ) ) then vm:SetMaterial( "models/alyx/emptool_glow" ) end
	return true;
end--]]

--[[function SWEP:Holster()
	local vm = self.Owner:GetViewModel()
	if ( IsValid( vm ) ) then vm:SetMaterial( "" ) end
	return true
end--]]
