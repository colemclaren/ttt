ENT.Base = "npc_humanoid_base"
ENT.Type = "ai"

ENT.PrintName = "Draugr"
ENT.Category = "Skyrim"

game.AddParticles("particles/draugr.pcf")
PrecacheParticleSystem("draugr_eye")
local _R = debug.getregistry()
local dir = "models/skyrim/animations/draugr/"
util.RegisterNPCAnimation(ENT,"1hmattacka",_R.Animation.Parse(dir .. "1hmattacka.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hmattackf",_R.Animation.Parse(dir .. "1hmattackf.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hmattackpowerchop",_R.Animation.Parse(dir .. "1hmattackpowerchop.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hmattackpowerslash",_R.Animation.Parse(dir .. "1hmattackpowerslash.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hmequip",_R.Animation.Parse(dir .. "1hmequip.ani"),ACT_ARM)
util.RegisterNPCAnimation(ENT,"1hmunequip",_R.Animation.Parse(dir .. "1hmunequip.ani"),ACT_DISARM)

util.RegisterNPCAnimation(ENT,"2gsattackb",_R.Animation.Parse(dir .. "2gsattackb.ani"),ACT_MELEE_ATTACK_SWING_GESTURE)
util.RegisterNPCAnimation(ENT,"2gsattackbackslash",_R.Animation.Parse(dir .. "2gsattackbackslash.ani"),ACT_MELEE_ATTACK_SWING_GESTURE)
util.RegisterNPCAnimation(ENT,"2gsequipgreatsword",_R.Animation.Parse(dir .. "2gsequipgreatsword.ani"),ACT_VM_PULLBACK_HIGH)
util.RegisterNPCAnimation(ENT,"2gsunequipgreatsword",_R.Animation.Parse(dir .. "2gsunequipgreatsword.ani"),ACT_VM_PULLBACK)

util.RegisterNPCAnimation(ENT,"bow_draw",_R.Animation.Parse(dir .. "bow_draw.ani"),ACT_VM_RECOIL1)
util.RegisterNPCAnimation(ENT,"bow_equip",_R.Animation.Parse(dir .. "bow_equip.ani"),ACT_SLAM_STICKWALL_IDLE)
util.RegisterNPCAnimation(ENT,"bow_unequip",_R.Animation.Parse(dir .. "bow_unequip.ani"),ACT_SLAM_STICKWALL_ND_IDLE)
util.RegisterNPCAnimation(ENT,"bow_drawidle",_R.Animation.Parse(dir .. "bow_drawidle.ani"),ACT_VM_RECOIL2)
util.RegisterNPCAnimation(ENT,"bowrelease",_R.Animation.Parse(dir .. "bowrelease.ani"),ACT_POLICE_HARASS1)

util.RegisterNPCAnimation(ENT,"2hmattacka",_R.Animation.Parse(dir .. "2hmattacka.ani"),ACT_DI_ALYX_ZOMBIE_MELEE)
util.RegisterNPCAnimation(ENT,"2hmattackb",_R.Animation.Parse(dir .. "2hmattackb.ani"),ACT_DI_ALYX_ZOMBIE_MELEE)
util.RegisterNPCAnimation(ENT,"2hmattackbackswipe",_R.Animation.Parse(dir .. "2hmattackbackswipe.ani"),ACT_DI_ALYX_ZOMBIE_MELEE)
util.RegisterNPCAnimation(ENT,"2hmattackc",_R.Animation.Parse(dir .. "2hmattackc.ani"),ACT_DI_ALYX_ZOMBIE_MELEE)
util.RegisterNPCAnimation(ENT,"2hmequipaxe",_R.Animation.Parse(dir .. "2hmequipaxe.ani"),ACT_ITEM_DROP)
util.RegisterNPCAnimation(ENT,"2hmunequipaxe",_R.Animation.Parse(dir .. "2hmunequipaxe.ani"),ACT_ITEM_THROW)

util.RegisterNPCAnimation(ENT,"shout",_R.Animation.Parse(dir .. "shout.ani"),ACT_BUSY_LEAN_BACK_ENTRY)
util.RegisterNPCAnimation(ENT,"shieldhit",_R.Animation.Parse(dir .. "shieldhit.ani"),ACT_SHIELD_KNOCKBACK)
util.RegisterNPCAnimation(ENT,"1hmidletoshieldidle",_R.Animation.Parse(dir .. "1hmidletoshieldidle.ani"),ACT_SHIELD_UP)
util.RegisterNPCAnimation(ENT,"shieldblock",_R.Animation.Parse(dir .. "shieldblock.ani"),ACT_SHIELD_UP_IDLE)
util.RegisterNPCAnimation(ENT,"shieldidleto1hmidle",_R.Animation.Parse(dir .. "shieldidleto1hmidle.ani"),ACT_SHIELD_DOWN)

util.RegisterNPCAnimation(ENT,"mtstaggerlight",_R.Animation.Parse(dir .. "mtstaggerlight.ani"),ACT_FLINCH_CHEST)
/*
local files = file.Find(dir .. "*.ani","GAME")
for _,f in ipairs(files) do
	local name = string.lower(string.sub(f,1,-5))
	util.RegisterNPCAnimation(ENT,name,_R.Animation.Parse(dir .. f))
end
*/

if(CLIENT) then
	language.Add("npc_draugr","Draugr")
end