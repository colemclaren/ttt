ITEM.Name = "Purple Armor Mask"
ITEM.ID = 435
ITEM.Description = "Bright Purple. Why not"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

