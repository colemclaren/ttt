include('shared.lua')

ENT.Rotation = 0;

function ENT:Draw()

	self.Entity:DrawModel();

	self.Entity:SetAngles(Angle(0,self.Rotation,0));

end

function ENT:Think()

	self.Rotation = self.Rotation + 60;

end