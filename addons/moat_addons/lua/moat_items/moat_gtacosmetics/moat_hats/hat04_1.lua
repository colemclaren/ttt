ITEM.Name = "Gray Beanie V2"
ITEM.ID = 378
ITEM.Description = "There isn't even a V1."
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)

	return model, pos, ang
end

