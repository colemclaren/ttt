ITEM.Name = "Fruit Trucker Hat"
ITEM.ID = 400
ITEM.Description = "One of your five a day"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin( 6 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)

	return model, pos, ang
end

