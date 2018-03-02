ITEM.Name = "Turqoise Bird Mask"
ITEM.ID = 656
ITEM.Description = "I'm feelying quite blue and gray right now"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 2
ITEM.Model = "models/splicermasks/birdmask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

