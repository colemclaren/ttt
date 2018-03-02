AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_FALMER","npc_falmer_gloomlurker")
util.AddNPCClassAlly(CLASS_FALMER,"npc_falmer_gloomlurker")

function ENT:GenerateArmor()
	self:SetBodygroup(1,math.random(3,5))
	self:SetBodygroup(2,math.random(0,1))
end