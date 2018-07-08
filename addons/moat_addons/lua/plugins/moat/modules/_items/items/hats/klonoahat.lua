
ITEM.ID = 137

ITEM.Name = "Klonoa Hat"

ITEM.Description = "Become the ultimate hipster"

ITEM.Model = "models/lordvipes/klonoahat/klonoahat.mdl"

ITEM.Rarity = 1

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.77, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

