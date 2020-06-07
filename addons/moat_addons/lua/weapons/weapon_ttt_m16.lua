AddCSLuaFile()

SWEP.HoldType     = "ar2"

if CLIENT then
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_m16"
   SWEP.IconLetter = "w"
end
SWEP.PrintName      = "M16"
SWEP.Base       = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M16
SWEP.ENUM = 10

SWEP.Primary.Delay      = 0.165
SWEP.Primary.Recoil     = 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 31.246875
SWEP.Primary.Cone = 0.018
SWEP.Primary.ClipSize = 24
SWEP.Primary.ClipMax = 72
SWEP.Primary.DefaultClip = 24
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.HeadshotMultiplier = 2

SWEP.UseHands     = true
SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV   = 64
SWEP.ViewModel      = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel     = "models/weapons/w_rif_m4a1.mdl"

SWEP.Primary.Sound = Sound( "Weapon_M4A1.Single" )
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	/*DefaultReload = {
		Anim = "reload",
		Time = 3.08108,
	},*/
	DefaultReload = {
		Anim = "reload_unsil",
		Time = 3.08108,
	},
}

SWEP.IronSightsPos = Vector(-7.8, -9.2, 0.55)
SWEP.IronSightsAng = Vector(2.599, -2, -5)

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(55, 0.5)
   	else
      	self.Owner:SetFOV(0, 0.2)
   	end
end