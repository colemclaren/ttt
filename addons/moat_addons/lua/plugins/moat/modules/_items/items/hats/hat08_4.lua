ITEM.Name = "Bishop Trucker Hat"
ITEM.ID = 398
ITEM.Description = "For all the Christian Truckers"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin( 4 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)

	return model, pos, ang
end

