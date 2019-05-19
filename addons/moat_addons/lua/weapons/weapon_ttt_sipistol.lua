
AddCSLuaFile()

SWEP.HoldType			= "pistol"
SWEP.PrintName = "Silenced Pistol"

if CLIENT then
   SWEP.Slot = 6

   SWEP.EquipMenuData = {
      type = "item_weapon",
      desc = "sipistol_desc"
   };

   SWEP.Icon = "vgui/ttt/icon_silenced"
   SWEP.IconLetter = "a"
end

SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"
SWEP.Primary.Recoil	= 1.35
SWEP.Primary.Damage = 28
SWEP.Primary.Delay = 0.38
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 20
SWEP.Primary.ClipMax = 80
SWEP.Primary.Ammo = "Pistol"

SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
SWEP.WeaponID = AMMO_SIPISTOL

SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.IsSilent = true

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp_silencer.mdl"

SWEP.Primary.Sound = Sound( "weapons/usp/usp1.wav" )
SWEP.Primary.SoundLevel = 50

SWEP.IronSightsPos = Vector( -3.91, -7, 2.84 )
SWEP.IronSightsAng = Vector(-0.5, 0, 0.5)

SWEP.PrimaryAnim = {"shoot1", "shoot2", "shoot3"}
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.7027,
	}
}

function SWEP:Deploy()
	if (BaseClass.Deploy(self)) then
		self:PlayAnimation("DrawAnim", "draw", self.DeploySpeed)
	end

	return true
end

-- We were bought as special equipment, and we have an extra to give
function SWEP:WasBought(buyer)
   if IsValid(buyer) then -- probably already self.Owner
      buyer:GiveAmmo( 20, "Pistol" )
   end
end

