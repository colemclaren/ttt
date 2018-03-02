ITEM.Name = "Waldo Beanie"
ITEM.ID = 372
ITEM.Description = "Where are you"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)

	return model, pos, ang
end

