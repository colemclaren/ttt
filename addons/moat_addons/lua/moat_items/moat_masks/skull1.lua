ITEM.Name = "Brown Skull Mask"
ITEM.ID = 465
ITEM.Description = "Perfect whilst pulling off the perfect Heist"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/skull.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
	
	return model, pos, ang
end

