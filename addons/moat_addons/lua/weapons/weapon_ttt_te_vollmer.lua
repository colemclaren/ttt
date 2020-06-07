--[[// Variables that are used on both client and server

local Walkspeed = CreateConVar ("sim_walk_speed", "250", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Runspeed = CreateConVar ("sim_run_speed", "500", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local WeightMod	= CreateClientConVar("sim_weightmod_t", 1, true, false)		// Enable/Disable
local EnableShell	= CreateClientConVar("sim_shell_t", 1, true, false)		// Enable/Disable
local EnableFlash	= CreateClientConVar("sim_flash_t", 1, true, false)		// Enable/Disable

SWEP.Instructions			= "Uses 7.62mm Nato ammo, Switch Weapons: E + Left Click"
SWEP.HoldType				= "smg"
SWEP.Base 				= "weapon_fas_sim_base"

SWEP.ViewModel			= "models/weapons/a_vollmer.mdl"
SWEP.WorldModel			= "models/weapons/b_mc51.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_vollmer.Shoot")
SWEP.Primary.Recoil		= 3
SWEP.Primary.Damage		= 48
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0165
SWEP.Primary.Delay 		= 0.1

SWEP.Primary.ClipSize		= 100					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_762x51"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellEffect2			= "sim_shelleject_fas_mc51link"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-2.4822, -5.0006, 1.1117)
SWEP.IronSightsAng = Vector (0.3693, -0.0079, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Speed = 0.5
SWEP.Mass = 0.7
SWEP.WeaponName = "weapon_fas_vollmer"
SWEP.WeaponEntName = "sim_fas_vollmer"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/m249/m249-1.wav")
end

/*---------------------------------------------------------
   Name: SWEP:DeployAnimation()
---------------------------------------------------------*/
function SWEP:DeployAnimation()


	if (self.Weapon:Clip1() > 8) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy"))
	end
	if (self.Weapon:Clip1() == 8) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy08"))
	end
	if (self.Weapon:Clip1() == 7) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy07"))
	end
	if (self.Weapon:Clip1() == 6) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy06"))
	end
	if (self.Weapon:Clip1() == 5) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy05"))
	end
	if (self.Weapon:Clip1() == 4) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy04"))
	end
	if (self.Weapon:Clip1() == 3) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy03"))
	end
	if (self.Weapon:Clip1() == 2) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy02"))
	end
	if (self.Weapon:Clip1() == 1) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy01"))
	end
	if (self.Weapon:Clip1() == 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("deploy00"))
	end
end

/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()

	self:SecondThink()

	if self.Weapon:Clip1() > 0 and self.IdleDelay < CurTime() and self.IdleApply then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Owner and self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			if (self.Weapon:Clip1() > 8) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle"))
			end
			if (self.Weapon:Clip1() == 8) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle08"))
			end
			if (self.Weapon:Clip1() == 7) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle07"))
			end
			if (self.Weapon:Clip1() == 6) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle06"))
			end
			if (self.Weapon:Clip1() == 5) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle05"))
			end
			if (self.Weapon:Clip1() == 4) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle04"))
			end
			if (self.Weapon:Clip1() == 3) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle03"))
			end
			if (self.Weapon:Clip1() == 2) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle02"))
			end
			if (self.Weapon:Clip1() == 1) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle01"))
			end
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("idle00"))
			end
			
			if self.AllowPlaybackRate and not self.Weapon:GetDTBool(1) then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			else
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end		
		end

		self.IdleApply = false
	elseif self.Weapon:Clip1() == 0 then
		self.IdleApply = false
	end
	
	if self.Weapon:GetDTBool(1) and self.Owner:KeyDown(IN_SPEED) then
		self:SetIronsights(false)
	end
	
	// If you're running or if your weapon is holsted, the third person animation is going to change
	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then
		
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
	// Burst fire mode
	if self.Weapon:GetDTBool(3) and self.Type == 3 then
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

	self:NextThink(CurTime())
end

/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()
		
	if (self.Weapon:Clip1() > 8) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload"))
	end
	if (self.Weapon:Clip1() == 8) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload08"))
	end
	if (self.Weapon:Clip1() == 7) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload07"))
	end
	if (self.Weapon:Clip1() == 6) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload06"))
	end
	if (self.Weapon:Clip1() == 5) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload05"))
	end
	if (self.Weapon:Clip1() == 4) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload04"))
	end
	if (self.Weapon:Clip1() == 3) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload03"))
	end
	if (self.Weapon:Clip1() == 2) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload02"))
	end
	if (self.Weapon:Clip1() == 1) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload01"))
	end
	if (self.Weapon:Clip1() == 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload00"))
	end
end
/*---------------------------------------------------------
   Name: SWEP:SetHolsted()
---------------------------------------------------------*/
function SWEP:SetHolsted(b)

	if (self.Owner) then
		if (b) then
			if (self.Weapon:Clip1() > 8) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster"))
			end	
			if (self.Weapon:Clip1() == 8) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster08"))
			end
			if (self.Weapon:Clip1() == 7) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster07"))
			end
			if (self.Weapon:Clip1() == 6) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster06"))
			end
			if (self.Weapon:Clip1() == 5) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster05"))
			end
			if (self.Weapon:Clip1() == 4) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster04"))
			end
			if (self.Weapon:Clip1() == 3) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster03"))
			end
			if (self.Weapon:Clip1() == 2) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster02"))
			end
			if (self.Weapon:Clip1() == 1) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster01"))
			end
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster00"))
			end
		else
			if (self.Weapon:Clip1() > 8) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy"))
			end	
			if (self.Weapon:Clip1() == 8) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy08"))
			end
			if (self.Weapon:Clip1() == 7) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy07"))
			end
			if (self.Weapon:Clip1() == 6) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy06"))
			end
			if (self.Weapon:Clip1() == 5) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy05"))
			end
			if (self.Weapon:Clip1() == 4) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy04"))
			end
			if (self.Weapon:Clip1() == 3) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy03"))
			end
			if (self.Weapon:Clip1() == 2) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy02"))
			end
			if (self.Weapon:Clip1() == 1) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy01"))
			end
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("deploy00"))
			end
		end
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(0, b)
	end
end


/*---------------------------------------------------------
   Name: SWEP:SetIronsights()
---------------------------------------------------------*/
function SWEP:SetIronsights(b)

	if (self.Owner) then
		if (b) then
			if (SERVER) then
				self.Owner:SetFOV(65, 0.2)
			end
			

			if self.AllowIdleAnimation then
		
				if (self.Weapon:Clip1() > 8) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle"))
				end
				if (self.Weapon:Clip1() == 8) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle08"))
				end
				if (self.Weapon:Clip1() == 7) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle07"))
				end
				if (self.Weapon:Clip1() == 6) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle06"))
				end
				if (self.Weapon:Clip1() == 5) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle05"))
					end
				if (self.Weapon:Clip1() == 4) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle04"))
					end
				if (self.Weapon:Clip1() == 3) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle03"))
				end
				if (self.Weapon:Clip1() == 2) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle02"))
				end
				if (self.Weapon:Clip1() == 1) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle01"))
				end
				if (self.Weapon:Clip1() == 0) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle00"))
				end
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end

			if WeightMod:GetBool() then
				self.Weapon:EmitSound("Defaulf.Iron_In")
				self.Owner:SetRunSpeed(Walkspeed:GetFloat()*self.Speed*self.Mass)
				self.Owner:SetWalkSpeed(Walkspeed:GetFloat()*self.Speed*self.Mass)
			else
				self.Weapon:EmitSound("Defaulf.Iron_In")
			end
		else
			if (SERVER) then
				self.Owner:SetFOV(0, 0.2)
			end

			if self.AllowPlaybackRate and self.AllowIdleAnimation then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			end	
			if WeightMod:GetBool() then
				self.Owner:SetRunSpeed(Runspeed:GetFloat()*self.Mass)
				self.Owner:SetWalkSpeed(Walkspeed:GetFloat()*self.Mass)
				self.Weapon:EmitSound("Defaulf.Iron_Out")
			else
				self.Weapon:EmitSound("Defaulf.Iron_Out")
			end
		end
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(1, b)
	end
end
/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() > 8) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire" .. math.random(1, 3)))
	end
	if (self.Weapon:Clip1() == 8) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last09"))
	end
	if (self.Weapon:Clip1() == 7) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last08"))
	end
	if (self.Weapon:Clip1() == 6) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last07"))
	end
	if (self.Weapon:Clip1() == 5) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last06"))
	end
	if (self.Weapon:Clip1() == 4) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last05"))
	end
	if (self.Weapon:Clip1() == 3) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last04"))
	end
	if (self.Weapon:Clip1() == 2) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last03"))
	end
	if (self.Weapon:Clip1() == 1) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last02"))
	end
	if (self.Weapon:Clip1() == 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last01"))
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

	if EnableFlash:GetBool() then
	timer.Simple(0, function()
		if not IsValid(self.Owner) then return end
		if (not IsFirstTimePredicted() or not self.Owner:Alive())then return end
		util.Effect("effect_sim_gunsmoke", effectdata)
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
	
	// Shell eject
	if EnableShell:GetBool() then
	timer.Simple(self.ShellDelay, function()
		if not IsValid(self.Owner) then return end
		if (not IsFirstTimePredicted() or not self.Owner:Alive())then return end

		local effectdata = EffectData()
			effectdata:SetEntity(self.Weapon)
			effectdata:SetNormal(self.Owner:GetAimVector())
			effectdata:SetAttachment(2)
		util.Effect(self.ShellEffect2, effectdata)
	end)
	end
	
	// Crosshair effect
	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
	end
end]]

AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_mp5"
   SWEP.IconLetter = "x"
end

SWEP.PrintName      = "MP5G"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Delay = 0.07
SWEP.Primary.Recoil = 1.2
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 13
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 75
SWEP.Primary.ClipMax = 225
SWEP.Primary.DefaultClip = 75
SWEP.Primary.Sound = Sound("Weapof_vollmer.Shoot")

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_vollmer.mdl"
SWEP.WorldModel			= "models/weapons/b_mc51.mdl"

SWEP.IronSightsPos = Vector (-2.4822, -5.0006, 1.1117)
SWEP.IronSightsAng = Vector (0.3693, -0.0079, 0)

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 2
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 7.00062
	},
}
