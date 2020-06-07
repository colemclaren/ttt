AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_famas"
   SWEP.IconLetter = "t"
end

SWEP.PrintName      = "Famas TE"

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Delay = 0.067
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Cone = 0.027
SWEP.Primary.Damage = 17
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90	
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Automatic = true

SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound = Sound( "Weapof_FAMAS.Shoot" )

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_famas.mdl"
SWEP.WorldModel			= "models/weapons/b_famas.mdl"

SWEP.IronSightsPos = Vector (-2.3579, -5.0007, 0.7573)
SWEP.IronSightsAng = Vector (0.028, 0.0006, 0)

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
		Time = 3,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 3.63636,
	}
}
