ITEM.Name = "Green Skull Cover"
ITEM.ID = 445
ITEM.Description = "We all have Skulls. Why not show it off"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/mask6.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
	
	return model, pos, ang
end

