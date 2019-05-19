-- Variables that are used on both client and server
SWEP.Category				= "Call Of Duty 4" --Category where you will find your weapons
SWEP.Author					= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.PrintName				= "M4A1"	-- Weapon name (Shown on HUD)
SWEP.Slot					= 2			-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight					= 30		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_c4_m4a1.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/m4a1/w_m4a1.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
--SWEP.Base					= "mw_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminOnly				= false
SWEP.FiresUnderwater 		= false

SWEP.Base 					= "weapon_tttbase"
SWEP.Kind 					= WEAPON_HEAVY
SWEP.AllowDrop 				= true
SWEP.IsSilent 				= false
SWEP.NoSights 				= false
SWEP.AutoSpawnable 			= false

SWEP.Icon = "vgui/ttt/m4icon.png"

if SERVER then
	--resource.AddFile("materials/vgui/ttt/m4icon.png")
end

SWEP.Primary.Sound			= Sound( "Weapon_CM4.Single" )		-- Script that calls the primary fire sound
SWEP.Primary.Delay			= 60 / 650
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.ClipMax			= 90
SWEP.Primary.DefaultClip		= 30		-- Bullets you start with
SWEP.Primary.KickUp				= 0.16		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.16		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.16		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.AmmoEnt 					= "item_ammo_smg1_ttt"
SWEP.Primary.Ammo				= "smg1"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet.
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= false

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more!

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		= 19	-- Base damage per bullet
SWEP.Primary.Spread		= .05	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2.36667,
	},
	DefaultReload = {
		Anim = "reload",
		Time = 2.06667,
	},
}

-- Enter iron sight info and bone mod info below


SWEP.IronSightsPos = Vector(-7.55, 0, 4.6)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-2.3655, 0, 0.7008)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(4.679, -1.441, 3.68)
SWEP.RunSightsAng = Vector(-12.101, 34.5, 0)