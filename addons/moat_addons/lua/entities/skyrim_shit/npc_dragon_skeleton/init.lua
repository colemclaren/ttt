AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DRAGON,"npc_dragon_skeleton")

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAGON","npc_dragon_skeleton")
ENT.NPCFaction = NPC_FACTION_DRAGON
ENT.sModel = "models/skyrim/dragonskeleton.mdl"
ENT.m_shouts = bit.bor(1,2,4,8,16,32,64)
ENT.ScaleExp = 8
ENT.CanFly = false
ENT.skName = "dragon_skeleton"
ENT.ScaleLootChance = 0.04
function ENT:SubInit()
end