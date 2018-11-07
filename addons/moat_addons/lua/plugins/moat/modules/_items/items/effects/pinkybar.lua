ITEM.Name = "Quartz Effect"
ITEM.ID = 253
ITEM.Description = "George6120: Thats a tricky one - Unless you want to reference Minecraft (^:"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_tides/menu_stand_p05.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"



function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,0.5,0.5)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)

	model:SetMaterial("models/props_combine/tprings_globe")

	local MAngle = Angle(0,0,0)
	local MPos = Vector(7.8299,0,-0.0399)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.039 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
	halo.Add( {model},
	Color(229,90,90),
	3.6,
	3.6,
	1)
	end


	return model, pos, ang
end

