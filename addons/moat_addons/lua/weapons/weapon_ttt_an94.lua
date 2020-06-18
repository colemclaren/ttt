AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Peacekeeper"
	SWEP.Slot = 2
	SWEP.Icon = "vgui/ttt/peacekeeper.png"
end

SWEP.PrintName = "Peacekeeper"
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
SWEP.Primary.Delay = 0.1 -- 0.105
SWEP.Primary.Recoil = 0.9 -- 0.9
SWEP.Primary.Cone = 0.015 -- 0.01
SWEP.Primary.Damage = 22
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
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

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2.45714,
		Sounds = {
			{Delay = .4, Sound = Sound("BO2_PEACE_MAGOUT")},
			{Delay = 1.3, Sound = Sound("BO2_PEACE_MAGIN")},
		}
	},
	DefaultReload = {
		Anim = "reload",
		Time = 2.08571,
		Sounds = {
			{Delay = .4, Sound = Sound("BO2_PEACE_MAGOUT")},
			{Delay = 1.3, Sound = Sound("BO2_PEACE_MAGIN")},
		}
	},
}


function SWEP:SetupDataTables()
	self:NetworkVar("Float", 1, "NextBurstFire")
	self:NetworkVar("Int", 1, "BurstRound")

	return BaseClass.SetupDataTables(self)
end

function SWEP:Initialize()
	BaseClass.Initialize(self)
	self:SetBurstRound(-1)
end

function SWEP:Holster()
	self:SetBurstRound(-1)

	return BaseClass.Holster(self)
end

function SWEP:Think()
	BaseClass.Think(self)

	if (self:GetBurstRound() >= 0 and self:GetBurstRound() < 2 and self:GetNextBurstFire() <= CurTime()) then
		if (not self.Owner:KeyDown(IN_ATTACK)) then
			self:SetBurstRound(-1)
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 1.5)
			return
		end

		self:FireABullet()
		self:SetBurstRound(self:GetBurstRound() + 1)
		self:SetNextBurstFire(CurTime() + self.Primary.Delay)
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
	if (not self:CanPrimaryAttack()) then
		return
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 4)

	self:SetBurstRound(0)
	self:SetNextBurstFire(CurTime() + self.Primary.Delay)

	self:FireABullet()
end