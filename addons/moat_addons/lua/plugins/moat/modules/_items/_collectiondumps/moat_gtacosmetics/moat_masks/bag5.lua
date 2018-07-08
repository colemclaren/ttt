ITEM.Name = "Sharp Teeth Bag"
ITEM.ID = 492
ITEM.Description = "Jaws 5: Trouble in Terrorist Ocean"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 5 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

