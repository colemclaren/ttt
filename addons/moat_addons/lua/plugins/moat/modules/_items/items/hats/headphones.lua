
ITEM.ID = 107

ITEM.Name = "Headphones"

ITEM.Description = "I can't hear you, I'm listeng to a game"

ITEM.Model = "models/gmod_tower/headphones.mdl"

ITEM.Rarity = 1

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

