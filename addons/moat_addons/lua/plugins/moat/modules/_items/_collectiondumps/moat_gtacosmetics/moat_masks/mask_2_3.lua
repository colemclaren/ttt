ITEM.Name = "Bear Hockey Mask"
ITEM.ID = 425
ITEM.Description = "I'd love to actually see Bears playing Hockey"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

