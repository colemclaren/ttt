if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName = "Rifle"
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.Icon = "vgui/ttt/icon_scout"
end

SWEP.Base			= "weapon_mor_base_bow"

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= true

SWEP.ViewModel      = "models/morrowind/bonemold/longbow/v_bonemold_longbow.mdl"
SWEP.WorldModel   = "models/morrowind/bonemold/longbow/w_bonemold_longbow.mdl"

SWEP.Primary.Damage		= 40 * 2
SWEP.Primary.Velocity 		= 3000

SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 16 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"
SWEP.Crosshair				= true
SWEP.AmmoEnt = "item_ammo_357_ttt"
SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"