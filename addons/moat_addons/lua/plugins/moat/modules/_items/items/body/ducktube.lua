ITEM.ID = 2067

ITEM.Name = "Duck Tube"

ITEM.Description = "The king of the pool party"

ITEM.Model = "models/captainbigbutt/skeyler/accessories/duck_tube.mdl"

ITEM.Rarity = 8

ITEM.Collection = "Independence Collection"

ITEM.Bone = "ValveBiped.Bip01_Spine1"

function ITEM:ModifyClientsideModel( ply, model, pos, ang )
	model:SetModelScale(1.65, 0)
	pos = pos + (ang:Forward() * 0) + (ang:Right() * -0) +  (ang:Up() * -1.2) + m_IsTerroristModel( ply:GetModel() )

	ang:RotateAroundAxis( ang:Right(), 270 )
	ang:RotateAroundAxis( ang:Up(), 90 )

	pos = pos + Vector(-5,3,0)
	return model, pos, ang
end