
ITEM.ID = 143

ITEM.Name = "Kitty Hat"

ITEM.Description = "Aww so cute"

ITEM.Model = "models/gmod_tower/toetohat.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 0.6) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

