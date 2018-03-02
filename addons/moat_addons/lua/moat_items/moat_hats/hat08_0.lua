ITEM.Name = "Orange Trucker Hat"
ITEM.ID = 394
ITEM.Description = "I can't stop thinking about an Orange Fruit wearing a little Trucker Hat"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)

	return model, pos, ang
end

