
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual Miniguns"

SWEP.Slot = 2
SWEP.Base = "weapon_ttt_dual_glock"

if CLIENT then
   SWEP.Slot      = 2

   SWEP.Icon = "vgui/entities/minigun"
   SWEP.IconLetter = "q"
end

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_STUN

SWEP.Primary.Damage = 13
SWEP.Primary.Delay = 0.09
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 200
SWEP.Primary.ClipMax = 600
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.NumShots = 2
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt            = "item_ammo_smg1_ttt"
SWEP.Primary.Recoil		= 0.8
SWEP.Primary.Sound 		= Sound("weapons/minigun/mini-1.wav")
SWEP.ShellEffect		= "effect_mad_shell_rifle"
SWEP.UseHands			= false
SWEP.ViewModel			= "models/weapons/v_minigun.mdl"
SWEP.WorldModel			= "models/weapons/w_minigun.mdl"

SWEP.HeadshotMultiplier = 3 -- brain fizz

function SWEP:Precache()
	util.PrecacheSound "weapons/minigun/mini-1.wav"
end

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {}