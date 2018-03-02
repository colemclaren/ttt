ITEM.Name = "Black Skull Mask"
ITEM.ID = 467
ITEM.Description = "2spooky4me"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/skull.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
	
	return model, pos, ang
end

