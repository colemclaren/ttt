--[[SWEP.Instructions		= "Uses 9mm ammo, Switch Weapons: E + Left Click"

local EnableShell	= CreateClientConVar("sim_shell_t", 1, true, false)		// Enable/Disable
local EnableFlash	= CreateClientConVar("sim_flash_t", 1, true, false)		// Enable/Disable

SWEP.ViewModelFOV      = 60
SWEP.Base				= "weapon_fas_sim_base"
SWEP.ViewModelFlip		= false
SWEP.HoldType				= "pistol"
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/a_m9.mdl"
SWEP.WorldModel			= "models/weapons/b_92sup.mdl"

SWEP.Primary.Sound			= Sound("Weapof_Beretta92fss.Shoot")
SWEP.Primary.Recoil			= 2.2
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 15
SWEP.Primary.Delay			= 0.15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo 		= "Pistol"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ShellDelay			= 0.02
SWEP.ShellEffect			= "sim_shelleject_fas_9x19mm"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-3.4915, -3.0001, 1.3414)
SWEP.IronSightsAng = Vector (-0.1484, 0.0126, 0)

SWEP.Speed = 0.6
SWEP.Mass = 0.95
SWEP.WeaponName = "weapon_fas_m9s"
SWEP.WeaponEntName = "sim_fas_m9s"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()
    util.PrecacheSound("weapons/pistol_beretta92fs/m9_silenced_fire1.wav")
	util.PrecacheSound("weapons/pistol_beretta92fs/m9_magout.wav")
	util.PrecacheSound("weapons/pistol_beretta92fs/m9_magin.wav")
	util.PrecacheSound("weapons/pistol_beretta92fs/m9_slidestop.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

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

/*---------------------------------------------------------
   Name: SWEP:DeployAnimation()
---------------------------------------------------------*/
function SWEP:DeployAnimation()

	if (self.Weapon:Clip1() == 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("draw_empty"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("draw"))
		
	end
end
/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()

	if (self.Weapon:Clip1() == 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload_empty"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload"))
		timer.Simple(self.Owner:GetViewModel():SequenceDuration() + 0.03, function()
			if (not IsValid(self.Owner) or not IsValid(self.Weapon) or not self.Owner:Alive())then return end
			self:SetClip1( self.Primary.ClipSize + 1 )
			self.Owner:RemoveAmmo( 1, self:GetPrimaryAmmoType() )
		end)
	end

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
end

/*---------------------------------------------------------
   Name: SWEP:SetHolsted()
---------------------------------------------------------*/
function SWEP:SetHolsted(b)

	if (self.Owner) then
		if (b) then
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster_empty"))
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster"))
			end		
		else
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("draw_empty"))
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("draw"))
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
				if (self.Weapon:Clip1() == 0) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle_empty"))
				else
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
					local Animation = self.Owner:GetViewModel()
					Animation:SetSequence(Animation:LookupSequence("idle"))
				end

				self.Owner:GetViewModel():SetPlaybackRate(0)
			end
			if (self.WeightMod) then
				self.Weapon:EmitSound("Defaulf.Iron_In")
				self.Owner:SetRunSpeed(self.Walkspeed*self.Speed*self.Mass)
				self.Owner:SetWalkSpeed(self.Walkspeed*self.Speed*self.Mass)
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
			if (self.WeightMod) then
				self.Owner:SetRunSpeed(self.Runspeed*self.Mass)
				self.Owner:SetWalkSpeed(self.Walkspeed*self.Mass)
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
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()

	self:SecondThink()

	if self.Weapon:Clip1() > 0 and self.IdleDelay < CurTime() and self.IdleApply then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Owner and self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("idle"))
	
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
	
	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then return end
		if (self.Owner:KeyDown(IN_USE) and self.Rifle) then
			self:SetWeaponHoldType("fist")	
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
]]

AddCSLuaFile()

SWEP.HoldType = "pistol"


if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/icon_pistol"
   SWEP.IconLetter = "u"
end

SWEP.PrintName = "Beretta M9S"
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL

SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"
SWEP.Primary.Recoil	= 2
SWEP.Primary.Damage = 25
SWEP.Primary.Delay = 0.16
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_m9.mdl"
SWEP.WorldModel			= "models/weapons/b_92sup.mdl"
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Sound = Sound("Weapof_Beretta92fss.Shoot")
SWEP.IronSightsPos = Vector (-3.4915, -3.0001, 1.3414)
SWEP.IronSightsAng = Vector (-0.1484, 0.0126, 0)
SWEP.PrimaryAnim =  {"fire1", "fire2", "fire3"}
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 1.82143,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2.17857,
	}
}

function SWEP:Deploy()
	if (BaseClass.Deploy(self)) then
		self:PlayAnimation("DrawAnim", "draw", self.DeploySpeed)
	end

	return true
end