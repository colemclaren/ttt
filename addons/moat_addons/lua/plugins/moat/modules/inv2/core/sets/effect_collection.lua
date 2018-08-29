------------------------------------
--
-- Effect Collection
--
------------------------------------


inv.Item(275)
	:SetRarity (5)
	:SetType "Crate"
	:SetName "Effect Crate"
	:SetDesc "This crate contains an item from the Effect Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/effect_crate64.png"
	:SetCollection "Effect Collection"

	:SetShop (3950, true)


------------------------------------
-- High-End Items
------------------------------------


inv.Item(213)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Black Hole Effect"
	:SetDesc "The center of the universe"
	:SetModel "models/effects/vol_light128x128.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.200,0.200,0.200)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/effects/portalrift_sheet")
		local MAngle = Angle(90,0,277.0)
		local MPos = Vector(23.26,-2,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = ((CurTime() * 0.5) * 0 *90)
		model.ModelDrawingAngle.y = ((CurTime() * 0.5) * 2.60 *90)
		model.ModelDrawingAngle.r = ((CurTime() * 0.5) * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(215)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Black Ice Effect"
	:SetDesc "Don't drive on this"
	:SetModel "models/props_junk/cinderblock01a.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.349,0.300,0.129)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props_combine/citadel_cable")
		local MAngle = Angle(0,0,0)
		local MPos = Vector(2.609,0,8.22)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 1.169 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,255,255),
		6.9,
		6.9,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(216)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Blue Data Effect"
	:SetDesc "This is what's left from the DDoS attack"
	:SetModel "models/props/cs_office/computer_caseb_p3b.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1.299,2,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props_combine/combine_interface_disp")
		local MAngle = Angle(0,0,0)
		local MPos = Vector(0,0,-0.0399)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(0,119,255),
		3.6,
		3.6,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(217)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Burger Effect"
	:SetDesc "Welcome to good burger, home of the good burger, can I take your order"
	:SetModel "models/food/burger.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(1,1,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(100.1699,360,280.1700)
		local MPos = Vector(-5.829,-2.609,-7.829)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(241,151,17),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(218)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Robot Effect"
	:SetDesc "Boop beep bop boop"
	:SetModel "models/perftest/loader.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.0299,0.0299,0.0299)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(84.519,0,275.4800)
		local MPos = Vector(5.219,-2.609,-5.219)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,204,0),
		1,
		1,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(219)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Combine Ball Effect"
	:SetDesc "Stop right there civilian scum"
	:SetModel "models/effects/combineball.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.3000,0.3000,0.3000)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(84.5199,173.7400,97.04000)
		local MPos = Vector(5.2199,-0.6100,-8.2200)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 10 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(220)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Confusion Effect"
	:SetDesc "uh ... huh"
	:SetModel "models/effects/vol_light.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.2000,0.1000,0.0199)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/effects/splodearc_sheet")
		local MAngle = Angle(93.9100,0,266.08999)
		local MPos = Vector(-4.570,-0.219,-0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(221)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "WASD Effect"
	:SetDesc "Just use WASD"
	:SetModel "models/props/de_train/bush.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.100,0.100,0.300)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props/cs_assault/moneywrap")
		local MAngle = Angle(90.7799,0,264.519)
		local MPos = Vector(-5.780,2,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.090 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(223)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Diamond Effect"
	:SetDesc "Shine bright"
	:SetModel "models/gibs/hgibs.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.60000,0.6000,0.600)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/wireframe")
		local MAngle = Angle(95.48000,180,65.739)
		local MPos = Vector(2.6099,2.6099,7.829)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0.827 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0.829 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0.779 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,255,255),
		2,
		2,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(224)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Donut Effect"
	:SetDesc "This donut reminds me so much of Homer from the Simpsons"
	:SetModel "models/noesis/donut.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,0,238),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(225)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Dr. Danger Effect"
	:SetDesc "Woooah watch out guys"
	:SetModel "models/props_wasteland/prison_toiletchunk01j.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.8000,0.800,0.80000)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("phoenix_storms/stripes")
		local MAngle = Angle(0,101.739,78.2600)
		local MPos = Vector(10.4300,-3.609,0.6101)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,238,0),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(226)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Explosion Effect"
	:SetDesc "This is so pretty"
	:SetModel "models/gibs/strider_gib3.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.200,0.200,0.200)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/effects/splode_sheet")
		local MAngle = Angle(0,101.7399,78.260)
		local MPos = Vector(10.4300,0.610,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,97,0),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(227)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Duhaf Effect"
	:SetDesc "What the duhaf"
	:SetModel "models/gibs/strider_gib3.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.200,0.200,0.200)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("phoenix_storms/wire/pcb_green")
		local MAngle = Angle(0,101.7399,78.260)
		local MPos = Vector(10.430,0.6100,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(0,255,63),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(228)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "dungo Effect"
	:SetDesc "Stop looking at me"
	:SetModel "models/gibs/antlion_gib_large_2.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(190,255,125),
		4.3,
		4.3,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(229)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Editor Effect"
	:SetDesc "Use this to help you edit your life"
	:SetModel "models/editor/axis_helper_thick.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.3000,0.3000,0.3000)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(264.5199,180,97.040)
		local MPos = Vector(4.6100,-1.6100,7.219)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 2.740 *90)
		model.ModelDrawingAngle.r = (CurTime() * 1.779 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(0,17,255),
		2.7,
		2.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(230)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "GMan Effect"
	:SetDesc "Good morning Mr. Freeman"
	:SetModel "models/perftest/gman.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.1500,0.1500,0.1500)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(92.349,0,280.170)
		local MPos = Vector(3.609,-2.609,7.219)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(124,113,175),
		1.7,
		1.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(231)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Koi Effect"
	:SetDesc "Just keep swimming, just keep swimming swimming swimming"
	:SetModel "models/props/de_inferno/goldfish.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.600,0.600,0.600)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(0,350.609,269.220)
		local MPos = Vector(7.8299,-2.6099,-10.430)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(241,17,17),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(233)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Holy Effect"
	:SetDesc ":O WOAH"
	:SetModel "models/effects/vol_light128x128.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.200,0.200,0.200)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(90,0,277.0400)
		local MPos = Vector(23.260,-2,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 2.609 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(234)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Horse Effect"
	:SetDesc "Neighhhh"
	:SetModel "models/props_phx/games/chess/white_knight.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.2000,0.2000,0.2000)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(0,0,269.649)
		local MPos = Vector(3.2200,-2.6099,-7.8299)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.2593 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,231,159),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(235)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Hotdog Effect"
	:SetDesc "Hotdogs here! Get your hotdogs"
	:SetModel "models/food/hotdog.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.699,0.699,0.699)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(100.1699,360,280.170)
		local MPos = Vector(-2.609,-2.609,-7.829)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(241,151,17),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(236)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Huladoll Effect"
	:SetDesc "That's racist to my culture sir"
	:SetModel "models/props_lab/huladoll.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(1,1,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(100.1699,360,280.1700)
		local MPos = Vector(5.219,-2.6099,-7.8299)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(17,241,84),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(237)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Snowman Effect"
	:SetDesc "Frosty the snowman was jolly good fellow"
	:SetModel "models/props/cs_office/snowman_face.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.4000,0.4000,0.4000)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(1.5701,0,264.519)
		local MPos = Vector(7.829,-1,-7.829)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,255,255),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(238)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "ILLIN Effect"
	:SetDesc "That's sick"
	:SetModel "models/props_phx/gibs/flakgib1.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.600,0.600,0.600)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/alyx/emptool_glow")
		local MAngle = Angle(0,0,269.649)
		local MPos = Vector(13.039,0.610,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.259 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(146,202,255),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(239)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Lamar Effect"
	:SetDesc "Wazzup people"
	:SetModel "models/nova/w_headcrab.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.300,0.300,0.300)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(173.740,286.429,84.51)
		local MPos = Vector(4.61,-1.61,7.21)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,204,0),
		2.7,
		2.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(240)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "LAPIZ Effect"
	:SetDesc "Oh great, another Minecraft reference"
	:SetModel "models/props_wasteland/prison_toiletchunk01j.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.80,0.80,0.80)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("phoenix_storms/blue_steel")
		local MAngle = Angle(0,101.739,78.260)
		local MPos = Vector(10.436,-3.60,0.610)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(29,0,255),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(241)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "L.F. Effect"
	:SetDesc "This only helps you if you're drowning"
	:SetModel "models/props/de_nuke/lifepreserver.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.5,0.5,0.5)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(95.480,360,178.429)
		local MPos = Vector(-2.609,0,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0.910 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(242)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Potke Effect"
	:SetDesc "You a sexy motherfucka"
	:SetModel "models/shadertest/vertexlittextureplusenvmappedbumpmap.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.150,0.150,0.150)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(86.089,3.130,280.17)
		local MPos = Vector(2.60,-2,6.21)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(0,246,255),
		2.7,
		2.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(243)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "lovd Effect"
	:SetDesc "Why can't you lovd me"
	:SetModel "models/props_lab/pipesystem03d.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1,1,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/items/boxsniperrounds")
		local MAngle = Angle(93.910,0,164.350)
		local MPos = Vector(14.039,-1.220,-0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 2.039 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,0,255),
		4,
		4,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(244)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "M Effect"
	:SetDesc "Not any other letter"
	:SetModel "models/props_rooftop/sign_letter_m001.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.303,0.303,0.300)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props_lab/Tank_Glass001")
		local MAngle = Angle(92.349,180.570,101.349)
		local MPos = Vector(10.430,0,0)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,85,0),
		2,
		2,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(245)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Mage Effect"
	:SetDesc "Nice magic"
	:SetModel "models/noesis/donut.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1,1,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("debug/env_cubemap_model")
		local MAngle = Angle(0,100,91)
		local MPos = Vector(3,-9.2600,0)
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
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(246)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Math Effect"
	:SetDesc "I was never good at math, but hey, I made this description"
	:SetModel "models/props_lab/bindergreen.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1.01999,4.2199,1.0393)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/wireframe")
		local MAngle = Angle(180,0,269.220)
		local MPos = Vector(-2.390,2,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0.959 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(248)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Metrocop Effect"
	:SetDesc "Not as cool as Robocop"
	:SetModel "models/nova/w_headgear.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,255,255),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(249)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Trees Effect"
	:SetDesc "God of trees"
	:SetModel "models/props_foliage/tree_springers_card_01_skybox.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.20,0.200,0.200)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(95.480,180,90)
		local MPos = Vector(-5.219,-2.609,2.609)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(250)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Nature Effect"
	:SetDesc "God of nature"
	:SetModel "models/props/pi_shrub.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.200,0.200,0.200)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(95.480,180,90)
		local MPos = Vector(14.039,0,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 2.039 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(251)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Pantom Effect"
	:SetDesc "You're a fucking demon"
	:SetModel "models/props_lab/miniteleportarc.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1,1,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/effects/comball_glow1")
		local MAngle = Angle(93.9100,0,266.08999)
		local MPos = Vector(-6.5700,-0.21999,-0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(252)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Paradigm Effect"
	:SetDesc "Be careful not to break the space time continuum"
	:SetModel "models/props_c17/playgroundtick-tack-toe_block01a.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.600,0.600,0.600)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props_lab/security_screens2")
		local MAngle = Angle(0,0,0)
		local MPos = Vector(2.609,1,-11.039)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 3.650 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(129,189,244),
		4.3,
		4.3,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(253)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Quartz Effect"
	:SetDesc "George6120: Thats a tricky one - Unless you want to reference Minecraft (^:"
	:SetModel "models/props/de_tides/menu_stand_p05.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(229,90,90),
		3.6,
		3.6,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(254)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Dead Bush Effect"
	:SetDesc "Don't fuck with this shrub"
	:SetModel "models/props/de_train/bush2.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.600,0.600,0.600)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props_c17/gate_door02a")
		local MAngle = Angle(90.779,0,264.519)
		local MPos = Vector(-6.780,1,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.090 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(255)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Scan Effect"
	:SetDesc "Scanning for possible scrub ... SCRUB FOUND"
	:SetModel "models/props_lab/generatortube.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.300,0.400,0.119)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/weapons/w_smg1/smg_crosshair")
		local MAngle = Angle(90,0,277.040)
		local MPos = Vector(2.609,-3,0)
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
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(256)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Rocket Effect"
	:SetDesc "5 .. 4 .. 3 .. 2 .. 1 .. LIFT OFF"
	:SetModel "models/weapons/w_missile_closed.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.600,0.800,0.800)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(0,86.0899,0)
		local MPos = Vector(7.829,-1.220,-7.219)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 10 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,97,0),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(257)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "QT Effect"
	:SetDesc "I hope this helps you"
	:SetModel "models/editor/cone_helper.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.300,0.300,0.300)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(264.519,180,97.040)
		local MPos = Vector(4.6100,-1.610,7.219)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 1.2599 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.7799 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(0,169,255),
		8.6,
		8.6,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(258)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Particle Effect"
	:SetDesc "So pretty"
	:SetModel "models/effects/splodeglass.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.100,0.100,0.0599)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(0,101.739,78.26000)
		local MPos = Vector(10.430,0.610,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0.8700 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,255,255),
		3.7,
		3.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(259)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Lava Effect"
	:SetDesc "Feel the BURN"
	:SetModel "models/props/cs_office/trash_can_p6.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1,1,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("phoenix_storms/top")
		local MAngle = Angle(0,0,0)
		local MPos = Vector(7.8299,0,-0.03999)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 1.0399 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,0,0),
		2,
		2,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(260)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Toxin Effect"
	:SetDesc "You're toxic"
	:SetModel "models/props/cs_office/trash_can_p6.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1,1,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("phoenix_storms/pack2/interior_sides")
		local MAngle = Angle(0,0,0)
		local MPos = Vector(7.8299,0,-0.03999)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 1.0399 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(161,255,0),
		2,
		2,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(261)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Wisp Effect"
	:SetDesc "Woah that's pretty cool"
	:SetModel "models/effects/vol_light128x128.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.2000,0.2000,0.2000)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/roller/rollermine_glow")
		local MAngle = Angle(90,0,277.04000)
		local MPos = Vector(23.26000,-2,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 2.6099 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(262)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Stone Effect"
	:SetDesc "You are the king of stone"
	:SetModel "models/props_combine/breenbust_chunk03.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1,0.5,0.5)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(0,0,0)
		local MPos = Vector(7.8299,0,-0.0399)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 2 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,219,219),
		3.6,
		3.6,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(264)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Gordon Effect"
	:SetDesc "What small body you have there Mr. Freeman"
	:SetModel "models/editor/playerstart.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.1500,0.1500,0.1500)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(264.519,180,97.0400)
		local MPos = Vector(4.610,-1.610,7.219)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(0,255,0),
		2.7,
		2.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(265)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Tornado Effect"
	:SetDesc "Don't let your house get swept up"
	:SetModel "models/props_combine/stasisvortex.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.1500,0.1500,0.0399)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props/cs_office/clouds")
		local MAngle = Angle(270.220,0,280.170)
		local MPos = Vector(11.430,0,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 6.039 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(266)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Turtle Effect"
	:SetDesc "Awww it's a turtle"
	:SetModel "models/props/de_tides/vending_turtle.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.600,0.600,0.600)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
		local MAngle = Angle(0,341.2200,264.519)
		local MPos = Vector(5.2199,-1,-7.829)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(122,230,86),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(267)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Valve Effect"
	:SetDesc "The annoying intro everyone watches because it's cool anyways"
	:SetModel "models/props_pipes/valvewheel001.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,0,0),
		2,
		2,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(268)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "White Snake Effect"
	:SetDesc "You sneaky bastard"
	:SetModel "models/props_lab/teleportring.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,255,255),
		1.7,
		1.7,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(269)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Acid Effect"
	:SetDesc "Get slimed"
	:SetModel "models/dav0r/hoverball.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1.299,1.299,1.299)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/effects/slimebubble_sheet")
		local MAngle = Angle(177,0,269.220)
		local MPos = Vector(2.609,2,0)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 10 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"


inv.Item(270)
	:SetRarity (5)
	:SetType "Effect"
	:SetName "Yellow Data Effect"
	:SetDesc "This is what's left from the yellow DDoS attack"
	:SetModel "models/props/cs_office/computer_caseb_p3b.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(1.299,2,1)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/props/cs_assault/pylon")
		local MAngle = Angle(0,0,0)
		local MPos = Vector(0,0,-0.0399)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 1.0399 *90)
		model.ModelDrawingAngle.y = (CurTime() * 0 *90)
		model.ModelDrawingAngle.r = (CurTime() * 0 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(255,242,0),
		3.6,
		3.6,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Effect Collection"

