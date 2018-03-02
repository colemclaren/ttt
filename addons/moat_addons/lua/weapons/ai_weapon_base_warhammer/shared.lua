if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
	
	SWEP.sounds = {
		["HitFlesh"] = "weapons/blunt/impact/impact_blunt2hand_flesh0[1-3].mp3",
		["HitFleshDraugr"] = "weapons/blunt/impact/impact_blunt2hand_flesh0[1-3].mp3",
		["HitDirt"] = "weapons/blunt/impact/impact_blunt_dirt0[1-2].mp3",
		["HitOther"] = "weapons/blunt/impact/impact_blunt2hand_other0[1-3].mp3",
		["HitWood"] = "weapons/blunt/impact/impact_blunt2hand_wood0[1-3].mp3",
		["Swing"] = "weapons/blade/swing_blade_medium0[1-4].mp3",
		["Draw"] = "weapons/blunt/blunt2hand_draw0[1-2].mp3",
		["Sheathe"] = "weapons/blunt/blunt2hand_sheathe01.mp3"
	}
end

SWEP.Base = "ai_weapon_base_melee"

SWEP.DelayEquip = 2
SWEP.Primary.Delay = 2
SWEP.PowerAttackSlow = false
SWEP.Range = 110