--[[local RecoilMul = CreateConVar ("mad_recoilmul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local RecoilMul = CreateConVar ("mad_recoilmul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local DamageMul = CreateConVar ("mad_damagemul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local AccuracyMul = CreateConVar ("sim_accuracymul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Walkspeed = CreateConVar ("sim_walk_speed", "250", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Runspeed = CreateConVar ("sim_run_speed", "500", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local WeightMod	= CreateClientConVar("sim_weightmod_t", 1, true, false)		// Enable/Disable
local ManualHolster	= CreateClientConVar("sim_manualholster_t", 1, true, false)		// Enable/Disable

SWEP.ViewModelFOV      = 55
SWEP.Instructions			= "Uses 7.62mm Nato ammo, Deploy Bipod: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base				= "weapon_fas_sim_base_snip"
SWEP.ViewModelFlip		= false
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.HoldType				= "ar2"
SWEP.ViewModel			= "models/weapons/a_m24.mdl"
SWEP.WorldModel			= "models/weapons/b_m24.mdl"

SWEP.Primary.Sound			= Sound( "Weapof_m24.Shoot" )
SWEP.Primary.Recoil			= 3.5
SWEP.Primary.Damage			= 55
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0008
SWEP.Primary.ClipSize		= 5
SWEP.Primary.Delay			= 1.8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "AR2"
SWEP.ShellEffect			= "sim_shelleject_fas_762x51"
SWEP.Pistol				= false
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= true
SWEP.ShellDelay			= .83
	
SWEP.Type				= 0 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= ""
SWEP.data.ModeMsg			= ""
SWEP.data.Delay			= 1.25
SWEP.data.Cone			= 1
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 0.5
SWEP.data.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)
---------------------------
-- Ironsight/Scope --
---------------------------
-- IronSightsPos and IronSightsAng are model specific paramaters that tell the game where to move the weapon viewmodel in ironsight mode.
SWEP.IronSightsPos = Vector (-2.5028, -3.001, 0.7263)
SWEP.IronSightsAng = Vector (0.0683, 0.004, 0)
SWEP.ScopeZooms			= {8}

SWEP.BoltActionSniper		= true

SWEP.Speed = 0.5
SWEP.Mass = 0.75
SWEP.WeaponName = "weapon_fas_m24"
SWEP.WeaponEntName = "sim_fas_m24"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/spring_shoot.wav")
end

/*---------------------------------------------------------
   Name: SWEP:DeployAnimation()
---------------------------------------------------------*/
function SWEP:DeployAnimation()

//	self.Weapon:SetMode(false)
	self.Weapon:SetDTBool(3, false)
	self.Weapon:SetNW2Int("NextChangeMode", CurTime())

	if (self.Weapon:Clip1() == 0) then
		self.Weapon:EmitSound("Defaulf.Draw")
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW_EMPTY)
	else
		self.Weapon:EmitSound("Defaulf.Holster")
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
end

/*---------------------------------------------------------
   Name: SWEP:Holster()
   Desc: Weapon wants to holster.
	   Return true to allow the weapon to holster.
---------------------------------------------------------*/
function SWEP:Holster()
	self:ResetVariables()
	self:ResetSpeed()
	if ManualHolster:GetBool() then
		if self.Weapon:GetDTBool(0) or self.Owner:InVehicle() then
			return true
		end
	else	
		return true
	end
end
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	// Holst/Deploy your fucking weapon
	if (not self.Owner:IsNPC() and not self.Owner:KeyDown(IN_SPEED) and not self.Weapon:GetDTBool(3) and not self.Owner:KeyDown(IN_RELOAD) and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self.Weapon:SetNextPrimaryFire(CurTime() + 1.0)
		self.Weapon:SetNextSecondaryFire(CurTime() + 1.0)

		self:SetIronsights(false)

		return
	end

	if (not self:CanPrimaryAttack()) then return end
	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.05)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Weapon:EmitSound(self.Primary.Sound)
	self:TakePrimaryAmmo(1)
	self:ShootBulletInformation()
	
	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration() + 0.5)
	end

	if (not self.Owner:IsNPC()) and (self.BoltActionSniper) and (self.Weapon:GetDTBool(1)) then
		
		timer.Simple(self.Primary.Delay, function()
			if not self.Owner then return end

			if (self.ScopeAfterShoot) and (self.Weapon:Clip1() > 0) then
				self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
				self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
				self:SetIronsights(true)
			end
		end)
	end

	
	timer.Simple(0.5, function()
		if not self.Owner or not IsFirstTimePredicted() or self.Weapon:Clip1() == 0 then return end
		self:ResetVariables()
		self:ResetSpeed()
		self.ScopeAfterShoot = true
		if (self.Weapon:GetDTBool(3)) then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_cock0" .. math.random(1, 3)))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("cock0" .. math.random(1, 3)))
		end

		if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
			self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
		end
	end)
end
/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	
	if self.Owner:IsNPC() then return end
	if not IsFirstTimePredicted() then return end

	if (self.Owner:KeyDown(IN_USE) and (self.Mode)) then // Mode
		local tr = {}
		tr.start = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 25)
		tr.endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 25) - Vector(0, 0, 36)
		tr.filter = self.Owner
		tr.mask = MASK_SHOT
		local trace = util.TraceLine(tr)

		if (trace.Hit and (self.Mode) and not self.Weapon:GetDTBool(0) and self.Owner:GetVelocity():Length() < 25) then // Mode

			bMode = !self.Weapon:GetDTBool(3)
			self:SetMode(bMode)

			self.Weapon:SetNextPrimaryFire(CurTime() + self.data.Delay)
			self.Weapon:SetNextSecondaryFire(CurTime() + self.data.Delay)
			self.ActionDelay = (CurTime() + self.data.Delay)

			self:SetIronsights(false)

			self.Weapon:SetNW2Int("NextChangeMode", CurTime() + self.data.Delay)

			return
		end
	end
	
	if (!self.IronSightsPos) or (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0)) then return end
	
	// Not pressing Use + Right click? Ironsights
	bIronsights = !self.Weapon:GetDTBool(1)
	self:SetIronsights(bIronsights)

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
end

/*---------------------------------------------------------
   Name: SWEP:SetMode()
---------------------------------------------------------*/
function SWEP:SetMode(b)

	if (self.Owner) then
		if (b) then
			self.Weapon:EmitSound("Weapof_M82.BipodDown")
			if self.Weapon:Clip1() == 0 then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("bipod_down_empty"))
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()	
				Animation:SetSequence(Animation:LookupSequence("bipod_down"))
			end
		else
			self.Weapon:EmitSound("Weapof_M82.BipodUp")
			if self.Weapon:Clip1() == 0 then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("bipod_up_empty"))
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("bipod_up"))
			end
		end
	end
	
	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(3, b)
	end
end

/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()

	self:SecondThink()

	if self.IdleDelay < CurTime() and self.IdleApply and self.Weapon:Clip1() > 0 then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			if (self.Weapon:GetDTBool(3)) then
				if self.Weapon:Clip1() == 0 then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("bipod_idle_empty"))
				else
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()	
					Animation:SetSequence(Animation:LookupSequence("bipod_idle"))
				end
			else
				if self.Weapon:Clip1() == 0 then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE_EMPTY)
				else
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle"))
				end
			end 

			if self.AllowPlaybackRate and not self.Weapon:GetDTBool(1) then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			else
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end	
		end

		self.IdleApply = false
	elseif self.Weapon:Clip1() <= 0 then
		self.IdleApply = false
	end

	if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) and self.Owner:KeyDown(IN_SPEED) then
		if WeightMod:GetBool() then
			self.Owner:SetRunSpeed(Runspeed:GetFloat()*self.Mass)
			self.Owner:SetWalkSpeed(Walkspeed:GetFloat()*self.Mass)
		else
			self:ResetSpeed()
		end	
		self:ResetVariables()
		self.Owner:SetFOV(0, 0.2)
	end

	if (self.BoltActionSniper) and (self.Owner:KeyPressed(IN_ATTACK2) or self.Owner:KeyPressed(IN_RELOAD)) then
		self.ScopeAfterShoot = false
	end
	
	// If you're running or if your weapon is holsted, the third person animation is going to change
	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then
		if (self.BoltActionSniper) then
			self.ScopeAfterShoot = false
		end	
	
		if self.Rifle or self.Sniper or self.Shotgun then
			if self.Owner:KeyDown(IN_DUCK) then
				self:SetWeaponHoldType("normal")
			else
				self:SetWeaponHoldType("passive")
			end

		elseif self.Pistol then
			self:SetWeaponHoldType("normal")
		end
	else
		self:SetWeaponHoldType(self.HoldType)
	end	

	if (CLIENT) and (self.Weapon:GetDTBool(2)) then
		self.MouseSensitivity = self.Owner:GetFOV() / 60
	else
		self.MouseSensitivity = 1
	end

	if not (CLIENT) and (self.Weapon:GetDTBool(2)) and (self.Weapon:GetDTBool(1)) then
		self.Owner:DrawViewModel(false)
	elseif not (CLIENT) then
		self.Owner:DrawViewModel(true)
	end

	self:NextThink(CurTime())
end

/*---------------------------------------------------------
   Name: SWEP:SecondThink()
   Desc: Called every frame. Use this function if you don't 
	   want to copy/past the think function everytime you 
	   create a new weapon with this base...
---------------------------------------------------------*/
function SWEP:SecondThink()

	local tr = {}
	tr.start = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 25)
	tr.endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 25) - Vector(0, 0, 36)
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine(tr)

	if (self.Weapon:GetDTBool(3)) and self.Weapon:GetNW2Int("NextChangeMode") < CurTime() then
		if (not trace.Hit or self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) or not self.Owner:IsOnGround() or self.Owner:GetVelocity():Length() > 25) then
			self:SetMode(false)
			self:SetIronsights(false)
			self.Weapon:SetNextPrimaryFire(CurTime() + 1.25)
			self.Weapon:SetNextSecondaryFire(CurTime() + 1.25)
		end	
	end
end


/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:GetDTBool(3)) then
		if (self.Weapon:Clip1() == 0) then
 			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_fire_last"))
			self.ShellEffect = ""
		else
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_fire_last"))
		end
	else	
		if (self.Weapon:Clip1() == 0) then
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.ShellEffect = ""
		else
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		end
	end
end


/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()
	
	if (self.Weapon:GetDTBool(3)) then
	
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 4) then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload_empty"))
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload_empty1"))	
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload_empty2"))	
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 3) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload_empty3"))	
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 4) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload_empty4"))
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload1"))	
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload2"))	
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload3"))	
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 4) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload4"))
		end
		if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload1"))	
		end
		if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload2"))	
		end
		if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload3"))	
		end
		if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload1"))			
		end
		if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload2"))			
		end
		if (self.Weapon:Clip1() == 4) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload1"))			
		end
	else
		
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 4) then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload_empty"))
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload_empty1"))	
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload_empty2"))	
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 3) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload_empty3"))	
		end
		if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 4) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload_empty4"))
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload1"))	
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload2"))	
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload3"))	
		end
		if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 4) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload4"))
		end
		if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload1"))	
		end
		if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload2"))	
		end
		if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload3"))	
		end
		if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload1"))			
		end
		if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload2"))			
		end
		if (self.Weapon:Clip1() == 4) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload1"))			
		end
	end

	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
       	    	     local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
       	    	     self.ReloadingTime = CurTime() + AnimationTime
       	    	     self:SetNextPrimaryFire(CurTime() + AnimationTime)
       	    	     self:SetNextSecondaryFire(CurTime() + AnimationTime)
	end
	
	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootBulletInformation()
   Desc: This function add the damage, the recoil, the number of shots and the cone on the bullet.
---------------------------------------------------------*/
function SWEP:ShootBulletInformation()

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone

	local LastAccuracy 	= self.LastAccuracy or 0
	local Accuracy 		= 1.0
	local LastShoot 		= self.Weapon:GetNetworkedFloat("LastShootTime", 0)
	local Speed 		= self.Owner:GetVelocity():Length()

	local SpeedClamp = math.Clamp(math.abs(Speed / 705), 0, 1)

	
	// Player is not on the ground
	if not self.Owner:IsOnGround() then
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() * (((1 - SpeedClamp) + 0.1) / 2) 
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil), math.Rand(-1, 1) * (CurrentRecoil), 0))
		// Player is not aiming
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() * 7 * (((1 - SpeedClamp) + 0.1) / 2) 
			self:ShootBullet(CurrentDamage, CurrentRecoil * 2.5, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 2.5), math.Rand(-1, 1) * (CurrentRecoil * 2.5), 0))
		end
	// Player is moving
	
	elseif self.Owner:KeyDown (bit.bor( IN_FORWARD, IN_BACK, IN_MOVELEFT, IN_MOVERIGHT )) then
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() 			
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 1.5), math.Rand(-1, 1) * (CurrentRecoil / 1.5), 0))
		// Player is not aiming
		elseif (Speed > 10) then	
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 7 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil * 1.5, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 1.5), math.Rand(-1, 1) * (CurrentRecoil * 1.5), 0))
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 2 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * CurrentRecoil, math.Rand(-1, 1) * CurrentRecoil, 0))
		end
	// Player is crouching
	elseif self.Owner:Crouching() then
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, 0, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 3), math.Rand(-1, 1) * (CurrentRecoil / 3), 0))
		// Player is not aiming
		elseif self.Weapon:GetDTBool(3) then
			CurrentDamage = self.Primary.Damage * self.data.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * self.data.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * self.data.Cone
			self:ShootBullet(CurrentDamage, 0, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 3), math.Rand(-1, 1) * (CurrentRecoil / 3), 0))
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 5 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
		end
	// Player is doing nothing
	else
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil / 6, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
		// Player is not aiming
		elseif self.Weapon:GetDTBool(3) then
			CurrentDamage = self.Primary.Damage * self.data.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * self.data.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * self.data.Cone
			self:ShootBullet(CurrentDamage, CurrentRecoil / 6, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 6 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * CurrentRecoil, math.Rand(-1, 1) * CurrentRecoil, 0))
		end
	end
end]]

AddCSLuaFile()

SWEP.HoldType           = "ar2"

if CLIENT then
   SWEP.Slot               = 2
   SWEP.Icon = "vgui/ttt/icon_scout"
   SWEP.IconLetter = "n"
end

SWEP.PrintName          = "M24"
SWEP.Base               = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_RIFLE

SWEP.Primary.Delay          = 1.5
SWEP.Primary.Recoil         = 7
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 50
SWEP.Primary.Cone = 0.000001
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 18 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 6

SWEP.HeadshotMultiplier = 5

SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_357_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 55
SWEP.ViewModel			= "models/weapons/a_m24.mdl"
SWEP.WorldModel			= "models/weapons/b_m24.mdl"

SWEP.Primary.Sound = Sound(")weapons/usp/usp1.wav")
SWEP.PrimaryAnim = {"cock01", "cock02", "cock03"}
SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.IronSightsPos      = Vector( 5, -15, -2 )
SWEP.IronSightsAng      = Vector( 2.6, 1.37, 3.5 )
SWEP.IsZoomed = 0
SWEP.Scope = true

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1.4
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload4",
		Time = 5.25,
		Act = ACT_VM_IDLE
	},
	DefaultReload4 = {
		Anim = "reload4",
		Time = 5.25,
		Act = ACT_VM_IDLE
	},
	DefaultReload3 = {
		Anim = "reload3",
		Time = 4.875,
		Act = ACT_VM_IDLE
	},
	DefaultReload2 = {
		Anim = "reload2",
		Time = 4.5,
		Act = ACT_VM_IDLE
	},
	DefaultReload1 = {
		Anim = "reload1",
		Time = 4.125,
		Act = ACT_VM_IDLE
	},
	ReloadEmpty1 = {
		Anim = "reload_empty1",
		Time = 3,
		Act = ACT_VM_IDLE
	},
	ReloadEmpty2 = {
		Anim = "reload_empty2",
		Time = 3.375,
		Act = ACT_VM_IDLE
	},
	ReloadEmpty3 = {
		Anim = "reload_empty3",
		Time = 3.75,
		Act = ACT_VM_IDLE
	},
	ReloadEmpty4 = {
		Anim = "reload_empty4",
		Time = 4.125,
		Act = ACT_VM_IDLE
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 4.5,
		Act = ACT_VM_IDLE
	}
}

function SWEP:LastShot(self)
	// self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	return true
end

function SWEP:ReloadAnimation(Clip, Ammo, CurrentTime)
	local Need = math.max(self:GetMaxClip1() - Clip, 0)

	if (Clip == 0 and Ammo > 4) then
		return "ReloadEmpty"
	end

	if (Clip == 0 and Ammo == 1) then
		return "ReloadEmpty1"
	end

	if (Clip == 0 and Ammo == 2) then
		return "ReloadEmpty2"
	end

	if (Clip == 0 and Ammo == 3) then
		return "ReloadEmpty3"
	end

	if (Clip == 0 and Ammo == 4) then
		return "ReloadEmpty4"
	end

	if (Need == 1 and Ammo >= 1) then
		return "DefaultReload1"
	end

	if (Need == 2 and Ammo >= 2) then
		return "DefaultReload2"
	end

	if (Need == 3 and Ammo >= 3) then
		return "DefaultReload3"
	end

	if (Need >= 4 and Ammo >= 4) then
		return "DefaultReload4"
	end

	if (Ammo == 1) then
		return "DefaultReload1"
	end

	if (Ammo == 2) then
		return "DefaultReload2"
	end

	if (Ammo == 3) then
		return "DefaultReload3"
	end

	if (Ammo == 4) then
		return "DefaultReload4"
	end

	return (Clip == 0) and "ReloadEmpty" or "DefaultReload"
end

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(20, .3)
   	else
      	self.Owner:SetFOV(0, .2)
   	end
end

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope")
   function SWEP:DrawHUD()
		-- draw.SimpleText("PING: " .. LocalPlayer():Ping() .. " MS", "WinHuge", 50, 50, Color(0, 255, 0))
      if self:GetIronsights() then
         surface.SetDrawColor( 0, 0, 0, 255 )
         
         local scrW = ScrW()
         local scrH = ScrH()

         local x = scrW / 2.0
         local y = scrH / 2.0
         local scope_size = scrH

         -- crosshair
         local gap = 80
         local length = scope_size
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )

         gap = 10
         length = 50
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )


         -- cover edges
         local sh = scope_size / 2
         local w = (x - sh) + 2
         surface.DrawRect(0, 0, w, scope_size)
         surface.DrawRect(x + sh - 2, 0, w, scope_size)
         
         -- cover gaps on top and bottom of screen
         surface.DrawLine( 0, 0, scrW, 0 )
         surface.DrawLine( 0, scrH - 1, scrW, scrH - 1 )

         surface.SetDrawColor(255, 0, 0, 255)
         surface.DrawRect(x - 1, y - 1, 2, 2)

         -- scope
         surface.SetTexture(scope)
         surface.SetDrawColor(255, 255, 255, 255)

         surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)
      else
         return self.BaseClass.DrawHUD(self)
      end
   end

   function SWEP:AdjustMouseSensitivity()
      return (self:GetIronsights() and 0.2) or nil
   end
end