AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()

	self.Owner = self.Entity.Owner
	
	if IsMounted("cstrike") then
		self.Entity:SetModel("models/bullets/w_pbullet1.mdl")
	else
		self.Entity:SetModel("models/bullets/w_pbullet1.mdl")
	end
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	phys:SetMass(0)
	end

	self.timeleft = CurTime() + .0 -- HOW LONG BEFORE EXPLOSION
	self:Think()
end

 function ENT:Think()
	
	if self.timeleft < CurTime() then
		self:Explosion()	
	end

	self.Entity:NextThink( CurTime() )
	return true
end

function ENT:Explosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	self.Entity:Remove()
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end