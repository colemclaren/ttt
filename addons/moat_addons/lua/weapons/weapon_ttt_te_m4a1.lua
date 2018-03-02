--[[
// Variables that are used on both client and server
SWEP.Instructions			= "Uses 5.56mm Nato ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base"
SWEP.HoldType				= "smg"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/b_m4.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_M4A1.Shoot")
SWEP.Primary.Recoil		= 1.5
SWEP.Primary.Damage		= 24.5
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.004
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_556"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false
SWEP.IronSightsPos = Vector (-2.7161, -5.0009, 0.6128)
SWEP.IronSightsAng = Vector (-0.1325, 0.0403, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)
SWEP.Type				= 1
SWEP.Mode				= true

SWEP.Speed = 0.6
SWEP.Mass = 0.75
SWEP.WeaponName = "weapon_fas_m4a1"
SWEP.WeaponEntName = "sim_fas_m4a1"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()
	util.PrecacheSound("weapons/ar_m4a1/m4_fire1.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_fire2.wav")
    	util.PrecacheSound("weapons/ar_m4a1/m4_fire3.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_fire4.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_fire5.wav")
	util.PrecacheSound("weapons/deployholster1.wav")
	util.PrecacheSound("weapons/deployholster2.wav")
	util.PrecacheSound("weapons/deployholster3.wav")
	util.PrecacheSound("weapons/deployholster4.wav")
	util.PrecacheSound("weapons/deployholster5.wav")
	util.PrecacheSound("weapons/deployholster6.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_magout.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_magin.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_boltcatch.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_stock.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_forwardassist.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_dustcover.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_check.wav")
	util.PrecacheSound("weapons/switch.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4_charge.wav")
	util.PrecacheSound("weapons/ar_m4a1/m4a1_deploy.wav")
end	

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() <= 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("shoot_last"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
end
]]

AddCSLuaFile()

if CLIENT then
   SWEP.PrintName     = "M4A1"
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_m16"
   SWEP.IconLetter = "w"
end
SWEP.PrintName      = "M4A1"
SWEP.Base       = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_AK47
SWEP.HoldType     = "smg"

SWEP.Primary.Delay      = 0.095
SWEP.Primary.Recoil     = 1.9
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 25
SWEP.HeadshotMultiplier = 2
SWEP.Primary.ClipSize = 35
SWEP.Primary.ClipMax = 70
SWEP.Primary.DefaultClip = 35
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/b_m4.mdl"

SWEP.Primary.Sound = Sound("Weapof_M4A1.Shoot")

SWEP.IronSightsPos = Vector (-2.7161, -5.0009, 0.6128)
SWEP.IronSightsAng = Vector (-0.1325, 0.0403, 0)

function SWEP:Initialize()
   if SERVER then
      self:SetSkin(1)
   end
end
function SWEP:SetZoom(state)
   if not (IsValid(self.Owner) and self.Owner:IsPlayer()) then return end
   if state then
      self.Owner:SetFOV(55, 0.5)
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
