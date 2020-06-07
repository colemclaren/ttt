// Variables that are used on both client and server
--[[
SWEP.Base 				= "weapon_fas_sim_base"
SWEP.Instructions			= "Uses 9mm Short ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_mac11.mdl"
SWEP.WorldModel			= "models/weapons/b_mac11.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_MAC11.Shoot")
SWEP.Primary.Recoil		= 2.2
SWEP.Primary.Damage		= 16
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.022
SWEP.Primary.Delay 		= 0.055045871559633

SWEP.Primary.ClipSize		= 32					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "SMG1"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_380acp"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."

SWEP.IronSightsPos = Vector (-4.6983, -3.0007, 2.0295)
SWEP.IronSightsAng = Vector (0.2289, 0.0152, 0)

SWEP.Speed = 0.65
SWEP.Mass = 0.9
SWEP.WeaponName = "weapon_fas_mac11"
SWEP.WeaponEntName = "sim_fas_mac11"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/sub_mac11/mac11_fire1.wav")
    	util.PrecacheSound("weapons/sub_mac11/mac11_fire2.wav")
    	util.PrecacheSound("weapons/sub_mac11/mac11_fire3.wav")
    	util.PrecacheSound("weapons/sub_mac11/mac11_fire4.wav")
    	util.PrecacheSound("weapons/sub_mac11/mac11_fire5.wav")
    	util.PrecacheSound("weapons/sub_mac11/mac11_magout.wav")
    	util.PrecacheSound("weapons/sub_mac11/mac11_magin.wav")
    	util.PrecacheSound("weapons/sub_mac11/mac11_boltback.wav")
	util.PrecacheSound("weapons/sub_mac11/mac11_boltforward.wav")
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

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.Slot = 2

   SWEP.Icon = "vgui/ttt/icon_mac"
   SWEP.IconLetter = "l"
end

SWEP.PrintName = "MAC10 TE"

SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_MAC10

SWEP.Primary.Damage      = 12
SWEP.Primary.Delay       = 0.057
SWEP.Primary.Cone        = 0.03
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 90
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 1.15
SWEP.Primary.Sound       = Sound("Weapof_MAC11.Shoot")

SWEP.AutoSpawnable = false

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel      = "models/weapons/a_mac11.mdl"
SWEP.WorldModel     = "models/weapons/b_mac11.mdl"

SWEP.IronSightsPos = Vector (-4.6983, -3.0007, 2.0295)
SWEP.IronSightsAng = Vector (0.2289, 0.0152, 0)

SWEP.DeploySpeed = 3
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 3,
	}
}

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end

