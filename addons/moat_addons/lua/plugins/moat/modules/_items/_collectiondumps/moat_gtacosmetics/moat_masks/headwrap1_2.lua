ITEM.Name = "Caution Wrap"
ITEM.ID = 405
ITEM.Description = "Trust me. It's for the best that you're covered up"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/headwrap1.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 2 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
	
	return model, pos, ang
end

