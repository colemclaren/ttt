
AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"
SWEP.HoldType			= "shotgun"
SWEP.PrintName = "XM1014"

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_shotgun"
   SWEP.IconLetter = "B"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN
SWEP.ENUM = 2

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 10000
SWEP.Primary.Damage = 7
SWEP.Primary.Cone = 0.05
SWEP.Primary.Delay = 0.65 + 0.2
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 14
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.HeadshotMultiplier = 1.1
SWEP.Primary.LayerMults = {0.2, 0.4, 0.4}

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_xm1014.mdl"
SWEP.Primary.Sound			= Sound( "Weapon_XM1014.Single" )
SWEP.Primary.Recoil			= 7

SWEP.IronSightsPos = Vector(-6.881, -9.214, 2.66)
SWEP.IronSightsAng = Vector(-0.101, -0.7, -0.201)

SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "insert",
		Time = 0.6,
	},
	AfterReload = {
		Anim = "after_reload",
		Time = 0.43333,
	},
	StartReload = {
		Anim = "start_reload",
		Time = 0.7,
	},
}
