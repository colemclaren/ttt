ITEM.Name = "White LS Cap"
ITEM.ID = 387
ITEM.Description = "Unfortunately this isn't a White Lego Sausage Cap"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)

	return model, pos, ang
end

