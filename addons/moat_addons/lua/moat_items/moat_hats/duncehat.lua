
ITEM.ID = 61

ITEM.Name = "Dunce Hat"

ITEM.Description = "You must sit in the corner and think of your terrible actions"

ITEM.Model = "models/duncehat/duncehat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	ang:RotateAroundAxis(ang:Right(), 25)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.5) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end