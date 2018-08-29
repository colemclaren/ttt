------------------------------------
--
-- Cosmetic Collection
--
------------------------------------


inv.Item(157)
	:SetRarity (3)
	:SetType "Crate"
	:SetName "Cosmetic Crate"
	:SetDesc "This crate contains an item from the Cosmetic Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/cosmetic_crate64.png"
	:SetCollection "Cosmetic Collection"

	:SetShop (300, true)


------------------------------------
-- Worn Items
------------------------------------


inv.Item(107)
	:SetRarity (1)
	:SetType "Hat"
	:SetName "Headphones"
	:SetDesc "I can't hear you, I'm listeng to a game"
	:SetModel "models/gmod_tower/headphones.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(137)
	:SetRarity (1)
	:SetType "Hat"
	:SetName "Klonoa Hat"
	:SetDesc "Become the ultimate hipster"
	:SetModel "models/lordvipes/klonoahat/klonoahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.77, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(82)
	:SetRarity (1)
	:SetType "Hat"
	:SetName "Star Headband"
	:SetDesc "You are amazing"
	:SetModel "models/captainbigbutt/skeyler/hats/starband.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"



------------------------------------
-- Standard Items
------------------------------------


inv.Item(95)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Bunny Ears"
	:SetDesc "Hello there Mr Bunny"
	:SetModel "models/captainbigbutt/skeyler/hats/bunny_ears.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(88)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Frog Hat"
	:SetDesc "Ribbit ribbit bitch"
	:SetModel "models/captainbigbutt/skeyler/hats/frog_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.6, 0)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(135)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "General Pepper"
	:SetDesc "Commander of the great and kind"
	:SetModel "models/lordvipes/generalpepperhat/generalpepperhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -4.2) + (ang:Right() * 0.4) +  (ang:Up() * 0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(108)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "KFC Bucket"
	:SetDesc "Incoming racist joke"
	:SetModel "models/gmod_tower/kfcbucket.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -2.6) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 25.8)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(143)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Kitty Hat"
	:SetDesc "Aww so cute"
	:SetModel "models/gmod_tower/toetohat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 0.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(116)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Party Hat"
	:SetDesc "Raise the ruff"
	:SetModel "models/gmod_tower/partyhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) + (ang:Right() * 1.2) +  (ang:Up() * 2.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(81)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Straw Hat"
	:SetDesc "Old McDonald had a farm"
	:SetModel "models/captainbigbutt/skeyler/hats/strawhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(71)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Grandma Glasses"
	:SetDesc "I hope these are big enough for you"
	:SetModel "models/captainbigbutt/skeyler/accessories/glasses04.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -1.4) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(110)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Lego Head"
	:SetDesc "Everything is awesome"
	:SetModel "models/gmod_tower/legohead.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(140)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Makar's Mask"
	:SetDesc "That's a very nice leaf you have there"
	:SetModel "models/lordvipes/makarmask/makarmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(2.2, 0)
		pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -9.6) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), -16)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(69)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Stylish Glasses"
	:SetDesc "Work those pretty little things gurl"
	:SetModel "models/captainbigbutt/skeyler/accessories/glasses02.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1.2) + (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"



------------------------------------
-- Specialized Items
------------------------------------


inv.Item(73)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Bear Hat"
	:SetDesc "Now you will always have your teddy bear with you, in a hat form"
	:SetModel "models/captainbigbutt/skeyler/hats/bear_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(132)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Black Mage Hat"
	:SetDesc "Do you know what happens to a giant when it gets blasted with a fireball? The same thing that happens to everything else"
	:SetModel "models/lordvipes/blackmage/blackmage_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.3, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -12) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(94)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Large Cat Ears"
	:SetDesc "What big ears you have you majestic beast"
	:SetModel "models/captainbigbutt/skeyler/hats/cat_ears.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * -0.2) +  (ang:Up() * -5.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(93)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Cat Hat"
	:SetDesc "This does not give you 9 lives"
	:SetModel "models/captainbigbutt/skeyler/hats/cat_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(87)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Heartband"
	:SetDesc "Wear this if you have no friends and want people to love you"
	:SetModel "models/captainbigbutt/skeyler/hats/heartband.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(111)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Link Hat"
	:SetDesc "Hyeeeh kyaah hyaaah haa hyet haa haa jum jum haaa"
	:SetModel "models/gmod_tower/linkhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) +(ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(114)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Midna Hat"
	:SetDesc "EPIC"
	:SetModel "models/gmod_tower/midnahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -1.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(142)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Red's Hat"
	:SetDesc "Pokemon red hat"
	:SetModel "models/lordvipes/redshat/redshat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.75, 0)
		pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 18)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(96)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "3D Glasses"
	:SetDesc "The most practical way to get your head in the game"
	:SetModel "models/gmod_tower/3dglasses.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(139)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "Majora's Mask"
	:SetDesc "It is a colorful mask"
	:SetModel "models/lordvipes/majoramask/majoramask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -9.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(113)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "Metaknight Mask"
	:SetDesc "Where the fuck is Kirby"
	:SetModel "models/gmod_tower/metaknight_mask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -4.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(115)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "No Face Mask"
	:SetDesc "Where did your face go?"
	:SetModel "models/gmod_tower/noface.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(70)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "Shutter Glasses"
	:SetDesc "The party is just getting started"
	:SetModel "models/captainbigbutt/skeyler/accessories/glasses03.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(122)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "Snowboard Goggles"
	:SetDesc "We don't need snow to wear these"
	:SetModel "models/gmod_tower/snowboardgoggles.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(128)
	:SetRarity (3)
	:SetType "Mask"
	:SetName "Toro Mask"
	:SetDesc ":3"
	:SetModel "models/gmod_tower/toromask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -4.6) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 10.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"



------------------------------------
-- Superior Items
------------------------------------


inv.Item(74)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Wooden Comb Afro"
	:SetDesc "You're as OG as OG can get my black friend"
	:SetModel "models/captainbigbutt/skeyler/hats/afro.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(98)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Baseball Cap"
	:SetDesc "Never forget the GMod Tower games. May they rest in peace"
	:SetModel "models/gmod_tower/baseballcap.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * 1.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), -20)
		ang:RotateAroundAxis(ang:Up(), 180)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(92)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Cowboy Hat"
	:SetDesc "It's hiiiigh nooon"
	:SetModel "models/captainbigbutt/skeyler/hats/cowboyhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 3.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 13.2)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(91)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Deadmau5"
	:SetDesc "A musicly talented deceased rodent"
	:SetModel "models/captainbigbutt/skeyler/hats/deadmau5.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(138)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Luigi Hat"
	:SetDesc "Taller and jumps higher than mario. Still doesn't get to be the main character. (no this does not change jump height)"
	:SetModel "models/lordvipes/luigihat/luigihat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * -3) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(75)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Mario Hat"
	:SetDesc "Shut up you fat italian"
	:SetModel "models/lordvipes/mariohat/mariohat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -1.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(117)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Pilgrim Hat"
	:SetDesc "What is a Mayflower"
	:SetModel "models/gmod_tower/pilgrimhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 1.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 16.4)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(121)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Seuss Hat"
	:SetDesc "Thing 1 and Thing 2 are not a thing here"
	:SetModel "models/gmod_tower/seusshat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(80)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Sun Hat"
	:SetDesc "It has flowers and protects you from the sun"
	:SetModel "models/captainbigbutt/skeyler/hats/sunhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -5) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(125)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Team Rocket Hat"
	:SetDesc "Prepare for trouble, and make it double!"
	:SetModel "models/gmod_tower/teamrockethat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 18.2)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(127)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Top Hat"
	:SetDesc "If only you had a suit"
	:SetModel "models/gmod_tower/tophat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 0.6) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 10.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(130)
	:SetRarity (4)
	:SetType "Hat"
	:SetName "Witch Hat"
	:SetDesc "Mwahahaha"
	:SetModel "models/gmod_tower/witchhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 1.4) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 22.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(76)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Andross Mask"
	:SetDesc "I've been waiting for you, Star Fox. You know that I control the galaxy. It's foolish to come against me. You will die just like your father"
	:SetModel "models/gmod_tower/androssmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1) + (ang:Up() * -2.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(72)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "El Mustache"
	:SetDesc "You sir are the most handsome and dashing man in all of the server"
	:SetModel "models/captainbigbutt/skeyler/accessories/mustache.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -2.4) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(103)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Jason Mask"
	:SetDesc "Boo"
	:SetModel "models/gmod_tower/halloween_jasonmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -6.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(124)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Star Glasses"
	:SetDesc "Too good for regular glasses"
	:SetModel "models/gmod_tower/starglasses.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1.4) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(131)
	:SetRarity (5)
	:SetType "Hat"
	:SetName "Billy Hatcher Hat"
	:SetDesc "Good Morning"
	:SetModel "models/lordvipes/billyhatcherhat/billyhatcherhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0.6) +  (ang:Up() * -1) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(106)
	:SetRarity (5)
	:SetType "Hat"
	:SetName "Headcrab"
	:SetDesc "You will be eaten alive"
	:SetModel "models/gmod_tower/headcrabhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(104)
	:SetRarity (5)
	:SetType "Hat"
	:SetName "Nightmare Hat"
	:SetDesc "Jack is on your head.."
	:SetModel "models/gmod_tower/halloween_nightmarehat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -4.2) + (ang:Up() * 1.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(78)
	:SetRarity (5)
	:SetType "Hat"
	:SetName "Gangsta Hat"
	:SetDesc "sup fam"
	:SetModel "models/captainbigbutt/skeyler/hats/zhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.68) + (ang:Right() * -0.013) +  (ang:Up() * 1.693) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(99)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Batman Mask"
	:SetDesc "Where the fuck is Rachel"
	:SetModel "models/gmod_tower/batmanmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.2) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(100)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Bomberman Helmet"
	:SetDesc "FOR THE GLORY OF ALLAH!!!"
	:SetModel "models/gmod_tower/bombermanhelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(133)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Cubone Skull"
	:SetDesc "I choose you"
	:SetModel "models/lordvipes/cuboneskull/cuboneskull.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.3, 0)
		pos = pos + (ang:Forward() * 0.2) + (ang:Up() * -6.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(136)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Keaton Mask"
	:SetDesc "What did the fox say"
	:SetModel "models/lordvipes/keatonmask/keatonmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -5.6) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(84)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Scary Pumpkin"
	:SetDesc "Shine bright like a pumpkin"
	:SetModel "models/captainbigbutt/skeyler/hats/pumpkin.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -3) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(119)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Samus Helmet"
	:SetDesc "It's a girl"
	:SetModel "models/gmod_tower/samushelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -2.05) + (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(77)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Servbot Head"
	:SetDesc "Smile"
	:SetModel "models/lordvipes/servbothead/servbothead.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -2.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(109)
	:SetRarity (6)
	:SetType "Hat"
	:SetName "King Boo's Crown"
	:SetDesc "Boo, bitch"
	:SetModel "models/gmod_tower/king_boos_crown.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 2.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), -19.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(83)
	:SetRarity (6)
	:SetType "Hat"
	:SetName "Santa Hat"
	:SetDesc "It's Christmas"
	:SetModel "models/gmod_tower/santahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2) + (ang:Right() * -0.2) +  (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(123)
	:SetRarity (6)
	:SetType "Hat"
	:SetName "Sombrero"
	:SetDesc "Arriba"
	:SetModel "models/gmod_tower/sombrero.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 12.6)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(129)
	:SetRarity (6)
	:SetType "Hat"
	:SetName "Turkey"
	:SetDesc "Stick this hot thing on your head"
	:SetModel "models/gmod_tower/turkey.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 1.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(85)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Monocle"
	:SetDesc "You probably think you're smart now. That's incorrect"
	:SetModel "models/captainbigbutt/skeyler/accessories/monocle.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -2.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 22.4)
		ang:RotateAroundAxis(ang:Up(),-9)
		ang:RotateAroundAxis(ang:Forward(), 153.8)
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(118)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Rubiks Cube"
	:SetDesc "You can't solve this one"
	:SetModel "models/gmod_tower/rubikscube.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.6, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(144)
	:SetRarity (7)
	:SetType "Hat"
	:SetName "Viewtiful Joe Helmet"
	:SetDesc "Shoot em up"
	:SetModel "models/lordvipes/viewtifuljoehelmet/viewtifuljoehelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"


inv.Item(134)
	:SetRarity (7)
	:SetType "Mask"
	:SetName "Tomas Helmet"
	:SetDesc "Hit that"
	:SetModel "models/lordvipes/daftpunk/thomas.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:SetCollection "Cosmetic Collection"

