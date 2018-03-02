-- Variables that are used on both client and server
SWEP.Gun = ("lr-300") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "S.T.A.L.K.E.R" --Category where you will find your weapons
SWEP.Author				= "hammerwolf555"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "LR-300"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
		-- Set false if you want no crosshair from hip
SWEP.DrawCrosshair			= false
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_stalker_lr-300.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_stalker_lr-300.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base 				= "weapon_tttbase" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.Kind 				= WEAPON_EQUIP2
SWEP.CanBuy 				= nil
SWEP.InLoadoutFor 			= nil
SWEP.LimitedStock 			= false
SWEP.AllowDrop 				= true
SWEP.IsSilent 				= true
SWEP.NoSights 				= false
SWEP.AutoSpawnable 			= false



SWEP.Primary.Sound			= Sound("stalker_lr300_shot")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 685		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.ClipMax			= 30
SWEP.Primary.DefaultClip			= 30	-- Bullets you start with
SWEP.Primary.KickUp			= .4				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .4			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= .6		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.AmmoEnt 				= "item_ammo_smg1_ttt"
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom			= 3
SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= true	-- I mean it, only one
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false
SWEP.Icon 						= "vgui/ttt/lr300.png"


SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.5
SWEP.ReticleScale 				= 0.6

SWEP.Primary.Damage		= 17	--base damage per bullet
SWEP.Primary.Spread		= .015	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (10.479, -25.201, 3.92)
SWEP.IronSightsAng = Vector (0.2, 0.4, 0)
SWEP.RunSightsPos = Vector (-7.441, -3.04, 2.16)
SWEP.RunSightsAng = Vector (-4.7, -48.3, -0.301)
