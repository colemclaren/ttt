
AddCSLuaFile()

SWEP.HoldType = "ar2"
SWEP.PrintName = "TMP"

SWEP.Slot = 2
SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"
SWEP.Kind = WEAPON_HEAVY
SWEP.ENUM = 7

SWEP.HeadshotMultiplier = 1.4
SWEP.Primary.Damage      = 9
SWEP.Primary.Delay       = 0.035
SWEP.Primary.Cone        = 0.025
SWEP.Primary.ClipSize    = 45
SWEP.Primary.ClipMax     = 135
SWEP.Primary.DefaultClip = 45
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "pistol"
SWEP.Primary.Recoil      = 1.2
SWEP.Primary.Sound       = Sound( "Weapon_TMP.Single" )

SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"

SWEP.DeploySpeed = 1
SWEP.ReloadSpeed = .7
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.16,
	},
	AfterReload = {
		Anim = "idle"
	}
}

function SWEP:ScaleDamage()
end