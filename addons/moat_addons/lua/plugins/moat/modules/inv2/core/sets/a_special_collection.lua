------------------------------------
--
-- Testing Collection
--
------------------------------------



------------------------------------
-- Extinct Items
------------------------------------


inv.Item(12)
	:SetRarity (10)
	:SetType "Tier"
	:SetName "TalentTest"
	:SetStats (7, 7)
		:SetStat ("Weight", -5, -13)
		:SetStat ("Firerate", 15, 30)
		:SetStat ("Magazine", 30, 50)
		:SetStat ("Accuracy", 15, 25)
		:SetStat ("Damage", 20, 30)
		:SetStat ("Kick", -15, -30)
		:SetStat ("Range", 40, 50)
	:SetTalents (3, 3)
		:SetTalent (3, "Inferno")
	:SetCollection "Testing Collection"






------------------------------------
--
-- 24 Hour Marathon Collection
--
------------------------------------



------------------------------------
-- Planetary Items
------------------------------------


inv.Item(912)
	:SetRarity (8)
	:SetType "Tier"
	:SetName "Insomnious"
	:SetEffect "glow"
	:SetStats (7, 7)
		:SetStat ("Weight", -5, -7)
		:SetStat ("Firerate", 17, 28)
		:SetStat ("Magazine", 23, 33)
		:SetStat ("Accuracy", 17, 28)
		:SetStat ("Damage", 17, 28)
		:SetStat ("Kick", -17, -28)
		:SetStat ("Range", 23, 33)
	:SetTalents (4, 4)
	:SetCollection "24 Hour Marathon Collection"

------------------------------------
--
-- April Fools Collection
--
------------------------------------



------------------------------------
-- Extinct Items
------------------------------------


inv.Item(850)
	:SetRarity (10)
	:SetType "Tier"
	:SetName "Jokesters"
	:SetColor {255, 0, 255}
	:SetStats (7, 7)
		:SetStat ("Weight", -5, -7)
		:SetStat ("Firerate", 17, 28)
		:SetStat ("Magazine", 23, 33)
		:SetStat ("Accuracy", 17, 28)
		:SetStat ("Damage", 17, 28)
		:SetStat ("Kick", -17, -28)
		:SetStat ("Range", 23, 33)
	:SetTalents (3, 3)
	:SetCollection "April Fools Collection"




------------------------------------
--
-- Beginners Collection
--
------------------------------------


inv.Item(0)
	:SetRarity (0)
	:SetType "Tier"
	:SetName "Stock"
	:SetCollection "Beginners Collection"





------------------------------------
--
-- Dev Collection
--
------------------------------------



------------------------------------
-- Extinct Items
------------------------------------


inv.Item(222)
	:SetRarity (10)
	:SetType "Effect"
	:SetName "Developer Effect"
	:SetDesc "Time for the dev to get sxy"
	:SetModel "models/props_c17/tools_wrench01a.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.8000,0.5,0.5)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/gibs/metalgibs/metal_gibs")
		local MAngle = Angle(236.35000,277.04002,360)
		local MPos = Vector(10.22000,-1,-8.220)
		pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = (CurTime() * 0 *90)
		model.ModelDrawingAngle.y = (CurTime() * 1.129 *90)
		model.ModelDrawingAngle.r = (CurTime() * 1.039 *90)
		ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
		ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
		ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model},
		Color(250,255,0),
		6.5,
		6.5,
		1)
		end
		return model, pos, ang
	end)
	:SetCollection "Dev Collection"


inv.Item(90)
	:SetRarity (10)
	:SetType "Hat"
	:SetName "Developer Hat"
	:SetDesc "This is an exclusive hat given to people that have created content for MG"
	:SetModel "models/captainbigbutt/skeyler/hats/devhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Dev Collection"





------------------------------------
--
-- Gamma Collection
--
------------------------------------



------------------------------------
-- High-End Items
------------------------------------


inv.Item(4008)
	:SetRarity (5)
	:SetType "Usable"
	:SetName "High-End Stat Mutator"
	:SetDesc "Using this item allows you to re-roll the stats of any High-End item"
	:SetImage "https://moat.gg/assets/img/highend_stat64.png"
	:SetCollection "Gamma Collection"


inv.Item(4004)
	:SetRarity (5)
	:SetType "Usable"
	:SetName "High-End Talent Mutator"
	:SetDesc "Using this item allows you to re-roll the talents of any High-End item. This will reset the item's LVL and XP"
	:SetImage "https://moat.gg/assets/img/highend_talent64.png"
	:SetCollection "Gamma Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(4006)
	:SetRarity (6)
	:SetType "Usable"
	:SetName "Ascended Stat Mutator"
	:SetDesc "Using this item allows you to re-roll the stats of any Ascended item"
	:SetImage "https://moat.gg/assets/img/ascended_stat64.png"
	:SetCollection "Gamma Collection"


inv.Item(4003)
	:SetRarity (6)
	:SetType "Usable"
	:SetName "Ascended Talent Mutator"
	:SetDesc "Using this item allows you to re-roll the talents of any Ascended item. This will reset the item's LVL and XP"
	:SetImage "https://moat.gg/assets/img/ascended_talent64.png"
	:SetCollection "Gamma Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(4007)
	:SetRarity (7)
	:SetType "Usable"
	:SetName "Cosmic Stat Mutator"
	:SetDesc "Using this item allows you to re-roll the stats of any Cosmic item"
	:SetImage "https://moat.gg/assets/img/cosmic_stat64.png"
	:SetCollection "Gamma Collection"


inv.Item(4002)
	:SetRarity (7)
	:SetType "Usable"
	:SetName "Cosmic Talent Mutator"
	:SetDesc "Using this item allows you to re-roll the talents of any Cosmic item. This will reset the item's LVL and XP"
	:SetImage "https://moat.gg/assets/img/cosmic_talent64.png"
	:SetCollection "Gamma Collection"



------------------------------------
-- Planetary Items
------------------------------------


inv.Item(4009)
	:SetRarity (8)
	:SetType "Usable"
	:SetName "Planetary Stat Mutator"
	:SetDesc "Using this item allows you to re-roll the stats of any Planetary item"
	:SetImage "https://moat.gg/assets/img/planetary_stat64.png"
	:SetCollection "Gamma Collection"


inv.Item(4005)
	:SetRarity (8)
	:SetType "Usable"
	:SetName "Planetary Talent Mutator"
	:SetDesc "Using this item allows you to re-roll the talents of any Planetary item. This will reset the item's LVL and XP"
	:SetImage "https://moat.gg/assets/img/planetary_talent64.png"
	:SetCollection "Gamma Collection"



------------------------------------
-- Extinct Items
------------------------------------


inv.Item(4001)
	:SetRarity (10)
	:SetType "Usable"
	:SetName "Name Mutator"
	:SetDesc "Using this item allows you to change the name of any equippable item in your inventory"
	:SetImage "https://moat.gg/assets/img/name_mutator64.png"
	:SetCollection "Gamma Collection"





------------------------------------
--
-- George Collection
--
------------------------------------



------------------------------------
-- Extinct Items
------------------------------------


inv.Item(530)
	:SetRarity (10)
	:SetType "Model"
	:SetName "Classy Gentleman Model"
	:SetDesc "Only for the Most Dapper of Tea-Sipping Gentelmen"
	:SetModel "models/player/macdguy.mdl"
	:SetCollection "George Collection"





------------------------------------
--
-- Gift Collection
--
------------------------------------


inv.Item(7820)
	:SetRarity (0)
	:SetType "Usable"
	:SetName "Empty Gift Package"
	:SetDesc "Right click to insert an item into the gift package"
	:SetImage "https://i.moat.gg/j1cLj.png"
	:SetCollection "Gift Collection"

	:SetShop (5000, true)






------------------------------------
--
-- Limited Collection
--
------------------------------------


inv.Item(10)
	:SetRarity (10)
	:SetType "Usable"
	:SetName "Traitor Token"
	:SetDesc "Use this item during the preparation phase with atleast 8 players online to be guaranteed to be a Traitor next round"
	:SetImage "https://i.moat.gg/18-08-04-l1p.png"
	:SetCollection "Limited Collection"

	:SetShop (100000, false)


------------------------------------
-- Extinct Items
------------------------------------


inv.Item(4082)
	:SetRarity (10)
	:SetType "Usable"
	:SetName "Dog Talent Mutator"
	:SetDesc "Using this item will add the Dog Lover talent to any weapon. It will replace the tier two talent if one already exists. Only 200 of these mutators can be produced."
	:SetImage "https://i.moat.gg/BT4wO.png"
	:SetCollection "Limited Collection"





------------------------------------
--
-- Space Collection
--
------------------------------------



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(769)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "The Gauntlet"
	:SetWeapon "weapon_ttt_te_deagle"
	:SetStats (5, 7)
		:SetStat ("Weight", -3, -7)
		:SetStat ("Firerate", -10, -1)
		:SetStat ("Magazine", 16, 24)
		:SetStat ("Accuracy", 11, 19)
		:SetStat ("Damage", 15, 25)
		:SetStat ("Kick", -11, -19)
		:SetStat ("Range", 16, 24)
	:SetTalents (3, 3)
		:SetTalent (1, "Space Stone")
		:SetTalent (2, "Reality Stone")
		:SetTalent (3, "Power Stone")
	:SetCollection "Space Collection"






------------------------------------
--
-- Sugar Daddy Collection
--
------------------------------------



------------------------------------
-- Extinct Items
------------------------------------


inv.Item(212)
	:SetRarity (10)
	:SetType "Effect"
	:SetName "Dola Effect"
	:SetDesc "A special item given as a thanks to the sugar daddies of MG"
	:SetModel "models/props/cs_assault/money.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		local Size = Vector(0.600,0.600,2.849)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("")
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
		if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
		halo.Add({model}, Color(148,192,72), 10, 10, 1)
		end
		return model, pos, ang
	end)
	:SetCollection "Sugar Daddy Collection"


inv.Item(66)
	:SetRarity (10)
	:SetType "Model"
	:SetName "Skeleton Model"
	:SetDesc "An exclusive item given to Shiny Mega Gallade, first donator of $100"
	:SetModel "models/player/skeleton.mdl"
	:SetCollection "Sugar Daddy Collection"






------------------------------------
--
-- Summer 2017 Event Collection
--
------------------------------------



------------------------------------
-- Worn Items
------------------------------------


inv.Item(3251)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Novice"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Summer 2017 Event Collection"



------------------------------------
-- Standard Items
------------------------------------


inv.Item(3252)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Amateur"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Summer 2017 Event Collection"



------------------------------------
-- Specialized Items
------------------------------------


inv.Item(3253)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Apprentice"
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Summer 2017 Event Collection"



------------------------------------
-- Superior Items
------------------------------------


inv.Item(3254)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Professional"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Summer 2017 Event Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(3256)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Expert"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Summer 2017 Event Collection"


inv.Item(3255)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Master"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Summer 2017 Event Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(3257)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Legend"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Summer 2017 Event Collection"



------------------------------------
-- Planetary Items
------------------------------------


inv.Item(3258)
	:SetRarity (8)
	:SetType "Tier"
	:SetName "God"
	:SetStats (7, 7)
		:SetStat ("Weight", -5, -7)
		:SetStat ("Firerate", 17, 28)
		:SetStat ("Magazine", 23, 33)
		:SetStat ("Accuracy", 17, 28)
		:SetStat ("Damage", 17, 28)
		:SetStat ("Kick", -17, -28)
		:SetStat ("Range", 23, 33)
	:SetTalents (4, 4)
	:SetCollection "Summer 2017 Event Collection"

