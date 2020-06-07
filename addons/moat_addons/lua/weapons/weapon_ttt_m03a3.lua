AddCSLuaFile()

if CLIENT then
    SWEP.Slot = 2
    SWEP.Icon = "vgui/ttt/king_m03a3_icon"
end
SWEP.PrintName = "Springfield"
SWEP.HoldType = "ar2"
SWEP.ShowWorldModel = false
SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSpawnable = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Delay = 1.8
SWEP.Primary.Recoil = 7
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 75
SWEP.Primary.Cone = 0.005
SWEP.Primary.ClipSize = 5
SWEP.Primary.ClipMax = 15
SWEP.Primary.DefaultClip = 5
SWEP.HeadshotMultiplier = 3.3
SWEP.DrawCrosshair = false
SWEP.Kind = WEAPON_HEAVY
SWEP.AmmoEnt = "item_ammo_357_ttt"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/doi/v_springfield.mdl"
SWEP.WorldModel = "models/weapons/doi/w_springfield.mdl"
SWEP.ViewModelFlip = false
SWEP.IronSightsPos = Vector(-2.56, 0, 1.32)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.Primary.Sound = Sound("Weapon_Springfield.Shoot")
SWEP.PrimaryAnim = "base_fire_end"
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "base_reload_empty_clip",
		Time = 4.49102,
	},
}

function SWEP:Deploy()
	if (BaseClass.Deploy(self)) then
		self:PlayAnimation("DrawAnim", "base_draw", self.DeploySpeed)
	end

	return true
end