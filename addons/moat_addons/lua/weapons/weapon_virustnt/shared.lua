-- Variables that are used on both client and server
	
/*
SWEP.Category				= "GMod Tower Tribute"
SWEP.Author				= "Babel Industries"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Lob a bundle of TNT somewhere, and watch it blow up like a proximity mine despite having a timer on it."
SWEP.PrintName				= "TNT"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 40			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true	-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 2			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "grenade"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles
SWEP.DisableChambering = true
SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_vir_tnt.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_vir_tnt.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_nade_base"
SWEP.Spawnable				= true
SWEP.UseHands = false
SWEP.AdminSpawnable			= true
SWEP.VMPos = Vector(0,10,0)
SWEP.VMAng = Vector(0,75,10)
SWEP.Primary.RPM				= 15		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 11		-- Bullets you start with
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "slam"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("vir_tnt")	--NAME OF ENTITY GOES HERE
SWEP.Velocity = 1000 -- Entity Velocity
SWEP.Delay = 0.1 -- Delay to fire entity
-- enter bone mod and other custom stuff below. Irons aren't used for grenades

SWEP.InspectPos = Vector()
SWEP.InspectAng = Vector()

if GetConVar("tfaUniqueSlots") != nil then
	if not (GetConVar("tfaUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end
*/
AddCSLuaFile()

SWEP.HoldType			= "grenade"
SWEP.PrintName = "TNT"
if CLIENT then
   SWEP.Slot = 3

   SWEP.Icon = "vgui/hud/weapon_virustnt"
end

SWEP.Base				= "weapon_tttbasegrenade"
SWEP.PrintName = "TNT"

SWEP.Spawnable = true
SWEP.AutoSpawnable = false

SWEP.WeaponID = AMMO_SMOKE
SWEP.Kind = WEAPON_NADE

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 65
SWEP.ViewModel				= "models/weapons/v_vir_tnt.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_vir_tnt.mdl"	-- Weapon world model
SWEP.Weight			= 5
SWEP.AutoSpawnable      = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "vir_tnt"
end
