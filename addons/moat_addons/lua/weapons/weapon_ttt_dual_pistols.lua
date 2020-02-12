
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual Pistols"

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/icon_pistol"
   SWEP.IconLetter = "u"
end

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL
SWEP.ENUM = 5

SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.33
SWEP.Primary.Cone = 0.016
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"
SWEP.Primary.NumShots = 2
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt            = "item_ammo_pistol_ttt"
SWEP.Primary.Recoil		= 1.5
SWEP.Primary.Sound = Sound( "Weapon_FiveSeven.Single" )

SWEP.UseHands			= false
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  		= "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel 		= "models/weapons/w_pist_fiveseven.mdl"

SWEP.HeadshotMultiplier = 3 -- brain fizz

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 3.23333,
	},
}

/*

AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.PrintName = "Pistol"

if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/icon_pistol"
   SWEP.IconLetter = "u"
end

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL
SWEP.ENUM = 5

SWEP.Base = "weapon_tttbase"
SWEP.Primary.Recoil	= 1.5
SWEP.Primary.Damage = 31.246875
SWEP.Primary.Delay = 0.33
SWEP.Primary.Cone = 0.008
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"

SWEP.Primary.Sound = Sound( "Weapon_FiveSeven.Single" )
SWEP.IronSightsPos = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 3.23333,
	},
}

*/