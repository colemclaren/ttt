
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual H.U.G.E-249s"
SWEP.UseHands = false

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

if CLIENT then
   SWEP.Slot				= 2

   SWEP.ViewModelFlip		= false

   SWEP.Icon = "vgui/ttt/icon_m249"
   SWEP.IconLetter = "z"
end


SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M249
SWEP.ENUM = 1

SWEP.Primary.Damage = 2
SWEP.Primary.Delay = 0.03
SWEP.Primary.Cone = 0.09
SWEP.Primary.ClipSize = 200
SWEP.Primary.ClipMax = 600
SWEP.Primary.DefaultClip	= 600
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AirboatGun"
SWEP.Primary.NumShots = 2
SWEP.AutoSpawnable      = false
SWEP.Primary.Recoil			= 1.9
SWEP.Primary.Sound			= Sound("Weapon_m249.Single")

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 55
SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier = 3

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 5.73333,
	},
}