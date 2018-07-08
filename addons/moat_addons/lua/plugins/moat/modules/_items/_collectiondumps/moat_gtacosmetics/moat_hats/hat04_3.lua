ITEM.Name = "Rasta Beanie"
ITEM.ID = 380
ITEM.Description = "Reggae Reggae"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)

	return model, pos, ang
end

