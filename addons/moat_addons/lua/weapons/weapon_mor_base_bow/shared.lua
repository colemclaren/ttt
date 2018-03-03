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
		if self:GetDTFloat(0) != 0 then
			local ratio = math.Clamp((self.MaxHoldTime + CurTime() - self:GetDTFloat(0))/(self.MaxHoldTime * .5), .5, 1)
			ratio = 2 * (ratio - .5)
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
SWEP.MaxHoldTime		= 3				// Must let go after this time. Determines damage/velocity based on time held.
//Do not touch.
//SWEP.FiredArrow			= false

function SWEP:Precache()
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_draw.mp3")
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_pull.mp3")
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_shoot.mp3")
end

function SWEP:Initialize()
	self:SetWeaponHoldType("Pistol")
	self:SetZoomed(false)
end

function SWEP:SetupDataTables()
	self:DTVar("Bool", 0, "FiredArrow")
	self:DTVar("Float", 0, "HoldTimer")
	self:NetworkVar("Bool", 1, "Zoomed")
	self:NetworkVar("Float", 1, "DelayTime")
end

function SWEP:Deploy()
	self:EmitSound("weapons/bow/skyrim_bow_draw.mp3")
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
	self:SetDelayTime(CurTime() + 1)
	if (SERVER) then
		local vm = self.Owner:GetViewModel()
		if (vm:IsValid()) then
			vm:SetPlaybackRate(1)
		end
	end
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetDTBool(0, false)
	self:SetDTFloat(0, 0)
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
	self:SendWeaponAnim(ACT_VM_RELOAD)

	if (SERVER) then
		local vm = self.Owner:GetViewModel()
		if (vm:IsValid()) then
			vm:SetPlaybackRate(1)
		end
	end

	self:EmitSound("weapons/bow/skyrim_bow_pull.mp3")
	self:SetDelayTime(CurTime() + 0.5)
	self:SetDTFloat(0, CurTime() + self.MaxHoldTime)
	self:SetNextPrimaryFire(self:GetDTFloat(0))
end

function SWEP:CanPrimaryAttack()
	if not IsValid(self.Owner) then return end
	if (self:GetDelayTime() > CurTime()) then return end

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

	if self:GetDTFloat(0) != 0 and self:GetDelayTime() < CurTime() and self:GetDTBool(0) == false then
		if !self.Owner:KeyDown(IN_ATTACK) then
			if SERVER then
				local vm = self.Owner:GetViewModel()
				if (vm:IsValid()) then
					vm:SetPlaybackRate(1)
				end
				self:ShootArrow()
				Damagelog:shootCallback(self)
			end
			self:SetDTBool(0, true)
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
			self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootArrow()
   Desc: Hot Potato.
---------------------------------------------------------*/
function SWEP:ShootArrow()
	if self:GetDelayTime() > CurTime() then return end
	local anim = self.Owner:GetViewModel():LookupSequence("shoot"..math.random(4,6))
	self.Owner:GetViewModel():SetSequence(anim)
	self.Owner:GetViewModel():SetPlaybackRate(4)
	timer.Simple(.2, function()
		if not self.Owner or not self.Owner:IsValid() then return end
		local anim = self.Owner:GetViewModel():LookupSequence("idle")
		self.Owner:GetViewModel():ResetSequence(anim)
		self.Owner:GetViewModel():SetPlaybackRate(1)
//		self.Owner:GetViewModel():SetCycle(10)
	end)
	timer.Simple(.2, function()
		if !self.Owner then return end
		local ratio = math.Clamp((self.MaxHoldTime + CurTime() - self:GetDTFloat(0))/(self.MaxHoldTime * .5), .5, 1)
		self.Weapon:EmitSound("weapons/bow/skyrim_bow_shoot.mp3")
		
		local arrow = ents.Create("ent_mor_arrow")
		if SERVER then
			arrow:SetAngles(self.Owner:EyeAngles())
			local pos = self.Owner:GetShootPos()
				pos = pos + self.Owner:GetUp() * -3
			arrow:SetPos(pos)
			arrow:SetOwner(self.Owner)
			arrow.Weapon = self		// Used to set the arrow's killicon.
			arrow.Damage = (self.Primary.Damage * ratio)
			arrow:SetAngles(self.Owner:EyeAngles() + Angle(0, 180, 0))
			local trail = util.SpriteTrail(arrow, 0, Color(255, 255, 255, 100), false, 5, 5, 0.05, 1/(15+1)*0.5, "trails/plasma.vmt")
			arrow.Trail = trail
			arrow:Spawn()
			arrow:Activate()
		end
		//		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:SetDTFloat(0, 0)
		self:SetDTBool(0, false)
		if SERVER then
			local phys = arrow:GetPhysicsObject()
			phys:SetVelocity(self.Owner:GetAimVector() * 5000 * ratio)
			arrow:SetOwner(self.Owner)
		end
		self:SetNextPrimaryFire(CurTime())
		self:SetNextSecondaryFire(CurTime())
		self:TakePrimaryAmmo(1)
	end)
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
	if SERVER then
		self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
	end
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