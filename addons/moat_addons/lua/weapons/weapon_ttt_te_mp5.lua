--[[
// Variables that are used on both client and server
SWEP.Instructions			= "Uses 9mm ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base"
SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_mp5.mdl"
SWEP.WorldModel			= "models/weapons/b_mp5.mdl"
SWEP.ViewModelFOV			= 60
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_MP5.Shoot")
SWEP.Primary.Recoil		= 1
SWEP.Primary.Damage		= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.01
SWEP.Primary.Delay 		= 0.075

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "SMG1"

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

SWEP.IronSightsPos = Vector (-2.6316, -3, 1.5211)
SWEP.IronSightsAng = Vector (0.3429, -1.1858, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Burst				= true
SWEP.BurstShots			= 3
SWEP.BurstDelay			= 0.06
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 3

SWEP.Type				= 3
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to burst fire mode."
SWEP.data.Delay			= 0.5
SWEP.data.Cone			= 1
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 1

SWEP.Speed = 0.6
SWEP.Mass = 0.8
SWEP.WeaponName = "weapon_fas_mp5"
SWEP.WeaponEntName = "sim_fas_mp5"
/*--------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/mp5savy/mp5-1.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end

]]

AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_mp5"
   SWEP.IconLetter = "x"
end
SWEP.RenderGroup = RENDERGROUP_TRANSLUCENT
SWEP.PrintName      = "MP5 TE"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Delay = 0.08
SWEP.Primary.Recoil = 1.2
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 18
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound = Sound( "Weapof_MP5.Shoot" )

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
SWEP.ViewModel			= "models/weapons/a_mp5.mdl"
SWEP.WorldModel			= "models/weapons/b_mp5.mdl"

SWEP.IronSightsPos = Vector (-2.6316, -3, 1.5211)
SWEP.IronSightsAng = Vector (0.3429, -1.1858, 0)

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.3,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2.58333,
	}
}
