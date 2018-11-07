
ITEM.ID = 212

ITEM.Name = "Dola Effect"

ITEM.Description = "A special item given as a thanks to the sugar daddies of MG"

ITEM.Model = "models/props/cs_assault/money.mdl"

ITEM.Rarity = 8

ITEM.Collection = "Sugar Daddy Collection"

ITEM.Bone = "ValveBiped.Bip01_Head1"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	local Size = Vector( 0.600,0.600,2.849 )
	
	local mat = Matrix()
	
	mat:Scale(Size)
	model:EnableMatrix( "RenderMultiply", mat )
	model:SetMaterial( "" )

	local MAngle = Angle(95.480,180,65.739)
	local MPos = Vector(2.609,0,-7.829)

	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)

	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0.610 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)

	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))

	if ( tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer()) ) then
		
	halo.Add( {model}, Color(148,192,72), 10, 10, 1)
	
	end

	return model, pos, ang

end
