SWEP.PrintName			= "Drachenlord"
SWEP.Author				= "SgtDark"
SWEP.Instructions		= "Drachenlord schmeißt die Prügel raus!"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true
SWEP.ViewModel			= "models/props_junk/watermelon01.mdl"
SWEP.WorldModel			= "models/props_junk/watermelon01.mdl"

SWEP.HoldType 	= "pistol"
SWEP.Icon 		= "vgui/entities/weapon_drachenbomb.png"

SWEP.Base 			= "weapon_tttbase"
SWEP.Kind 			= WEAPON_EQUIP2
SWEP.AutoSpawnable 	= false
SWEP.AmmoEnt 		= "item_ammo_ttt"
SWEP.CanBuy 		= {ROLE_TRAITOR}
SWEP.InLoadoutFor 	= nil
SWEP.LimitedStock 	= true
SWEP.AllowDelete 	= false
SWEP.AllowDrop 		= false

if CLIENT then
	SWEP.EquipMenuData = {
		type = "Weapon",
		desc = "Drachenlord schmeißt die Prügel raus!\nImmediately kills you on use."
	};
end
