//include shared
include("shared.lua");

//when drawing
function ENT:Draw()

	//remove outline
	self.Entity:DrawModel();

end