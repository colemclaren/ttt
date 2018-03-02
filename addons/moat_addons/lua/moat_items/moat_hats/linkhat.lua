
ITEM.ID = 111

ITEM.Name = "Link Hat"

ITEM.Description = "Hyeeeh kyaah hyaaah haa hyet haa haa jum jum haaa"

ITEM.Model = "models/gmod_tower/linkhat.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -3) +(ang:Up() * -0.8) + m_IsTerroristModel( ply:GetModel() )
	return model, pos, ang

end

