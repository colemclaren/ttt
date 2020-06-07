AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 1
   SWEP.Icon = "vgui/ttt/king_deliverer_icon"
end

SWEP.Gun = ("ttt_king_deliverer")
SWEP.PrintName = "The Deliverer"
SWEP.HoldType 				= "pistol"	

SWEP.ShowWorldModel			= false
SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AutoSpawnable 			= false

SWEP.Primary.Damage		= 30
SWEP.Primary.Spread		= .01
SWEP.Primary.Delay 				= 0.2
SWEP.Primary.ClipSize			= 8
SWEP.Primary.DefaultClip		= 8
SWEP.Primary.ClipMax 			= 24
SWEP.Primary.KickUp				= 0.4
SWEP.Primary.KickDown			= 0.3
SWEP.Primary.KickHorizontal		= 0.3
SWEP.Primary.Automatic			= false	
SWEP.Primary.Ammo			= "pistol"	
SWEP.HeadshotMultiplier = 2

SWEP.Primary.Sound 			= Sound("TFA_FO4_DELIVERER.1")


SWEP.Kind					= WEAPON_PISTOL
SWEP.AmmoEnt				= "item_ammo_pistol_ttt"


SWEP.ViewModel			= "models/weapons/tfa_fo4/c_deliverer.mdl" --Viewmodel path
SWEP.ViewModelFOV		= 56		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position. 
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle. 


SWEP.WorldModel			= "models/weapons/tfa_fo4/w_deliverer.mdl" -- Weapon world model path

SWEP.RunSightsPos = Vector(-0.202, -12.457, -7.447)
SWEP.RunSightsAng = Vector(64.723, 0, 0)

--[[IRONSIGHTS]]--

SWEP.data 				= {}
SWEP.data.ironsights			= 1 --Enable Ironsights
SWEP.Secondary.IronFOV			= 60					-- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos = Vector(-2.8, 0, 1.399)
SWEP.IronSightsAng = Vector(0.515, 0, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload_sil",
		Time = 2.17742,
	},
}