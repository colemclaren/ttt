--[[
SWEP.ViewModelFOV      = 60
SWEP.Instructions		= "Uses 9mm ammo, Switch Weapons: E + Left Click"
SWEP.Base				= "weapon_fas_sim_base"
SWEP.ViewModelFlip		= false
SWEP.HoldType				= "pistol"
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/a_m9.mdl"
SWEP.WorldModel			= "models/weapons/b_92f.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapof_Beretta92fs.Shoot")
SWEP.Primary.Recoil			= 2.5
SWEP.Primary.Damage			= 17
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.021
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

SWEP.Type				= 2
SWEP.Mode				= false

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-3.4915, -3.0001, 1.3414)
SWEP.IronSightsAng = Vector (-0.1484, 0.0126, 0)

SWEP.Speed = 0.6
SWEP.Mass = 0.95
SWEP.WeaponName = "weapon_fas_m9"
SWEP.WeaponEntName = "sim_fas_m9"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()
    util.PrecacheSound("weapons/pistol_beretta92fs/m9_fire1.wav")
	util.PrecacheSound("weapons/pistol_beretta92fs/m9_fire2.wav")
	util.PrecacheSound("weapons/pistol_beretta92fs/m9_fire3.wav")
	util.PrecacheSound("weapons/pistol_beretta92fs/m9_fire4.wav")
	util.PrecacheSound("weapons/pistol_beretta92fs/m9_fire5.wav")
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
		Animation:SetSequence(Animation:LookupSequence("fire_last_nosup"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
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

SWEP.PrintName = "Beretta M9"
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL

SWEP.Base = "weapon_tttbase"
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
SWEP.WorldModel			= "models/weapons/b_92f.mdl"
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Sound = Sound("Weapof_Beretta92fs.Shoot")
SWEP.IronSightsPos = Vector (-3.4915, -3.0001, 1.3414)
SWEP.IronSightsAng = Vector (-0.1484, 0.0126, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload_nosup",
		Time = 2.17857,
	},
	ReloadEmpty = {
		Anim = "reload_empty_nosup",
		Time = 2.17857,
	},
}