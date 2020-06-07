
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual M16s"

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

if CLIENT then
   SWEP.Slot      = 2

   SWEP.Icon = "vgui/ttt/icon_m16"
   SWEP.IconLetter = "w"
end

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Damage = 15.6234375
SWEP.Primary.Delay = 0.165
SWEP.Primary.Cone = 0.018
SWEP.Primary.ClipSize = 36
SWEP.Primary.ClipMax = 108
SWEP.Primary.DefaultClip	= 36
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"
SWEP.Primary.NumShots = 2
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt            = "item_ammo_smg1_ttt"
SWEP.Primary.Recoil		= 3.2
SWEP.Primary.Sound		= Sound( "Weapon_M4A1.Single" )

SWEP.UseHands			= false
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 55
SWEP.ViewModel      	= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel     	= "models/weapons/w_rif_m4a1.mdl"

SWEP.HeadshotMultiplier = 2

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload_unsil",
		Time = 3.08108,
	},
}