
ITEM.ID = 125

ITEM.Name = "Team Rocket Hat"

ITEM.Description = "Prepare for trouble, and make it double!"

ITEM.Model = "models/gmod_tower/teamrockethat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(1.15, 0)
	pos = pos + (ang:Forward() * -4) + (ang:Up() * -0.6) + m_IsTerroristModel( ply:GetModel() )
	ang:RotateAroundAxis(ang:Right(), 18.2)

	return model, pos, ang

end

