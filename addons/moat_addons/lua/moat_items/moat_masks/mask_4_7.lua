ITEM.Name = "Lightning Armor Mask"
ITEM.ID = 439
ITEM.Description = "How long until you hear the thunder? Hmm.."
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 7 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

