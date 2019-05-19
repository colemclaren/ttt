--- Author informations ---
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

if SERVER then
	AddCSLuaFile()
else
	SWEP.Slot = 1
end
SWEP.PrintName = "Golden Deagle"

--- Default GMod values ---
SWEP.Base = "weapon_tttbase"
SWEP.Category = "Counter-Strike: Source"
SWEP.Purpose = "Shoot with style."
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false

SWEP.Kind = WEAPON_PISTOL

SWEP.AmmoEnt = "item_ammo_revolver_ttt"
SWEP.Primary.Ammo = "AlyxGun"
SWEP.Primary.Delay = 0.6
SWEP.Primary.Recoil = 6
SWEP.Primary.Cone = 0.01
SWEP.Primary.Damage = 60
SWEP.HeadshotMultiplier = 5
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Sound = Sound("Golden_Deagle.Single")

SWEP.AutoSpawnable = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

--- Model settings ---
SWEP.HoldType = "pistol"

SWEP.UseHands = true
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 85
SWEP.ViewModel = Model("models/weapons/zaratusa/golden_deagle/v_golden_deagle.mdl")
SWEP.WorldModel = Model("models/weapons/zaratusa/golden_deagle/w_golden_deagle.mdl")

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.22222,
	},
}