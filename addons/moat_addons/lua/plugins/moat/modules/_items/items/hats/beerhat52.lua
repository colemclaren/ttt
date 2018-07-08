ITEM.Name = "USA J Lager Beer Hat"
ITEM.ID = 2503
ITEM.Description = "Jelly Lager? Delicious"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 5 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

