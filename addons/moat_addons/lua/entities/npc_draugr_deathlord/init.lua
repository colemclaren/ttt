AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAUGR","npc_draugr_deathlord")
util.AddNPCClassAlly(CLASS_DRAUGR,"npc_draugr_deathlord")
ENT.skName = "draugr_deathlord"
ENT.m_shouts = bit.bor(SHOUT_UNRELENTING_FORCE,SHOUT_DISMAY,SHOUT_ICE_STORM,SHOUT_DISARM)

function ENT:GenerateEquipment()
	local r = math.random(1,3)
	if(r == 1) then
		self:AddToEquipment(table.Random({"000139AD","000139A5"})) // Ebony Bow / Glass Bow
		self:AddToEquipment(table.Random({"000139BF","000139BE"})) // Ebony Arrow / Glass Arrow
		self:AddToEquipment("0002C672") // Ancient Nord War Axe
	elseif(r == 2) then
		self:AddToEquipment(table.Random({"000139B2","000139AC"})) // Ebony Warhammer / Ebony Battleaxe
	else
		self:AddToEquipment(table.Random({"00013964","0001393C"})) // Ebony Shield // Glass Shield
		self:AddToEquipment(table.Random({"000139AB","000139B1"})) // Ebony War Axe / Ebony Sword
	end
	self:EquipSuitedEquipment()
end

function ENT:GenerateArmor()
	local gender = self:GetGender()
	if(gender == 0) then self:SetBodygroup(3,8)
	else self:SetBodygroup(3,4) end
	local helmet = 3
	self:SetBodygroup(4,helmet)
end