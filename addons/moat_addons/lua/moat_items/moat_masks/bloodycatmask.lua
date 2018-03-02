ITEM.Name = "Bloody Cat Mask"
ITEM.ID = 655
ITEM.Description = "Tearing up one face at a time"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/catmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0.6) + (ang:Up() * -4.6)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

