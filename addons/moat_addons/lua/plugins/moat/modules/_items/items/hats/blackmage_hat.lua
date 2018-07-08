
ITEM.ID = 132

ITEM.Name = "Black Mage Hat"

ITEM.Description = "Do you know what happens to a giant when it gets blasted with a fireball? The same thing that happens to everything else"

ITEM.Model = "models/lordvipes/blackmage/blackmage_hat.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.3, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -12) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

