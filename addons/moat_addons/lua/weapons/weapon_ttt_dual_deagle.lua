
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual Deagles"

SWEP.Slot = 1
SWEP.Base = "weapon_ttt_dual_glock"

if CLIENT then
   SWEP.Slot      = 1

   SWEP.Icon = "vgui/ttt/icon_deagle"
   SWEP.IconLetter = "c"
end

SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Damage = 17
SWEP.Primary.Delay = 0.4
SWEP.Primary.Cone = 0.034
SWEP.Primary.ClipSize = 12
SWEP.Primary.ClipMax = 36
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AlyxGun"
SWEP.Primary.NumShots = 2
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt            = "item_ammo_revolver_ttt"
SWEP.Primary.Recoil		= 12
SWEP.Primary.Sound		= Sound( "Weapon_Deagle.Single" )

SWEP.UseHands			= false
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_deagle.mdl"

SWEP.HeadshotMultiplier = 5.5

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.2,
	},
}

-- AddCSLuaFile()

-- SWEP.HoldType			= "pistol"
-- SWEP.PrintName			= "Deagle"

-- if CLIENT then
--    SWEP.Author				= "TTT"

--    SWEP.Slot				= 1
--    SWEP.SlotPos			= 1

--    SWEP.Icon = "vgui/ttt/icon_deagle"
-- end

-- SWEP.Base				= "weapon_tttbase"
-- DEFINE_BASECLASS "weapon_tttbase"

-- SWEP.Spawnable = true
-- SWEP.Kind = WEAPON_PISTOL
-- SWEP.WeaponID = AMMO_DEAGLE
-- SWEP.ENUM = 4

-- SWEP.Primary.Ammo       = "AlyxGun" -- hijack an ammo type we don't use otherwise
-- SWEP.Primary.Recoil			= 6
-- SWEP.Primary.Damage = 37
-- SWEP.Primary.Delay = 0.4
-- SWEP.Primary.Cone = 0.017
-- SWEP.Primary.ClipSize = 8
-- SWEP.Primary.ClipMax = 36
-- SWEP.Primary.DefaultClip = 8
-- SWEP.Primary.Automatic = true

-- SWEP.HeadshotMultiplier = 5.5

-- SWEP.AutoSpawnable      = true
-- SWEP.AmmoEnt = "item_ammo_revolver_ttt"
-- SWEP.Primary.Sound			= Sound( "Weapon_Deagle.Single" )

-- SWEP.UseHands			= true
-- SWEP.ViewModelFlip		= false
-- SWEP.ViewModelFOV		= 54
-- SWEP.ViewModel			= "models/weapons/cstrike/c_pist_deagle.mdl"
-- SWEP.WorldModel			= "models/weapons/w_pist_deagle.mdl"

-- SWEP.IronSightsPos = Vector(-6.361, -3.701, 2.15)
-- SWEP.IronSightsAng = Vector(0, 0, 0)

-- SWEP.DeploySpeed = 1.4
-- SWEP.ReloadSpeed = 1
-- SWEP.ReloadAnim = {
-- 	DefaultReload = {
-- 		Anim = "reload",
-- 		Time = 2.2,
-- 	},
-- }
