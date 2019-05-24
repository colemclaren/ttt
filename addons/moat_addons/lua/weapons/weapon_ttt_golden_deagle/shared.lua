--- Author informations ---
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

if SERVER then
	AddCSLuaFile()
else
	SWEP.Slot = 1
end

SWEP.HoldType = "pistol"
SWEP.PrintName = "Golden Deagle"

--- Default GMod values ---
SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"
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
SWEP.ViewModel = "models/weapons/zaratusa/golden_deagle/v_golden_deagle.mdl"
SWEP.WorldModel = "models/weapons/zaratusa/golden_deagle/w_golden_deagle.mdl"

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1.25
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.22222,
	}
}

function SWEP:Initialize()
   	if (self.SetHoldType) then
		self:SetHoldType(self.HoldType or "pistol")
	end

   	return self.BaseClass.Initialize(self)
end

function SWEP:ViewPunch()
	if (not IsValid(self.Owner) or not self.Owner.ViewPunch) then
		return
	end

	self:GetOwner():ViewPunch(Angle(util.SharedRandom(self:GetClass(), -0.2, -0.1, 1) * self.Primary.Recoil, util.SharedRandom(self:GetClass(), -0.1, 0.1, 2) * self.Primary.Recoil, 0))
end

function SWEP:HandleRecoil()
end