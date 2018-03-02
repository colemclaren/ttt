ITEM.Name = "Owl Mask"
ITEM.ID = 461
ITEM.Description = "Does not improve Night Vision"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/owl.mdl"
ITEM.Attachment = "eyes"





function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

