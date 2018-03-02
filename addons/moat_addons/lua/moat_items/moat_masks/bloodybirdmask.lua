ITEM.Name = "Bloody Bird Mask"
ITEM.ID = 668
ITEM.Description = "A very pale vulture feasts on terrorist souls"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/birdmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

