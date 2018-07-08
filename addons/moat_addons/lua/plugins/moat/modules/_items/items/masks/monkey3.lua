ITEM.Name = "Old Monkey Mask"
ITEM.ID = 449
ITEM.Description = "Basically Cranky Kong"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/monkey.mdl"
ITEM.Attachment = "eyes"





function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

