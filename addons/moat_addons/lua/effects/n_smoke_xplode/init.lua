function EFFECT:Init(data)
	self.Entity = data:GetEntity()
	pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(pos)
	for i=1, 50 do
		local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos)
		if (particle) then
			particle:SetVelocity( VectorRand():GetNormalized()*math.Rand(300, 600) )
			if i <= 5 then 
			particle:SetDieTime( 25 )
			else
			particle:SetDieTime( math.Rand( 15, 25 ) )
			end
			particle:SetStartAlpha( math.Rand( 100, 150 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand( 100, 150 ) )
			particle:SetEndSize( math.Rand( 200, 250 ) )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1) )
			particle:SetColor( 0 , 127, 31 ) 
			particle:SetAirResistance( 100 ) 
			//particle:SetGravity( Vector(math.Rand(-30, 30),math.Rand(-30, 30), -200 )) 	
			particle:SetCollide( true )
			particle:SetBounce( 1 )
		end
	end
	
	for i=1, 50 do
		local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos)
		if (particle) then
			particle:SetVelocity( VectorRand():GetNormalized()*math.Rand(300, 600) )
			if i <= 5 then 
			particle:SetDieTime( 25 )
			else
			particle:SetDieTime( math.Rand( 15, 25 ) )
			end
			particle:SetStartAlpha( math.Rand( 100, 150 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand( 100, 150 ) )
			particle:SetEndSize( math.Rand( 200, 250 ) )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1) )
			particle:SetColor( 255 , 127, 127 ) 
			particle:SetAirResistance( 100 ) 
			//particle:SetGravity( Vector(math.Rand(-30, 30),math.Rand(-30, 30), -200 )) 	
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