
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual TMPs"

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

SWEP.Kind = WEAPON_HEAVY
SWEP.ENUM = 7


--[[
    
SWEP.Primary.Damage      = 8
SWEP.Primary.Delay       = 0.035
SWEP.Primary.Cone        = 0.025
SWEP.Primary.ClipSize    = 40
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 40
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "pistol"
SWEP.Primary.Recoil      = 1.2
SWEP.Primary.Sound       = Sound( "Weapon_TMP.Single" )

]]

SWEP.Primary.Damage      = 5
SWEP.Primary.Delay       = 0.05
SWEP.Primary.Cone        = 0.04
SWEP.Primary.ClipSize    = 68
SWEP.Primary.ClipMax     = 136
SWEP.Primary.DefaultClip = 68
SWEP.Primary.NumShots    = 2
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "pistol"
SWEP.Primary.Recoil      = 3
SWEP.Primary.Sound       = Sound "Weapon_TMP.Single"
SWEP.Primary.Range       = 200
SWEP.Tracer = 3

SWEP.AutoSpawnable = false
SWEP.UseHands = false

SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.ViewModelFlip		= true
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"

SWEP.DeploySpeed = 3
SWEP.WElements = true

SWEP.HeadshotMultiplier = 1.4

SWEP.DeploySpeed = 3
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.16,
	},
}

function SWEP:ScaleDamage()
end