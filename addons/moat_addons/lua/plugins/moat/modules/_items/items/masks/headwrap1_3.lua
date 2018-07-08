ITEM.Name = "Red Arrow Wrap"
ITEM.ID = 406
ITEM.Description = "Like the superhero Green Arrow, but Red"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/headwrap1.mdl"
ITEM.Attachment = "eyes"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)

	model:SetSkin( 3 )
	model:SetModelScale( 1.05, 0 )
	pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
	
	return model, pos, ang
end

