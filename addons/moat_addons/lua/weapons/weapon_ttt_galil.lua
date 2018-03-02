AddCSLuaFile()

SWEP.HoldType			= "ar2"

if CLIENT then
   SWEP.PrintName			= "Galil"
   SWEP.Slot				= 2

   SWEP.Icon = "vgui/ttt/icon_galil"
   SWEP.IconLetter = "w"
end
SWEP.PrintName			= "Galil"
SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_AK47
SWEP.ENUM = 12

SWEP.Primary.Delay			= 0.085
SWEP.Primary.Recoil			= 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Cone = 0.025
SWEP.Primary.Damage = 18
SWEP.HeadshotMultiplier = 2.5
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV   = 64
SWEP.ViewModel      = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel     = "models/weapons/w_rif_galil.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Galil.Single" )

SWEP.IronSightsPos = Vector (-6.3505, -1.783, 2.5841)
SWEP.IronSightsAng = Vector (-0.2068, -0.0088, 0)


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
