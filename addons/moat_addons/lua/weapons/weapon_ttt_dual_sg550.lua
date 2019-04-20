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
SWEP.Primary.Delay = 0.3
SWEP.Primary.Recoil = 4
SWEP.Primary.Cone = 0.006
SWEP.Primary.Damage = 30
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 40
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Sound = Sound("Weapon_SG550.Single")
SWEP.Secondary.Delay = 0.3
SWEP.Secondary.Sound = Sound("Default.Zoom")
SWEP.HeadshotMultiplier = 5
SWEP.Scope = true

SWEP.ViewModel = Model("models/weapons/cstrike/c_snip_sg550.mdl")
SWEP.WorldModel = Model("models/weapons/w_snip_sg550.mdl")

SWEP.OffsetVector = Vector(0, -3.5, 0)