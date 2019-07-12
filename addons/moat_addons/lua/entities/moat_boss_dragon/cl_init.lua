include "shared.lua"

function ENT:Initialize()
	if (Content and Content.HotMount) then
		Content:HotMount "1800828047"
	end
end

function ENT:Draw()
	self.Entity:DrawModel()
end