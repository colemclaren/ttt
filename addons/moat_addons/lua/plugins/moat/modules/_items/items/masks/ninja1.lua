ITEM.Name = "White Ninja Mask"
ITEM.ID = 451
ITEM.Description = "How is this meant to help you stay hidden in the shadows"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.1 )
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

