ITEM.Name = "Brown Monkey Mask"
ITEM.ID = 447
ITEM.Description = "King Kong. Is that you? Hmm.."
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/monkey.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

