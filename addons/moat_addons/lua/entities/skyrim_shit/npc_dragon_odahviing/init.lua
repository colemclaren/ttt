AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_PLAYER","npc_dragon_odahviing")
ENT.NPCFaction = NPC_FACTION_PLAYER
ENT.iClass = CLASS_PLAYER_ALLY
ENT.sModel = "models/skyrim/dragonodahviing.mdl"
ENT.m_shouts = bit.bor(1,2,4,8,16,32,64)
ENT.ScaleExp = 10
ENT.ScaleLootChance = 0.03
function ENT:SubInit()
end