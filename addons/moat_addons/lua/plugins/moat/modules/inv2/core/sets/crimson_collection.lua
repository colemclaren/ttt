------------------------------------
--
-- Crimson Collection
--
------------------------------------


inv.Item(700)
	:SetRarity (2)
	:SetType "Crate"
	:SetName "Crimson Crate"
	:SetDesc "This crate contains an item from the Crimson Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/crimson_crate64.png"
	:SetCollection "Crimson Collection"

	:SetShop (350, true)


------------------------------------
-- Worn Items
------------------------------------


inv.Item(606)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Busted"
	:SetColor {255, 229, 204}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(607)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Faulty"
	:SetColor {188, 143, 143}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(608)
	:SetRarity (1)
	:SetType "Tier"
	:SetName "Rough"
	:SetColor {255, 160, 122}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(632)
	:SetRarity (1)
	:SetType "Unique"
	:SetName "Old Comrade"
	:SetColor {210, 180, 140}
	:SetWeapon "weapon_ttt_glock"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(631)
	:SetRarity (1)
	:SetType "Unique"
	:SetName "Ruscelenas"
	:SetColor {245, 222, 179}
	:SetWeapon "weapon_ttt_dual_elites"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(668)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Bloody Bird Mask"
	:SetDesc "A very pale vulture feasts on terrorist souls"
	:SetModel "models/splicermasks/birdmask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(650)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Bloody Butterfly Mask"
	:SetDesc "A very pale butterfly feasts on terrorist souls"
	:SetModel "models/splicermasks/butterflymask.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1.6) + (ang:Right() * 0) + (ang:Up() * -2.4)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(651)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Bloody Rabbit Mask"
	:SetDesc "Who knew the easter bunny was hungry enough to eat human flesh"
	:SetModel "models/splicermasks/rabbitmask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0.8) + (ang:Right() * 0) + (ang:Up() * -2.4)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"



------------------------------------
-- Standard Items
------------------------------------


inv.Item(609)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Feeble"
	:SetColor {135, 206, 235}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(610)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Retracted"
	:SetColor {176, 224, 230}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(611)
	:SetRarity (2)
	:SetType "Tier"
	:SetName "Sustainable"
	:SetColor {152, 251, 152}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(634)
	:SetRarity (2)
	:SetType "Unique"
	:SetName "Shoopan"
	:SetColor {176, 196, 222}
	:SetWeapon "weapon_ttt_shotgun"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(633)
	:SetRarity (2)
	:SetType "Unique"
	:SetName "Taluhoo"
	:SetWeapon "weapon_ttt_famas"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(655)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Bloody Cat Mask"
	:SetDesc "Tearing up one face at a time"
	:SetModel "models/splicermasks/catmask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1) + (ang:Right() * 0.6) + (ang:Up() * -4.6)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(652)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Colorful Bird Mask"
	:SetDesc "You are a colorful human bird"
	:SetModel "models/splicermasks/birdmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(653)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Royal Rabbit Mask"
	:SetDesc "Hop hop hop... here comes the royal easter bunny"
	:SetModel "models/splicermasks/rabbitmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0.8) + (ang:Right() * 0) + (ang:Up() * -2.4)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(654)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Royal Spider Mask"
	:SetDesc "The itsy bitsy spider crawled up the royal kingdom"
	:SetModel "models/splicermasks/spidermask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1) + (ang:Right() * 0) + (ang:Up() * -1.8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"



------------------------------------
-- Specialized Items
------------------------------------


inv.Item(601)
	:SetRarity (3)
	:SetType "Power-Up"
	:SetName "Flame Retardant"
	:SetColor {255, 60, 0}
	:SetDesc "Fire and explosion damage is reduced by %s_ when using this powerup"
	:SetImage "https://moat.gg/assets/img/flame_powerup64.png"
	:SetStats (1, 1)
		:SetStat (1, -35, -75)
	:SetCollection "Crimson Collection"


inv.Item(612)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Infringed"
	:SetColor {128, 128, 0}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(614)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Unpassable"
	:SetColor {60, 179, 113}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(613)
	:SetRarity (3)
	:SetType "Tier"
	:SetName "Tolerable"
	:SetColor {221, 160, 221}
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(636)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Kahtinga"
	:SetWeapon "weapon_ttt_aug"
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(635)
	:SetRarity (3)
	:SetType "Unique"
	:SetName "Pocketier"
	:SetWeapon "weapon_ttt_p228"
	:SetStats (3, 5)
		:SetStat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:SetCollection "Crimson Collection"


inv.Item(657)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "Royal Cat Mask"
	:SetDesc "Don't touch me, I'm fabulous"
	:SetModel "models/splicermasks/catmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1) + (ang:Right() * 0.6) + (ang:Up() * -4.6)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(656)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "Turqoise Bird Mask"
	:SetDesc "I'm feelying quite blue and gray right now"
	:SetModel "models/splicermasks/birdmask.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"



------------------------------------
-- Superior Items
------------------------------------


inv.Item(600)
	:SetRarity (4)
	:SetType "Power-Up"
	:SetName "Credit Hoarder"
	:SetColor {255, 255, 0}
	:SetDesc "Start with %s extra credits as a detective/traitor when using this powerup"
	:SetImage "https://moat.gg/assets/img/cred_powerup64.png"
	:SetStats (1, 1)
		:SetStat (1, 1, 5)
	:SetCollection "Crimson Collection"


inv.Item(616)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Kosher"
	:SetColor {186, 85, 211}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Crimson Collection"


inv.Item(617)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Pleasant"
	:SetColor {218, 112, 214}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Crimson Collection"


inv.Item(615)
	:SetRarity (4)
	:SetType "Tier"
	:SetName "Touted"
	:SetColor {34, 139, 34}
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Crimson Collection"


inv.Item(638)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Ecopati"
	:SetColor {0, 139, 139}
	:SetWeapon "weapon_ttt_m1911"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Crimson Collection"


inv.Item(637)
	:SetRarity (4)
	:SetType "Unique"
	:SetName "Goongsta"
	:SetColor {139, 0, 0}
	:SetWeapon "weapon_ttt_mac11"
	:SetStats (6, 6)
		:SetStat ("Firerate", 8, 12)
		:SetStat ("Magazine", 8, 15)
		:SetStat ("Accuracy", 5, 12)
		:SetStat ("Damage", 4, 8)
		:SetStat ("Range", 30, 60)
	:SetTalents (1, 2)
	:SetCollection "Crimson Collection"


inv.Item(659)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Heart Hat"
	:SetDesc "I'm in love with my head"
	:SetModel "models/balloons/balloon_classicheart.mdl"
	:SetRender ("ValveBiped.Bip01_Head1", function(ply, model, pos, ang)
		model:SetModelScale(0.775, 0)
		model:SetColor(Color(255, 0, 0))
		pos = pos + (ang:Forward() * -3) + (ang:Right() * 0) + (ang:Up() * 0)
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(658)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Arnold Mask"
	:SetDesc "Grrr.. I'm a mean dog"
	:SetModel "models/arnold_mask/arnold_mask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0) + (ang:Right() * 0) + (ang:Up() * 0)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(660)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Peacock Butterfly Mask"
	:SetDesc "Don't put me in a zoo please"
	:SetModel "models/splicermasks/butterflymask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1.6) + (ang:Right() * 0) + (ang:Up() * -2.4)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(604)
	:SetRarity (5)
	:SetType "Power-Up"
	:SetName "Experience Lover"
	:SetColor {255, 0, 255}
	:SetDesc "Gain %s_ more weapon XP after a rightfull kill when using this powerup"
	:SetImage "https://moat.gg/assets/img/xp_powerup64.png"
	:SetStats (1, 1)
		:SetStat (1, 25, 75)
	:SetCollection "Crimson Collection"


inv.Item(619)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Devoted"
	:SetColor {220, 20, 60}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Crimson Collection"


inv.Item(620)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Lovely"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Crimson Collection"


inv.Item(618)
	:SetRarity (5)
	:SetType "Tier"
	:SetName "Crimson"
	:SetColor {178, 34, 34}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Crimson Collection"


inv.Item(639)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "Breach-N-Clear"
	:SetWeapon "weapon_ttt_mp5k"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Crimson Collection"


inv.Item(641)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "M4ALover"
	:SetColor {220, 20, 60}
	:SetWeapon "weapon_ttt_m4a1"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Crimson Collection"


inv.Item(640)
	:SetRarity (5)
	:SetType "Unique"
	:SetName "The Deliverer"
	:SetColor {0, 128, 0}
	:SetWeapon "weapon_ttt_deliverer"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:SetCollection "Crimson Collection"


inv.Item(662)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Chuck Mask"
	:SetDesc "God Bless the Badass America"
	:SetModel "models/chuck_mask/chuck_mask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 2) + (ang:Right() * 0) + (ang:Up() * 0)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(661)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Dolph Mask"
	:SetDesc "My horns will pierce any terrorist that gets in my way"
	:SetModel "models/dolph_mask/dolph_mask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0) + (ang:Right() * 0) + (ang:Up() * 0)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(663)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Heart Welder Mask"
	:SetDesc "You weld broken hearts back together"
	:SetModel "models/splicermasks/weldingmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Right() * 2.6) + (ang:Up() * -7.6)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(602)
	:SetRarity (6)
	:SetType "Power-Up"
	:SetName "Hard Hat"
	:SetColor {0, 255, 255}
	:SetDesc "Headshot damage is reduced by %s_ when using this power-up"
	:SetImage "https://moat.gg/assets/img/hardhat_powerup64.png"
	:SetStats (1, 1)
		:SetStat (1, -15, -38)
	:SetCollection "Crimson Collection"


inv.Item(622)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Charismatic"
	:SetColor {199, 21, 133}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Crimson Collection"


inv.Item(621)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Divine"
	:SetColor {0, 250, 154}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Crimson Collection"


inv.Item(623)
	:SetRarity (6)
	:SetType "Tier"
	:SetName "Sacred"
	:SetColor {100, 149, 237}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Crimson Collection"


inv.Item(642)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Autocatis"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_cz75"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Crimson Collection"


inv.Item(643)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Collectinator"
	:SetColor {255, 165, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m03a3"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Crimson Collection"


inv.Item(644)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Deadshot"
	:SetColor {0, 206, 209}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_sg550"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Crimson Collection"


inv.Item(645)
	:SetRarity (6)
	:SetType "Unique"
	:SetName "Westernaci"
	:SetColor {218, 165, 32}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_mr96"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:SetCollection "Crimson Collection"


inv.Item(665)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Brown Horsie Mask"
	:SetDesc "Neihhhh, feed me apples and take me to water"
	:SetModel "models/horsie/horsiemask.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1.2) + (ang:Right() * 0) + (ang:Up() * 0.8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"


inv.Item(664)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Po Mask"
	:SetDesc "The panda is a great animal and will always be named Po"
	:SetModel "models/jean-claude_mask/jean-claude_mask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1) + (ang:Right() * 0) + (ang:Up() * 0)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(625)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Righteous"
	:SetColor {255, 255, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Crimson Collection"


inv.Item(626)
	:SetRarity (7)
	:SetType "Tier"
	:SetName "Saintlike"
	:SetColor {255, 69, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Crimson Collection"


inv.Item(648)
	:SetRarity (7)
	:SetType "Unique"
	:SetName "Bonds Best Friend"
	:SetColor {255, 215, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_golden_deagle"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Crimson Collection"


inv.Item(646)
	:SetRarity (7)
	:SetType "Unique"
	:SetName "Mohtuanica"
	:SetColor {220, 20, 60}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_mp5k"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Crimson Collection"


inv.Item(647)
	:SetRarity (7)
	:SetType "Unique"
	:SetName "Ratisaci"
	:SetColor {0, 255, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_msbs"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:SetCollection "Crimson Collection"


inv.Item(666)
	:SetRarity (7)
	:SetType "Mask"
	:SetName "Stallion Mask"
	:SetDesc "You are a beautiful horse"
	:SetModel "models/horsie/horsiemask.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1.2) + (ang:Right() * 0) + (ang:Up() * 0.8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:SetCollection "Crimson Collection"

