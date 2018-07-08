ITEM.Name = "Bulldog Hockey Mask"
ITEM.ID = 418
ITEM.Description = "Woof woof back the fuck up"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

