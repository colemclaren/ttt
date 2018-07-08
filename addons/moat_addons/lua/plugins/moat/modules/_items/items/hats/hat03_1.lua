ITEM.Name = "BB Beanie"
ITEM.ID = 373
ITEM.Description = "Big Bad Beanie"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)

	return model, pos, ang
end

