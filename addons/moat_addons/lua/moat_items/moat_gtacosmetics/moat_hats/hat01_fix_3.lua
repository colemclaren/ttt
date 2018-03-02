ITEM.Name = "Tan Fedora"
ITEM.ID = 367
ITEM.Description = "Why sunbathe for a tan when you could just wear this Fedora"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)

	return model, pos, ang
end

