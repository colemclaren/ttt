ENT.Base = "npc_creature_base"
ENT.Type = "ai"

ENT.PrintName = "Dragon"
ENT.Category = "Skyrim"
ENT.NPCID = "000B80E"
ENT.HasSoundtrack = true

if(CLIENT) then
	language.Add("npc_dragon","Dragon")
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Controller")
end