
ITEM.ID = 131

ITEM.Name = "Billy Hatcher Hat"

ITEM.Description = "Good Morning"

ITEM.Model = "models/lordvipes/billyhatcherhat/billyhatcherhat.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0.6) +  (ang:Up() * -1) + m_IsTerroristModel( ply:GetModel() )
	return model, pos, ang

end

