--[[
// Variables that are used on both client and server

SWEP.Base 				= "weapon_fas_sim_base"
SWEP.Instructions			= "Uses 9mm Russian ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_ots33.mdl"
SWEP.WorldModel			= "models/weapons/b_ots33.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_ots33.Shoot")
SWEP.Primary.Recoil		= 2.6
SWEP.Primary.Damage		= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.023
SWEP.Primary.Delay 		= 0.0666666666666667
SWEP.Primary.ClipSize		= 18					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "SMG1"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_9x18mm"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02
SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."

SWEP.IronSightsPos = Vector (-3.4864, -3.001, 1.4005)
SWEP.IronSightsAng = Vector (0.5583, 0.0261, 0)

SWEP.Speed = 0.65
SWEP.Mass = 0.9
SWEP.WeaponName = "weapon_fas_ots33"
SWEP.WeaponEntName = "sim_fas_ots33"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/pistol_ots33/ots33_fire1.wav")
	util.PrecacheSound("weapons/pistol_ots33/ots33_fire2.wav")
	util.PrecacheSound("weapons/pistol_ots33/ots33_fire3.wav")
	util.PrecacheSound("weapons/pistol_ots33/ots33_fire4.wav")
	util.PrecacheSound("weapons/pistol_ots33/ots33_fire5.wav")
	util.PrecacheSound("weapons/pistol_ots33/ots33_magin.wav")
	util.PrecacheSound("weapons/pistol_ots33/ots33_magout.wav")	
	util.PrecacheSound("weapons/pistol_ots33/ots33_slidestop.wav")
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

   SWEP.Icon = "vgui/ttt/icon_pistol"
   SWEP.IconLetter = "u"
end

SWEP.PrintName = "OTS-33"
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL

SWEP.Base = "weapon_tttbase"
SWEP.Primary.Recoil	= 1
SWEP.Primary.Damage = 25
SWEP.Primary.Delay = 0.22
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 25
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 25
SWEP.Primary.ClipMax = 75
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_ots33.mdl"
SWEP.WorldModel			= "models/weapons/b_ots33.mdl"

SWEP.Primary.Sound = Sound("Weapof_ots33.Shoot")
SWEP.IronSightsPos = Vector (-3.4864, -3.001, 1.4005)
SWEP.IronSightsAng = Vector (0.5583, 0.0261, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 1.5,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2,
	}
}