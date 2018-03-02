ITEM.Name = "Chuck Mask"
ITEM.ID = 662
ITEM.Description = "God Bless the Badass America"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/chuck_mask/chuck_mask.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 2) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

