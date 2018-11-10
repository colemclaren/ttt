AddCSLuaFile()

SWEP.PrintName = "Peacekeeper"
if CLIENT then
   SWEP.PrintName = "Peacekeeper"
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/peacekeeper.png"
end

SWEP.HoldType 				= "ar2"

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_bo2r_peacekeeper.mdl"
SWEP.WorldModel				= "models/weapons/w_bo2_peacekeeper.mdl"
SWEP.ShowWorldModel			= false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= false
SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound			= Sound("BO2_PEACE_FIRE")
local Reload1 = Sound("BO2_PEACE_MAGOUT")
local Reload2 = Sound("BO2_PEACE_MAGIN")
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.105
SWEP.Primary.Recoil = 0.9
SWEP.Primary.Cone = 0.01
SWEP.Primary.Damage = 22
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.BurstAmt = 3 -- adds 1 automatically

SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"
SWEP.AutoSpawnable = true
SWEP.Kind = WEAPON_HEAVY

SWEP.NextBurst = CurTime()
SWEP.IronSightsPos = Vector(-3.78, -3.161, 0.615)
SWEP.IronSightsAng = Angle(-0.141, 0, 0)

function SWEP:Reload()
   if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
   self.StopSounds = false
   self.Firing = false
   self.Reloading = true

   local anim = "reload"
   if (self:Clip1() == 0) then anim = "reload_empty" end
   
  local Animation = self.Owner:GetViewModel()
  local seq = Animation:LookupSequence(anim)
  Animation:SetSequence(seq)

	timer.Simple(0.4, function() 
    	if (self.StopSounds or not self.Primary) then return end
    	self:EmitSound(Reload1)
	
    	timer.Simple(0.8, function()
      		if (self.StopSounds or not self.Primary) then return end
      		self:EmitSound(Reload2)
      		self.Reloading = false
    	end)
  	end)

   self:DefaultReload(self.ReloadAnim)
   self:SetIronsights(false)
end

function SWEP:Deploy()
   self.Firing = false
   self.Reloading = false
   self:SetIronsights(false)
   return true
end

function SWEP:Holster()
  self.Firing = false
  self.StopSounds = true
  self.Reloading = false

  return true
end

function SWEP:OnRemove()
  self.Firing = false
  self.StopSounds = true
  self.Reloading = false
end

function SWEP:BurstAttack()
  if (not self:CanPrimaryAttack()) then
    self.Firing = false
    return
  end

  if (self.Reloading) then return end

  self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel)

  self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone())
  self:TakePrimaryAmmo(1)

  local owner = self.Owner
  if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   self.ViewPunch1 = util.SharedRandom(self:GetClass(),-0.2,-0.1,0) * self.Primary.Recoil
   self.ViewPunch2 = util.SharedRandom(self:GetClass(),-0.1,0.1,1) * self.Primary.Recoil

  owner:ViewPunch( Angle( self.ViewPunch1, self.ViewPunch2, 0 ) )

  if (self.BurstAmt < (self.Primary.BurstAmt or 1)) then
    self.BurstAmt = self.BurstAmt + 1
    self.NextBurst = CurTime() + self.Primary.Delay
  else
    self.Firing = false
  end
end

function SWEP:Think()
  if (self.Firing and self.NextBurst <= CurTime()) then
    self:BurstAttack()
  end
end

function SWEP:PrimaryAttack()

   self:SetNextSecondaryFire(CurTime() + (self.Primary.Delay * (self.Primary.BurstAmt or 1)))
   self:SetNextPrimaryFire(CurTime() + (self.Primary.Delay * (self.Primary.BurstAmt or 1)))

   if (not self:CanPrimaryAttack()) then return end

   self.BurstAmt = 1
   self.Firing = true
   self:BurstAttack()
end