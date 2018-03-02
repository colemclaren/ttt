
function EFFECT:Init( data )

	local vOffset = data:GetOrigin()
	local ply = data:GetEntity()
	local NumParticles = ply.confetti_num or 160
	sound.Play( "garrysmod/balloon_pop_cute.wav", vOffset, 90, math.random( 90, 120 ) )

	local emitter = ParticleEmitter( vOffset, true )

	for i = 0, NumParticles do

		local Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local particle = emitter:Add( "particles/balloon_bit", vOffset + Pos * 8 )
		if ( particle ) then

			particle:SetVelocity( Pos * 500 )

			particle:SetLifeTime( 0 )
			particle:SetDieTime( 10 )

			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 255 )

			local Size = math.Rand( 1, 3 )
			particle:SetStartSize( Size )
			particle:SetEndSize( 0 )

			particle:SetRoll( math.Rand( 0, 360 ) )
			particle:SetRollDelta( math.Rand( -2, 2 ) )

			particle:SetAirResistance( 100 )
			particle:SetGravity( Vector( 0, 0, -300 ) )

            local col = Color(255,0,0)
            if math.random() > 0.5 then 
                col = Color(0,255,0)
            end

			particle:SetColor(col.r, col.g, 0)

			particle:SetCollide( true )

			particle:SetAngleVelocity( Angle( math.Rand( -160, 160 ), math.Rand( -160, 160 ), math.Rand( -160, 160 ) ) )

			particle:SetBounce( 1 )
			particle:SetLighting( true )

		end

	end

	emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end