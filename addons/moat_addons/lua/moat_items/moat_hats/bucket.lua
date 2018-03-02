
ITEM.ID = 19

ITEM.Name = "Bucket Helmet"

ITEM.Description = "It's a bucket"

ITEM.Model = "models/props_junk/MetalBucket01a.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Alpha Collection"

ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )

	model:SetModelScale( 0.7, 0 )
	
	pos = pos + ( ang:Forward() * -5 ) + ( ang:Up() * 5 )// + m_IsTerroristModel( ply:GetModel() )
	
	ang:RotateAroundAxis( ang:Right(), 200 )
	
	return model, pos, ang

end