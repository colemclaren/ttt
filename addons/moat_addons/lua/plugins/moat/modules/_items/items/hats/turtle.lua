
ITEM.ID = 18

ITEM.Name = "Turtle Hat"

ITEM.Description = "This cute little turtle can sit on your head and give you amazing love"

ITEM.Model = "models/props/de_tides/Vending_turtle.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + ( ang:Forward() * -3 ) + m_IsTerroristModel( ply:GetModel() )

	ang:RotateAroundAxis( ang:Up(), -90 )
	

	return model, pos, ang

end