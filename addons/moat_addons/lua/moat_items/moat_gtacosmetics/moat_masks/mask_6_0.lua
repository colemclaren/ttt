ITEM.Name = "Black Skull Cover"
ITEM.ID = 442
ITEM.Description = "2spooky4me"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/mask6.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )
	pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
	
	return model, pos, ang
end