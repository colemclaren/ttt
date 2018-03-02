if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
	
	SWEP.sounds = {
		["HitArmor"] = "weapons/blade/impact/hit_armor_blade0[1-4].mp3",
		["HitFlesh"] = "weapons/axe/impact/impact_axelarge_flesh0[1-3].mp3",
		["HitFleshDraugr"] = "weapons/axe/impact/impact_axelarge_flesh0[1-3].mp3",
		["HitIce"] = "weapons/blade/impact/impact_blade_ice0[1-3].mp3",
		["HitMetal"] = "weapons/blade/impact/impact_blade2hand_metal0[1-3].mp3",
		["HitDirt"] = "weapons/blade/impact/melee_sword_dirt0[1-2].mp3",
		["HitOther"] = "weapons/blade/impact/melee_sword_other0[1-3].mp3",
		["HitWood"] = "weapons/blade/impact/melee_sword_wood0[1-2].mp3",
		["Swing"] = "weapons/axe/swing_axe0[1-2].mp3",
		["Draw"] = "weapons/axe/axe2hand_draw.mp3",
		["Sheathe"] = "weapons/axe/axe2hand_sheathe.mp3"
	}
end

SWEP.Base = "ai_weapon_base_melee"

SWEP.DelayEquip = 2
SWEP.Primary.Delay = 2
SWEP.PowerAttackSlow = false
SWEP.Range = 120