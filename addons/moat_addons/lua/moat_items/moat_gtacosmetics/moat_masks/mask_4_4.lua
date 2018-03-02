ITEM.Name = "Carbon Armor Mask"
ITEM.ID = 436
ITEM.Description = "Although it's hard to break. This won't save you from Headshots"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 4 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

