ITEM.Name = "Metrocop Effect"
ITEM.ID = 248
ITEM.Description = "Not as cool as Robocop"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/nova/w_headgear.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.5,0.5,0.5)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(92.3499,270.779,360)
	local MPos = Vector(6.219,-1,-7.2197)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(255,255,255),
	6.5,
	6.5,
	1)
	end


	return model, pos, ang
end


