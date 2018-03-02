ITEM.Name = "Stone Zombie Mask"
ITEM.ID = 470
ITEM.Description = "For those who enjoy Roleplaying a Gargoyle"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/zombie.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.1, 0 )
	pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
	
	return model, pos, ang
end

