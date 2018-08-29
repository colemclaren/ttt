------------------------------------
--
-- Urban Style Collection
--
------------------------------------


inv.Item(524)
	:SetRarity (3)
	:SetType "Crate"
	:SetName "Urban Style Crate"
	:SetDesc "This crate contains an item from the Urban Style Collection! Right click to open"
	:SetImage "https://moat.gg/assets/img/urban_crate64.png"
	:SetCollection "Urban Style Collection"

	:SetShop (300, true)


------------------------------------
-- Worn Items
------------------------------------


inv.Item(522)
	:SetRarity (1)
	:SetType "Hat"
	:SetName "White Fedora"
	:SetDesc "Smooth Criminal"
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(509)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Black Vintage Glasses"
	:SetDesc "Like the Gray Vintage Glasses, but darker"
	:SetModel "models/modified/glasses01.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(510)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Silver Vintage Glasses"
	:SetDesc "At least it's better than Bronze"
	:SetModel "models/modified/glasses01.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(511)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Green Vintage Glasses"
	:SetDesc "Let's be honest. You look like the green hornet"
	:SetModel "models/modified/glasses01.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(512)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Brown Vintage Glasses"
	:SetDesc "Hipster Style: Poop Version"
	:SetModel "models/modified/glasses01.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(513)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Bronze Vintage Glasses"
	:SetDesc "Bronze. The Shiny Brown"
	:SetModel "models/modified/glasses01.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(514)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Gray Vintage Glasses"
	:SetDesc "Vintage - Black and White - Gray. It all adds up"
	:SetModel "models/modified/glasses01.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(515)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Beach Raybands"
	:SetDesc "Perfect for when you strut your stuff in your Bathing Suit"
	:SetModel "models/modified/glasses02.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(516)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Red Raybands"
	:SetDesc "A classic type of glasses which every hipster must have"
	:SetModel "models/modified/glasses02.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(517)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "White Raybands"
	:SetDesc "Opposite to the Black Raybands"
	:SetModel "models/modified/glasses02.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(518)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Black Raybands"
	:SetDesc "Opposite to the White Raybands"
	:SetModel "models/modified/glasses02.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(519)
	:SetRarity (1)
	:SetType "Mask"
	:SetName "Brown Raybands"
	:SetDesc "Disclaimer: These do not make you any cooler"
	:SetModel "models/modified/glasses02.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
		else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"



------------------------------------
-- Standard Items
------------------------------------


inv.Item(520)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Grey Fedora"
	:SetDesc "Become that kid everybody hates"
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(521)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Black Fedora"
	:SetDesc "Bring out your inner Hipster"
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(367)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Tan Fedora"
	:SetDesc "Why sunbathe for a tan when you could just wear this Fedora"
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(368)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Red Fedora"
	:SetDesc "Stained with the Blood of your Victims"
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(369)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "BR Fedora"
	:SetDesc "I know what you're thinking. \"Oh boy! Another Fedora! Hell yeah!!\""
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(370)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Brown Fedora"
	:SetDesc "Amazing, memingly brown"
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(371)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Blue Fedora"
	:SetDesc "How many of the eight Fedoras do you own? Collect them"
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(372)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Waldo Beanie"
	:SetDesc "Where are you"
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(373)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "BB Beanie"
	:SetDesc "Big Bad Beanie"
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(374)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Red Beanie"
	:SetDesc "It's Red. It's a Beanie. What else do you need to know"
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(375)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "White Beanie"
	:SetDesc "A Beanie... That's White"
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(376)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "GB Beanie"
	:SetDesc "A Giant Beetle Beanie? Oh wait. It's not that cool"
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(377)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Black Beanie V2"
	:SetDesc "What happened to Black Beanie V1"
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(378)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Gray Beanie V2"
	:SetDesc "There isn't even a V1."
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(379)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Gray Striped Beanie"
	:SetDesc "Loved the Gray Beanie? Well you'll love this Gray Striped Beanie"
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(380)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Rasta Beanie"
	:SetDesc "Reggae Reggae"
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(381)
	:SetRarity (2)
	:SetType "Hat"
	:SetName "Blue Beanie V2"
	:SetDesc "Blue Beanie V3s and Blue Beanie V3c Coming Soon"
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(505)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "White Doctor Mask"
	:SetDesc "The party wants their mask back"
	:SetModel "models/sal/halloween/doctor.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		if (moat_TerroristModels[ply:GetModel()]) then
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -1.163300)
		else
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -2.5)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(506)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Gray Doctor Mask"
	:SetDesc "You don't need to hide your face with this"
	:SetModel "models/sal/halloween/doctor.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		if (moat_TerroristModels[ply:GetModel()]) then
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -1.163300)
		else
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -2.5)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(507)
	:SetRarity (2)
	:SetType "Mask"
	:SetName "Black Doctor Mask"
	:SetDesc "Black doctors are the best doctors out there"
	:SetModel "models/sal/halloween/doctor.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		if (moat_TerroristModels[ply:GetModel()]) then
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -1.163300)
		else
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -2.5)
		end
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"



------------------------------------
-- Specialized Items
------------------------------------


inv.Item(498)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Piswasser Beer Hat"
	:SetDesc "It's true. German beer is literally Piss Water"
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(499)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Super Wet Beer Hat"
	:SetDesc "It was so tempting to put a 'Yo Mama' joke here"
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(500)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Patriot Beer Hat"
	:SetDesc "For the True Redneck"
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(501)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Benedict Beer Hat"
	:SetDesc "Clench your thirst with this Hat"
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(502)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Blarneys Beer Hat"
	:SetDesc "Sounds like a knock off Barney the Dinosaur"
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(503)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "J Lager Beer Hat"
	:SetDesc "Jelly Lager? Delicious"
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(382)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Gray Musicians Hat"
	:SetDesc "If only Voice Chat became Autotune whilst wearing this"
	:SetModel "models/modified/hat06.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(383)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Franklin Cap"
	:SetDesc "For the Franklin Cap OGs"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(384)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Franklin Cap V2"
	:SetDesc "Apparently there was something wrong with the original"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(385)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Fist Cap"
	:SetDesc "A smaller cap, best worn on your fist"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(386)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Gray C Cap"
	:SetDesc "Cannot be used as Fallout Currency"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(387)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "White LS Cap"
	:SetDesc "Unfortunately this isn't a White Lego Sausage Cap"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(388)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Feud Cap"
	:SetDesc "This Cap is Presented by Steve Harvey"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(389)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Magnetics Cap"
	:SetDesc "Keep away from Metal surfaces"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(390)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "OG Cap"
	:SetDesc "Straight outta Compton"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(391)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Stank Cap"
	:SetDesc "Don't do the Stanky Leg"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(392)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Dancer Cap"
	:SetDesc "Disco Boogie"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(393)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Ape Cap"
	:SetDesc "Please refrain from the Harambe memes"
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(394)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Orange Trucker Hat"
	:SetDesc "I can't stop thinking about an Orange Fruit wearing a little Trucker Hat"
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(395)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Blue Trucker Hat"
	:SetDesc "Your typical Trucker Hat"
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(396)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Nut House Trucker Hat"
	:SetDesc "Sounds a lot like a Gay Bar"
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(397)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Rusty Trucker Hat"
	:SetDesc "Rust is another name for Iron Oxide, which occurs when Iron or an alloy that contains Iron, like Steel, is exposed to Oxygen and moisture for a long period of time"
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(398)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Bishop Trucker Hat"
	:SetDesc "For all the Christian Truckers"
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(399)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "24/7 Trucker Hat"
	:SetDesc "I'm open all hours"
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(400)
	:SetRarity (3)
	:SetType "Hat"
	:SetName "Fruit Trucker Hat"
	:SetDesc "One of your five a day"
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"



------------------------------------
-- Superior Items
------------------------------------


inv.Item(584)
	:SetRarity (4)
	:SetType "Body"
	:SetName "Red Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_1.mdl"
	:SetSkin (0)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -3) + (ang:Up() * 0) + (ang:Forward() * 0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(585)
	:SetRarity (4)
	:SetType "Body"
	:SetName "Black Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_1.mdl"
	:SetSkin (1)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -3) + (ang:Up() * 0) + (ang:Forward() * 0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(403)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Crime Scene Wrap"
	:SetDesc "CSI: TTT"
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(404)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Arrows Wrap"
	:SetDesc "This way up"
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(405)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Caution Wrap"
	:SetDesc "Trust me. It's for the best that you're covered up"
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(406)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Red Arrow Wrap"
	:SetDesc "Like the superhero Green Arrow, but Red"
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(407)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Gray Mummy Wrap"
	:SetDesc "50 Shades of Mummy. No, wait"
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(408)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Black Mummy Wrap"
	:SetDesc "Not to be confused with Black Ninja Mask"
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(409)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "White Mummy Wrap"
	:SetDesc "Tutankhamun, is that you"
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(410)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Rainbow Mummy Wrap"
	:SetDesc "Some say there is Treasure at the end of the Rainbow"
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(417)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Blue Hockey Mask"
	:SetDesc "It's what a blue Jason would wear"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(418)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Bulldog Hockey Mask"
	:SetDesc "Woof woof back the fuck up"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(419)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Electric Hockey Mask"
	:SetDesc "Zap me into the hockey rink sir"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(420)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Skull Hockey Mask"
	:SetDesc "Made from the Skull of a previous victim"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (11)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(11)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(421)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Patch Hockey Mask"
	:SetDesc "Made from the skin of previous victims"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (12)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(12)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(422)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Patch 2 Hockey Mask"
	:SetDesc "The Highly Anticipated Sequel to Patch Hockey Mask"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (13)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(13)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(423)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Something Hockey Mask"
	:SetDesc "It could be anything"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (14)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(14)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(424)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Wolf Hockey Mask"
	:SetDesc "How is a Wolf meant to hold the Hockey Stick"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(425)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Bear Hockey Mask"
	:SetDesc "I'd love to actually see Bears playing Hockey"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(426)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Dog Hockey Mask"
	:SetDesc "Dog backwards is God"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(427)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Crown Hockey Mask"
	:SetDesc "This does not make you the new Queen of England."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(428)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Monster Hockey Mask"
	:SetDesc "Sponsored by Monster Energy Drink"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(429)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Monster 2 Hockey Mask"
	:SetDesc "The Highly Anticipated Sequel to Monster Hockey Mask"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(430)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Flame Hockey Mask"
	:SetDesc "Keep away from Flamable objects"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(431)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "GFlame Hockey Mask"
	:SetDesc "For when you want your flames a little more Green"
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(432)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Steel Armor Mask"
	:SetDesc "Become a Knight of the Realm"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(433)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Circuit Armor Mask"
	:SetDesc "It's like an unmasked Robot Face"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(434)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Lava Armor Mask"
	:SetDesc "Feeling Hot Hot Hot"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(435)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Purple Armor Mask"
	:SetDesc "Bright Purple. Why not"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(436)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Carbon Armor Mask"
	:SetDesc "Although it's hard to break. This won't save you from Headshots"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(437)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Bullseye Armor Mask"
	:SetDesc "Aim for between the eyes"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(438)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Stone Armor Mask"
	:SetDesc "The weight of this seems impractical"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(439)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Lightning Armor Mask"
	:SetDesc "How long until you hear the thunder? Hmm.."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(440)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Wood Armor Mask"
	:SetDesc "Smells like paper"
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(441)
	:SetRarity (4)
	:SetType "Mask"
	:SetName "Please Stop Mask"
	:SetDesc "Ripped straight from a Horror Movie"
	:SetModel "models/modified/mask5.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"



------------------------------------
-- High-End Items
------------------------------------


inv.Item(569)
	:SetRarity (5)
	:SetType "Body"
	:SetName "Gray Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_1.mdl"
	:SetSkin (2)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -3) + (ang:Up() * 0) + (ang:Forward() * 0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(570)
	:SetRarity (5)
	:SetType "Body"
	:SetName "BlueCABackpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_2.mdl"
	:SetSkin (0)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 1)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(571)
	:SetRarity (5)
	:SetType "Body"
	:SetName "GreenCABackpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_2.mdl"
	:SetSkin (1)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 1)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(572)
	:SetRarity (5)
	:SetType "Body"
	:SetName "RedCABackpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_2.mdl"
	:SetSkin (2)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 1)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(573)
	:SetRarity (5)
	:SetType "Body"
	:SetName "Black Tactical Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_3.mdl"
	:SetSkin (0)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 0.9)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(574)
	:SetRarity (5)
	:SetType "Body"
	:SetName "Grey Tactical Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
	:SetModel "models/modified/backpack_3.mdl"
	:SetSkin (1)
	:SetRender ("ValveBiped.Bip01_Spine2", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1, 0)
		pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 0.9)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(471)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Up-n-Atom Bag"
	:SetDesc "The place to go for the finest of Burgers"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(472)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Smiley Bag"
	:SetDesc "Colon Closed Parentheses"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(473)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Pig Bag"
	:SetDesc "Unlimited Bacon within"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(474)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Reptilian Bag"
	:SetDesc "Does not provide Camouflage capabilities"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (11)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(11)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(475)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Meanie Bag"
	:SetDesc "Why you gotta be so rude"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (12)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(12)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(476)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Queasy Bag"
	:SetDesc "Good thing you have this bag if you need to puke"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (13)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(13)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(477)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Skull Bag"
	:SetDesc "Spooky Scary Skeleton"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (14)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(14)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(478)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Puppy Bag"
	:SetDesc "I will skin you alive if you do not stop barking"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (15)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(15)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(479)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Pink Ghost Bag"
	:SetDesc "Like Pinky from Pacman. But not. For Legal Reasons"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (16)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(16)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(480)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Alien Bag"
	:SetDesc "Stolen from the depths of Uranus"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (17)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(17)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(481)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Help Me Bag"
	:SetDesc "Help Me... Please"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (18)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(18)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(482)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Maze Bag"
	:SetDesc "Why isn't this just called a Spiral Bag"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (19)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(19)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(483)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Pretty Cry Bag"
	:SetDesc "Am I still beautiful.."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(484)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "FU Bag"
	:SetDesc "This bag sums up how you feel after doing 150 of these"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (20)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(20)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(485)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Sir Bag"
	:SetDesc "For the most dapper of Gentlemen"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (21)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(21)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(486)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Stickers Bag"
	:SetDesc "Release your inner college kid"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (22)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(22)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(487)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Sheman Bag"
	:SetDesc "Wanna kiss sweetheart? Hmm.."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (23)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(23)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(488)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Heart Bag"
	:SetDesc "Less than Three"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (24)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(24)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(489)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Brown Bag"
	:SetDesc "Otherwise known as the 'Blackout Bag'"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (25)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(25)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(490)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Shy Bag"
	:SetDesc "Not to be confused with Shy Guy"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(491)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Mob Boss Bag"
	:SetDesc "You are the Godfather"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(492)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Sharp Teeth Bag"
	:SetDesc "Jaws 5: Trouble in Terrorist Ocean"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(493)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Kiddo Bag"
	:SetDesc "Why would you bring Children into this"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(494)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Burger Shot Bag"
	:SetDesc "Let's hope Big Shot doesn't want to order from here"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(495)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Kill Me Bag"
	:SetDesc "That's pretty messed up"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(496)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Devil Bag"
	:SetDesc "Perfect for when you're setting people on fire"
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(450)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Black Ninja Mask"
	:SetDesc "Disclaimer: Does not make you an actual Ninja"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(451)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "White Ninja Mask"
	:SetDesc "How is this meant to help you stay hidden in the shadows"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(452)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Police Ninja Mask"
	:SetDesc "Police Ninja. Sounds like the best movie ever"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(453)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Tan Ninja Mask"
	:SetDesc "For when you want your Ninja Mask to look like your own face"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(454)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Benders Ninja Mask"
	:SetDesc "This is not related to Futurama. Unfortunately"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(455)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Justice Ninja Mask"
	:SetDesc "Become a member of the Justice League"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(456)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Camo Ninja Mask"
	:SetDesc "Who is that dude without a head"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(457)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Candy Ninja Mask"
	:SetDesc "The latest franchise in the Candy Crush saga"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(458)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "LoveFist Ninja Mask"
	:SetDesc "Sounds like a Euphemism"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(459)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "TPI Ninja Mask"
	:SetDesc "TPI: Turtle People Indeed"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(460)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Pink Ninja Mask"
	:SetDesc "The latest must-have accessory for Barbie"
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(464)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Gray Skull Mask"
	:SetDesc "It's actually Purple with the Grayscale Filter applied"
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(465)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Brown Skull Mask"
	:SetDesc "Perfect whilst pulling off the perfect Heist"
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(466)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "White Skull Mask"
	:SetDesc "We all have Skulls. Why not show it off"
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(467)
	:SetRarity (5)
	:SetType "Mask"
	:SetName "Black Skull Mask"
	:SetDesc "2spooky4me"
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"



------------------------------------
-- Ascended Items
------------------------------------


inv.Item(576)
	:SetRarity (6)
	:SetType "Body"
	:SetName "White Scarf"
	:SetDesc "It's getting chilly outside"
	:SetModel "models/sal/acc/fix/scarf01.mdl"
	:SetSkin (0)
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		model:SetSkin(0)
		pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
		ang:RotateAroundAxis(ang:Right(), -2.400)
		ang:RotateAroundAxis(ang:Up(), 74.100)
		ang:RotateAroundAxis(ang:Forward(), 90.300)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(577)
	:SetRarity (6)
	:SetType "Body"
	:SetName "Gray Scarf"
	:SetDesc "It's getting chilly outside"
	:SetModel "models/sal/acc/fix/scarf01.mdl"
	:SetSkin (1)
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		model:SetSkin(1)
		pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
		ang:RotateAroundAxis(ang:Right(), -2.400)
		ang:RotateAroundAxis(ang:Up(), 74.100)
		ang:RotateAroundAxis(ang:Forward(), 90.300)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(578)
	:SetRarity (6)
	:SetType "Body"
	:SetName "Black Scarf"
	:SetDesc "It's getting chilly outside"
	:SetModel "models/sal/acc/fix/scarf01.mdl"
	:SetSkin (2)
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		model:SetSkin(2)
		pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
		ang:RotateAroundAxis(ang:Right(), -2.400)
		ang:RotateAroundAxis(ang:Up(), 74.100)
		ang:RotateAroundAxis(ang:Forward(), 90.300)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(579)
	:SetRarity (6)
	:SetType "Body"
	:SetName "Midnight Scarf"
	:SetDesc "It's getting chilly outside"
	:SetModel "models/sal/acc/fix/scarf01.mdl"
	:SetSkin (3)
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		model:SetSkin(3)
		pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
		ang:RotateAroundAxis(ang:Right(), -2.400)
		ang:RotateAroundAxis(ang:Up(), 74.100)
		ang:RotateAroundAxis(ang:Forward(), 90.300)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(580)
	:SetRarity (6)
	:SetType "Body"
	:SetName "Red Scarf"
	:SetDesc "It's getting chilly outside"
	:SetModel "models/sal/acc/fix/scarf01.mdl"
	:SetSkin (4)
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		model:SetSkin(4)
		pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
		ang:RotateAroundAxis(ang:Right(), -2.400)
		ang:RotateAroundAxis(ang:Up(), 74.100)
		ang:RotateAroundAxis(ang:Forward(), 90.300)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(581)
	:SetRarity (6)
	:SetType "Body"
	:SetName "Green Scarf"
	:SetDesc "It's getting chilly outside"
	:SetModel "models/sal/acc/fix/scarf01.mdl"
	:SetSkin (5)
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		model:SetSkin(5)
		pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
		ang:RotateAroundAxis(ang:Right(), -2.400)
		ang:RotateAroundAxis(ang:Up(), 74.100)
		ang:RotateAroundAxis(ang:Forward(), 90.300)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(582)
	:SetRarity (6)
	:SetType "Body"
	:SetName "Pink Scarf"
	:SetDesc "It's getting chilly outside"
	:SetModel "models/sal/acc/fix/scarf01.mdl"
	:SetSkin (6)
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		model:SetSkin(6)
		pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
		ang:RotateAroundAxis(ang:Right(), -2.400)
		ang:RotateAroundAxis(ang:Up(), 74.100)
		ang:RotateAroundAxis(ang:Forward(), 90.300)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(497)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Bear Mask"
	:SetDesc "Give me a hug"
	:SetModel "models/sal/bear.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.391235) + (ang:Right() * -0.229431) +  (ang:Up() * -0.777100)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(504)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Cat Mask"
	:SetDesc "Nine Lives not included"
	:SetModel "models/sal/cat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.390503) + (ang:Right() * -0.228668) +  (ang:Up() * -0.152496)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(508)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Fox Mask"
	:SetDesc "What does the fox say? Yep"
	:SetModel "models/sal/fox.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.561279) + (ang:Right() * 0.079376) +  (ang:Up() * -0.346680)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(401)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "White Hawk Mask"
	:SetDesc "Show off your true Patriotism"
	:SetModel "models/sal/hawk_1.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(402)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Brown Hawk Mask"
	:SetDesc "Show off your true Patriotism"
	:SetModel "models/sal/hawk_2.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(446)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Monkey Mask"
	:SetDesc "Exactly what it says on the tin"
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(447)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Brown Monkey Mask"
	:SetDesc "King Kong. Is that you? Hmm.."
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(448)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Zombie Monkey Mask"
	:SetDesc "Please refrain from the dead Harambe memes"
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(449)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Old Monkey Mask"
	:SetDesc "Basically Cranky Kong"
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(461)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Owl Mask"
	:SetDesc "Does not improve Night Vision"
	:SetModel "models/sal/owl.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(462)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Pig Mask"
	:SetDesc "Bacon not included"
	:SetModel "models/sal/pig.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.220093) + (ang:Right() * 0.055542) +  (ang:Up() * -1.410973)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(463)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Zombie Pig Mask"
	:SetDesc "Please not another Minecraft Reference"
	:SetModel "models/sal/pig.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.220093) + (ang:Right() * 0.055542) +  (ang:Up() * -1.410973)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(468)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Wolf Mask"
	:SetDesc "May cause violent outbursts of howling at a Full Moon"
	:SetModel "models/sal/wolf.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.05)
		pos = pos + (ang:Forward() * -4.468628) + (ang:Right() * 0.039375) +  (ang:Up() * -2.770370)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(469)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Zombie Mask"
	:SetDesc "Unfortunately you can't eat the corpses while wearing this"
	:SetModel "models/sal/halloween/zombie.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(470)
	:SetRarity (6)
	:SetType "Mask"
	:SetName "Stone Zombie Mask"
	:SetDesc "For those who enjoy Roleplaying a Gargoyle"
	:SetModel "models/sal/halloween/zombie.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"



------------------------------------
-- Cosmic Items
------------------------------------


inv.Item(575)
	:SetRarity (7)
	:SetType "Body"
	:SetName "Face Bandana"
	:SetDesc "True terrorists will always have a spare one of these on them"
	:SetModel "models/modified/bandana.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Right() * 0.1) + (ang:Up() * -4.5) + (ang:Forward() * -4.1)
		ang:RotateAroundAxis(ang:Up(), 0)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(442)
	:SetRarity (7)
	:SetType "Mask"
	:SetName "Black Skull Cover"
	:SetDesc "2spooky4me"
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(443)
	:SetRarity (7)
	:SetType "Mask"
	:SetName "Gray Skull Cover"
	:SetDesc "It's actually Purple with the Grayscale Filter applied"
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(444)
	:SetRarity (7)
	:SetType "Mask"
	:SetName "Tan Skull Cover"
	:SetDesc "Perfect whilst pulling off the perfect Heist"
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"


inv.Item(445)
	:SetRarity (7)
	:SetType "Mask"
	:SetName "Green Skull Cover"
	:SetDesc "We all have Skulls. Why not show it off"
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:SetCollection "Urban Style Collection"

