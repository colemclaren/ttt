ITEM.Name = "Benders Ninja Mask"
ITEM.ID = 454
ITEM.Description = "This is not related to Futurama. Unfortunately"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.1 )
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

