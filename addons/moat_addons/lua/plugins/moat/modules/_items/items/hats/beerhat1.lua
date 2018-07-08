ITEM.Name = "Super Wet Beer Hat"
ITEM.ID = 499
ITEM.Description = "It was so tempting to put a 'Yo Mama' joke here"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

