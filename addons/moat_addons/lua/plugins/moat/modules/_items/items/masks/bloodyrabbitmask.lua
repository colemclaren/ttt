ITEM.Name = "Bloody Rabbit Mask"
ITEM.ID = 651
ITEM.Description = "Who knew the easter bunny was hungry enough to eat human flesh"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/rabbitmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.8) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

