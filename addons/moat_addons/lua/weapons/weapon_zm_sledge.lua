
AddCSLuaFile()

SWEP.HoldType			= "crossbow"
SWEP.PrintName			= "H.U.G.E-249"

if CLIENT then
   SWEP.Slot				= 2

   SWEP.ViewModelFlip		= false

   SWEP.Icon = "vgui/ttt/icon_m249"
   SWEP.IconLetter = "z"
end

SWEP.Base				= "weapon_tttbase"

SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M249
SWEP.ENUM = 1

SWEP.Primary.Damage         = 10
SWEP.Primary.Delay = 0.048
SWEP.Primary.Cone           = 0.04
SWEP.Primary.ClipSize = 150
SWEP.Primary.ClipMax = 450
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.AutoSpawnable      = true
SWEP.Primary.Recoil			= 1
SWEP.Primary.Sound			= Sound("Weapon_m249.Single")
SWEP.Primary.Range          = 1100
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier = 2.5

SWEP.IronSightsPos = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Animation = "reload",
		ReloadTime = 5.74
	}
}