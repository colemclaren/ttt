ITEM.Name = "Tan Ninja Mask"
ITEM.ID = 453
ITEM.Description = "For when you want your Ninja Mask to look like your own face"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale( 1.1 )
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

