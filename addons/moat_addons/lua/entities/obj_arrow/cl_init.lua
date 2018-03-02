include('shared.lua')

language.Add("obj_arrow","Arrow")
function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
end
 
function ENT:OnRemove()
end
 