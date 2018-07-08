ITEM.Name = "TPI Ninja Mask"
ITEM.ID = 459
ITEM.Description = "TPI: Turtle People Indeed"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 8
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 8 )
	model:SetModelScale( 1.1 )
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

