ITEM.ID = 7001


ITEM.Name = "Santa's Cap"
ITEM.Description = "Ho Ho Ho Merry Christmas"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/santa/santa.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
    model:SetModelScale(1.1, 0)

    pos = pos + (ang:Forward() * -5.4) + (ang:Up() * -1)

	return model, pos, ang
end

/*
children:
self:
		Angles	=	-90.000 0.000 180.000
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	3.100000 -2.100000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254
children:
self:
		Angles	=	0.000 -80.000 268.300
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/sal/gingerbread.mdl
		Position	=	1.500000 -0.600000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254
children:
self:
		Angles	=	0.000 -80.000 268.300
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/santa/santa.mdl
		Position	=	0.100000 1.300000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254


children:
self:
		Angles	=	0.000 -90.000 0.000
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	-2.500000 0.000000 0.500000
		Size	=	1.1
		UniqueID	=	3503520631
self:
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/sal/gingerbread.mdl
		Position	=	-3.800000 0.000000 0.000000
		Size	=	1.1
		UniqueID	=	3503520631
self:
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/santa/santa.mdl
		Position	=	-5.400000 0.000000 -1.000000
		Size	=	1.1
		UniqueID	=	3503520631


*/