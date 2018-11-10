// Variables that are used on both client and server
--[[
SWEP.Instructions			= "Uses 7.62mm Nato ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base_reg"
SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_g3.mdl"
SWEP.WorldModel			= "models/weapons/b_g3a3.mdl"
SWEP.ViewModelFOV			= 55

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_G3.Shoot")
SWEP.Primary.Recoil		= 2.2
SWEP.Primary.Damage		= 46
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.003
SWEP.Primary.Delay 		= 0.1

SWEP.Primary.ClipSize		= 20					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_762x51"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-3.2942, -5.0006, 0.7174)
SWEP.IronSightsAng = Vector (0.5454, -0.0083, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."

SWEP.Speed = 0.6
SWEP.Mass = 0.725
SWEP.WeaponName = "weapon_fas_g3"
SWEP.WeaponEntName = "sim_fas_g3"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/ar_g3a3/g3_fire1.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_fire2.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_fire3.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_fire4.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_fire5.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_magout.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_magin.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_boltforward.wav")
	util.PrecacheSound("weapons/ar_g3a3/g3_boltback.wav")
end
--]]

AddCSLuaFile()

SWEP.HoldType     = "ar2"

if CLIENT then
   SWEP.PrintName     = "FAL"
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_m16"
   SWEP.IconLetter = "w"
end
SWEP.PrintName      = "FAL"
SWEP.Base       = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M16

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.1
SWEP.Primary.Recoil = 0.9
SWEP.Primary.Cone = 0.02
SWEP.Primary.Damage = 29
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV   = 55
SWEP.ViewModel			= "models/weapons/a_g3.mdl"
SWEP.WorldModel			= "models/weapons/b_g3a3.mdl"

SWEP.Primary.Sound = Sound("Weapof_G3.Shoot")

SWEP.IronSightsPos = Vector(-3.2942, -5.0006, 0.7174)
SWEP.IronSightsAng = Vector(0.5454, -0.0083, 0)


function SWEP:SetZoom(state)
   if not (IsValid(self.Owner) and self.Owner:IsPlayer()) then return end
   if state then
      self.Owner:SetFOV(60, 0.5)
   else
      self.Owner:SetFOV(0, 0.2)
   end
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
   if not self.IronSightsPos then return end
   if self:GetNextSecondaryFire() > CurTime() then return end

   local bIronsights = not self:GetIronsights()

   self:SetIronsights( bIronsights )

      self:SetZoom( bIronsights )

   self:SetNextSecondaryFire( CurTime() + 0.3 )
end

function SWEP:PreDrop()
   self:SetZoom(false)
   self:SetIronsights(false)
   return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
    if (self:Clip1() == self.Primary.ClipSize or
        self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
       return
    end
    self:DefaultReload(ACT_VM_RELOAD)
    self:SetIronsights(false)
    self:SetZoom(false)
end

function SWEP:Holster()
   self:SetIronsights(false)
   self:SetZoom(false)
   return true
end
