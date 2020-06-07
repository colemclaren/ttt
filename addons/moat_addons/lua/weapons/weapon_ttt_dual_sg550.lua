SWEP.HoldType = "duel"
SWEP.PrintName = "Dual SG550"
SWEP.UseHands = false

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

if SERVER then
	AddCSLuaFile()
else

	SWEP.Slot = 2
	SWEP.Icon = "vgui/ttt/icon_sg550"

	-- client side model settings
	SWEP.ViewModelFlip = false -- should the weapon be hold with the left or the right hand
	SWEP.ViewModelFOV = 60
end


SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M249
SWEP.ENUM = 1

SWEP.Primary.Ammo = "357"
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 8
SWEP.Primary.Cone = 0.012
SWEP.Primary.Damage = 20
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound = Sound("Weapon_SG550.Single")
SWEP.Secondary.Delay = 0.3
SWEP.Secondary.Sound = Sound("Default.Zoom")
SWEP.HeadshotMultiplier = 5
SWEP.Scope = true
SWEP.AutoSpawnable = false

SWEP.ViewModel = Model("models/weapons/cstrike/c_snip_sg550.mdl")
SWEP.WorldModel = Model("models/weapons/w_snip_sg550.mdl")
SWEP.AmmoEnt = "item_ammo_357_ttt"

SWEP.OffsetVector = Vector(0, -3.5, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 3.78571,
	},
}