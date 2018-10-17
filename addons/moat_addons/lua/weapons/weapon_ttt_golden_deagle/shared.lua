--- Author informations ---
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

if SERVER then
	AddCSLuaFile()
else
	SWEP.PrintName = "Golden Deagle"
	SWEP.Slot = 1
end

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

function SWEP:Initialize()
	self:SetDeploySpeed(self.DeploySpeed)

	if (self.SetHoldType) then
		self:SetHoldType(self.HoldType or "pistol")
	end

	PrecacheParticleSystem("smoke_trail")
end

function SWEP:PrimaryAttack(worldsnd)
	if (self:CanPrimaryAttack()) then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		local owner = self.Owner
		owner:GetViewModel():StopParticles()

		if (!worldsnd) then
			self.Weapon:EmitSound(self.Primary.Sound)
		elseif SERVER then
			sound.Play(self.Primary.Sound, self:GetPos())
		end

		self:ShootBullet(self.Primary.Damage, self.Primary.NumShots, 1, self.Primary.Cone)
		self:TakePrimaryAmmo(1)

		if (IsValid(owner) and !owner:IsNPC() and owner.ViewPunch) then
			owner:ViewPunch(Angle(math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0))
		end

		timer.Simple(0.5, function() if (IsValid(self) and IsValid(self.Owner)) then ParticleEffectAttach("smoke_trail", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 1) end end)
	end
end

function SWEP:Holster()
	if (IsValid(self.Owner)) then
		local vm = self.Owner:GetViewModel()
		if (IsValid(vm)) then
			vm:StopParticles()
		end
	end
	return true
end
