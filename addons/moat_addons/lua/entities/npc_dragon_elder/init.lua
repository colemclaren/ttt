AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DRAGON,"npc_dragon_elder")

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAGON","npc_dragon_elder")
ENT.NPCFaction = NPC_FACTION_DRAGON
ENT.m_shouts = bit.bor(1,2,4,8,16,32,64)
ENT.sModel = "models/skyrim/dragontundra.mdl"
ENT.skName = "dragon_elder"
ENT.ScaleExp = 7
ENT.ScaleLootChance = 0.04
function ENT:SubInit()
end