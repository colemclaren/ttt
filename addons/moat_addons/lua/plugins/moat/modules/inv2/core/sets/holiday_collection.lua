------------------------------------
--
-- Santa's Collection
--
------------------------------------


inv.Item(7101)
	:SetRarity (10)
	:SetType "Usable"
	:SetName "Santa's Crate"
	:SetDesc "Every player will receive a holiday crate when this item is used"
	:SetImage "https://moat.gg/assets/img/gift_usable64.png"
	:SetCollection "Santa's Collection"

	:SetShop (50000, false)






------------------------------------
--
-- Holiday Collection
--
------------------------------------


inv.Item(2002)
	:SetRarity (4)
	:SetType "Crate"
	:SetName "Holiday Crate"
	:SetDesc "This crate contains an item from the Holiday Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/holiday_crate64.png"
	:SetCollection "Holiday Collection"

	:SetShop (2000, false)


------------------------------------
-- Superior Items
------------------------------------


inv.Item(7023)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Cozy"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Holiday Collection"


inv.Item(7025)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Decorated"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Holiday Collection"


inv.Item(7027)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Friendly"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Holiday Collection"


inv.Item(7035)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Snowy"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Holiday Collection"


inv.Item(7019)
	:SetRarity (4)
	:SetType "Other"
	:SetName "Snowball"
	:SetDesc "I think your snow is too soft or something, cause this thing ain't killing anyone"
	:SetWeapon "snowball_harmless"
	:SetCollection "Holiday Collection"


inv.Item(7009)
	:SetRarity (4)
	:SetType "Model"
	:SetName "Green Lantern Model"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/superheroes/greenlantern.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7012)
	:SetRarity (4)
	:SetType "Model"
	:SetName "Winter Male 1"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/portal/male_02_snow.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7013)
	:SetRarity (4)
	:SetType "Model"
	:SetName "Winter Male 2"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/portal/male_04_snow.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7014)
	:SetRarity (4)
	:SetType "Model"
	:SetName "Winter Male 3"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/portal/male_05_snow.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7015)
	:SetRarity (4)
	:SetType "Model"
	:SetName "Winter Male 4"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/portal/male_07_snow.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7016)
	:SetRarity (4)
	:SetType "Model"
	:SetName "Winter Male 5"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/portal/male_08_snow.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7017)
	:SetRarity (4)
	:SetType "Model"
	:SetName "Winter Male 6"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/portal/male_09_snow.mdl"
	:SetCollection "Holiday Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(7004)
	:SetRarity (5)
	:SetType "Melee"
	:SetName "A Candy Cane"
	:SetWeapon "weapon_ttt_candycane"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Holiday Collection"


inv.Item(7024)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Dashin"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Holiday Collection"


inv.Item(7029)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Giving"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Holiday Collection"


inv.Item(7030)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Holiday"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Holiday Collection"


inv.Item(7033)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Merry"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Holiday Collection"


inv.Item(7022)
	:SetRarity (5)
	:SetType "Other"
	:SetName "Christmas Smoke"
	:SetDesc "Don't get lost in the smoke, you might miss santa claus"
	:SetWeapon "weapon_xmassmoke"
	:SetCollection "Holiday Collection"


inv.Item(7010)
	:SetRarity (5)
	:SetType "Model"
	:SetName "Cat Woman Model"
	:SetDesc "I'm a catist, not a feminist"
	:SetModel "models/player/bobert/accatwoman.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7006)
	:SetRarity (5)
	:SetType "Model"
	:SetName "Batman Model"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/superheroes/batman.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7007)
	:SetRarity (5)
	:SetType "Model"
	:SetName "Flash Model"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/superheroes/flash.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7003)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Snowman Head"
	:SetDesc "Frosty the terrorist"
	:SetModel "models/props/cs_office/snowman_face.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -2.5) + (ang:Up() * 0.5)
		ang:RotateAroundAxis(ang:Up(), -90)
		return model, pos, ang
		end
		/*
		Angles	=	0.000 -90.000 0.000
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	-2.500000 0.000000 0.500000
		Size	=	1.1
		UniqueID	=	3503520631
		*/)
	:SetCollection "Holiday Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(7026)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Festive"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Holiday Collection"


inv.Item(7031)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Jolly"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Holiday Collection"


inv.Item(7032)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Magical"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Holiday Collection"


inv.Item(7052)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Dasher"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_g36c"
	:SetStats (6, 7)
		:SetStat ("Firerate", 14, 38)
		:SetStat ("Accuracy", 5, 10)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7054)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Dancer"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m16"
	:SetStats (6, 7)
		:SetStat ("Firerate", 5, 40)
		:SetStat ("Accuracy", 2, 15)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7055)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Prancer"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_p228"
	:SetStats (6, 7)
		:SetStat ("Damage", 14, 28)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7056)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Vixen"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_p228"
	:SetStats (6, 7)
		:SetStat ("Firerate", 20, 40)
		:SetStat ("Magazine", 30, 60)
		:SetStat ("Damage", 6, 12)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7057)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Comet"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_sg552"
	:SetStats (6, 7)
		:SetStat ("Magazine", 14, 22)
		:SetStat ("Damage", 14, 30)
		:SetStat ("Kick", -20, -34)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7058)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Cupid"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_p90"
	:SetStats (6, 7)
		:SetStat ("Firerate", 2, 12)
		:SetStat ("Accuracy", 4, 40)
		:SetStat ("Damage", 12, 20)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7059)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Dunder"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m03a3"
	:SetStats (6, 7)
		:SetStat ("Magazine", 4, 8)
		:SetStat ("Accuracy", 14, 30)
		:SetStat ("Damage", 20, 35)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7063)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Blixem"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_cz75"
	:SetStats (6, 7)
		:SetStat ("Magazine", 5, 12)
		:SetStat ("Damage", 23, 35)
		:SetStat ("Kick", -5, -10)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7020)
	:SetRarity (6)
	:SetType "Other"
	:SetName "Christmas Flash"
	:SetDesc "Don't blink, you might miss santa claus"
	:SetWeapon "weapon_xmasflash"
	:SetCollection "Holiday Collection"


inv.Item(7005)
	:SetRarity (6)
	:SetType "Model"
	:SetName "Superman Model"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/superheroes/superman.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7002)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Gingerbread Mask"
	:SetDesc "Please don't eat my face"
	:SetModel "models/sal/gingerbread.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.8)
		return model, pos, ang
		end
		/*
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/sal/gingerbread.mdl
		Position	=	-3.800000 0.000000 0.000000
		Size	=	1.1
		UniqueID	=	3503520631
		*/)
	:SetCollection "Holiday Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(7028)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Gift-Wrapped"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Holiday Collection"


inv.Item(7034)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Santa's own"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Holiday Collection"


inv.Item(7053)
	:SetRarity (7)
	:SetType "Unique"
	:SetName "Rudolph"
	:SetEffect "glow"
	:SetWeapon "weapon_mor_daedric"
	:SetStats (6, 7)
		:SetStat ("Weight", -4, -7)
		:SetStat ("Firerate", 14, 23)
		:SetStat ("Magazine", 19, 28)
		:SetStat ("Accuracy", 14, 23)
		:SetStat ("Damage", 14, 40)
		:SetStat ("Kick", -14, -23)
		:SetStat ("Range", 19, 28)
	:SetTalents (2, 3)
		:SetTalent (2, "Snowball")
	:SetCollection "Holiday Collection"


inv.Item(7036)
	:SetRarity (7)
	:SetType "Other"
	:SetName "Frozen Snowball"
	:SetDesc "A deadly snowball made of hard ice probably"
	:SetWeapon "snowball_harmful"
	:SetCollection "Holiday Collection"


inv.Item(7021)
	:SetRarity (7)
	:SetType "Other"
	:SetName "Christmas Frag"
	:SetDesc "Don't run away, you might miss santa claus"
	:SetWeapon "weapon_xmasfrag"
	:SetCollection "Holiday Collection"


inv.Item(7001)
	:SetRarity (7)
	:SetType "Hat"
	:SetName "Santa's Cap"
	:SetDesc "Ho Ho Ho Merry Christmas"
	:SetModel "models/santa/santa.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.4) + (ang:Up() * -1)
		return model, pos, ang
		end
		/*
		children:
		self:
		Angles	=	-90.000 0.000 180.000
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	3.100000 -2.100000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254
		children:
		self:
		Angles	=	0.000 -80.000 268.300
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/sal/gingerbread.mdl
		Position	=	1.500000 -0.600000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254
		children:
		self:
		Angles	=	0.000 -80.000 268.300
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/santa/santa.mdl
		Position	=	0.100000 1.300000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254
		children:
		self:
		Angles	=	0.000 -90.000 0.000
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	-2.500000 0.000000 0.500000
		Size	=	1.1
		UniqueID	=	3503520631
		self:
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/sal/gingerbread.mdl
		Position	=	-3.800000 0.000000 0.000000
		Size	=	1.1
		UniqueID	=	3503520631
		self:
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/santa/santa.mdl
		Position	=	-5.400000 0.000000 -1.000000
		Size	=	1.1
		UniqueID	=	3503520631
		*/)
	:SetCollection "Holiday Collection"


inv.Item(7008)
	:SetRarity (7)
	:SetType "Model"
	:SetName "Jolly Santa Model"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/christmas/santa.mdl"
	:SetCollection "Holiday Collection"


inv.Item(7011)
	:SetRarity (7)
	:SetType "Model"
	:SetName "Jesus Model"
	:SetDesc "A special model from the holiday season"
	:SetModel "models/player/jesus/jesus.mdl"
	:SetCollection "Holiday Collection"

