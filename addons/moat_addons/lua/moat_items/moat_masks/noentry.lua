
ITEM.ID = 20

ITEM.Name = "No Entry Mask"

ITEM.Description = "No man shall enter your face again"

ITEM.Model = "models/props_c17/streetsign004f.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale( 0.7, 0 )

	pos = pos + ( ang:Forward() * 3 )

	ang:RotateAroundAxis( ang:Up(), -90 )
	
	return model, pos, ang
	
end