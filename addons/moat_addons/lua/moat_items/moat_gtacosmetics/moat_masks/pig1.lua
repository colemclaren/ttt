ITEM.Name = "Zombie Pig Mask"
ITEM.ID = 463
ITEM.Description = "Please not another Minecraft Reference"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/pig.mdl"
ITEM.Attachment = "eyes"





function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.220093) + (ang:Right() * 0.055542) +  (ang:Up() * -1.410973)
	
	return model, pos, ang
end

