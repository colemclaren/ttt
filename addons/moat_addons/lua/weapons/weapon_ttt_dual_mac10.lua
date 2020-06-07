AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual MAC10s"

if CLIENT then
   SWEP.Slot = 2

   SWEP.Icon = "vgui/ttt/icon_mac"
   SWEP.IconLetter = "l"
end
SWEP.Base = "weapon_ttt_dual_glock"

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_MAC10
SWEP.ENUM = 7

SWEP.Primary.Damage      = 7
SWEP.Primary.Delay       = 0.05
SWEP.Primary.Cone        = 0.12
SWEP.Primary.ClipSize    = 35
SWEP.Primary.ClipMax     = 105
SWEP.Primary.DefaultClip = 35
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 1.6
SWEP.Primary.NumShots    = 2
SWEP.Primary.Sound       = Sound( "Weapon_mac10.Single" )
SWEP.Primary.Range       = 400

SWEP.AutoSpawnable = false

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"

SWEP.DeploySpeed = 3
SWEP.UseHands = false

SWEP.HeadshotMultiplier = 1.4

SWEP.DeploySpeed = 3
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "mac10_reload",
		Time = 3.17143,
	},
}