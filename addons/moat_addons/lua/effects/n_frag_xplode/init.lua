function EFFECT:Init(data)
	self.Entity = data:GetEntity()
	pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(pos)
	for i=1, 5 do
		local particle = self.Emitter:Add( "effects/advisoreffect/advisorblast1", pos)
		if (particle) then
			particle:SetDieTime( .15 )
			particle:SetStartAlpha( 50 )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand( 40, 50 ) )
			particle:SetEndSize( math.Rand( 450,500 ) )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1) )
			particle:SetColor( 186 , 0 , 0 ) 
 			particle:SetAirResistance( 100 ) 
			particle:SetCollide( true )
			particle:SetBounce( 1 )
		end
	end
end

function EFFECT:Think()
return false
end

function EFFECT:Render()

end