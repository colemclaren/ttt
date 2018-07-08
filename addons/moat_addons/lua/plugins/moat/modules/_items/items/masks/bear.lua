ITEM.Name = "Bear Mask"
ITEM.ID = 497
ITEM.Description = "Give me a hug"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/bear.mdl"
ITEM.Attachment = "eyes"





function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.391235) + (ang:Right() * -0.229431) +  (ang:Up() * -0.777100)
	
	return model, pos, ang
end


