ITEM.Name = "White Fedora"
ITEM.ID = 522
ITEM.Description = "Smooth Criminal"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)

	return model, pos, ang
end

