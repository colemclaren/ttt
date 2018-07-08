
ITEM.ID = 83

ITEM.Name = "Santa Hat"

ITEM.Description = "It's Christmas"

ITEM.Model = "models/gmod_tower/santahat.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Forward() * -2) + (ang:Right() * -0.2) +  (ang:Up() * 2.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

