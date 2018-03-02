if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
	
	SWEP.sounds = {
		["HitArmor"] = "weapons/blade/impact/hit_armor_blade0[1-4].mp3",
		["HitFlesh"] = "weapons/blade/impact/impact_blade_flesh0[1-3].mp3",
		["HitFleshDraugr"] = "weapons/blade/impact/impact_blade_fleshdraugr0[1-3].mp3",
		["HitIce"] = "weapons/blade/impact/impact_blade_ice0[1-3].mp3",
		["HitMetal"] = "weapons/blade/impact/impact_blade_metal0[1-3].mp3",
		["HitDirt"] = "weapons/blade/impact/melee_sword_dirt0[1-2].mp3",
		["HitOther"] = "weapons/blade/impact/melee_sword_other0[1-3].mp3",
		["HitWood"] = "weapons/blade/impact/melee_sword_wood0[1-2].mp3",
		["Swing"] = "weapons/blade/swing_blade_medium0[1-4].mp3",
		["Draw"] = "weapons/blade/blade1hand_draw0[1-3].mp3",
		["Sheathe"] = "weapons/blade/blade1hand_sheathe.mp3"
	}
end

SWEP.Base = "ai_weapon_base_melee"

SWEP.DelayEquip = 1.46667
SWEP.Primary.Delay = 1.5
SWEP.Range = 95