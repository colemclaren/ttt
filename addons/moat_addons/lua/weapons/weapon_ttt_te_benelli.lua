AddCSLuaFile()

SWEP.HoldType			= "shotgun"
SWEP.PrintName = "Benelli TE"

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_shotgun"
   SWEP.IconLetter = "B"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 600
SWEP.Primary.Damage = 7
SWEP.Primary.Cone = 0.04
SWEP.Primary.Delay = 0.55 + 0.2
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 12
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.Primary.LayerMults = {0.4, 0.4, 0}

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/a_m3.mdl"
SWEP.WorldModel			= "models/weapons/b_m3s90.mdl"
SWEP.Primary.Sound			= Sound("Weapof_M3S90.Shoot")
SWEP.Primary.Recoil			= 7

SWEP.IronSightsPos = Vector (-2.2631, -4.0007, 1.6813)
SWEP.IronSightsAng = Vector (0.2298, 0.0043, 0)

SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	StartReload = {
		Anim = "reload_start",
		Time = 0.7,
	},
	AfterReload = {
		Anim = "reload_abort",
		Time = 0.7,
	},
	DefaultReload = {
		Anim = "reload_load1",
		Time = 0.86667,
	},

	/*
	DefaultReload = {
		Anim = "reload_abort",
		Time = 0.7,
	},
	StartReload = {
		Anim = "reload_start",
		Time = 0.7,
	},
	DefaultReload = {
		Anim = "reload_start_empty",
		Time = 2.03333,
	},
	DefaultReload = {
		Anim = "reload_load1",
		Time = 0.86667,
	},
	DefaultReload = {
		Anim = "reload_load2",
		Time = 1.36667,
	},
	DefaultReload = {
		Anim = "reload_load3",
		Time = 1.7,
	},
	DefaultReload = {
		Anim = "reload_load4",
		Time = 1.7,
	},
	DefaultReload = {
		Anim = "reload_load1_end",
		Time = 1.36667,
	},
	DefaultReload = {
		Anim = "reload_load2_end",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "reload_load3_end",
		Time = 1.86667,
	},
	DefaultReload = {
		Anim = "reload_load4_end",
		Time = 2.2,
	},
	DefaultReload = {
		Anim = "last1_reload_start",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "last1_reload_start_empty",
		Time = 2.2,
	},
	DefaultReload = {
		Anim = "last1_reload_start_end",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "last1_reload_end",
		Time = 1.03333,
	},
	DefaultReload = {
		Anim = "last2_reload_start",
		Time = 1.36667,
	},
	DefaultReload = {
		Anim = "last2_reload_start_empty",
		Time = 2.03333,
	},
	DefaultReload = {
		Anim = "last2_reload_start_end",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "last2_reload_insert",
		Time = 0.86667,
	},
	DefaultReload = {
		Anim = "last2_reload_end",
		Time = 1.03333,
	},
	DefaultReload = {
		Anim = "last3_reload_start",
		Time = 1.36667,
	},
	DefaultReload = {
		Anim = "last3_reload_start_empty",
		Time = 2.03333,
	},
	DefaultReload = {
		Anim = "last3_reload_start_end",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "last3_reload_insert",
		Time = 0.86667,
	},
	DefaultReload = {
		Anim = "last3_reload_end",
		Time = 1.03333,
	},
	DefaultReload = {
		Anim = "last4_reload_start",
		Time = 1.36667,
	},
	DefaultReload = {
		Anim = "last4_reload_start_empty",
		Time = 2.03333,
	},
	DefaultReload = {
		Anim = "last4_reload_start_end",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "last4_reload_insert",
		Time = 0.86667,
	},
	DefaultReload = {
		Anim = "last4_reload_end",
		Time = 1.03333,
	},
	DefaultReload = {
		Anim = "last5_reload_start",
		Time = 1.36667,
	},
	DefaultReload = {
		Anim = "last5_reload_start_empty",
		Time = 2.03333,
	},
	DefaultReload = {
		Anim = "last5_reload_start_end",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "last5_reload_insert",
		Time = 0.86667,
	},
	DefaultReload = {
		Anim = "last5_reload_end",
		Time = 1.03333,
	},
	DefaultReload = {
		Anim = "last6_reload_start",
		Time = 1.36667,
	},
	DefaultReload = {
		Anim = "last6_reload_start_empty",
		Time = 2.03333,
	},
	DefaultReload = {
		Anim = "last6_reload_start_end",
		Time = 1.53333,
	},
	DefaultReload = {
		Anim = "last6_reload_insert",
		Time = 0.86667,
	},
	DefaultReload = {
		Anim = "last6_reload_end",
		Time = 1.03333,
	},
	DefaultReload = {
		Anim = "reload1",
		Time = 2.06667,
	},
	DefaultReload = {
		Anim = "reload2",
		Time = 2.23333,
	},
	DefaultReload = {
		Anim = "reload3",
		Time = 2.56667,
	},
	DefaultReload = {
		Anim = "reload4",
		Time = 2.9,
	},
	DefaultReload = {
		Anim = "reload5",
		Time = 3.8,
	},
	DefaultReload = {
		Anim = "reload6",
		Time = 3.93333,
	},
	DefaultReload = {
		Anim = "reload7",
		Time = 4.26667,
	},
	DefaultReload = {
		Anim = "reload8",
		Time = 5.6,
	},
	DefaultReload = {
		Anim = "reload1_empty",
		Time = 2.73333,
	},
	DefaultReload = {
		Anim = "reload2_empty",
		Time = 3.56667,
	},
	DefaultReload = {
		Anim = "reload3_empty",
		Time = 3.9,
	},
	DefaultReload = {
		Anim = "reload4_empty",
		Time = 3.9,
	},
	DefaultReload = {
		Anim = "reload5_empty",
		Time = 4.23333,
	},
	DefaultReload = {
		Anim = "reload6_empty",
		Time = 5.13333,
	},
	DefaultReload = {
		Anim = "reload7_empty",
		Time = 5.26667,
	}
	*/
}