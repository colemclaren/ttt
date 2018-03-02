
ITEM.ID = 74

ITEM.Name = "Wooden Comb Afro"

ITEM.Description = "You're as OG as OG can get my black friend"

ITEM.Model = "models/captainbigbutt/skeyler/hats/afro.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.4) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

