ITEM.Name = "Nut House Trucker Hat"
ITEM.ID = 396
ITEM.Description = "Sounds a lot like a Gay Bar"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin( 2 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)

	return model, pos, ang
end

