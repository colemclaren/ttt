ENT.Base = "npc_humanoid_base"
ENT.Type = "ai"

ENT.PrintName = "Falmer"
ENT.Category = "Skyrim"

local _R = debug.getregistry()
local dir = "models/skyrim/animations/falmer/"
util.RegisterNPCAnimation(ENT,"1hm_attack1",_R.Animation.Parse(dir .. "1hm_attack1.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hm_attack2",_R.Animation.Parse(dir .. "1hm_attack2.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hm_attack3",_R.Animation.Parse(dir .. "1hm_attack3.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hm_attack4",_R.Animation.Parse(dir .. "1hm_attack4.ani"),ACT_MELEE_ATTACK1)
util.RegisterNPCAnimation(ENT,"1hmequip",_R.Animation.Parse(dir .. "1hmequip.ani"),ACT_ARM)
util.RegisterNPCAnimation(ENT,"1hmunequip",_R.Animation.Parse(dir .. "1hmunequip.ani"),ACT_DISARM)

util.RegisterNPCAnimation(ENT,"shieldhit",_R.Animation.Parse(dir .. "1hmshieldblock.ani"),ACT_SHIELD_KNOCKBACK)
util.RegisterNPCAnimation(ENT,"1hmidletoshieldidle",_R.Animation.Parse(dir .. "1hmidleto1hmshieldidle.ani"),ACT_SHIELD_UP)
util.RegisterNPCAnimation(ENT,"shieldblock",_R.Animation.Parse(dir .. "1hmshieldblock.ani"),ACT_SHIELD_UP_IDLE)
util.RegisterNPCAnimation(ENT,"shieldidleto1hmidle",_R.Animation.Parse(dir .. "1hmshieldidleto1hmidle.ani"),ACT_SHIELD_DOWN)

util.RegisterNPCAnimation(ENT,"bow_draw",_R.Animation.Parse(dir .. "bowdraw.ani"),ACT_VM_RECOIL1)
util.RegisterNPCAnimation(ENT,"bow_equip",_R.Animation.Parse(dir .. "bowequip.ani"),ACT_SLAM_STICKWALL_IDLE)
util.RegisterNPCAnimation(ENT,"bow_unequip",_R.Animation.Parse(dir .. "bowunequip.ani"),ACT_SLAM_STICKWALL_ND_IDLE)
util.RegisterNPCAnimation(ENT,"bow_drawidle",_R.Animation.Parse(dir .. "bowidledrawn.ani"),ACT_VM_RECOIL2)
util.RegisterNPCAnimation(ENT,"bowrelease",_R.Animation.Parse(dir .. "bowdrawnrelease.ani"),ACT_POLICE_HARASS1)

if(CLIENT) then
	language.Add("npc_falmer","Falmer")
end