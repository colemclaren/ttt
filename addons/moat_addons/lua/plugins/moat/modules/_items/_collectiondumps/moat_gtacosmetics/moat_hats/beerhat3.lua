ITEM.Name = "Benedict Beer Hat"
ITEM.ID = 501
ITEM.Description = "Clench your thirst with this Hat"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

