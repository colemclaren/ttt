ITEM.ID = 7002

ITEM.Name = "Gingerbread Mask"
ITEM.Description = "Please don't eat my face"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/sal/gingerbread.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)

	pos = pos + (ang:Forward() * -3.8)
	
	return model, pos, ang
end


/*
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/sal/gingerbread.mdl
		Position	=	-3.800000 0.000000 0.000000
		Size	=	1.1
		UniqueID	=	3503520631
		*/