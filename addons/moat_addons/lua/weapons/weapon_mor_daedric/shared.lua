AddCSLuaFile()

SWEP.PrintName = "Daedric Bow"

SWEP.Base			= "weapon_mor_base_bow"

SWEP.ViewModel      = "models/morrowind/daedric/longbow/v_daedric_longbow.mdl"
SWEP.WorldModel   = "models/morrowind/daedric/longbow/w_daedric_longbow.mdl"

SWEP.Primary.Damage		= 110
SWEP.Primary.Velocity	= 3000

SWEP.Primary.ClipSize		= 10
SWEP.Primary.ClipMax		= 30 -- keep mirrored to ammo
SWEP.Primary.DefaultClip	= 10
--SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"
SWEP.AmmoEnt				= "item_ammo_357_ttt"
SWEP.Secondary.Ammo			= "none"

SWEP.ChargeSpeed = 2.5