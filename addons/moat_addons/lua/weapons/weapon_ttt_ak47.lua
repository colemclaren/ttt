AddCSLuaFile()

SWEP.HoldType     = "ar2"
SWEP.PrintName     = "AK47"
if CLIENT then
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_ak47"
   SWEP.IconLetter = "w"
end
SWEP.Base       = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_AK47
SWEP.ENUM = 12

SWEP.Primary.Delay      = 0.095
SWEP.Primary.Recoil     = 1.9
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 19
SWEP.Primary.ClipSize = 35
SWEP.Primary.ClipMax = 105
SWEP.Primary.DefaultClip = 35
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands     = true
SWEP.ViewModelFlip    = true
SWEP.ViewModelFOV   = 64
SWEP.ViewModel  = "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.Primary.Sound = Sound( "Weapon_AK47.Single" )

SWEP.IronSightsPos = Vector (6.14, -.5, 2.5024)
SWEP.IronSightsAng = Vector (0, 0, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "ak47_reload",
		Time = 2.5 - .4,
	}
}

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(55, 0.5)
   	else
      	self.Owner:SetFOV(0, 0.2)
   	end
end