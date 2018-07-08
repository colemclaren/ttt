ITEM.Name = "Justice Ninja Mask"
ITEM.ID = 455
ITEM.Description = "Become a member of the Justice League"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 4 )
	model:SetModelScale( 1.1 )
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

