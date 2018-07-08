ITEM.Name = "Queasy Bag"
ITEM.ID = 476
ITEM.Description = "Good thing you have this bag if you need to puke"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 13
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 13 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

