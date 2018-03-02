include('shared.lua')

language.Add("obj_centurion_arrow","Dwarven Sphere")
function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
end
 
function ENT:OnRemove()
end
 