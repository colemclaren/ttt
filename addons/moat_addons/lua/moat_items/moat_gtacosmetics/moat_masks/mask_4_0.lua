ITEM.Name = "Steel Armor Mask"
ITEM.ID = 432
ITEM.Description = "Become a Knight of the Realm"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

