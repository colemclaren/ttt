--[[
SWEP.Instructions			= "Uses 7.62mm Short ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base_reg"
SWEP.HoldType				= "smg"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_sako.mdl"
SWEP.WorldModel			= "models/weapons/b_sako.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_sako.Shoot")
SWEP.Primary.Recoil		= 2
SWEP.Primary.Damage		= 32
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.007
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_762x39"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02

SWEP.IronSightsPos = Vector (-2.7896, -5.0002, 1.35)
SWEP.IronSightsAng = Vector (-0.0659, 0.0126, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."

SWEP.Speed = 0.6
SWEP.Mass = 0.75
SWEP.WeaponName = "weapon_fas_sako"
SWEP.WeaponEntName = "sim_fas_sako"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/ar_sako92/sako_fire1.wav")
	util.PrecacheSound("weapons/ar_sako92/sako_fire2.wav")
	util.PrecacheSound("weapons/ar_sako92/sako_fire3.wav")
	util.PrecacheSound("weapons/ar_sako92/sako_fire4.wav")
	util.PrecacheSound("weapons/ar_sako92/sako_fire5.wav")
	util.PrecacheSound("weapons/ar_sako92/sako_cock.wav")
	util.PrecacheSound("weapons/ar_sako92/sako_magin.wav")
	util.PrecacheSound("weapons/ar_sako92/sako_magout.wav")
end
]]

AddCSLuaFile()

SWEP.HoldType     = "ar2"

if CLIENT then
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_ak47"
   SWEP.IconLetter = "w"
end

SWEP.PrintName      = "Sako"
SWEP.Base       = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_AK47

SWEP.Primary.Delay      = 0.09
SWEP.Primary.Recoil     = 1.9
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Cone = 0.025
SWEP.Primary.Damage = 19
SWEP.Primary.ClipSize = 35
SWEP.Primary.ClipMax = 105
SWEP.Primary.DefaultClip = 35
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_smg1_ttt"
SWEP.HeadshotMultiplier = 2.4

SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV = 60
SWEP.ViewModel			= "models/weapons/a_sako.mdl"
SWEP.WorldModel			= "models/weapons/b_sako.mdl"

SWEP.Primary.Sound = Sound("Weapof_sako.Shoot")

SWEP.IronSightsPos = Vector (-2.7896, -5.0002, 1.35)
SWEP.IronSightsAng = Vector (-0.0659, 0.0126, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.5,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 3.33333,
	}
}

function SWEP:Initialize()
	BaseClass.Initialize(self)

   	if (SERVER) then
		self:SetSkin(1)
   	end
end

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(55, 0.5)
   	else
      	self.Owner:SetFOV(0, 0.2)
   	end
end