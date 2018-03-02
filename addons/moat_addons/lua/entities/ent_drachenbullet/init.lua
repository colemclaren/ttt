AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local v = {}
function ENT:Initialize()
	local id = self:EntIndex()
	v[id] = {}
	v[id]["hit"] = false
	v[id]["hit_pos"] = Vector(0,0,0)

	self:SetModel("models/props_junk/watermelon01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid( SOLID_VPHYSICS ) 
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:PhysWake()
	self:DrawShadow(false)
end

function ENT:PhysicsCollide(data, phys)
	local id = self:EntIndex()
	if(!v[id]["hit"]) then
		v[id]["hit"] = true
		v[id]["hit_pos"] = data.HitPos
		self:SetNoDraw(true)
	end
end

function ENT:Think()
	local id = self:EntIndex()
	if(v[id]["hit"]) then
		local ent = ents.Create("ent_drachenlord") 
		ent:SetPos(v[id]["hit_pos"]+Vector(0,0,5))
		ent:Spawn()
		self:Remove()
		v[self:EntIndex()] = nil
	end
end
