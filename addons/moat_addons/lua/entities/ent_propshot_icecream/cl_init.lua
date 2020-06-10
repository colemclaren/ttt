include('shared.lua')

ENT.Rotation = 0;
ENT.Collided = false

function ENT:Draw()
	self.Entity:DrawModel()

	if (not self.Collided) then
		-- self.Entity:SetAngles(Angle(0,self.Rotation,0))
	end
end

function ENT:Think()
	if (not self.Collided) then
		self.Rotation = self.Rotation + 60
	end
end


function ENT:PhysicsCollide(data)
	if (self.Collided) then return end
	if (not IsValid(data.HitObject)) then return end
	if (data.HitEntity:GetClass() == "ent_propshot") then return end
	self.Collided = true
end 