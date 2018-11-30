if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.PrintName = "Daedric Bow"
if( CLIENT ) then
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.Icon = "vgui/ttt/icon_scout"
end

SWEP.Base			= "weapon_mor_base_bow"

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= true

SWEP.ViewModel      = "models/morrowind/daedric/longbow/v_daedric_longbow.mdl"
SWEP.WorldModel   = "models/morrowind/daedric/longbow/w_daedric_longbow.mdl"

SWEP.Primary.Damage		= 110
SWEP.Primary.Velocity 		= 3000

SWEP.Primary.ClipSize = 15
SWEP.Primary.ClipMax = 45 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 15
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"
SWEP.Crosshair				= true
SWEP.AmmoEnt = "item_ammo_357_ttt"
SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"