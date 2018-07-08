
ITEM.ID = 77

ITEM.Name = "Mario Hat"

ITEM.Description = "Shut up you fat italian"

ITEM.Model = "models/lordvipes/mariohat/mariohat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -1.6) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

