ITEM.Name = "Dog Hockey Mask"
ITEM.ID = 426
ITEM.Description = "Dog backwards is God"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 4 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

