--[[
// Variables that are used on both client and server
SWEP.Instructions			= "Uses 7.62mm Nato ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base"
SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_m14.mdl"
SWEP.WorldModel			= "models/weapons/b_m14.mdl"
SWEP.ViewModelFOV			= 55

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_M14.Shoot")
SWEP.Primary.Recoil		= 2.1
SWEP.Primary.Damage		= 47
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.004
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 20					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_762x51"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-2.6232, -5.001, 1.8408)
SWEP.IronSightsAng = Vector (-0.2341, 0.0351, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."

SWEP.Speed = 0.6
SWEP.Mass = 0.75
SWEP.WeaponName = "weapon_fas_m14"
SWEP.WeaponEntName = "sim_fas_m14"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/ar_m14/m14_fire1.wav")
    	util.PrecacheSound("weapons/ar_m14/m14_fire2.wav")
    	util.PrecacheSound("weapons/ar_m14/m14_fire3.wav")
    	util.PrecacheSound("weapons/ar_m14/m14_fire4.wav")
    	util.PrecacheSound("weapons/ar_m14/m14_fire5.wav")
    	util.PrecacheSound("weapons/ar_m14/m14_boltcatch.wav")
	util.PrecacheSound("weapons/ar_m14/m14_magout.wav")
	util.PrecacheSound("weapons/ar_m14/m14_magin.wav")
	util.PrecacheSound("weapons/ar_m14/m14_charge.wav")
	util.PrecacheSound("weapons/ar_m14/m14_check.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() <= 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("shoot_last"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
end
]]


AddCSLuaFile()

SWEP.HoldType     = "ar2"

if CLIENT then
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_m16"
   SWEP.IconLetter = "w"
end

SWEP.PrintName      = "M14A1"
SWEP.Base       = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M16

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.24
SWEP.Primary.Recoil = 0.9
SWEP.Primary.Cone = 0.015
SWEP.Primary.Damage = 29
SWEP.HeadshotMultiplier = 3.3
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV   = 55
SWEP.ViewModel			= "models/weapons/a_m14.mdl"
SWEP.WorldModel			= "models/weapons/b_m14.mdl"

SWEP.Primary.Sound = Sound("Weapof_M14.Shoot")

SWEP.IronSightsPos = Vector (-2.6232, -5.001, 1.8408)
SWEP.IronSightsAng = Vector (-0.2341, 0.0351, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 3,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 4,
	}
}

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(60, 0.5)
   	else
      	self.Owner:SetFOV(0, 0.2)
   	end
end