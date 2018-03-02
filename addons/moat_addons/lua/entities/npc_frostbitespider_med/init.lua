AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_SPIDER","npc_frostbitespider_med")
ENT.iClass = CLASS_SPIDER_FROSTBITE
util.AddNPCClassAlly(CLASS_SPIDER_FROSTBITE,"npc_frostbitespider_medium")
ENT.sModel = "models/skyrim/frostbitespider_medium.mdl"
ENT.CollisionBounds = Vector(27,27,24)
ENT.fMeleeDistance	= 40
ENT.fMeleeForwardDistance = 220
ENT.fRangeDistance = 700
ENT.skName = "frostbitespider_medium"