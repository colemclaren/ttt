--- Author informations ---
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

if SERVER then
	AddCSLuaFile()
elseif CLIENT then
	SWEP.Slot = 5
end
SWEP.PrintName = "Sandwich"
--- Default GMod values ---
SWEP.Base = "weapon_base"
SWEP.Category = "Food"
SWEP.Purpose = "Heal yourself or others."
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 2
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = 4

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.HealAmount = 25

--- Model settings ---
SWEP.HoldType = "slam"

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel = Model("models/weapons/zaratusa/sandwich/v_sandwich.mdl")
SWEP.WorldModel = Model("models/weapons/zaratusa/sandwich/w_sandwich.mdl")

local HealSound = Sound("weapons/sandwich/eat.wav")

function SWEP:Initialize()
	-- compat for gmod update
	if self.SetHoldType then
		self:SetHoldType(self.HoldType or "pistol")
	end

	self:SetDeploySpeed(self.DeploySpeed)
end

function SWEP:PrimaryAttack()
	if (SERVER and self:CanPrimaryAttack() and self:GetNextPrimaryFire() <= CurTime()) then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

		local owner = self.Owner
		if (IsValid(owner)) then
			local tr = util.TraceLine({
				start = owner:GetShootPos(),
				endpos = owner:GetShootPos() + owner:GetAimVector() * 80,
				filter = owner,
				mask = MASK_SOLID
			})
			local ent = tr.Entity
			if (IsValid(ent) and ent:IsPlayer() and ent:Health() < ent:GetMaxHealth()) then
				self:Heal(ent)
			end
		end
	end
end

function SWEP:SecondaryAttack()
	if (SERVER and self:CanPrimaryAttack() and self:GetNextSecondaryFire() <= CurTime()) then
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		local owner = self.Owner
		if (IsValid(owner) and owner:Health() < owner:GetMaxHealth()) then
			self:Heal(owner)
		end
	end
end

function SWEP:Heal(player)
	player:SetHealth(math.min(player:GetMaxHealth(), player:Health() + self.HealAmount))
	player:EmitSound(HealSound)
	player:SetAnimation(PLAYER_ATTACK1)

	self:TakePrimaryAmmo(1)
	if (self.Weapon:Clip1() < 1) then
		self:Remove()
	end
end

function SWEP:OnRemove()
	if (CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive()) then
		RunConsoleCommand("lastinv")
	end
end

function SWEP:DrawHUD()
	local x = ScrW() / 2.0
	local y = ScrH() * 0.995
	
	draw.SimpleText("Primary attack to feed someone else.", "Default", x, y - 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("Secondary attack to eat.", "Default", x, y, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
end
