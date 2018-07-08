ITEM.Name = "Gray C Cap"
ITEM.ID = 386
ITEM.Description = "Cannot be used as Fallout Currency"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)

	return model, pos, ang
end

