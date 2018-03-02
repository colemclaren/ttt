
ITEM.ID = 62

ITEM.Name = "Fedora"

ITEM.Description = "You're the best meme of them all"

ITEM.Model = "models/gmod_tower/fedorahat.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 2.5) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end