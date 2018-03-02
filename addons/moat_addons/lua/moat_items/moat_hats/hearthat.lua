ITEM.Name = "Heart Hat"
ITEM.ID = 659
ITEM.Description = "I'm in love with my head"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/balloons/balloon_classicheart.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"


function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale(0.775, 0)
	model:SetColor(Color(255, 0, 0))
	pos = pos + (ang:Forward() * -3) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

