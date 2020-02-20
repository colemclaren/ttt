
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual Shotguns"

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

if CLIENT then
   SWEP.Slot      = 2

   SWEP.Icon = "vgui/ttt/icon_m3s90"
   SWEP.IconLetter = "B"
end

SWEP.Kind = WEAPON_HEAVY
SWEP.Primary.Range = 900
SWEP.Primary.Damage = 6.5
SWEP.Primary.Delay = 1.4
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = 12
SWEP.Primary.ClipMax = 36
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Buckshot"
SWEP.Primary.NumShots = 20
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt			 = "item_box_buckshot_ttt"
SWEP.Primary.Recoil		= 14
SWEP.Primary.Sound		= Sound( "Weapon_M3.Single" )

SWEP.UseHands			= false
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 58
SWEP.ViewModel       	= "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel         = "models/weapons/w_shot_m3super90.mdl"

SWEP.HeadshotMultiplier = 2


SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "insert",
		Time = 0.8,
	},
	AfterReload = {
		Anim = "after_reload",
		Time = 1.03,
	},
	StartReload = {
		Anim = "start_reload",
		Time = 0.46,
	},
}
/*

AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

SWEP.HoldType        = "shotgun"
SWEP.PrintName = "Shotgun"

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_m3s90"
   SWEP.IconLetter = "B"
end

SWEP.Base            = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN
SWEP.ENUM = 13

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 900
SWEP.Primary.Delay = 1.2 + 0.2
SWEP.Primary.Recoil = 7
SWEP.Primary.Cone = 0.04
SWEP.Primary.Damage = 13
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 10
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.Primary.LayerMults = {0.2, 0.4, 0.6}

SWEP.UseHands        = true
SWEP.ViewModelFlip      = false
SWEP.ViewModelFOV    = 58
SWEP.ViewModel       = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel         = "models/weapons/w_shot_m3super90.mdl"
SWEP.Primary.Sound         = Sound( "Weapon_M3.Single" )

SWEP.IronSightsPos = Vector( -7.67, -12.86, 3.371 )
SWEP.IronSightsAng = Vector( 0.637, 0.01, -1.458 )

SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "insert",
		Time = 0.8,
	},
	AfterReload = {
		Anim = "after_reload",
		Time = 1.03,
	},
	StartReload = {
		Anim = "start_reload",
		Time = 0.46,
	},
}

*/