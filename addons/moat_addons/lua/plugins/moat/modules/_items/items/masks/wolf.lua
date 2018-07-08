ITEM.Name = "Wolf Mask"
ITEM.ID = 468
ITEM.Description = "May cause violent outbursts of howling at a Full Moon"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/wolf.mdl"
ITEM.Attachment = "eyes"


function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetModelScale( 1.05 )
	pos = pos + (ang:Forward() * -4.468628) + (ang:Right() * 0.039375) +  (ang:Up() * -2.770370)
	
	return model, pos, ang
end

