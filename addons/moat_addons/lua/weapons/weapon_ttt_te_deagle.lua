--[[SWEP.Instructions			= "Uses .50AE ammo, Switch Weapons: E + Left Click"
SWEP.ViewModelFOV      = 60
SWEP.Base				= "weapon_fas_sim_base"
SWEP.ViewModelFlip		= false
SWEP.HoldType				= "pistol"
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/a_deserteagle.mdl"
SWEP.WorldModel			= "models/weapons/b_deserteagle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapof_DEagle.Shoot" )
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 28
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.019
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.3
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo 		= "357"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ShellDelay			= 0.02
SWEP.ShellEffect			= "sim_shelleject_fas_50ae"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false
SWEP.IronSightsPos = Vector (-3.0537, -3.0001, 0.7817)
SWEP.IronSightsAng = Vector (0.702, -0.0077, 0)

SWEP.Speed = 0.65
SWEP.Mass = 0.9

SWEP.WeaponName = "weapon_fas_Deagle"
SWEP.WeaponEntName = "sim_fas_Deagle"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/pistol_deserteagle/de_fire1.wav")
	util.PrecacheSound("weapons/pistol_deserteagle/de_fire2.wav")
	util.PrecacheSound("weapons/pistol_deserteagle/de_fire3.wav")
	util.PrecacheSound("weapons/pistol_deserteagle/de_fire4.wav")
	util.PrecacheSound("weapons/pistol_deserteagle/de_fire5.wav")
	util.PrecacheSound("weapons/pistol_deserteagle/de_magin.wav")
	util.PrecacheSound("weapons/pistol_deserteagle/de_magout.wav")	
	util.PrecacheSound("weapons/pistol_deserteagle/de_slidestop.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() <= 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
end]]

AddCSLuaFile()

SWEP.HoldType			= "pistol"

if CLIENT then
   SWEP.Author				= "TTT"

   SWEP.Slot				= 1
   SWEP.SlotPos			= 1

   SWEP.Icon = "vgui/ttt/icon_deagle"
end

SWEP.PrintName			= "Deagle TE"
SWEP.Base				= "weapon_tttbase"

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_DEAGLE
SWEP.ENUM = 4

SWEP.Primary.Ammo       = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage = 37
SWEP.Primary.Delay = 0.5
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true

SWEP.HeadshotMultiplier = 5.5

SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_revolver_ttt"
SWEP.Primary.Sound			= Sound( "Weapof_DEagle.Shoot" )

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/a_deserteagle.mdl"
SWEP.WorldModel			= "models/weapons/b_deserteagle.mdl"

SWEP.IronSightsPos = Vector (-3.0537, -3.0001, 0.7817)
SWEP.IronSightsAng = Vector (0.702, -0.0077, 0)
SWEP.ReloadLength = 2.05
SWEP.ReloadTime = 2.05

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.05,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 2.7,
	}
}
