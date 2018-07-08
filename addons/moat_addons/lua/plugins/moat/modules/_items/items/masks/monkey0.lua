ITEM.Name = "Monkey Mask"
ITEM.ID = 446
ITEM.Description = "Exactly what it says on the tin"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/monkey.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

