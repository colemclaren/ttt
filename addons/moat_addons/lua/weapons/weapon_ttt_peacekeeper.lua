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
DEFINE_BASECLASS "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= false

SWEP.Primary.Sound			= Sound("BO2_PEACE_FIRE")
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.083 -- 0.105
SWEP.Primary.Recoil = 0.4 -- 0.9
SWEP.Primary.Cone = 0.03 -- 0.01
SWEP.Primary.Damage = 24
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30

SWEP.BurstAmount = 3
SWEP.Shots = 0

SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"
SWEP.AutoSpawnable = true
SWEP.Kind = WEAPON_HEAVY

SWEP.IronSightsPos = Vector(-3.78, -3.161, 0.615)
SWEP.IronSightsAng = Angle(-0.141, 0, 0)

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	self:NetworkVar("Float", 0, "NextBurstFire")
	self:NetworkVar("Int", 0, "BurstRound")
end

SWEP.ReloadSound = {"BO2_PEACE_MAGOUT", "BO2_PEACE_MAGIN"}
function SWEP:Reload()
	self.ReloadAnim = Either(self:Clip1() == 0, ACT_VM_RELOAD_EMPTY, ACT_VM_RELOAD)
	if (not BaseClass.Reload(self)) then
		return
	end

	self:SetNextPrimaryFire(CurTime() + 0.8)
	self:SetBurstRound(-1)
	timer.Simple(0.4, function()
		if (not self.ReloadSound) then return end
		self.ReloadSound.Active = self.ReloadSound[1]
		self:EmitSound(self.ReloadSound.Active)

		timer.Simple(0.8, function()
			if (not self.ReloadSound) then return end
			self.ReloadSound.Active = self.ReloadSound[2]
			self:EmitSound(self.ReloadSound[2])
		end)
	end)
end

function SWEP:Initialize()
	BaseClass.Initialize(self)
	self:SetBurstRound(-1)
end

function SWEP:Holster()
	if (self.ReloadSound and self.ReloadSound.Active) then
		self:StopSound(self.ReloadSound.Active)
	end

	self:SetBurstRound(-1)

	return true
end

function SWEP:Think()
	BaseClass.Think(self)

	if (self:GetBurstRound() >= 0 and self:GetBurstRound() < 2 and self:GetNextBurstFire() <= CurTime()) then
		if (not self.Owner:KeyDown(IN_ATTACK)) then
			self:SetBurstRound(-1)
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 1.5)
			return
		end

		self:SetBurstRound(self:GetBurstRound() + 1)
		self:SetNextBurstFire(CurTime() + self.Primary.Delay)
		self:FireABullet()
	end
end

function SWEP:FireABullet()
	if (not self:CanPrimaryAttack()) then
		return
	end

	self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel)

	self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone())
	self:TakePrimaryAmmo(1)

	if (not IsValid(self.Owner) or not self.Owner.ViewPunch) then
		return
	end

	self.Owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 4)

	if (not self:CanPrimaryAttack()) then
		return
	end

	self:SetBurstRound(0)
	self:SetNextBurstFire(CurTime() + self.Primary.Delay)

	self:FireABullet()
end