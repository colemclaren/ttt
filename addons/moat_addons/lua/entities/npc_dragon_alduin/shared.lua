ENT.Base = "npc_dragon"
ENT.Type = "ai"

ENT.PrintName = "Alduin"
ENT.Category = "Skyrim"
ENT.NPCID = "00071BI"

if(CLIENT) then
	language.Add("npc_dragon_alduin","Alduin")
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Controller")
end