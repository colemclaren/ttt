ENT.Type = "anim"
ENT.Model = Model( "models/pigeon.mdl" )

local BirdSounds = {
	"ambient/creatures/seagull_idle1.wav",
	"ambient/creatures/seagull_idle2.wav",
	"ambient/creatures/seagull_idle3.wav",
	"ambient/creatures/seagull_pain1.wav",
	"ambient/creatures/seagull_pain2.wav",
	"ambient/creatures/seagull_pain3.wav"
}


function ENT:Initialize()
	self.Entity:SetModel( self.Model )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	

	if( SERVER ) then
		self.Entity:GetPhysicsObject():SetMass( 1 )
		self.Entity:GetPhysicsObject():ApplyForceCenter( ( self.Target:GetShootPos() - self.Entity:GetPos() ) * Vector( 3, 3, 3 ) )
	end
	
	if( CLIENT ) then
      self.Entity:EmitSound( Sound( BirdSounds[ math.random( 1, #BirdSounds ) ], 100 ) )
	end
end


function ENT:Think()
	if( SERVER ) then
		if( IsValid( self.Target ) ) then
			local Mul = 3
			if( self.Entity:GetPos():Distance( self.Target:GetPos() ) < 200 ) then Mul = 20 end
			self.Entity:GetPhysicsObject():ApplyForceCenter( ( self.Target:GetShootPos() - self.Entity:GetPos() ) * Vector( Mul, Mul, Mul ) )
			self.Entity:SetAngles( ( ( self.Target:GetShootPos() - self.Entity:GetPos() ) * Vector( Mul, Mul, Mul ) ):Angle() )
			
			if( !self.Target:Alive() ) then
				self:Remove()
			end
		else
			self:Remove()
		end
	end
end
