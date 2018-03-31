AddCSLuaFile( "shared.lua" )

AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:Explode()

	local radius = 125

	local damage = 100

	local pos = self:GetPos()



	local explosion = ents.Create("env_explosion")

	if IsValid(explosion) then

		explosion:SetPos( pos )

		explosion:Spawn()

		explosion:SetKeyValue( "iMagnitude", damage )

		explosion:SetKeyValue( "iRadiusOverride", radius )

		explosion:SetOwner( self.Owner )

		explosion:Fire( "Explode", 0, 0 )

	end

	self:Remove()

end





function ENT:PhysicsCollide( data, phys )

	self:Explode()

end

