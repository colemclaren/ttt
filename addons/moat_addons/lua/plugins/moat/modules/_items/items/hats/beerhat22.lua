ITEM.Name = "USA Patriot Beer Hat"
ITEM.ID = 2500
ITEM.Description = "For the True Redneck"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

