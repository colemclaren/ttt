ITEM.Name = "Face Bandana"
ITEM.ID = 575
ITEM.Description = "True terrorists will always have a spare one of these on them"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/bandana.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin( 0 )
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Right() * 0.1) + (ang:Up() * -4.5) + (ang:Forward() * -4.1)
	ang:RotateAroundAxis(ang:Up(), 0)
	
	return model, pos, ang
end
