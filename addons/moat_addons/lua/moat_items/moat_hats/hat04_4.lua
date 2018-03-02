ITEM.Name = "Blue Beanie V2"
ITEM.ID = 381
ITEM.Description = "Blue Beanie V3s and Blue Beanie V3c Coming Soon"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 4 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)

	return model, pos, ang
end

