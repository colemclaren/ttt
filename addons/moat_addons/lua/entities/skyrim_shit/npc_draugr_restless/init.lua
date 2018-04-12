AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAUGR","npc_draugr_restless")
util.AddNPCClassAlly(CLASS_DRAUGR,"npc_draugr_restless")
ENT.skName = "draugr_restless"
ENT.m_shouts = SHOUT_UNRELENTING_FORCE

function ENT:GenerateArmor()
	local gender = self:GetGender()
	if(gender == 0) then self:SetBodygroup(3,math.random(2,4))
	else self:SetBodygroup(3,math.random(1,2)) end
	local helmet = math.random(0,1)
	self:SetBodygroup(4,helmet)
end