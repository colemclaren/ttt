
ITEM.ID = 144

ITEM.Name = "Viewtiful Joe Helmet"

ITEM.Description = "Shoot em up"

ITEM.Model = "models/lordvipes/viewtifuljoehelmet/viewtifuljoehelmet.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Cosmetic Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -0.6) + m_IsTerroristModel( ply:GetModel() )

	return model, pos, ang

end

