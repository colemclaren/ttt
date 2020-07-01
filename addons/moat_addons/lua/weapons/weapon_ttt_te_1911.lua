--[[
SWEP.Instructions			= "Uses .45Acp ammo, Switch Weapons: E + Left Click"
SWEP.ViewModelFOV      = 60
SWEP.Base				= "weapon_tttbase"
SWEP.ViewModelFlip		= false
SWEP.HoldType				= "pistol"
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/a_1911.mdl"
SWEP.WorldModel			= "models/weapons/b_1911.mdl"

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_DEAGLE
SWEP.AutoSpawnable      = false

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapof_1911.Shoot" )
SWEP.Primary.Recoil			= 2.5
SWEP.Primary.Damage			= 21
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.022
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.17
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo 		= "Pistol"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ShellDelay			= 0.02
SWEP.ShellEffect			= "sim_shelleject_fas_45acp"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false
SWEP.IronSightsPos = Vector (-2.9903, -3, 1.9658)
SWEP.IronSightsAng = Vector (1.2967, 0.0068, 0)

SWEP.Speed = 0.6
SWEP.Mass = 0.95
SWEP.WeaponName = "weapon_fas_colt1911"
SWEP.WeaponEntName = "sim_fas_colt1911"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()
    util.PrecacheSound("weapons/pistol_m1911a1/1911fire1.wav")
	util.PrecacheSound("weapons/pistol_m1911a1/1911fire2.wav")
	util.PrecacheSound("weapons/pistol_m1911a1/1911fire3.wav")
	util.PrecacheSound("weapons/pistol_m1911a1/1911fire4.wav")
	util.PrecacheSound("weapons/pistol_m1911a1/1911fire5.wav")
	util.PrecacheSound("weapons/pistol_m1911a1/1911magin.wav")
	util.PrecacheSound("weapons/pistol_m1911a1/1911magout.wav")	
	util.PrecacheSound("weapons/pistol_m1911a1/1911slidestop.wav")
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
end]]

AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.PrintName = "M1911"

if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/icon_pistol"
   SWEP.IconLetter = "u"
end

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL

SWEP.Base = "weapon_tttbase"
SWEP.Primary.Recoil	= 1.5
SWEP.Primary.Damage = 38
SWEP.Primary.Delay = 0.38
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 12
SWEP.Primary.ClipMax = 36
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV = 60
SWEP.ViewModel			= "models/weapons/a_1911.mdl"
SWEP.WorldModel			= "models/weapons/b_1911.mdl"

SWEP.Primary.Sound = Sound("Weapof_1911.Shoot")
SWEP.IronSightsPos = Vector (-2.9903, -3, 1.9658)
SWEP.IronSightsAng = Vector (1.2967, 0.0068, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 1.83333,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2.26667,
	}
}
