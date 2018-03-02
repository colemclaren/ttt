include( 'shared.lua' )


local MIN_EMIT_SPEED = 220 


function ENT:Initialize()

	self.Emitter = ParticleEmitter( self:GetPos(), true )
	self.NextEmit = CurTime()

end


function ENT:Draw()

	self:DrawModel()
	

	local speed = self:GetVelocity():Length()
	if speed <= MIN_EMIT_SPEED then return end
	

	if self.NextEmit > CurTime() then return end
	self.NextEmit = CurTime() + math.Clamp( math.Rand( 70, 110 ) / ( speed - MIN_EMIT_SPEED ), 0.04, 0.4 )
	
	local mypos = self:GetPos()
	mypos.z = mypos.z + 10
	
	self.Emitter:SetPos( mypos )
	
	local size = math.Rand( 3, 5 )
	local particle = self.Emitter:Add( "particles/feather", mypos )
	particle:SetDieTime( math.Rand( 2, 3 ) )
	particle:SetVelocity( VectorRand() * 15 )
	particle:SetAirResistance( 400 )
	particle:SetGravity( Vector( math.Rand( -25, 25 ), math.Rand( -25, 25 ), -300 ) )
	particle:SetCollide( true )
	particle:SetBounce( 0.1 )
	particle:SetAngles( VectorRand():Angle() )

	particle:SetStartAlpha( 255 )
	particle:SetStartSize( size )
	particle:SetEndSize( size )
	particle:SetColor( 255, 255, 255 )
	
end


function ENT:OnRemove()

	--self.Emitter:Finish()

end

