--[[

// Variables that are used on both client and server

local Walkspeed = CreateConVar ("sim_walk_speed", "250", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Runspeed = CreateConVar ("sim_run_speed", "500", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local WeightMod	= CreateClientConVar("sim_weightmod_t", 1, true, false)		// Enable/Disable

SWEP.Instructions			= "Uses 9mm ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base_reg"
SWEP.HoldType				= "smg"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_cf05.mdl"
SWEP.WorldModel			= "models/weapons/b_changfeng.mdl"
SWEP.ViewModelFOV			= 55
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_cf05.Shoot")
SWEP.Primary.Recoil		= 1.2
SWEP.Primary.Damage		= 17
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay 		= 0.075

SWEP.Primary.ClipSize		= 50					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_9x19mm"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false
SWEP.IronSightsPos = Vector (-2.8864, -3.001, 0.2457)
SWEP.IronSightsAng = Vector (1.3839, 0.0241, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."

SWEP.Speed = 0.6
SWEP.Mass = 0.8
SWEP.WeaponName = "weapon_fas_cf05"
SWEP.WeaponEntName = "sim_fas_cf05"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/sub_cf05/cf05_fire1.wav")
	util.PrecacheSound("weapons/sub_cf05/cf05_fire2.wav")
	util.PrecacheSound("weapons/sub_cf05/cf05_fire3.wav")
	util.PrecacheSound("weapons/sub_cf05/cf05_fire4.wav")
	util.PrecacheSound("weapons/sub_cf05/cf05_fire5.wav")
	util.PrecacheSound("weapons/sub_cf05/cf05_magin.wav")
	util.PrecacheSound("weapons/sub_cf05/cf05_magout.wav")	
	util.PrecacheSound("weapons/sub_cf05/cf05_boltback.wav")
end
]]

AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_mp5"
   SWEP.IconLetter = "x"
end

SWEP.PrintName      = "CF05"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.08
SWEP.Primary.Recoil = 0.6
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 18
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound = Sound("Weapof_cf05.Shoot")

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_cf05.mdl"
SWEP.WorldModel			= "models/weapons/b_changfeng.mdl"

SWEP.IronSightsPos = Vector (-2.8864, -3.001, 0.2457)
SWEP.IronSightsAng = Vector (1.3839, 0.0241, 0)

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.66667,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 4,
	}
}