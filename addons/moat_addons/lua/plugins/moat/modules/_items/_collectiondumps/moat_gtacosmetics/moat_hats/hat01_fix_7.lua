ITEM.Name = "Blue Fedora"
ITEM.ID = 371
ITEM.Description = "How many of the eight Fedoras do you own? Collect them"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 7 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)

	return model, pos, ang
end

