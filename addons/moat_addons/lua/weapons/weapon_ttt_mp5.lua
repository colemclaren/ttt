AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_mp5"
   SWEP.IconLetter = "x"
end
SWEP.PrintName = "MP5"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Delay = 0.08
SWEP.Primary.Recoil = 1.2
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 18
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Range = 800
SWEP.Primary.FalloffRange = 1600
SWEP.Primary.Sound = Sound( "Weapon_MP5Navy.Single" )

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
SWEP.ViewModel = Model( "models/weapons/cstrike/c_smg_mp5.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_smg_mp5.mdl" )

SWEP.IronSightsPos = Vector( -5.361, -7.481, 1.559 )
SWEP.IronSightsAng = Vector( 2, 0, 0 )

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload1",
		Time = 3.07895,
	},
}