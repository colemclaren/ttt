ITEM.Name = "Gray Striped Beanie"
ITEM.ID = 379
ITEM.Description = "Loved the Gray Beanie? Well you'll love this Gray Striped Beanie"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)

	return model, pos, ang
end

