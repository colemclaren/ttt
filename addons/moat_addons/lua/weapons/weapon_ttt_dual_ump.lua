
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual UMPs"

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

if CLIENT then
   SWEP.Slot      = 2

   SWEP.ViewModelFOV = 72

   SWEP.EquipMenuData = {
      type = "item_weapon",
      desc = "ump_desc"
   };

   SWEP.Icon = "vgui/ttt/icon_ump"
   SWEP.IconLetter = "q"
end

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_STUN
SWEP.LimitedStock = false

SWEP.Primary.Damage = 10
SWEP.Primary.Delay = 0.09
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.NumShots = 2
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt            = "item_ammo_smg1_ttt"
SWEP.Primary.Recoil		= 1.2
SWEP.Primary.Sound		= Sound( "Weapon_UMP45.Single" )

SWEP.UseHands			= false
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_ump45.mdl"

SWEP.HeadshotMultiplier = 3 -- brain fizz

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 3.48485,
	},
}