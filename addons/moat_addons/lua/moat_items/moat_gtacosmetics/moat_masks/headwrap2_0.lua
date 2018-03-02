ITEM.Name = "Gray Mummy Wrap"
ITEM.ID = 407
ITEM.Description = "50 Shades of Mummy. No, wait"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/headwrap2.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 0 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
	
	return model, pos, ang
end

