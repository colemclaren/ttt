ITEM.Name = "Fox Mask"
ITEM.ID = 508
ITEM.Description = "What does the fox say? Yep"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/fox.mdl"
ITEM.Attachment = "eyes"





function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.561279) + (ang:Right() * 0.079376) +  (ang:Up() * -0.346680)
	
	return model, pos, ang
end

