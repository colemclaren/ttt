ITEM.Name = "White Snake Effect"
ITEM.ID = 268
ITEM.Description = "You sneaky bastard"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/teleportring.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.3000,0.4000,0.1199)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("models/props/de_nuke/nukconcretewalla")

	local MAngle = Angle(90,0,277.040)
	local MPos = Vector(12.649,-3,0)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.130 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(255,255,255),
	1.7,
	1.7,
	1)
	end


	return model, pos, ang
end


