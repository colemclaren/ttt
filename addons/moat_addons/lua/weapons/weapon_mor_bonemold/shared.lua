
AddCSLuaFile()

SWEP.PrintName = "Bonemold Bow"

SWEP.Base			= "weapon_mor_base_bow"

SWEP.ViewModel      = "models/morrowind/bonemold/longbow/v_bonemold_longbow.mdl"
SWEP.WorldModel   = "models/morrowind/bonemold/longbow/w_bonemold_longbow.mdl"

SWEP.Primary.Damage		= 90
SWEP.Primary.Velocity	= 3000

SWEP.Primary.ClipSize		= 8
SWEP.Primary.ClipMax		= 24 -- keep mirrored to ammo
SWEP.Primary.DefaultClip	= 8
--SWEP.Primary.Automatic	= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"
SWEP.AmmoEnt				= "item_ammo_357_ttt"
SWEP.Secondary.Ammo			= "none"

SWEP.ChargeSpeed = 1.75