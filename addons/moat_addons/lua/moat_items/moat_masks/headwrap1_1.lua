ITEM.Name = "Arrows Wrap"
ITEM.ID = 404
ITEM.Description = "This way up"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/headwrap1.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 1 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
	
	return model, pos, ang
end

