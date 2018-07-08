ITEM.Name = "dungo Effect"
ITEM.ID = 228
ITEM.Description = "Stop looking at me"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/gibs/antlion_gib_large_2.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.400,0.400,0.400)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("phoenix_storms/camera")

	local MAngle = Angle(266.0899,0,272.3500)
	local MPos = Vector(4.219,2,-10.430)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.039 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.039 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(190,255,125),
	4.3,
	4.3,
	1)
	end


	return model, pos, ang
end
