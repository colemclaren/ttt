ITEM.Name = "GB Beanie"
ITEM.ID = 376
ITEM.Description = "A Giant Beetle Beanie? Oh wait. It's not that cool"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 4 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)

	return model, pos, ang
end

