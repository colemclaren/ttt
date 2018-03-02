ITEM.Name = "Wireframe Egg Mask"
ITEM.ID = 859
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/wireframe"


function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)

	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end