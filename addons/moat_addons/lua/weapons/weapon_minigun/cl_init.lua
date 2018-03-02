include('shared.lua')

SWEP.PrintName			= "Minigun"					// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 2							// Slot in the weapon selection menu
SWEP.SlotPos			= 8							// Position in the slot

// Override this in your SWEP to set the icon in the weapon selection
if (file.Exists("weapon_minigun.vmt","materials/weapons/weapon_minigun.vmt")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_minigun")
end