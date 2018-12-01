
AddCSLuaFile()

SWEP.HoldType			= "grenade"
SWEP.PrintName = "Smoke Grenade"

if CLIENT then
   SWEP.Slot = 3

   SWEP.Icon = "vgui/ttt/icon_nades"
   SWEP.IconLetter = "Q"
end

SWEP.Base				= "weapon_tttbasegrenade"
SWEP.PrintName = "Smoke Grenade"

SWEP.Spawnable = true

SWEP.WeaponID = AMMO_SMOKE
SWEP.Kind = WEAPON_NADE

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_eq_smokegrenade.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_smokegrenade.mdl"
SWEP.Weight			= 5
SWEP.AutoSpawnable      = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "ttt_smokegrenade_proj"
end

function SWEP:PostDrawViewModel(vm, weapon, ply)
    self:DrawDefaultThrowPath(weapon, ply)
end