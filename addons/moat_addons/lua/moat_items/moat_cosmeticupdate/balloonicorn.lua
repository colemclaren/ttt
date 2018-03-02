
ITEM.ID = 97

ITEM.Name = "Balloonicorn"

ITEM.Description = "Hey look, you finally have a friend now"

ITEM.Model = "models/gmod_tower/balloonicorn_nojiggle.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes" // left trapezius

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.3, 0)
	pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -5.2) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

