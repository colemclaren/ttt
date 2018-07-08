ITEM.Name = "Rainbow Mummy Wrap"
ITEM.ID = 410
ITEM.Description = "Some say there is Treasure at the end of the Rainbow"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/headwrap2.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
	
	return model, pos, ang
end

