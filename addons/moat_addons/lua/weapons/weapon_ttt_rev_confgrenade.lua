

AddCSLuaFile()



SWEP.HoldType = "grenade"

SWEP.PrintName = "Combobulator"



if CLIENT then

   SWEP.Slot = 3

   SWEP.SlotPos	= 0



   SWEP.Icon = "vgui/ttt/icon_nades"

   SWEP.IconLetter = "h"

end



SWEP.Base				= "weapon_tttbasegrenade"

SWEP.PrintName = "Combobulator"

--SWEP.WeaponID = AMMO_COMB

SWEP.Kind = WEAPON_NADE



SWEP.WeaponID = WEAPON_EQUIP

--SWEP.Kind = WEAPON_EQUIP2



SWEP.Spawnable = true

SWEP.CanBuy = { ROLE_TRAITOR }

SWEP.EquipMenuData = {
	type = "item_weapon",
	name = "Combobulator",
	desc = "A reverse disombob that will pull everything towards it on explosion."
}


SWEP.AutoSpawnable      = false



SWEP.UseHands			= true

SWEP.ViewModelFlip		= false

SWEP.ViewModelFOV		= 54

SWEP.ViewModel			= "models/weapons/cstrike/c_eq_fraggrenade.mdl"

SWEP.WorldModel			= "models/weapons/w_eq_flashbang.mdl"

SWEP.Weight				= 5



SWEP.Primary.ClipSize		=  -1

SWEP.Primary.DefaultClip	=  -1

SWEP.Primary.Automatic		= false

SWEP.Primary.Delay = 1.0

SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1

SWEP.Secondary.DefaultClip	= -1

SWEP.Secondary.Automatic	= false

SWEP.Secondary.Ammo		= "none"





-- really the only difference between grenade weapons: the model and the thrown

-- ent.





function SWEP:OnDrop()

   self:Activate()

end



function SWEP:GetGrenadeName()

	return "ttt_rev_confgrenade_proj"   

end


function SWEP:PostDrawViewModel(vm, weapon, ply)
    self:DrawDefaultThrowPath(weapon, ply)
end