--[[// Variables that are used on both client and server

local EnableShell	= CreateClientConVar("sim_shell_t", 1, true, false)		// Enable/Disable
local EnableFlash	= CreateClientConVar("sim_flash_t", 1, true, false)		// Enable/Disable

SWEP.Instructions			= "Uses 9mm ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base"
SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_sterling_sil.mdl"
SWEP.WorldModel			= "models/weapons/b_sterling_sil.mdl"
SWEP.ViewModelFOV			= 60

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_Beretta92fss.Shoot")
SWEP.Primary.Recoil		= 1
SWEP.Primary.Damage		= 16
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.014
SWEP.Primary.Delay 		= 0.1090909090909091

SWEP.Primary.ClipSize		= 34					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "SMG1"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_9x19mm"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-2.9803, -3.001, 1.8269)
SWEP.IronSightsAng = Vector (0.0683, 0.004, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Type				= 1
SWEP.Mode				= true

SWEP.Speed = 0.6
SWEP.Mass = 0.8

SWEP.WeaponName = "weapon_fas_sterlingsil"
SWEP.WeaponEntName = "sim_fas_sterlingsil"
/*--------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()
    util.PrecacheSound("weapons/pistol_beretta92fs/m9_silenced_fire1.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() <= 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("shoot_last"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
end

/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()


	if (self.Weapon:Clip1() == 0) then
		self.Weapon:DefaultReload(ACT_VM_RELOAD_EMPTY)
		timer.Simple(0.5, function()
		self.Weapon:EmitSound("Weapof_STERLING.ReloadEmpty")
		end)
	else
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
		timer.Simple(0.5, function()
		self.Weapon:EmitSound("Weapof_STERLING.Reload")
		end)
		timer.Simple(self.Owner:GetViewModel():SequenceDuration() + 0.05, function()
			if (not IsValid(self.Owner) or not IsValid(self.Weapon) or not self.Owner:Alive() or (self.Owner:GetAmmoCount(self.Primary.Ammo) < 1) )then return end
			self.Owner:RemoveAmmo( 1, self:GetPrimaryAmmoType() )
			self:SetClip1( self:Clip1() + 1 )
		end)
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
]]

AddCSLuaFile()

if CLIENT then  
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_mp5"
   SWEP.IconLetter = "x"
end

SWEP.PrintName      = "Sterling Silver"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Delay = 0.08
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 18
SWEP.HeadshotMultiplier = 2.4
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound = Sound("Weapof_Beretta92fss.Shoot")

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
--SWEP.ViewModel			= "models/weapons/a_sterling_sil.mdl"
-- SWEP.WorldModel			= "models/weapons/b_sterling_sil.mdl"
SWEP.ViewModel			= "models/weapons/a_sterling.mdl"
SWEP.WorldModel			= "models/weapons/b_sterling.mdl"

SWEP.IronSightsPos = Vector (-2.9803, -3.001, 1.8269)
SWEP.IronSightsAng = Vector (0.0683, 0.004, 0)

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.5,
		Sounds = {
			{Delay = .5, Sound = Sound "Weapof_STERLING.Reload"}
		}
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 3.6,
		Sounds = {
			{Delay = .5, Sound = Sound "Weapof_STERLING.ReloadEmpty"}
		}
	},
}