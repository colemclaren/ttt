ITEM.Name = "Gray Musicians Hat"
ITEM.ID = 382
ITEM.Description = "If only Voice Chat became Autotune whilst wearing this"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/modified/hat06.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)

	return model, pos, ang
end

