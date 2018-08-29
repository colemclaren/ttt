------------------------------------
--
-- Alpha Collection
--
------------------------------------


inv.Item(22)
	:SetRarity (2)
	:SetType "Crate"
	:SetName "Alpha Crate"
	:SetDesc "This crate contains an item from the Alpha Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/alpha_crate64.png"
	:SetCollection "Alpha Collection"

	:SetShop (250, true)


------------------------------------
-- Worn Items
------------------------------------


inv.Item(27)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Junky"
	:SetColor {149, 129, 115}
	:SetStats (1, 3)
	:SetCollection "Alpha Collection"


inv.Item(1)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Recycled"
	:SetColor {181, 128, 117}
	:SetStats (1, 3)
	:SetCollection "Alpha Collection"



------------------------------------
-- Standard Items
------------------------------------


inv.Item(24)
	:SetRarity (2)
	:SetType "Power-Up"
	:SetName "Cat Sense"
	:SetColor {139, 0, 166}
	:SetDesc "Fall damage is reduced by %s_ when using this power-up"
	:SetImage "https://moat.gg/assets/img/smithfallicon.png"
	:SetStats (1, 1)
		:SetStat (1, -35, -75)
	:SetCollection "Alpha Collection"


inv.Item(11)
	:SetRarity (2)
	:SetType "Power-Up"
	:SetName "Froghopper"
	:SetColor {255, 0, 0}
	:SetEffect "bounce"
	:SetDesc "Froghoppers can jump 70 times their body height. Too bad this only allows you to jump +%s_ higher"
	:SetImage "https://moat.gg/assets/img/jumpboost64.png"
	:SetStats (1, 1)
		:SetStat (1, 15, 50)
	:SetCollection "Alpha Collection"


inv.Item(4)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Moderate"
	:SetColor {153, 255, 255}
	:SetStats (3, 4)
	:SetCollection "Alpha Collection"


inv.Item(29)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Ordinary"
	:SetColor {204, 229, 255}
	:SetStats (3, 4)
	:SetCollection "Alpha Collection"


inv.Item(28)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Stable"
	:SetColor {255, 255, 255}
	:SetStats (3, 4)
	:SetCollection "Alpha Collection"


inv.Item(19)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Bucket Helmet"
	:SetDesc "It's a bucket"
	:SetModel "models/props_junk/MetalBucket01a.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * -5) + (ang:Up() * 5)// + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 200)
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"


inv.Item(18)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Turtle Hat"
	:SetDesc "This cute little turtle can sit on your head and give you amazing love"
	:SetModel "models/props/de_tides/Vending_turtle.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Up(), -90)
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"


inv.Item(21)
	:SetRarity (2)
	:SetType "Model"
	:SetName "Kliener Model"
	:SetDesc "The smartest of them all"
	:SetModel "models/player/kleiner.mdl"
	:SetCollection "Alpha Collection"


inv.Item(20)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "No Entry Mask"
	:SetDesc "No man shall enter your face again"
	:SetModel "models/props_c17/streetsign004f.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * 3)
		ang:RotateAroundAxis(ang:Up(), -90)
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"



------------------------------------
-- Specialized Items
------------------------------------


inv.Item(26)
	:SetRarity (3)
	:SetType "Power-Up"
	:SetName "Marathon Runner"
	:SetColor {85, 85, 255}
	:SetDesc "Movement speed is increased by +%s_ when using this power-up"
	:SetImage "https://moat.gg/assets/img/smithrunicon.png"
	:SetStats (1, 1)
		:SetStat (1, 5, 15)
	:SetCollection "Alpha Collection"


inv.Item(31)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Dashing"
	:SetColor {255, 153, 153}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Alpha Collection"


inv.Item(30)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Frisky"
	:SetColor {204, 255, 153}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Alpha Collection"


inv.Item(32)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Harmful"
	:SetColor {255, 86, 44}
	:SetStats (6, 6)
		:SetStat ("Firerate", -10, -20)
		:SetStat ("Accuracy", -10, -25)
		:SetStat ("Damage", 20, 35)
		:SetStat ("Weight", 10, 15)
		:SetStat ("Kick", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Alpha Collection"


inv.Item(5)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Odd"
	:SetColor {153, 255, 153}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Alpha Collection"


inv.Item(33)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Precise"
	:SetColor {153, 204, 255}
	:SetStats (5, 5)
		:SetStat ("Firerate", 0, 5)
		:SetStat ("Magazine", 15, 20)
		:SetStat ("Accuracy", 30, 60)
		:SetStat ("Damage", 5, 10)
		:SetStat ("Kick", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Alpha Collection"


inv.Item(34)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Steady"
	:SetColor {153, 255, 153}
	:SetStats (6, 6)
		:SetStat ("Damage", 5, 10)
		:SetStat ("Weight", 3, 5)
		:SetStat ("Kick", -20, -50)
	:SetTalents (1, 1)
	:SetCollection "Alpha Collection"


inv.Item(54)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Afro"
	:SetDesc "Become a jazzy man with this afro"
	:SetModel "models/gmod_tower/afro.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Up() * 2.5) + (ang:Forward() * -4.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"


inv.Item(60)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Drink Cap"
	:SetDesc "The server drunk"
	:SetModel "models/sam/drinkcap.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.1) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"


inv.Item(62)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Fedora"
	:SetDesc "You're the best meme of them all"
	:SetModel "models/gmod_tower/fedorahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"



------------------------------------
-- Superior Items
------------------------------------


inv.Item(23)
	:SetRarity (4)
	:SetType "Power-Up"
	:SetName "Ammo Hoarder"
	:SetColor {255, 102, 0}
	:SetDesc "Spawn with +%s_ more ammo in your reserves"
	:SetImage "https://moat.gg/assets/img/smithammoicon.png"
	:SetStats (1, 1)
		:SetStat (1, 45, 125)
	:SetCollection "Alpha Collection"


inv.Item(25)
	:SetRarity (4)
	:SetType "Power-Up"
	:SetName "Health Bloom"
	:SetColor {0, 204, 0}
	:SetDesc "Health is increased by +%s_ when using this power-up"
	:SetImage "https://moat.gg/assets/img/smithhealicon.png"
	:SetStats (1, 1)
		:SetStat (1, 5, 25)
	:SetCollection "Alpha Collection"


inv.Item(39)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Ammofull"
	:SetColor {255, 128, 0}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 20, 50)
		:SetStat ("Accuracy", -13, -17)
		:SetStat ("Damage", 4, 13)
	:SetTalents (1, 2)
	:SetCollection "Alpha Collection"


inv.Item(6)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Chaotic"
	:SetColor {255, 255, 0}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Alpha Collection"


inv.Item(36)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Fearful"
	:SetColor {92, 50, 176}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Alpha Collection"


inv.Item(40)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Global"
	:SetColor {0, 153, 0}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Alpha Collection"


inv.Item(37)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Intimidating"
	:SetColor {162, 0, 0}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Alpha Collection"


inv.Item(41)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Lightweight"
	:SetColor {152, 255, 255}
	:SetStats (5, 5)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 5, 12)
		:SetStat ("Weight", -9, -17)
	:SetTalents (1, 2)
	:SetCollection "Alpha Collection"


inv.Item(38)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Rapid"
	:SetColor {255, 178, 102}
	:SetStats (6, 6)
		:SetStat ("Firerate", 20, 40)
		:SetStat ("Damage", 4, 13)
		:SetStat ("Range", -13, -20)
	:SetTalents (1, 2)
	:SetCollection "Alpha Collection"


inv.Item(16)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Volcanica"
	:SetColor {255, 0, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_ak47"
	:SetStats (5, 7)
		:SetStat ("Weight", -3, -7)
		:SetStat ("Firerate", 11, 19)
		:SetStat ("Magazine", 16, 24)
		:SetStat ("Accuracy", 11, 19)
		:SetStat ("Damage", 11, 19)
		:SetStat ("Kick", -11, -19)
		:SetStat ("Range", 16, 24)
	:SetTalents (1, 1)
		:SetTalent (1, "Inferno")
	:SetCollection "Alpha Collection"


inv.Item(56)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Astronaut Helmet"
	:SetDesc "Instantly become a space god with this helmet"
	:SetModel "models/astronauthelmet/astronauthelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * -5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"


inv.Item(58)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Cake Hat"
	:SetDesc "This cake is a lie"
	:SetModel "models/cakehat/cakehat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Up() * 1.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"


inv.Item(59)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Cat Ears"
	:SetDesc "You look so cute with these cat ears on, omfg"
	:SetModel "models/gmod_tower/catears.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.5) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"


inv.Item(61)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Dunce Hat"
	:SetDesc "You must sit in the corner and think of your terrible actions"
	:SetModel "models/duncehat/duncehat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		ang:RotateAroundAxis(ang:Right(), 25)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(43)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Remarkable"
	:SetColor {255, 102, 178}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Alpha Collection"


inv.Item(44)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Strange"
	:SetColor {255, 0, 102}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Alpha Collection"


inv.Item(7)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Unusual"
	:SetColor {178, 205, 255}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Alpha Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(48)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Heroic"
	:SetColor {51, 51, 255}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Alpha Collection"


inv.Item(8)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Legendary"
	:SetColor {255, 255, 51}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Alpha Collection"


inv.Item(47)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Mythical"
	:SetColor {178, 102, 255}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Alpha Collection"


inv.Item(63)
	:SetRarity (6)
	:SetType "Model"
	:SetName "Alyx Model"
	:SetDesc "slut"
	:SetModel "models/player/alyx.mdl"
	:SetCollection "Alpha Collection"


inv.Item(57)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Aviators"
	:SetDesc "You look like the terminator with these badass glasses on"
	:SetModel "models/gmod_tower/aviators.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2) + (ang:Up() * -0.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Alpha Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(52)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Angelic"
	:SetColor {255, 0, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Alpha Collection"


inv.Item(9)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Celestial"
	:SetColor {0, 255, 128}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Alpha Collection"


inv.Item(51)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Immortal"
	:SetColor {0, 255, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Alpha Collection"

