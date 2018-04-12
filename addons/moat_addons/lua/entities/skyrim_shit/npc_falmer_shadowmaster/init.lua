AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_FALMER","npc_falmer_shadowmaster")
util.AddNPCClassAlly(CLASS_FALMER,"npc_falmer_shadowmaster")

function ENT:GenerateArmor()
	self:SetBodygroup(1,math.random(6,7))
	self:SetBodygroup(2,1)
end