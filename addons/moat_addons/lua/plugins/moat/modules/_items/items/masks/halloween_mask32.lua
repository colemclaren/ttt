ITEM.ID = 5133
ITEM.Name = "Pumpkin Head"
ITEM.Description = "An exclusive head mask from the Pumpkin Event"
ITEM.Model = "models/gmod_tower/halloween_pumpkinhat.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.875, 0)
	pos = pos + (ang:Forward() * -3.1) + (ang:Up() * -7.5) + m_IsTerroristModel(ply:GetModel())

	return model, pos, ang
end

