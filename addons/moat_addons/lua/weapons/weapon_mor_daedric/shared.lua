if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName = "Rifle"
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.Icon = "vgui/ttt/icon_scout"
end

SWEP.Base			= "weapon_mor_base_bow"

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= true

SWEP.ViewModel      = "models/morrowind/daedric/longbow/v_daedric_longbow.mdl"
SWEP.WorldModel   = "models/morrowind/daedric/longbow/w_daedric_longbow.mdl"

SWEP.Primary.Damage		= 40 * 2
SWEP.Primary.Delay 		= 2
SWEP.Primary.Velocity 		= 3000

SWEP.Primary.ClipSize = 10
SWEP.Primary.ClipMax = 20 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"
SWEP.Crosshair				= true
SWEP.AmmoEnt = "item_ammo_357_ttt"
SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

function SWEP:PrimaryAttack()
	if self:GetDTFloat(0) != 0 then return end
    if (not self:CanPrimaryAttack()) then return end

    self:SetNextPrimaryFire(self:GetDTFloat(0))

	if (SERVER) then
		local vm = self.Owner:GetViewModel()
		if (vm:IsValid()) then
			vm:SetPlaybackRate(1)
		end
	end

	local anim = self.Owner:GetViewModel():LookupSequence("reload"..math.random(1,3))
	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)

	if (SERVER) then
		local vm = self.Owner:GetViewModel()
		if (vm:IsValid()) then
			vm:SetPlaybackRate(1)
		end
	end
	
	self.Weapon:EmitSound("weapons/bow/skyrim_bow_pull.mp3")
	self.DelayTime = CurTime() + 0.5
	self:SetDTFloat(0, CurTime() + self.MaxHoldTime)
	self:SetNextPrimaryFire(self:GetDTFloat(0))
end