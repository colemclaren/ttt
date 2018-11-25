AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Springfield"
    SWEP.Slot = 2
    SWEP.Icon = "vgui/ttt/king_m03a3_icon"
end

SWEP.HoldType = "ar2"
SWEP.ShowWorldModel = false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSpawnable = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Delay = 1.8
SWEP.Primary.Recoil = 7
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 75
SWEP.Primary.Cone = 0.005
SWEP.Primary.ClipSize = 5
SWEP.Primary.ClipMax = 20
SWEP.Primary.DefaultClip = 5
SWEP.HeadshotMultiplier = 2
SWEP.DrawCrosshair = false
SWEP.Kind = WEAPON_HEAVY
SWEP.AmmoEnt = "item_ammo_357_ttt"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/doi/v_springfield.mdl"
SWEP.WorldModel = "models/weapons/doi/w_springfield.mdl"
SWEP.ViewModelFlip = false
SWEP.IronSightsPos = Vector(-2.56, 0, 1.32)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.Primary.Sound = Sound("Weapon_Springfield.Shoot")

function SWEP:PrimaryAttack(worldsnd)
    if (not self:CanPrimaryAttack()) then return end

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    if self:GetNWBool("Ironsights", true) then
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_DEPLOYED)
    end

    if not worldsnd then
      self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
    elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
   end

   self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone())

   self:TakePrimaryAmmo(1)

   local owner = self.Owner
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

    owner:ViewPunch( Angle( util.SharedRandom(self:GetClass(), -0.2, -0.1, 0) * self.Primary.Recoil, util.SharedRandom(self:GetClass(), -0.1, 0.1, 1) * self.Primary.Recoil, 0 ) )
end

function SWEP:Deploy()
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), CurTime() + self.Owner:GetViewModel():SequenceDuration()))
    self:SendWeaponAnim(ACT_VM_DRAW)
    self:SetIronsights(false)

    return true
end

function SWEP:OnRestore()
    self:SetIronsights(false)
end

function SWEP:Reload()
    if (self:Clip1() == self.Primary.ClipSize or
        self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
        return
    end
    self:DefaultReload(ACT_VM_RELOAD)
    self:SetIronsights(false)
end