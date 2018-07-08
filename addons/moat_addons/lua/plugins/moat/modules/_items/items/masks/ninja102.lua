ITEM.Name = "USA Police Ninja Mask"
ITEM.ID = 2452
ITEM.Description = "Police Ninja. Sounds like the best movie ever"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 10
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 10 )
	model:SetModelScale( 1.1 )
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

