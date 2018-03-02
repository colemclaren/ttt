AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DRAGON,"npc_dragon_revered")

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAGON","npc_dragon_revered")
ENT.NPCFaction = NPC_FACTION_DRAGON
ENT.sModel = "models/skyrim/dragonicelake.mdl"
ENT.skName = "dragon_revered"
ENT.m_shouts = bit.bor(1,2,4,8,16,32,64)
ENT.ScaleExp = 5
ENT.ScaleLootChance = 0.05
function ENT:SubInit()
end

function ENT:UpdateModel()
	local model
	if(!self.m_type) then model = table.Random({"dragonicelake","dragonpurple"})
	elseif(self.m_type == 0) then model = "dragonpurple"
	else model = "dragonicelake" end
	self:SetModel("models/skyrim/" .. model .. ".mdl")
end

local BaseClass = "npc_dragon"
function ENT:KeyValueHandle(key,val)
	if(self:GetBaseClass(BaseClass).KeyValueHandle(self,key,val)) then return true end
	if(key == "type") then self.m_type = tonumber(val); self:UpdateModel()
	else return false end
	return true
end