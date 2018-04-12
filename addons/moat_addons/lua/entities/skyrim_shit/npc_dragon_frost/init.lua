AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DRAGON,"npc_dragon_frost")

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAGON","npc_dragon_frost")
ENT.NPCFaction = NPC_FACTION_DRAGON
ENT.sModel = "models/skyrim/dragonsnow.mdl"
ENT.m_shouts = bit.bor(1,4,64)
ENT.ScaleExp = 5
ENT.ScaleLootChance = 0.05
function ENT:SubInit()
end