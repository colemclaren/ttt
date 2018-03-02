ITEM.Name = "Please Stop Mask"
ITEM.ID = 441
ITEM.Description = "Ripped straight from a Horror Movie"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/modified/mask5.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

