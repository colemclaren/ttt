AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DRAGON,"npc_dragon_ancient")

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAGON","npc_dragon_ancient")
ENT.NPCFaction = NPC_FACTION_DRAGON
ENT.sModel = "models/skyrim/dragonboss.mdl"
ENT.m_shouts = bit.bor(1,2,4,8,16,32,64)
ENT.skName = "dragon_ancient"
ENT.ScaleExp = 10
ENT.ScaleLootChance = 0.025
function ENT:SubInit()
end