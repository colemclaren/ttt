if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	util.AddNetworkString "moat_hide_trail"
end

if( CLIENT ) then
	SWEP.PrintName = "Rifle"
	SWEP.Slot = 2
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.Icon = "vgui/ttt/icon_scout"

	local grad_d = Material("vgui/gradient-d")

	function SWEP:DrawHUD()
		local client = LocalPlayer()
		if (not IsValid(client)) then return end

		local sights = (not self.NoSights) and self:GetIronsights()

		local x = math.floor(ScrW() / 2.0)
		local y = math.floor(ScrH() / 2.0)
		local scale = math.max(0.2,  10 * self:GetPrimaryCone())

		local LastShootTime = self:LastShootTime()
		scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

		local alpha = sights and 0.8 or 1
		local bright = 1

		if client.IsTraitor and client:IsTraitor() then
			surface.SetDrawColor(255 * bright,
								50 * bright,
								50 * bright,
								255 * alpha)
		else
			surface.SetDrawColor(0,
								255 * bright,
								0,
								255 * alpha)
		end

		local gap = math.floor(20 * scale * (sights and 0.8 or 1))
		local length = math.floor(gap + (25 * 1) * scale)

		surface.DrawLine(x - 6, y + 6, x, y)
		surface.DrawLine(x + 6, y + 6, x, y)

		surface.DrawLine(x - 6, y + 5, x, y - 1)
		surface.DrawLine(x + 6, y + 5, x, y - 1)

		surface.DrawLine(x - 5, y + 15, x + 5, y + 15)
		surface.DrawLine(x - 4, y + 25, x + 4, y + 25)
		surface.DrawLine(x - 3, y + 35, x + 3, y + 35)
		surface.DrawLine(x - 2, y + 45, x + 2, y + 45)


		local scrx = ScrW()/2
		local scry = ScrH()/2
		surface.SetDrawColor(255, 255, 255, 100)
		--surface.DrawRect(scrx - 75, scry + 200, 150, 16)
		surface.DrawOutlinedRect(scrx - 75, scry + 200, 150, 16)
		if self.UnpredictedHoldTime and self.UnpredictedHoldTime ~= 0 then
			local ratio = (math.Clamp((SysTime() - self.UnpredictedHoldTime) / self.MaxHoldTime, 0.1, 1) - 0.1) / 0.9
			surface.SetDrawColor(255, 0, 0, 180)
			surface.DrawRect(scrx - 75, scry + 200, 150 * ratio, 16)

			surface.SetDrawColor(0, 0, 0, 200)
			surface.SetMaterial(grad_d)
			surface.DrawTexturedRect(scrx - 75, scry + 200, 150 * ratio, 16)
		end

		draw.SimpleText("Bow Power", "ChatFont", scrx, scry + 207, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

SWEP.PrintName = "Morrowind Bow"

SWEP.Base = "weapon_tttbase"
SWEP.AutoSpawnable = false
SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_RIFLE

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= true

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/steel/shortbow/v_steel_shortbow.mdl"
SWEP.WorldModel   = "models/morrowind/steel/shortbow/w_steel_shortbow.mdl"

SWEP.Primary.Damage		= 50 * 2
SWEP.Primary.Delay 		= 0

SWEP.Primary.ClipSize = 10
SWEP.Primary.ClipMax = 20 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Velocity		= 2800					// Arrow speed.
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"
SWEP.AmmoEnt = "item_ammo_357_ttt"
--SWEP.Crosshair				= true

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"
SWEP.HoldType     = "Pistol"
SWEP.QuickFireRatio		= .6			// Changes quickfire damage/velocity, a ratio of normal damage/velocity.
SWEP.MaxHoldTime		= 2				// Must let go after this time. Determines damage/velocity based on time held.

function SWEP:Precache()
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_draw.mp3")
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_pull.mp3")
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_shoot.mp3")
end

function SWEP:Initialize()
	self:SetWeaponHoldType("Pistol")
	self:SetZoomed(false)
	self:CreateArrow()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "HoldTime")
	self:NetworkVar("Float", 1, "AnimationResetTime")
	self:NetworkVar("Bool", 1, "Zoomed")
	self:NetworkVar("Entity", 0, "Arrow")
end

function SWEP:ResetNetworkable()
	self:SetHoldTime(0)
	self.UnpredictedHoldTime = 0
	self:SetAnimationResetTime(0)
	self:SetZoomed(false)
end

function SWEP:Deploy()
	self:EmitSound("weapons/bow/skyrim_bow_draw.mp3")
	self:SetNextPrimaryFire(CurTime())
	local vm = self.Owner:GetViewModel()
	if (vm:IsValid()) then
		vm:SetPlaybackRate(1)
	end
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:ResetNetworkable()
	return true
end

function SWEP:Holster()
	self:SetZoomed(false)
	if SERVER then
		self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
	end
	return true
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	if (self:GetHoldTime() ~= 0) then return end
	if (not self:CanPrimaryAttack()) then return end

	self:SendWeaponAnim(ACT_VM_RELOAD)

	local vm = self.Owner:GetViewModel()
	if (vm:IsValid()) then
		vm:SetPlaybackRate(1)
	end

	self:SetHoldTime(CurTime())
	if (IsFirstTimePredicted()) then
		self.UnpredictedHoldTime = SysTime()
	end

	self:EmitSound("weapons/bow/skyrim_bow_pull.mp3")
end

function SWEP:CanPrimaryAttack()
	if not IsValid(self.Owner) then return end

	if self:Clip1() <= 0 then
		self:DryFire(self.SetNextPrimaryFire)
		return false
	end
	return true
end

/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()
	if !self.Owner:IsValid() or !self.Owner:IsPlayer() then return end

	if self:GetHoldTime() ~= 0 then
		if (!self.Owner:KeyDown(IN_ATTACK)) then
			local vm = self.Owner:GetViewModel()
			if (vm:IsValid()) then
				vm:SetPlaybackRate(1)
			end
			self:ShootArrow()
			if SERVER then
				Damagelog:shootCallback(self)
			end
		end
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	end

	if (self:GetAnimationResetTime() ~= 0 and self:GetAnimationResetTime() < CurTime()) then
		self:SetAnimationResetTime(0)
		local anim = self.Owner:GetViewModel():LookupSequence("idle")
		self.Owner:GetViewModel():ResetSequence(anim)
		self.Owner:GetViewModel():SetPlaybackRate(1)
//		self.Owner:GetViewModel():SetCycle(10)
	end

end

function SWEP:CreateArrow()
	if (not SERVER) then return end
	self:SetArrow(ents.Create "ent_mor_arrow")
	self:GetArrow():SetRenderMode(RENDERMODE_NONE)
end

/*---------------------------------------------------------
   Name: SWEP:ShootArrow()
   Desc: Hot Potato.
---------------------------------------------------------*/
function SWEP:ShootArrow()
	local anim = self.Owner:GetViewModel():LookupSequence("shoot"..math.random(4,6))
	self.Owner:GetViewModel():SetSequence(anim)
	self.Owner:GetViewModel():SetPlaybackRate(4)
	self:SetAnimationResetTime(CurTime() + 0.2)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetHoldTime(0)
	if (IsFirstTimePredicted()) then
		self.UnpredictedHoldTime = 0
	end

	local ratio = math.Clamp((CurTime() - self:GetHoldTime()) / self.MaxHoldTime, 0.1, 1)
	self:EmitSound("weapons/bow/skyrim_bow_shoot.mp3")

	local arrow = self:GetArrow()
	arrow:SetRenderMode(RENDERMODE_NORMAL)
	arrow:SetModel("models/morrowind/steel/arrow/steelarrow.mdl")
	self:CreateArrow()
	arrow:SetAngles(self.Owner:EyeAngles())
	local pos = self.Owner:GetShootPos()
	pos = pos + self.Owner:GetUp() * -3
	arrow:SetPos(pos)
	arrow:SetOwner(self.Owner)
	arrow.Weapon = self		-- Used to set the arrow's killicon.
	arrow.Damage = self.Primary.Damage * ratio
	arrow:SetAngles(self.Owner:EyeAngles() + Angle(0, 180, 0))
	arrow:Spawn()
	arrow:Activate()
	//		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	arrow.Velocity = self.Owner:GetAimVector() * 5000 * ratio
	arrow:SetFirer(self.Owner)
	self:SetNextPrimaryFire(CurTime())
	self:TakePrimaryAmmo(1)
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	 if not self:GetZoomed() then -- The player is not zoomed in.
		self:SetZoomed(true)
		self.Owner:SetFOV( 35, 0.3 )
	else
		self:SetZoomed(false)
		self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
	end
end

function SWEP:Reload()
	if (self:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0) then return end
	self:DefaultReload(0)
	self:SetZoomed(false)
	self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
end

function MorBowArrow(ent, ragdoll)
	if ent:IsNPC() then
		for k, v in pairs(ents.FindByClass("ent_mor_arrow")) do
			if v:GetParent() == ent then
				v:SetParent(ragdoll)
			end
		end
	end
end

hook.Add( "CreateEntityRagdoll", "MorBowArrow", MorBowArrow)