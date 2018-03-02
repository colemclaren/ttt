
ITEM.ID = 138

ITEM.Name = "Luigi Hat"

ITEM.Description = "Taller and jumps higher than mario. Still doesn't get to be the main character. (no this does not change jump height)"

ITEM.Model = "models/lordvipes/luigihat/luigihat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * -3) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

