--[[
// Variables that are used on both client and server
SWEP.Instructions			= "Uses 10mm Auto ammo, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base"
SWEP.HoldType				= "pistol"
SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_glock20.mdl"
SWEP.WorldModel			= "models/weapons/b_glock20.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_Glock20.Shoot")
SWEP.Primary.Recoil		= 3
SWEP.Primary.Damage		= 23
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.021
SWEP.Primary.Delay 		= 0.15

SWEP.Primary.ClipSize		= 15					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_10mm"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false
SWEP.IronSightsPos = Vector (-2.3764, -3.001, 1.6042)
SWEP.IronSightsAng = Vector (0.0412, 0.0164, 0)

SWEP.Speed = 0.6
SWEP.Mass = 0.95
SWEP.WeaponName = "weapon_fas_glock20"
SWEP.WeaponEntName = "sim_fas_glock20"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/pistol_glock20/glock20_fire1.wav")
	util.PrecacheSound("weapons/pistol_glock20/glock20_fire2.wav")
	util.PrecacheSound("weapons/pistol_glock20/glock20_fire3.wav")
	util.PrecacheSound("weapons/pistol_glock20/glock20_fire4.wav")
	util.PrecacheSound("weapons/pistol_glock20/glock20_fire5.wav")
	util.PrecacheSound("weapons/pistol_glock20/glock20_magin.wav")
	util.PrecacheSound("weapons/pistol_glock20/glock20_magout.wav")	
	util.PrecacheSound("weapons/pistol_glock20/glock20_sliderelease.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() <= 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
end
]]


AddCSLuaFile()

SWEP.HoldType = "pistol"


if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/icon_glock"
   SWEP.IconLetter = "c"
end

SWEP.PrintName = "Glock TE"
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK

SWEP.Base = "weapon_tttbase"
SWEP.Primary.Recoil	= 0.9
SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.10
SWEP.Primary.Cone = 0.028
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 55
SWEP.ViewModel			= "models/weapons/a_glock20.mdl"
SWEP.WorldModel			= "models/weapons/b_glock20.mdl"

SWEP.Primary.Sound = Sound("Weapof_Glock20.Shoot")

SWEP.IronSightsPos = Vector (-2.3764, -3.001, 1.6042)
SWEP.IronSightsAng = Vector (0.0412, 0.0164, 0)

SWEP.HeadshotMultiplier = 1.75

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 1.66667,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2.33333,
	}
}
