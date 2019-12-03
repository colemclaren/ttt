--[[
// Variables that are used on both client and server
SWEP.Instructions			= "Uses 5.56mm Nato ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base"
SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_g36c.mdl"
SWEP.WorldModel			= "models/weapons/b_g36.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_G36.Shoot")
SWEP.Primary.Recoil		= 1.4
SWEP.Primary.Damage		= 22
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.007
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "SMG1"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_556"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false
SWEP.IronSightsPos = Vector (-3.2916, -10, 0.7012)
SWEP.IronSightsAng = Vector (0.0412, 0.0164, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Type				= 1
SWEP.Mode				= true

SWEP.Speed = 0.55
SWEP.Mass = 0.75
SWEP.WeaponName = "weapon_fas_g36c"
SWEP.WeaponEntName = "sim_fas_g36c"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/ar_g36c/g36c_fire1.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_fire2.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_fire3.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_fire4.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_fire5.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_magout.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_magin.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_cock.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_handle.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_boltcatch.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_stock.wav")
	util.PrecacheSound("weapons/ar_g36c/g36c_deploy.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()
	if self.Weapon:GetDTBool(1) then
		if (self.Weapon:Clip1() == 0) then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("fire_last_scoped"))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("fire_scoped" .. math.random(1, 3)))
		end
	else
		if (self.Weapon:Clip1() == 0) then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("fire_last"))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		end
	end
end
]]

AddCSLuaFile()

SWEP.HoldType     = "ar2"

if CLIENT then
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_m16"
   SWEP.IconLetter = "w"
end

SWEP.PrintName      = "G36C"
SWEP.Base       = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M16

SWEP.Primary.Delay      = 0.12
SWEP.Primary.Recoil     = 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 28
SWEP.Primary.Cone = 0.018
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.HeadshotMultiplier = 2.2

SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel			= "models/weapons/a_g36c.mdl"
SWEP.WorldModel			= "models/weapons/b_g36.mdl"

SWEP.Primary.Sound = Sound("Weapof_G36.Shoot")

SWEP.IronSightsPos = Vector (-3.2916, -10, 0.7012)
SWEP.IronSightsAng = Vector (0.0412, 0.0164, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.16667,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 3,
	}
}

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(60, 0.5)
   	else
      	self.Owner:SetFOV(0, 0.2)
   	end
end