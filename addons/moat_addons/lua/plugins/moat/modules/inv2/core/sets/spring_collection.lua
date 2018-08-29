------------------------------------
--
-- Spring Collection
--
------------------------------------


inv.Item(810)
	:SetRarity (2)
	:SetType "Crate"
	:SetName "Spring Crate"
	:SetDesc "This crate contains an item from the Spring Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/spring_crate64.png"
	:SetCollection "Spring Collection"

	:SetShop (400, true)


------------------------------------
-- Worn Items
------------------------------------


inv.Item(737)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Petty"
	:SetColor {255, 182, 193}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(738)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Soft"
	:SetColor {175, 238, 238}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(736)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Weak"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"



------------------------------------
-- Standard Items
------------------------------------


inv.Item(740)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Crisp"
	:SetColor {123, 104, 238}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(739)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Fair"
	:SetColor {135, 206, 250}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(741)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Fresh"
	:SetColor {102, 205, 170}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(742)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Pure"
	:SetColor {64, 224, 208}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(775)
	:SetRarity (2)
	:SetType "Unique"
	:SetName "Trenchinator"
	:SetWeapon "weapon_ttt_m590"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(710)
	:SetRarity (2)
	:SetType "Other"
	:SetName "Agree Taunt"
	:SetDesc "I concur doctor"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_agree"
	:SetCollection "Spring Collection"


inv.Item(715)
	:SetRarity (2)
	:SetType "Other"
	:SetName "Disagree Taunt"
	:SetDesc "I don't think so"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_disagree"
	:SetCollection "Spring Collection"



------------------------------------
-- Specialized Items
------------------------------------


inv.Item(729)
	:SetRarity (3)
	:SetType "Melee"
	:SetName "A Fish"
	:SetColor {255, 160, 122}
	:SetWeapon "weapon_fish"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(730)
	:SetRarity (3)
	:SetType "Melee"
	:SetName "Fists"
	:SetImage "https://moat.gg/assets/img/moat_fists.png"
	:SetWeapon "weapon_ttt_fists"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(746)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Bright"
	:SetColor {199, 21, 133}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(745)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Lush"
	:SetColor {154, 205, 50}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(743)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Sweet"
	:SetColor {221, 160, 221}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(744)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Warm"
	:SetColor {173, 255, 47}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(785)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Akimbonators"
	:SetWeapon "weapon_akimbo"
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(773)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Alien Poo90"
	:SetWeapon "weapon_rcp120"
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(792)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Intruder Killer"
	:SetWeapon "weapon_doubleb"
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Spring Collection"


inv.Item(725)
	:SetRarity (3)
	:SetType "Other"
	:SetName "Smokinator"
	:SetDesc "A smoke grenade that's %s_ more dense than a regular smoke grenade"
	:SetWeapon "weapon_ttt_smokegrenade"
	:SetStats (1, 1)
		:SetStat (1, 25, 100)
	:SetCollection "Spring Collection"


inv.Item(711)
	:SetRarity (3)
	:SetType "Other"
	:SetName "Call For Taunt"
	:SetDesc "Come over here please"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_beacon"
	:SetCollection "Spring Collection"


inv.Item(712)
	:SetRarity (3)
	:SetType "Other"
	:SetName "Bow Taunt"
	:SetDesc "Thank you very much, I know I'm awesome"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_bow"
	:SetCollection "Spring Collection"


inv.Item(721)
	:SetRarity (3)
	:SetType "Other"
	:SetName "Salute Taunt"
	:SetDesc "Press F to pay respects"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_salute"
	:SetCollection "Spring Collection"



------------------------------------
-- Superior Items
------------------------------------


inv.Item(801)
	:SetRarity (4)
	:SetType "Melee"
	:SetName "A Sword"
	:SetColor {70, 130, 180}
	:SetWeapon "weapon_pvpsword"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(734)
	:SetRarity (4)
	:SetType "Melee"
	:SetName "A Tomahawk"
	:SetColor {47, 79, 79}
	:SetWeapon "weapon_tomahawk"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(747)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Airy"
	:SetColor {0, 191, 255}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(749)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Floral"
	:SetColor {144, 238, 144}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(748)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Fluffy"
	:SetColor {238, 130, 238}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(750)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Joyful"
	:SetColor {147, 112, 219}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(800)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Goongsto"
	:SetWeapon "weapon_thompson"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(784)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Hedge Shooter"
	:SetWeapon "weapon_spas12pvp"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(778)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Semi-Glock-17"
	:SetWeapon "weapon_semiauto"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(780)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Space90"
	:SetWeapon "weapon_rcp120"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(770)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Trusty Steed"
	:SetWeapon "weapon_supershotty"
	:SetStats (6, 6)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Spring Collection"


inv.Item(701)
	:SetRarity (4)
	:SetType "Other"
	:SetName "Confusionade"
	:SetDesc "A throwable grenade that discombobulates enimies %s_ more than a regular discombobulator"
	:SetWeapon "weapon_ttt_confgrenade"
	:SetStats (1, 1)
		:SetStat (1, 25, 100)
	:SetCollection "Spring Collection"


inv.Item(713)
	:SetRarity (4)
	:SetType "Other"
	:SetName "Cheer Taunt"
	:SetDesc "WOOOOO"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_cheer"
	:SetCollection "Spring Collection"


inv.Item(717)
	:SetRarity (4)
	:SetType "Other"
	:SetName "Hands Up Taunt"
	:SetDesc "Please don't shoot me"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_hands"
	:SetCollection "Spring Collection"


inv.Item(723)
	:SetRarity (4)
	:SetType "Other"
	:SetName "Wave Taunt"
	:SetDesc "Hey Guys"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_wave"
	:SetCollection "Spring Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(728)
	:SetRarity (5)
	:SetType "Melee"
	:SetName "A Diamond Pickaxe"
	:SetColor {0, 255, 255}
	:SetWeapon "weapon_diamond_pick"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(735)
	:SetRarity (5)
	:SetType "Melee"
	:SetName "A Toy Hammer"
	:SetWeapon "weapon_toy_hammer"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(754)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Blissful"
	:SetColor {200, 200, 0}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(751)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Blooming"
	:SetColor {220, 20, 60}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(753)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Energized"
	:SetColor {65, 105, 225}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(752)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Vibrant"
	:SetColor {255, 105, 180}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(776)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "Akimbonitos"
	:SetWeapon "weapon_akimbo"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(771)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "The Patriot"
	:SetWeapon "weapon_patriot"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(772)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "Raginator"
	:SetWeapon "weapon_ragingbull"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(793)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "Stealthano"
	:SetWeapon "weapon_sp"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Spring Collection"


inv.Item(805)
	:SetRarity (5)
	:SetType "Other"
	:SetName "Angry Shoe"
	:SetDesc "A shoe you can annoy and distract enimes with"
	:SetWeapon "weapon_angryhobo"
	:SetCollection "Spring Collection"


inv.Item(726)
	:SetRarity (5)
	:SetType "Other"
	:SetName "Molotovian"
	:SetDesc "A molotov grenade that lasts %s_ longer than a regular molotov grenade."
	:SetWeapon "weapon_zm_molotov"
	:SetStats (1, 1)
		:SetStat (1, 25, 100)
	:SetCollection "Spring Collection"


inv.Item(716)
	:SetRarity (5)
	:SetType "Other"
	:SetName "Flail Taunt"
	:SetDesc "Asdfghjkl;'"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_flail"
	:SetCollection "Spring Collection"


inv.Item(718)
	:SetRarity (5)
	:SetType "Other"
	:SetName "Laugh Taunt"
	:SetDesc "haHA"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_laugh"
	:SetCollection "Spring Collection"


inv.Item(808)
	:SetRarity (5)
	:SetType "Other"
	:SetName "Dynamite"
	:SetDesc "A throwable set of TNT that detonates a few seconds after being thrown"
	:SetWeapon "weapon_virustnt"
	:SetCollection "Spring Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(731)
	:SetRarity (6)
	:SetType "Melee"
	:SetName "A Katana"
	:SetWeapon "weapon_katana"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(733)
	:SetRarity (6)
	:SetType "Melee"
	:SetName "A Diamond Sword"
	:SetColor {0, 255, 255}
	:SetWeapon "weapon_diamond_sword"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(802)
	:SetRarity (6)
	:SetType "Melee"
	:SetName "A Smart Pen"
	:SetWeapon "weapon_smartpen"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 15, 35)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(757)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Flourishing"
	:SetColor {255, 20, 147}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(755)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Heavenly"
	:SetColor {255, 215, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(756)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Spectacular"
	:SetColor {0, 255, 127}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(758)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Sunny"
	:SetColor {255, 255, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(782)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Bond's Double Friend"
	:SetWeapon "weapon_virussil"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(804)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Compactachi"
	:SetWeapon "weapon_xm8b"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(789)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "DBMonster"
	:SetWeapon "weapon_doubleb"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(779)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Executioner"
	:SetWeapon "weapon_flakgun"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Spring Collection"


inv.Item(806)
	:SetRarity (6)
	:SetType "Other"
	:SetName "Babynade"
	:SetDesc "A throwable baby that explodes like dynamite"
	:SetWeapon "weapon_babynade"
	:SetCollection "Spring Collection"


inv.Item(719)
	:SetRarity (6)
	:SetType "Other"
	:SetName "Play Dead Taunt"
	:SetDesc "Too bad you don't get a treat for this one diggity dog"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_lay"
	:SetCollection "Spring Collection"


inv.Item(720)
	:SetRarity (6)
	:SetType "Other"
	:SetName "Robot Taunt"
	:SetDesc "Beep boop beep bop beep"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_robot"
	:SetCollection "Spring Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(732)
	:SetRarity (7)
	:SetType "Melee"
	:SetName "A Lightsaber"
	:SetWeapon "weapon_light_saber"
	:SetStats (4, 4)
		:SetStat ("Force", 13, 35)
		:SetStat ("Damage", 10, 25)
		:SetStat ("Firerate", 10, 30)
		:SetStat ("Pushrate", 5, 10)
	:SetCollection "Spring Collection"


inv.Item(761)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Cloudless"
	:SetColor {0, 191, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Spring Collection"


inv.Item(759)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Incredible"
	:SetColor {255, 0, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Spring Collection"


inv.Item(760)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Stunning"
	:SetColor {148, 0, 211}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Spring Collection"


inv.Item(774)
	:SetRarity (7)
	:SetType "Unique"
	:SetName "Bond's Worst Friend"
	:SetWeapon "weapon_golden_revolver"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Spring Collection"


inv.Item(783)
	:SetRarity (7)
	:SetType "Unique"
	:SetName "Nintendo Switchpa"
	:SetWeapon "weapon_zapperpvp"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Spring Collection"


inv.Item(790)
	:SetRarity (7)
	:SetType "Unique"
	:SetName "Spasinator"
	:SetWeapon "weapon_spas12pvp"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Spring Collection"


inv.Item(807)
	:SetRarity (7)
	:SetType "Other"
	:SetName "Stealth Box"
	:SetDesc "A box you can use to hide from enimes. Crouching makes the box completely still"
	:SetWeapon "weapon_stealthbox"
	:SetCollection "Spring Collection"


inv.Item(714)
	:SetRarity (7)
	:SetType "Other"
	:SetName "Dab Taunt"
	:SetDesc "Hit em with it"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_dab"
	:SetCollection "Spring Collection"


inv.Item(722)
	:SetRarity (7)
	:SetType "Other"
	:SetName "Sexy Taunt"
	:SetDesc "Work that big booty of yours you sexy thang"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_sexy"
	:SetCollection "Spring Collection"


inv.Item(724)
	:SetRarity (7)
	:SetType "Other"
	:SetName "Zombie Climb Taunt"
	:SetDesc "Best dance move eva"
	:SetImage "https://moat.gg/assets/img/moat_taunt.png"
	:SetWeapon "weapon_ttt_taunt_climb"
	:SetCollection "Spring Collection"

