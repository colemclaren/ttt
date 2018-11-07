ITEM.Name = "Valve Effect"
ITEM.ID = 267
ITEM.Description = "The annoying intro everyone watches because it's cool anyways"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_pipes/valvewheel001.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.300,0.300,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("")

	local MAngle = Angle(90.7799,181.5700,48.5200)
	local MPos = Vector(5.2199,2.6099,0)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.869 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(255,0,0),
	2,
	2,
	1)
	end


	return model, pos, ang
end

