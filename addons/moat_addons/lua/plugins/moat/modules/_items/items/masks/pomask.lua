ITEM.Name = "Po Mask"
ITEM.ID = 664
ITEM.Description = "The panda is a great animal and will always be named Po"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/jean-claude_mask/jean-claude_mask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

