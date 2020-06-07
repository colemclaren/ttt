

AddCSLuaFile()

if (SERVER) then
	util.AddNetworkString "moat_hide_trail"
else
	SWEP.Slot = 2
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.Icon = "vgui/ttt/icon_scout"
end

SWEP.PrintName = "Steel Bow"

SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"

SWEP.AutoSpawnable = false
SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_RIFLE

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= true

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/steel/shortbow/v_steel_shortbow.mdl"
SWEP.WorldModel		= "models/morrowind/steel/shortbow/w_steel_shortbow.mdl"

SWEP.Primary.Damage			= 200
SWEP.Primary.Delay			= 0.3
SWEP.Primary.ClipSize		= 10
SWEP.Primary.ClipMax		= 30 -- keep mirrored to ammo
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Velocity		= 2800					// Arrow speed.
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"
SWEP.Secondary.Ammo			= "none"

SWEP.AmmoEnt = "item_ammo_357_ttt"

SWEP.HoldType = "Pistol"

SWEP.IronSightsPos = Vector(0,0,0)--Vector (-2.7995, -5.0013, 1.9694)
SWEP.IronSightsAng = Vector (0.2422, -0.0422, 0)

SWEP.UnpredictedHoldTime = 0
SWEP.MaxHoldTime = 3				// Must let go after this time. Determines damage/velocity based on time held.
SWEP.ChargeSpeed = 1.5

function SWEP:GetCharge()
	return math.Clamp(((CurTime() - self:GetHoldTime()) * self.ChargeSpeed) / self.MaxHoldTime, .1, 1)
end

function SWEP:Precache()
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_draw.mp3")
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_pull.mp3")
	util.PrecacheSound("sound/weapons/bow/skyrim_bow_shoot.mp3")
end

function SWEP:Initialize()
	BaseClass.Initialize(self)

	self:SetWeaponHoldType("Pistol")
	self:CreateArrow()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 1, "HoldTime")
	self:NetworkVar("Float", 2, "AnimationResetTime")
	self:NetworkVar("Entity", 1, "Arrow")

	return BaseClass.SetupDataTables(self)
end

function SWEP:CalcViewModelView(vm, oeye, oang, eye, ang)
	ang:RotateAroundAxis(ang:Forward(), 10)
	--ang:RotateAroundAxis(ang:Up(), 20)
	ang:RotateAroundAxis(ang:Right(), -15)
	return eye + ang:Forward() * 4, ang
end

function SWEP:ResetNetworkable()
	self:SetHoldTime(0)
	self.UnpredictedHoldTime = 0
	self:SetAnimationResetTime(0)
end

function SWEP:GetHeadshotMultiplier(ply, dmginfo)
	return 3
end

function SWEP:ScaleDamage(ply, hitgroup, dmginfo)
end

function SWEP:EmitBowSound(sound)
	if (not self.Silenced) then
		self:EmitSound(sound)
	end
end

function SWEP:Deploy()
	self:EmitBowSound("weapons/bow/skyrim_bow_draw.mp3")

	self:SetNextPrimaryFire(CurTime())

	local vm = self.Owner:GetViewModel()
	if (IsValid(vm)) then
		vm:SetPlaybackRate(1)
	end

	self:SendWeaponAnim(ACT_VM_DRAW)
	self:ResetNetworkable()

	return BaseClass.Deploy(self)
end

function SWEP:Holster()
	self:SetIronsights(false)
	self:SetZoom(false)

	return BaseClass.Holster(self)
end

function SWEP:PreDrop()
	self:SetZoom(false)
	self:SetIronsights(false)
	return BaseClass.PreDrop(self)
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
	if (IsValid(vm)) then
		vm:SetPlaybackRate(1)
	end

	self:SetHoldTime(CurTime())
	if (IsFirstTimePredicted()) then
		self.UnpredictedHoldTime = SysTime()
	end

	self:EmitBowSound("weapons/bow/skyrim_bow_pull.mp3")
end


/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	if not self.IronSightsPos then return end
	if (not self:CanSecondaryAttack()) then return end

	local bIronsights = not self:GetIronsights()
	self:SetIronsights(bIronsights)
	self:SetZoom(bIronsights)
	
	self:SetNextSecondaryFire( CurTime() + 0.3 )
end


/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: +reload has been pressed.
---------------------------------------------------------*/
function SWEP:Reload()
	if (self:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0) then return end
	
	self:DefaultReload(ACT_RESET)
    self:SetIronsights(false)
    self:SetZoom(false)
end


/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()
	if not (self.Owner:IsValid() and self.Owner:IsPlayer()) then return end

	if (self:GetHoldTime() ~= 0) then
		if (not self.Owner:KeyDown(IN_ATTACK)) then
			local vm = self.Owner:GetViewModel()
			if (IsValid(vm)) then
				vm:SetPlaybackRate(1)
			end

			self:ShootArrow()
			if (SERVER) then
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
	
	local arrow = ents.Create "ent_mor_arrow"
	arrow:SetRenderMode(RENDERMODE_NONE)
	
	self:SetArrow(arrow)
end

function SWEP:ShootArrow()
	local anim = self.Owner:GetViewModel():LookupSequence("shoot"..math.random(4,6))
	self.Owner:GetViewModel():SetSequence(anim)
	self.Owner:GetViewModel():SetPlaybackRate(4)
	self:SetAnimationResetTime(CurTime() + 0.2)

	local ratio = self:GetCharge()
	self:EmitBowSound("weapons/bow/skyrim_bow_shoot.mp3")

	local arrow = self:GetArrow()
	if (not IsValid(arrow)) then
		self:CreateArrow()
		arrow = self:GetArrow()
		if (not IsValid(arrow)) then return end -- hopeless
	end

	arrow:SetRenderMode(RENDERMODE_NORMAL)
	arrow:SetModel("models/morrowind/steel/arrow/steelarrow.mdl")
	arrow:SetAngles(self.Owner:EyeAngles())

	local pos = self.Owner:GetShootPos()
	pos = pos + self.Owner:GetUp() * -3
	arrow:SetNetworkOrigin(pos)
	arrow:SetOwner(self.Owner)
	if (not IsValid(arrow)) then
		if (SERVER and IsValid(arrow)) then arrow:Remove() end
		return
	end

	arrow:SetAbsVelocity(self.Owner:GetAimVector() * 4500 * ratio)
	arrow:SetFirer(self.Owner)
	arrow.Weapon = self		-- Used to set the arrow's killicon.
	arrow.Damage = self.Primary.Damage * ratio ^ 0.7
	arrow:SetAngles(self.Owner:EyeAngles() + Angle(0, 180, 0))
	arrow:Spawn()
	arrow:Activate()

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:TakePrimaryAmmo(1)

	self:SetHoldTime(0)
	if (IsFirstTimePredicted()) then
		self.UnpredictedHoldTime = 0
	end
end

function SWEP:SetZoom(state)
	if not (IsValid(self.Owner) and self.Owner:IsPlayer()) then return end

	if state then
		self.Owner:SetFOV(35, 0.1)	
	else
		self.Owner:SetFOV(0, 0.1)
	end
end

local function MorBowArrow(ent, ragdoll)
	if ent:IsNPC() then
		for k, v in pairs(ents.FindByClass("ent_mor_arrow")) do
			if v:GetParent() == ent then
				v:SetParent(ragdoll)
			end
		end
	end
end

hook.Add( "CreateEntityRagdoll", "MorBowArrow", MorBowArrow)


if (CLIENT) then
	local grad_d = Material("vgui/gradient-d")
	local client = LocalPlayer()
	function SWEP:DrawHUD()
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
		local ratio = 0
		if (self:GetHoldTime() ~= 0) then
			ratio = (self:GetCharge() - 0.1) / 0.9
		end
	
		if self:GetHoldTime() ~= 0 then
			surface.SetDrawColor(183, 183, 183, 15 * ratio)
			surface.DrawOutlinedRect(scrx - 1 - (100 * ratio), scry + 200 - 1, (200 * ratio), 22)


			surface.SetDrawColor(25 + (175 * ratio), 200 - (175 * ratio), 25, 255)

			if (ratio >= 1) then
				surface.SetDrawColor(rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b, 255)
			end

			surface.DrawRect(scrx - 1, scry + 200, 100 * ratio, 20)
			surface.DrawRect(scrx + 1 - (100 * ratio), scry + 200, 100 * ratio, 20)

			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(scrx - (99 * ratio), scry + 200, 198 * ratio, 20)

			surface.SetDrawColor(0, 0, 0, 150)
			surface.SetMaterial(grad_d)
			surface.DrawTexturedRect(scrx - (99 * ratio), scry + 200, 198 * ratio, 20)
			local charge = ""
			/*
			if (self.ChargeSpeed and self.ChargeSpeed > 1) then
				charge = " ... " .. math.Round((self.ChargeSpeed - 1) * 100, 2) .. ""
			end
			*/

			local text, text_y = (ratio >= 1) and "Ready to Fire!" or math.Round(ratio * 100) .. " / 100" .. charge, scry + 209
			draw.SimpleText(text, "moat_Medium4", scrx, text_y, Color(255, 255, 255, 15 + (255 * ratio)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(text, "moat_Medium4s", scrx, text_y, Color(0, 0, 20, (200 * ratio)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	function SWEP:AdjustMouseSensitivity()
		return (self:GetIronsights() and 0.2) or nil
	end
end
