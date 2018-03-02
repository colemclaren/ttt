AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_FALMER","npc_falmer_skulker")
util.AddNPCClassAlly(CLASS_FALMER,"npc_falmer_skulker")

function ENT:GenerateArmor()
	self:SetBodygroup(1,math.random(2,4))
end