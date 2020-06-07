AddCSLuaFile()

SWEP.HoldType           = "ar2"

if CLIENT then
   SWEP.Slot               = 2
   SWEP.Icon = "vgui/ttt/icon_scout"
   SWEP.IconLetter = "n"
end

SWEP.PrintName          = "SR-25"
SWEP.Base               = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_RIFLE

SWEP.Primary.Delay          = 0.5
SWEP.Primary.Recoil         = 2.5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 35
SWEP.Primary.Cone = 0.005
SWEP.Primary.ClipSize = 16
SWEP.Primary.ClipMax = 48 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 16

SWEP.HeadshotMultiplier = 5

SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_357_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/a_sr-25.mdl"
SWEP.WorldModel			= "models/weapons/b_sr25.mdl"

SWEP.Primary.Sound = Sound("Weapof_SR25.Shoot")

SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.IronSightsPos      = Vector( 5, -15, -2 )
SWEP.IronSightsAng      = Vector( 2.6, 1.37, 3.5 )
SWEP.Scope = true

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 3,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 3,
	}
}

function SWEP:SetZoom(state)
   if not (IsValid(self.Owner) and self.Owner:IsPlayer()) then return end
      if state then
         self.Owner:SetFOV(20, 0.3)
      else
         self.Owner:SetFOV(0, 0.2)
      end
end

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope")
   function SWEP:DrawHUD()
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

         gap = 0
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
         surface.DrawLine(x, y, x + 1, y + 1)

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


--[[local RecoilMul = CreateConVar ("mad_recoilmul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local DamageMul = CreateConVar ("mad_damagemul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local AccuracyMul = CreateConVar ("sim_accuracymul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Walkspeed = CreateConVar ("sim_walk_speed", "250", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Runspeed = CreateConVar ("sim_run_speed", "500", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local WeightMod	= CreateClientConVar("sim_weightmod_t", 1, true, false)		// Enable/Disable
local ManualHolster	= CreateClientConVar("sim_manualholster_t", 1, true, false)		// Enable/Disable
local EnableShell	= CreateClientConVar("sim_shell_t", 1, true, false)		// Enable/Disable
local EnableFlash	= CreateClientConVar("sim_flash_t", 1, true, false)		// Enable/Disable
// Variables that are used on both client and server
SWEP.Instructions			= "Uses 7.62mm Nato ammo, Deploy Bipod: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_tttbase"
SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_sr-25.mdl"
SWEP.WorldModel			= "models/weapons/b_sr25.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.AutoSpawnable      = false

SWEP.Primary.Sound 		= Sound("Weapof_SR25.Shoot")
SWEP.Primary.Recoil		= 3
SWEP.Primary.Damage		= 50
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0009
SWEP.Primary.Delay 		= 0.14

SWEP.Primary.ClipSize		= 10					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false			// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_762x51"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02

SWEP.IronSightsPos = Vector (-2.7896, -5.0002, 1.35)
SWEP.IronSightsAng = Vector (-0.0659, 0.0126, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)
SWEP.ScopeZooms			= {8}

SWEP.Pistol				= false
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= true

SWEP.Type				= 0 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= ""
SWEP.data.ModeMsg			= ""
SWEP.data.Delay			= 1.25
SWEP.data.Cone			= 1
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 0.25
SWEP.data.Automatic		= false

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_RIFLE

SWEP.Speed = 0.5
SWEP.Mass = 0.75
SWEP.WeaponName = "weapon_fas_sr25"
SWEP.WeaponEntName = "sim_fas_sr25"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/sniper_sr25/sr25_fire1.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_fire2.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_fire3.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_fire4.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_fire5.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_magout.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_magin.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_magslap.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_charge.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_boltcatch.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_boltcatchslap.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_boltcatchhandle.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_stockpull.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_stocklock.wav")
	util.PrecacheSound("weapons/sniper_sr25/sr25_safety.wav")
	util.PrecacheSound("weapons/accessories/harrisbipod_up1.wav")
	util.PrecacheSound("weapons/accessories/harrisbipod_up2.wav")
	util.PrecacheSound("weapons/accessories/harrisbipod_down1.wav")
	util.PrecacheSound("weapons/accessories/harrisbipod_down2.wav")
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
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()
	if (self.Weapon:GetDTBool(3)) then
		if (self.Weapon:Clip1() == 0) then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_fire_last"))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_fire" .. math.random(1, 3)))
		end
	else
		if (self.Weapon:Clip1() == 0) then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("fire_last"))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("fire" .. math.random(1, 3)))
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
		// Holst/Deploy your fucking weapon
	if (not self.Owner:IsNPC() and not self.Owner:KeyDown(IN_SPEED) and not self.Weapon:GetDTBool(3) and not self.Owner:KeyDown(IN_RELOAD) and self.Owner:KeyDown(IN_USE)) then
		
		if (SERVER) then
			bHolsted = !self.Weapon:GetDTBool(0)
			self:SetHolsted(bHolsted)
		end

		self.Weapon:SetNextPrimaryFire(CurTime() + 1.0)
		self.Weapon:SetNextSecondaryFire(CurTime() + 1.0)

		self:SetIronsights(false)

		return
	end

	if (not self:CanPrimaryAttack()) then return end
	
	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.05)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	// If the burst mode is activated, it's going to shoot the three bullets (or more if you're dumb and put 4 or 5 bullets for your burst mode)
	if self.Weapon:GetNetworkedBool("Burst") then
		self.BurstTimer 	= CurTime()
		self.BurstCounter = self.BurstShots - 1
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	end

	if (not self.Owner:IsNPC()) and (self.BoltActionSniper) and (self.Weapon:GetDTBool(1)) then
		self:ResetVariables()
		self.ScopeAfterShoot = true

		timer.Simple(self.Primary.Delay, function()
			if not self.Owner then return end

			if (self.ScopeAfterShoot) and (self.Weapon:Clip1() > 0) then
				self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
				self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
				self:SetIronsights(true)
			end
		end)
	end

	self.Weapon:EmitSound(self.Primary.Sound)

	self:TakePrimaryAmmo(1)

	self:ShootBulletInformation()
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
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("bipod_down_empty"))
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("bipod_down"))
			end
		else
			if (self.Weapon:Clip1() == 0) then
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
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle_empty"))
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

	if self.Weapon:GetNetworkedBool("Burst") then
		if self.BurstTimer + self.BurstDelay < CurTime() then
			if self.BurstCounter > 0 then
				self.BurstCounter = self.BurstCounter - 1
				self.BurstTimer = CurTime()
				
				if self:CanPrimaryAttack() then
					self.Weapon:EmitSound(self.Primary.Sound)
					self:ShootBulletInformation()
					self:TakePrimaryAmmo(1)
				end
			end
		end
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
   Name: SWEP:Holster()
---------------------------------------------------------*/
function SWEP:Holster()

//	self.Weapon:SetMode(false)
	self.Weapon:SetNetworkedBool("Mode", false)
	self:ResetSpeed()
	self:ResetVariables()
	if ManualHolster:GetBool() then
		if self.Weapon:GetDTBool(0) or self.Owner:InVehicle() then
			return true
		end
	else	
		return true
	end
end

/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()

	if (self.Weapon:GetDTBool(3)) then
		if self.Weapon:Clip1() == 0 then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("bipod_reload_empty"))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()	
			Animation:SetSequence(Animation:LookupSequence("bipod_reload"))
			timer.Simple(self.Owner:GetViewModel():SequenceDuration() + 0.03, function()
			if (not IsValid(self.Owner) or not IsValid(self.Weapon) or not self.Owner:Alive())then return end
			self:SetClip1( self.Primary.ClipSize + 1 )
			self.Owner:RemoveAmmo( 1, self:GetPrimaryAmmoType() )
		end)
		end
	else
		if self.Weapon:Clip1() == 0 then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload_empty"))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("reload"))
			timer.Simple(self.Owner:GetViewModel():SequenceDuration() + 0.01, function()
			if (not IsValid(self.Owner) or not IsValid(self.Weapon) or not self.Owner:Alive())then return end
			self:SetClip1( self.Primary.ClipSize + 1 )
			self.Owner:RemoveAmmo( 1, self:GetPrimaryAmmoType() )
		end)
		end
	end 

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootEffects()
   Desc: A convenience function to shoot negroes.
---------------------------------------------------------*/
function SWEP:ShootEffects()
	
	self:ShootAnimation()
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	local effectdata = EffectData()
		effectdata:SetOrigin(self.Owner:GetShootPos())
		effectdata:SetEntity(self.Weapon)
		effectdata:SetStart(self.Owner:GetShootPos())
		effectdata:SetNormal(self.Owner:GetAimVector())
		effectdata:SetAttachment(1)

	// Add a timer to solve this problem : in multiplayer, when you aim with the ironsights, tracers, effects, etc. still come from where the barrel is when you don't aim with ironsights
	if EnableFlash:GetBool() then
	timer.Simple(0, function()
		if not IsValid(self.Owner) then return end
		if (not IsFirstTimePredicted() or not self.Owner:Alive())then return end
		util.Effect("effect_sim_silsmoke", effectdata)
		
	end)
	end
	
	// Shell eject
	
	if EnableShell:GetBool() then
	timer.Simple(self.ShellDelay, function()
		if not IsValid(self.Owner) then return end
		if (not IsFirstTimePredicted() or not self.Owner:Alive())then return end

		local effectdata = EffectData()
			effectdata:SetEntity(self.Weapon)
			effectdata:SetNormal(self.Owner:GetAimVector())
			effectdata:SetAttachment(2)
		util.Effect(self.ShellEffect, effectdata)
	end)
	end
	
	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
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