ITEM.ID = 7003

ITEM.Name = "Snowman Head"
ITEM.Description = "Frosty the terrorist"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/props/cs_office/snowman_face.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
    model:SetModelScale(1.1, 0)

    pos = pos + (ang:Forward() * -2.5) + (ang:Up() * 0.5)
    ang:RotateAroundAxis(ang:Up(), -90)
    
	return model, pos, ang
end

/*
		Angles	=	0.000 -90.000 0.000
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	-2.500000 0.000000 0.500000
		Size	=	1.1
		UniqueID	=	3503520631
		*/