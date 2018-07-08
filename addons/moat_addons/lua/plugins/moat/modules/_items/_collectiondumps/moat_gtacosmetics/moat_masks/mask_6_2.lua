ITEM.Name = "Tan Skull Cover"
ITEM.ID = 444
ITEM.Description = "Perfect whilst pulling off the perfect Heist"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/mask6.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
	
	return model, pos, ang
end

