------------------------------------
--
-- Beta Collection
--
------------------------------------


inv.Item(365)
	:SetRarity (2)
	:SetType "Crate"
	:SetName "Beta Crate"
	:SetDesc "This crate contains an item from the Beta Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/beta_crate64.png"
	:SetCollection "Beta Collection"

	:SetShop (400, true)


------------------------------------
-- Worn Items
------------------------------------


inv.Item(331)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Shabby"
	:SetColor {215, 255, 224}
	:SetStats (1, 3)
	:SetCollection "Beta Collection"


inv.Item(330)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Tattered"
	:SetColor {69, 87, 71}
	:SetStats (1, 3)
	:SetCollection "Beta Collection"



------------------------------------
-- Standard Items
------------------------------------


inv.Item(334)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Mediocre"
	:SetStats (3, 4)
	:SetCollection "Beta Collection"


inv.Item(333)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Passable"
	:SetColor {153, 255, 204}
	:SetStats (3, 4)
	:SetCollection "Beta Collection"


inv.Item(332)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Trifling"
	:SetColor {56, 64, 92}
	:SetStats (3, 4)
	:SetCollection "Beta Collection"



------------------------------------
-- Specialized Items
------------------------------------


inv.Item(336)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Dynamic"
	:SetColor {153, 153, 255}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Beta Collection"


inv.Item(337)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Peppy"
	:SetColor {255, 151, 210}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Beta Collection"


inv.Item(335)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Zesty"
	:SetColor {92, 169, 76}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Beta Collection"


inv.Item(317)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Hawkeyo"
	:SetColor {255, 0, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_sledge"
	:SetStats (5, 5)
		:SetStat ("Firerate", 1, 10)
		:SetStat ("Magazine", 5, 10)
		:SetStat ("Accuracy", 10, 50)
		:SetStat ("Damage", 1, 10)
		:SetStat ("Range", 1, 10)
	:SetTalents (1, 1)
	:SetCollection "Beta Collection"


inv.Item(318)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Holukis"
	:SetColor {133, 213, 239}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_shotgun"
	:SetStats (3, 3)
		:SetStat ("Damage", -50, -70)
		:SetStat ("Firerate", 80, 100)
		:SetStat ("Magazine", 10, 30)
	:SetCollection "Beta Collection"


inv.Item(320)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Kik-Back"
	:SetColor {171, 1, 37}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_ak47"
	:SetStats (3, 3)
		:SetStat ("Accuracy", 10, 20)
		:SetStat ("Damage", 15, 30)
		:SetStat ("Kick", 60, 70)
	:SetTalents (1, 1)
	:SetCollection "Beta Collection"


inv.Item(325)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Slowihux"
	:SetColor {212, 44, 151}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_shotgun"
	:SetStats (4, 4)
		:SetStat ("Magazine", 5, 10)
		:SetStat ("Damage", 10, 30)
		:SetStat ("Firerate", -40, -50)
		:SetStat ("Range", 1, 10)
	:SetCollection "Beta Collection"


inv.Item(326)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Spray-N-Pray"
	:SetColor {27, 126, 7}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_galil"
	:SetStats (4, 4)
		:SetStat ("Kick", -1, -19)
		:SetStat ("Damage", -10, -30)
		:SetStat ("Firerate", 30, 60)
		:SetStat ("Magazine", 5, 10)
	:SetCollection "Beta Collection"



------------------------------------
-- Superior Items
------------------------------------


inv.Item(338)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Deranged"
	:SetColor {255, 102, 102}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Beta Collection"


inv.Item(341)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Erratic"
	:SetColor {153, 255, 153}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Beta Collection"


inv.Item(340)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Haywire"
	:SetColor {255, 178, 102}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Beta Collection"


inv.Item(339)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Turbid"
	:SetColor {228, 232, 107}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:SetCollection "Beta Collection"


inv.Item(321)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Karitichu"
	:SetColor {255, 233, 109}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_rifle"
	:SetStats (5, 5)
		:SetStat ("Firerate", 30, 60)
		:SetStat ("Magazine", 5, 10)
		:SetStat ("Accuracy", 10, 20)
		:SetStat ("Damage", 5, 10)
		:SetStat ("Kick", -11, -19)
	:SetTalents (1, 1)
	:SetCollection "Beta Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(347)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Eccentric"
	:SetColor {255, 102, 178}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Beta Collection"


inv.Item(342)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Marvelous"
	:SetColor {215, 121, 255}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Beta Collection"


inv.Item(346)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Quaint"
	:SetColor {59, 132, 172}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Beta Collection"


inv.Item(345)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Uncanny"
	:SetColor {157, 120, 158}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Beta Collection"


inv.Item(319)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "Headcrusher"
	:SetColor {29, 201, 150}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_revolver"
	:SetStats (5, 5)
		:SetStat ("Firerate", -50, -95)
		:SetStat ("Magazine", -40, -80)
		:SetStat ("Accuracy", 10, 30)
		:SetStat ("Damage", 25, 50)
		:SetStat ("Range", 1, 20)
	:SetTalents (1, 1)
		:SetTalent (1, "Brutal")
	:SetCollection "Beta Collection"


inv.Item(323)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "Headbanger"
	:SetColor {23, 116, 89}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_pistol"
	:SetStats (5, 5)
		:SetStat ("Firerate", -50, -95)
		:SetStat ("Magazine", -40, -80)
		:SetStat ("Accuracy", 10, 30)
		:SetStat ("Damage", 25, 50)
		:SetStat ("Range", 1, 20)
	:SetTalents (1, 1)
		:SetTalent (1, "Brutal")
	:SetCollection "Beta Collection"


inv.Item(324)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "SGLento"
	:SetColor {0, 97, 179}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_sg552"
	:SetStats (7, 7)
		:SetStat ("Weight", 0, -20)
		:SetStat ("Firerate", -20, -30)
		:SetStat ("Magazine", 20, 30)
		:SetStat ("Accuracy", 10, 20)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Kick", 0, 10)
		:SetStat ("Range", 5, 10)
	:SetCollection "Beta Collection"


inv.Item(300)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "Zeusitae"
	:SetColor {255, 255, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_revolver"
	:SetStats (5, 7)
	:SetTalents (1, 1)
		:SetTalent (1, "Tesla")
	:SetCollection "Beta Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(348)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Eternal"
	:SetColor {153, 51, 255}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Beta Collection"


inv.Item(349)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Evergreen"
	:SetColor {0, 204, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Beta Collection"


inv.Item(351)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Partisan"
	:SetColor {189, 255, 145}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Beta Collection"


inv.Item(350)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Satanic"
	:SetColor {102, 0, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Beta Collection"


inv.Item(316)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Doom-Bringer"
	:SetColor {231, 213, 10}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m16"
	:SetStats (6, 6)
		:SetStat ("Weight", -5, -10)
		:SetStat ("Magazine", -35, -65)
		:SetStat ("Accuracy", 15, 30)
		:SetStat ("Damage", 60, 95)
		:SetStat ("Kick", -11, -19)
		:SetStat ("Range", -40, -68)
	:SetTalents (1, 1)
	:SetCollection "Beta Collection"


inv.Item(322)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Misicordia"
	:SetColor {0, 189, 71}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_glock"
	:SetStats (6, 6)
		:SetStat ("Weight", -10, -20)
		:SetStat ("Magazine", 5, 19)
		:SetStat ("Accuracy", 10, 10)
		:SetStat ("Damage", 15, 30)
		:SetStat ("Kick", 0, 10)
		:SetStat ("Range", 5, 10)
	:SetTalents (1, 1)
		:SetTalent (1, "Sustained")
	:SetCollection "Beta Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(353)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Astral"
	:SetColor {255, 255, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Beta Collection"


inv.Item(352)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Shiny"
	:SetColor {127, 178, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Beta Collection"


inv.Item(354)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Virtuous"
	:SetColor {213, 0, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Beta Collection"

