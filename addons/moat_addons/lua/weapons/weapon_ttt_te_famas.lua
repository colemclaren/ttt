--[[
// Variables that are used on both client and server

local Walkspeed = CreateConVar ("sim_walk_speed", "250", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Runspeed = CreateConVar ("sim_run_speed", "500", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local WeightMod	= CreateClientConVar("sim_weightmod_t", 1, true, false)		// Enable/Disable

SWEP.HoldType				= "ar2"
SWEP.Base 				= "weapon_fas_sim_base_reg"
SWEP.Instructions			= "Uses 5.56mm Nato ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.ViewModel			= "models/weapons/a_famas.mdl"
SWEP.WorldModel			= "models/weapons/b_famas.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_FAMAS.Shoot")
SWEP.Primary.Recoil		= 1.8
SWEP.Primary.Damage		= 23
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.005
SWEP.Primary.Delay 		= 0.0666666666666667

SWEP.Primary.ClipSize		= 25					// Size of a clip
SWEP.Primary.DefaultClip	= 0			// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_556"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-2.3579, -5.0007, 0.7573)
SWEP.IronSightsAng = Vector (0.028, 0.0006, 0)
SWEP.RunArmOffset 		= Vector (1.7661, -3.2645, 1.9996)
SWEP.RunArmAngle	 		= Vector (-19.3086, 29.9962, 0)

SWEP.Type				= 1
SWEP.Mode				= true

SWEP.Speed = 0.6
SWEP.Mass = 0.75
SWEP.WeaponName = "weapon_fas_famas"
SWEP.WeaponEntName = "sim_fas_famas"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/ar_famas/famas_fire1.wav")
	util.PrecacheSound("weapons/ar_famas/famas_fire2.wav")
	util.PrecacheSound("weapons/ar_famas/famas_fire3.wav")
	util.PrecacheSound("weapons/ar_famas/famas_fire4.wav")
	util.PrecacheSound("weapons/ar_famas/famas_fire5.wav")
	util.PrecacheSound("weapons/ar_famas/famas_magout.wav")
	util.PrecacheSound("weapons/ar_famas/famas_magin.wav")
	util.PrecacheSound("weapons/ar_famas/famas_cock.wav")
end

/*---------------------------------------------------------
   Name: SWEP:DeployAnimation()
---------------------------------------------------------*/
function SWEP:DeployAnimation()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end
]]

AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_famas"
   SWEP.IconLetter = "t"
end

SWEP.PrintName      = "Famas TE"

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Delay = 0.067
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Cone = 0.025
SWEP.Primary.Damage = 17
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.HeadshotMultiplier = 2

SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound = Sound( "Weapof_FAMAS.Shoot" )

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_famas.mdl"
SWEP.WorldModel			= "models/weapons/b_famas.mdl"

SWEP.IronSightsPos = Vector (-2.3579, -5.0007, 0.7573)
SWEP.IronSightsAng = Vector (0.028, 0.0006, 0)

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false