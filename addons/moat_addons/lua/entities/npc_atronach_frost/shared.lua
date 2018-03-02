ENT.Base = "npc_creature_base"
ENT.Type = "ai"

ENT.PrintName = "Frost Atronach"
ENT.Category = "Skyrim"
//ENT.NPCID = "000G4KL5"

PrecacheParticleSystem("frost_atro_bodyice")
PrecacheParticleSystem("frost_atro_gpound")
if(CLIENT) then
	local attFrost = {"ice_chest","ice_head","ice_lhand","ice_rhand","ice_lfoot","ice_rfoot","ice_larm","ice_rarm"}
	function ENT:Initialize()
		for _,att in ipairs(attFrost) do
			local attID = self:LookupAttachment(att)
			local attPosAng = self:GetAttachment(attID)
			if(attPosAng) then ParticleEffectAttach("frost_atro_bodyice",PATTACH_POINT_FOLLOW,self,attID)
			else MsgN("Warning: Unable to find attachment '" .. att .. "'(" .. attID .. ") on " .. tostring(self) .. "."); end
		end
	end
	language.Add("npc_atronach_frost","Frost Atronach")
end

