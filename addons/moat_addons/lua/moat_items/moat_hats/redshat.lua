
ITEM.ID = 142

ITEM.Name = "Red's Hat"

ITEM.Description = "Pokemon red hat"

ITEM.Model = "models/lordvipes/redshat/redshat.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.75, 0)
	pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 18)

	return model, pos, ang

end

