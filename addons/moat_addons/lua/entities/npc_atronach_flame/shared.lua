ENT.Base = "npc_creature_base"
ENT.Type = "ai"

ENT.PrintName = "Flame Atronach"
ENT.Category = "Skyrim"
ENT.NPCID = "000G4KL5"

PrecacheParticleSystem("burning_engine_fire")
PrecacheParticleSystem("fire_small_02")
PrecacheParticleSystem("fire_small_base")
if(CLIENT) then
	local attIgnite = {
		["flame_base"] = "burning_engine_fire",
		["flame_head"] = "fire_small_02",
		["flame_lhand"] = "fire_small_base",
		["flame_rhand"] = "fire_small_base",
		["flame_chest"] = "burning_engine_fire",
		["flame_larm"] = "burning_engine_fire",
		["flame_rarm"] = "burning_engine_fire"
	}
	function ENT:Initialize()
		for att,particle in pairs(attIgnite) do
			local attID = self:LookupAttachment(att)
			local attPosAng = self:GetAttachment(attID)
			if(attPosAng) then ParticleEffectAttach(particle,PATTACH_POINT_FOLLOW,self,attID)
			else MsgN("Warning: Unable to find attachment '" .. att .. "'(" .. attID .. ") on " .. tostring(self) .. "."); end
		end
	end
	language.Add("npc_atronach_flame","Flame Atronach")
end

