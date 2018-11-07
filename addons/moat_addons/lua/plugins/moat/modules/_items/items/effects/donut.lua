ITEM.Name = "Donut Effect"
ITEM.ID = 224
ITEM.Description = "This donut reminds me so much of Homer from the Simpsons"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/noesis/donut.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.30000,0.3000,0.3000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(236.350,187.8300,275.4800)
	local MPos = Vector(6.219999,-1,-7.2199)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.129 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(255,0,238),
	6.5,
	6.5,
	1)
	end


	return model, pos, ang
end



