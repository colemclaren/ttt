
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01_chunk02c.mdl")
	self:DrawShadow(false)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
end

function ENT:OnRemove()
end

function ENT:Think()
end
