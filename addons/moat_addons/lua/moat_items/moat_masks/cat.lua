ITEM.Name = "Cat Mask"
ITEM.ID = 504
ITEM.Description = "Nine Lives not included"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/cat.mdl"
ITEM.Attachment = "eyes"





function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.390503) + (ang:Right() * -0.228668) +  (ang:Up() * -0.152496)
	
	return model, pos, ang
end

