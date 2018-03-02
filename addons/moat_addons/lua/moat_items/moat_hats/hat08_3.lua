ITEM.Name = "Rusty Trucker Hat"
ITEM.ID = 397
ITEM.Description = "Rust is another name for Iron Oxide, which occurs when Iron or an alloy that contains Iron, like Steel, is exposed to Oxygen and moisture for a long period of time"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin( 3 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)

	return model, pos, ang
end

