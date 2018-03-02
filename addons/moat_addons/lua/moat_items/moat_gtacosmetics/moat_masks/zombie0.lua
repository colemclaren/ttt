ITEM.Name = "Zombie Mask"
ITEM.ID = 469
ITEM.Description = "Unfortunately you can't eat the corpses while wearing this"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/zombie.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
	
	return model, pos, ang
end

