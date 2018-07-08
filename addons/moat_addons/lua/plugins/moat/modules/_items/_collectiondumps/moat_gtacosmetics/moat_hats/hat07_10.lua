ITEM.Name = "Fist Cap"
ITEM.ID = 385
ITEM.Description = "A smaller cap, best worn on your fist"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 10
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 10 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)

	return model, pos, ang
end

