ITEM.Name = "Red Beanie"
ITEM.ID = 374
ITEM.Description = "It's Red. It's a Beanie. What else do you need to know"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)

	return model, pos, ang
end

