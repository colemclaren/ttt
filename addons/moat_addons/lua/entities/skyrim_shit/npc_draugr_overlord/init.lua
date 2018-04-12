AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAUGR","npc_draugr_overlord")
util.AddNPCClassAlly(CLASS_DRAUGR,"npc_draugr_overlord")
ENT.skName = "draugr_overlord"
ENT.m_shouts = bit.bor(SHOUT_UNRELENTING_FORCE,SHOUT_DISMAY,SHOUT_ICE_STORM,SHOUT_DISARM)

function ENT:GenerateEquipment()
	local r = math.random(1,3)
	if(r == 1) then
		self:AddToEquipment("000302CA") // Ancient Nord Bow
		self:AddToEquipment("0002C672") // Ancient Nord War Axe
		self:AddToEquipment("000139BB") // Orcish Arrow
	elseif(r == 2) then self:AddToEquipment(table.Random({"0001CB64","000236A5"})) // Ancient Nord Battle Axe / Ancient Nord Greatsword
	else
		self:AddToEquipment("00012EB6") // Iron Shield
		self:AddToEquipment(table.Random({"0002C672","0002C66F"})) // Ancient Nord War Axe / Ancient Nord Sword
	end
	self:EquipSuitedEquipment()
end

function ENT:GenerateArmor()
	local gender = self:GetGender()
	if(gender == 0) then self:SetBodygroup(3,math.random(6,7))
	else self:SetBodygroup(3,math.random(3,4)) end
	local helmet = math.random(2,3)
	self:SetBodygroup(4,helmet)
end