ITEM.Name = "Peacock Butterfly Mask"
ITEM.ID = 660
ITEM.Description = "Don't put me in a zoo please"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/butterflymask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.6) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

