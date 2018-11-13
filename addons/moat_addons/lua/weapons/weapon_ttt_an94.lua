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

SWEP.Primary.Sound			= Sound("BO2_PEACE_FIRE")
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.083 -- 0.105
SWEP.Primary.Recoil = 0.4 -- 0.9
SWEP.Primary.Cone = 0.03 -- 0.01
SWEP.Primary.Damage = 22
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

SWEP.NextBurst = CurTime()
SWEP.IronSightsPos = Vector(-3.78, -3.161, 0.615)
SWEP.IronSightsAng = Angle(-0.141, 0, 0)

SWEP.ReloadSound = {"BO2_PEACE_MAGOUT", "BO2_PEACE_MAGIN"}
function SWEP:Reload()
	self.ReloadAnim = Either(self:Clip1() == 0, ACT_VM_RELOAD_EMPTY, ACT_VM_RELOAD)
	if (not self.BaseClass.Reload(self)) then
		return
	end

	local ReloadTime = CurTime()
	self.ReloadTime = ReloadTime
	self.Reloading = true
	timer.Simple(0.4, function()
		if (self.ReloadTime ~= ReloadTime) then return end
		self.ReloadSound.Active = self.ReloadSound[1]
		self:EmitSound(self.ReloadSound.Active)

		timer.Simple(0.8, function()
			if (self.ReloadTime ~= ReloadTime) then return end
			self.ReloadSound.Active = self.ReloadSound[2]
			self:EmitSound(self.ReloadSound[2])
			self.Reloading = false
		end)
	end)
end

function SWEP:Holster()
	if (self.ReloadTime) then self.ReloadTime = 0 end
	if (self.ReloadSound.Active) then self:StopSound(self.ReloadSound.Active) end
	self.Reloading = false

	return true
end

function SWEP:Think()
	self.BaseClass.Think(self)

	if (self.BurstAmount and self.Shots and self.Shots > 0 and not self.Owner:KeyDown(IN_ATTACK)) then
		self:SetNextPrimaryFire(CurTime() + (self.Primary.Delay * 3))
		self.Shots = 0
	end
end

function SWEP:PrimaryAttack(worldsnd)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if (not self:CanPrimaryAttack()) then
		return
	end

	if (self.BurstAmount and self.Shots and self.Shots >= self.BurstAmount) then
		return
	end

	if (self.Reloading) then
		return
	end

	if (not worldsnd) then
		self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel)
	elseif (SERVER) then
		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
	end

	self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone())
	self:TakePrimaryAmmo(1)

	if (not IsValid(self.Owner) or not self.Owner.ViewPunch) then
		return
	end

	self.Owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
end