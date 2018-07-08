
ITEM.ID = 58

ITEM.Name = "Cake Hat"

ITEM.Description = "This cake is a lie"

ITEM.Model = "models/cakehat/cakehat.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	pos = pos + (ang:Up() * 1.5) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end