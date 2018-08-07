
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

//ENT.CanExplode = false

function ENT:Initialize()   
	local function ICanExplode()
		self.CanExplode = true;
	end

	--math.randomseed(CurTime())

	self.firesound = CreateSound(self,"weapons/rpg/rocket1.wav")

	self.exploded = false
	self.Entity:SetModel( "models/weapons/w_missile_launch.mdl" ) 	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
	self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox  
	//self.Entity:SetMaterial("models/props_combine/stasisshield_sheet")   
	util.SpriteTrail(self, 0, Color(255,255,255,179), false, 12, 1, 4, 1/(10+1)*0.5, "trails/smoke.vmt");    
	//self.Entity:SetColor(0,0,0,255)
	//self.Entity:Ignite( 120, 40 )
	
	self.dietime = CurTime() + 4
	
	self.firesound:Play()
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then 		
		phys:Wake()  
		phys:EnableGravity(false) 
	end 
	
	//timer.Simple(1,ICanExplode())
end   

function ENT:OnTakeDamage( dmginfo )
	
	self.Entity:TakePhysicsDamage( dmginfo )
	
end

function ENT:PhysicsCollide()
	if ( self.exploded == false) then
		util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 100, 250)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		util.Effect( "Explosion", effectdata )
		
		self.exploded = true
		self:EmitSound("weapons/explode3.wav")
		self.firesound:Stop()
		print("Exploded due to collision with world")
	end
end

function ENT:Think()
	if ( self.dietime < CurTime() ) then
		util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 100, 250)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		util.Effect( "Explosion", effectdata )
		
		self.exploded = true
		self:EmitSound("weapons/explode3.wav")
		self.firesound:Stop()
		print("Exploded due to time out")
	end

	if self.exploded == true then self:Remove() end
	self:NextThink(CurTime())
	return true
end
/*
function ENT:Touch()
	if ( self.exploded == false) then
		util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 100, 250)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		util.Effect( "Explosion", effectdata )
		
		self.exploded = true
		self:EmitSound("weapons/explode3.wav")
		self.firesound:Stop()
		print("Exploded due to collision")
	end
end
*/