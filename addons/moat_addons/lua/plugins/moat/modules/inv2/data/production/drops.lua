local i = mi.Item
------------------------------------
--
-- Veteran Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(920)
	:Chance (8)
	:SetType "Effect"
	:SetName "Tesla Effect"
	:SetColor {0, 191, 255}
	:SetEffect "electric"
	:SetDesc "A special effect given to the very dedicated Moat players that reach level 100."
	:SetIcon "https://cdn.moat.gg/f/d8488f994f9134a830a9624106145219.png"
	:SetModel "models/weapons/w_missile_closed.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0,0,0)
		local mat = Matrix()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		return model, pos, ang
	end)
	:Set "Veteran"





------------------------------------
--
-- Valentine Collection
--
------------------------------------

i(3999)
	:Chance (3)
	:SetType "Crate"
	:SetName "Box Of Chocolates"
	:SetColor {255, 0, 255}
	:SetDesc "This box contains an item from the Valentine Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/boxofchocolates.png"
	:SetShop (444, true)
	:Set "Valentine"


------------------------------------
-- Standard Items
------------------------------------

i(3136)
	:Chance (2)
	:SetType "Tier"
	:SetName "Cover Girl"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(3142)
	:Chance (2)
	:SetType "Tier"
	:SetName "Splendid"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(3138)
	:Chance (2)
	:SetType "Tier"
	:SetName "Amazing"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"


------------------------------------
-- Specialized Items
------------------------------------

i(3139)
	:Chance (3)
	:SetType "Tier"
	:SetName "Prettier"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(3137)
	:Chance (3)
	:SetType "Tier"
	:SetName "Gentle"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(3140)
	:Chance (3)
	:SetType "Tier"
	:SetName "Cutie"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(6824)
	:Chance (3)
	:SetType "Unique"
	:SetName "Fat Lovers"
	:SetColor {255, 0, 255}
	:SetWeapon "weapon_ttt_dual_huge"
	:SetStats (6, 7)
		:Stat ("Weight", 20, 10)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Valentine"

i(6572)
	:Chance (3)
	:SetType "Hat"
	:SetName "Heartband"
	:SetColor {255, 0, 255}
	:SetDesc "Wear this if you have no friends and want people to love you."
	:SetModel "models/captainbigbutt/skeyler/hats/heartband.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Valentine"


------------------------------------
-- Superior Items
------------------------------------

i(3141)
	:Chance (4)
	:SetType "Tier"
	:SetName "Scrumptious"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(3182)
	:Chance (4)
	:SetType "Tier"
	:SetName "Ravishing"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(3187)
	:Chance (4)
	:SetType "Tier"
	:SetName "Purty"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(3183)
	:Chance (4)
	:SetType "Tier"
	:SetName "Dainty"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Valentine"

i(6831)
	:Chance (4)
	:SetType "Unique"
	:SetName "Pistol Lovers"
	:SetColor {255, 0, 255}
	:SetWeapon "weapon_ttt_dual_pistols"
	:SetStats (6, 7)
		:Stat ("Weight", 7, 4)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(6573)
	:Chance (4)
	:SetType "Hat"
	:SetName "Heart Hat"
	:SetColor {255, 0, 255}
	:SetDesc "I'm in love with my head."
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
	:Set "Valentine"


------------------------------------
-- High-End Items
------------------------------------

i(3143)
	:Chance (5)
	:SetType "Tier"
	:SetName "Handsome"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(3144)
	:Chance (5)
	:SetType "Tier"
	:SetName "Nice"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(3185)
	:Chance (5)
	:SetType "Tier"
	:SetName "Enchanting"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(3146)
	:Chance (5)
	:SetType "Tier"
	:SetName "Charming"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(3145)
	:Chance (5)
	:SetType "Tier"
	:SetName "Dreamy"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(3176)
	:Chance (5)
	:SetType "Tier"
	:SetName "Yummy"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(6825)
	:Chance (5)
	:SetType "Unique"
	:SetName "Glock Lovers"
	:SetColor {255, 0, 255}
	:SetWeapon "weapon_ttt_dual_glock"
	:SetStats (6, 7)
		:Stat ("Weight", 7, 4)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Valentine"

i(6822)
	:Chance (5)
	:SetType "Unique"
	:SetName "SG550 Lovers"
	:SetColor {255, 0, 255}
	:SetWeapon "weapon_ttt_dual_sg550"
	:SetStats (6, 7)
		:Stat ("Weight", 16, 8)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Valentine"

i(6488)
	:Chance (5)
	:SetType "Mask"
	:SetName "Heart Bag"
	:SetColor {255, 0, 255}
	:SetDesc "Less than Three."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (24)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(24)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Valentine"

i(6634)
	:Chance (5)
	:SetType "Mask"
	:SetName "Heart Welder Mask"
	:SetColor {255, 0, 255}
	:SetDesc "You weld broken hearts back together."
	:SetModel "models/splicermasks/weldingmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Right() * 2.6) + (ang:Up() * -7.6)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Valentine"


------------------------------------
-- Ascended Items
------------------------------------

i(3147)
	:Chance (6)
	:SetType "Tier"
	:SetName "Fabulous"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "Valentine"

i(3148)
	:Chance (6)
	:SetType "Tier"
	:SetName "Gorgeous"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "Valentine"

i(3188)
	:Chance (6)
	:SetType "Tier"
	:SetName "Beautiful"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "Valentine"

i(3189)
	:Chance (6)
	:SetType "Tier"
	:SetName "Adorable"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "Valentine"

i(6823)
	:Chance (6)
	:SetType "Unique"
	:SetName "MAC10 Lovers"
	:SetColor {255, 0, 255}
	:SetWeapon "weapon_ttt_dual_mac10"
	:SetStats (6, 7)
		:Stat ("Weight", 14, 8)
	:SetTalents (3, 3)
	:Set "Valentine"

i(6821)
	:Chance (6)
	:SetType "Unique"
	:SetName "TMP Lovers"
	:SetColor {255, 0, 255}
	:SetWeapon "weapon_ttt_dual_tmp"
	:SetStats (6, 7)
		:Stat ("Weight", 4, -4)
	:SetTalents (3, 3)
	:Set "Valentine"


------------------------------------
-- Cosmic Items
------------------------------------

i(3149)
	:Chance (7)
	:SetType "Tier"
	:SetName "Lovable"
	:SetColor {255, 0, 255}
	:SetEffect "glow"
	:SetStats (7, 7)
	:SetTalents (4, 4)
	:Set "Valentine"

i(6820)
	:Chance (7)
	:SetType "Unique"
	:SetName "UMP Lovers"
	:SetColor {255, 0, 255}
	:SetWeapon "weapon_ttt_dual_ump"
	:SetStats (6, 7)
		:Stat ("Weight", 0, -4)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Valentine"





------------------------------------
--
-- Urban Style Collection
--
------------------------------------

i(524)
	:Chance (3)
	:SetType "Crate"
	:SetName "Urban Style Crate"
	:SetDesc "This crate contains an item from the Urban Style Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/urban_crate64.png"
	:SetShop (300, true)
	:Set "Urban Style"


------------------------------------
-- Worn Items
------------------------------------

i(522)
	:Chance (1)
	:SetType "Hat"
	:SetName "White Fedora"
	:SetDesc "Smooth Criminal."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(509)
	:Chance (1)
	:SetType "Mask"
	:SetName "Black Vintage Glasses"
	:SetDesc "Like the Gray Vintage Glasses, but darker."
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
	:Set "Urban Style"

i(510)
	:Chance (1)
	:SetType "Mask"
	:SetName "Silver Vintage Glasses"
	:SetDesc "At least it's better than Bronze."
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
	:Set "Urban Style"

i(511)
	:Chance (1)
	:SetType "Mask"
	:SetName "Green Vintage Glasses"
	:SetDesc "Let's be honest. You look like the green hornet."
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
	:Set "Urban Style"

i(512)
	:Chance (1)
	:SetType "Mask"
	:SetName "Brown Vintage Glasses"
	:SetDesc "Hipster Style: Poop Version."
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
	:Set "Urban Style"

i(513)
	:Chance (1)
	:SetType "Mask"
	:SetName "Bronze Vintage Glasses"
	:SetDesc "Bronze. The Shiny Brown."
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
	:Set "Urban Style"

i(514)
	:Chance (1)
	:SetType "Mask"
	:SetName "Gray Vintage Glasses"
	:SetDesc "Vintage - Black and White - Gray. It all adds up."
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
	:Set "Urban Style"

i(515)
	:Chance (1)
	:SetType "Mask"
	:SetName "Beach Raybands"
	:SetDesc "Perfect for when you strut your stuff in your Bathing Suit."
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
	:Set "Urban Style"

i(516)
	:Chance (1)
	:SetType "Mask"
	:SetName "Red Raybands"
	:SetDesc "A classic type of glasses which every hipster must have."
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
	:Set "Urban Style"

i(517)
	:Chance (1)
	:SetType "Mask"
	:SetName "White Raybands"
	:SetDesc "Opposite to the Black Raybands."
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
	:Set "Urban Style"

i(518)
	:Chance (1)
	:SetType "Mask"
	:SetName "Black Raybands"
	:SetDesc "Opposite to the White Raybands."
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
	:Set "Urban Style"

i(519)
	:Chance (1)
	:SetType "Mask"
	:SetName "Brown Raybands"
	:SetDesc "Disclaimer: These do not make you any cooler."
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
	:Set "Urban Style"


------------------------------------
-- Standard Items
------------------------------------

i(520)
	:Chance (2)
	:SetType "Hat"
	:SetName "Grey Fedora"
	:SetDesc "Become that kid everybody hates."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(521)
	:Chance (2)
	:SetType "Hat"
	:SetName "Black Fedora"
	:SetDesc "Bring out your inner Hipster."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(367)
	:Chance (2)
	:SetType "Hat"
	:SetName "Tan Fedora"
	:SetDesc "Why sunbathe for a tan when you could just wear this Fedora."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(368)
	:Chance (2)
	:SetType "Hat"
	:SetName "Red Fedora"
	:SetDesc "Stained with the Blood of your Victims."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(369)
	:Chance (2)
	:SetType "Hat"
	:SetName "BR Fedora"
	:SetDesc "I know what you're thinking. \"Oh boy! Another Fedora! Hell yeah!!\"."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(370)
	:Chance (2)
	:SetType "Hat"
	:SetName "Brown Fedora"
	:SetDesc "Amazing, memingly brown."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(371)
	:Chance (2)
	:SetType "Hat"
	:SetName "Blue Fedora"
	:SetDesc "How many of the eight Fedoras do you own? Collect them."
	:SetModel "models/modified/hat01_fix.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(372)
	:Chance (2)
	:SetType "Hat"
	:SetName "Waldo Beanie"
	:SetDesc "Where are you."
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(373)
	:Chance (2)
	:SetType "Hat"
	:SetName "BB Beanie"
	:SetDesc "Big Bad Beanie."
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(374)
	:Chance (2)
	:SetType "Hat"
	:SetName "Red Beanie"
	:SetDesc "It's Red. It's a Beanie. What else do you need to know."
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(375)
	:Chance (2)
	:SetType "Hat"
	:SetName "White Beanie"
	:SetDesc "A Beanie... That's White."
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(376)
	:Chance (2)
	:SetType "Hat"
	:SetName "GB Beanie"
	:SetDesc "A Giant Beetle Beanie? Oh wait. It's not that cool."
	:SetModel "models/modified/hat03.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(377)
	:Chance (2)
	:SetType "Hat"
	:SetName "Black Beanie V2"
	:SetDesc "What happened to Black Beanie V1."
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(378)
	:Chance (2)
	:SetType "Hat"
	:SetName "Gray Beanie V2"
	:SetDesc "There isn't even a V1.."
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(379)
	:Chance (2)
	:SetType "Hat"
	:SetName "Gray Striped Beanie"
	:SetDesc "Loved the Gray Beanie? Well you'll love this Gray Striped Beanie."
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(380)
	:Chance (2)
	:SetType "Hat"
	:SetName "Rasta Beanie"
	:SetDesc "Reggae Reggae."
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(381)
	:Chance (2)
	:SetType "Hat"
	:SetName "Blue Beanie V2"
	:SetDesc "Blue Beanie V3s and Blue Beanie V3c Coming Soon."
	:SetModel "models/modified/hat04.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(505)
	:Chance (2)
	:SetType "Mask"
	:SetName "White Doctor Mask"
	:SetDesc "The party wants their mask back."
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
	:Set "Urban Style"

i(506)
	:Chance (2)
	:SetType "Mask"
	:SetName "Gray Doctor Mask"
	:SetDesc "You don't need to hide your face with this."
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
	:Set "Urban Style"

i(507)
	:Chance (2)
	:SetType "Mask"
	:SetName "Black Doctor Mask"
	:SetDesc "Black doctors are the best doctors out there."
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
	:Set "Urban Style"


------------------------------------
-- Specialized Items
------------------------------------

i(498)
	:Chance (3)
	:SetType "Hat"
	:SetName "Piswasser Beer Hat"
	:SetDesc "It's true. German beer is literally Piss Water."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(499)
	:Chance (3)
	:SetType "Hat"
	:SetName "Super Wet Beer Hat"
	:SetDesc "It was so tempting to put a 'Yo Mama' joke here."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(500)
	:Chance (3)
	:SetType "Hat"
	:SetName "Patriot Beer Hat"
	:SetDesc "For the True Redneck."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(501)
	:Chance (3)
	:SetType "Hat"
	:SetName "Benedict Beer Hat"
	:SetDesc "Clench your thirst with this Hat."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(502)
	:Chance (3)
	:SetType "Hat"
	:SetName "Blarneys Beer Hat"
	:SetDesc "Sounds like a knock off Barney the Dinosaur."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(503)
	:Chance (3)
	:SetType "Hat"
	:SetName "J Lager Beer Hat"
	:SetDesc "Jelly Lager? Delicious."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(382)
	:Chance (3)
	:SetType "Hat"
	:SetName "Gray Musicians Hat"
	:SetDesc "If only Voice Chat became Autotune whilst wearing this."
	:SetModel "models/modified/hat06.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(383)
	:Chance (3)
	:SetType "Hat"
	:SetName "Franklin Cap"
	:SetDesc "For the Franklin Cap OGs."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(384)
	:Chance (3)
	:SetType "Hat"
	:SetName "Franklin Cap V2"
	:SetDesc "Apparently there was something wrong with the original."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(385)
	:Chance (3)
	:SetType "Hat"
	:SetName "Fist Cap"
	:SetDesc "A smaller cap, best worn on your fist."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(386)
	:Chance (3)
	:SetType "Hat"
	:SetName "Gray C Cap"
	:SetDesc "Cannot be used as Fallout Currency."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(387)
	:Chance (3)
	:SetType "Hat"
	:SetName "White LS Cap"
	:SetDesc "Unfortunately this isn't a White Lego Sausage Cap."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(388)
	:Chance (3)
	:SetType "Hat"
	:SetName "Feud Cap"
	:SetDesc "This Cap is Presented by Steve Harvey."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(389)
	:Chance (3)
	:SetType "Hat"
	:SetName "Magnetics Cap"
	:SetDesc "Keep away from Metal surfaces."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(390)
	:Chance (3)
	:SetType "Hat"
	:SetName "OG Cap"
	:SetDesc "Straight outta Compton."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(391)
	:Chance (3)
	:SetType "Hat"
	:SetName "Stank Cap"
	:SetDesc "Don't do the Stanky Leg."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(392)
	:Chance (3)
	:SetType "Hat"
	:SetName "Dancer Cap"
	:SetDesc "Disco Boogie."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(393)
	:Chance (3)
	:SetType "Hat"
	:SetName "Ape Cap"
	:SetDesc "Please refrain from the Harambe memes."
	:SetModel "models/modified/hat07.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(394)
	:Chance (3)
	:SetType "Hat"
	:SetName "Orange Trucker Hat"
	:SetDesc "I can't stop thinking about an Orange Fruit wearing a little Trucker Hat."
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(395)
	:Chance (3)
	:SetType "Hat"
	:SetName "Blue Trucker Hat"
	:SetDesc "Your typical Trucker Hat."
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(396)
	:Chance (3)
	:SetType "Hat"
	:SetName "Nut House Trucker Hat"
	:SetDesc "Sounds a lot like a Gay Bar."
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(397)
	:Chance (3)
	:SetType "Hat"
	:SetName "Rusty Trucker Hat"
	:SetDesc "Rust is another name for Iron Oxide, which occurs when Iron or an alloy that contains Iron, like Steel, is exposed to Oxygen and moisture for a long period of time."
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(398)
	:Chance (3)
	:SetType "Hat"
	:SetName "Bishop Trucker Hat"
	:SetDesc "For all the Christian Truckers."
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(399)
	:Chance (3)
	:SetType "Hat"
	:SetName "24/7 Trucker Hat"
	:SetDesc "I'm open all hours."
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(400)
	:Chance (3)
	:SetType "Hat"
	:SetName "Fruit Trucker Hat"
	:SetDesc "One of your five a day."
	:SetModel "models/modified/hat08.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
		return model, pos, ang
	end)
	:Set "Urban Style"


------------------------------------
-- Superior Items
------------------------------------

i(584)
	:Chance (4)
	:SetType "Body"
	:SetName "Red Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(585)
	:Chance (4)
	:SetType "Body"
	:SetName "Black Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(403)
	:Chance (4)
	:SetType "Mask"
	:SetName "Crime Scene Wrap"
	:SetDesc "CSI: TTT."
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(404)
	:Chance (4)
	:SetType "Mask"
	:SetName "Arrows Wrap"
	:SetDesc "This way up."
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(405)
	:Chance (4)
	:SetType "Mask"
	:SetName "Caution Wrap"
	:SetDesc "Trust me. It's for the best that you're covered up."
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(406)
	:Chance (4)
	:SetType "Mask"
	:SetName "Red Arrow Wrap"
	:SetDesc "Like the superhero Green Arrow, but Red."
	:SetModel "models/sal/halloween/headwrap1.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(407)
	:Chance (4)
	:SetType "Mask"
	:SetName "Gray Mummy Wrap"
	:SetDesc "50 Shades of Mummy. No, wait."
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(408)
	:Chance (4)
	:SetType "Mask"
	:SetName "Black Mummy Wrap"
	:SetDesc "Not to be confused with Black Ninja Mask."
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(409)
	:Chance (4)
	:SetType "Mask"
	:SetName "White Mummy Wrap"
	:SetDesc "Tutankhamun, is that you."
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(410)
	:Chance (4)
	:SetType "Mask"
	:SetName "Rainbow Mummy Wrap"
	:SetDesc "Some say there is Treasure at the end of the Rainbow."
	:SetModel "models/sal/halloween/headwrap2.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(417)
	:Chance (4)
	:SetType "Mask"
	:SetName "Blue Hockey Mask"
	:SetDesc "It's what a blue Jason would wear."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(418)
	:Chance (4)
	:SetType "Mask"
	:SetName "Bulldog Hockey Mask"
	:SetDesc "Woof woof back the fuck up."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(419)
	:Chance (4)
	:SetType "Mask"
	:SetName "Electric Hockey Mask"
	:SetDesc "Zap me into the hockey rink sir."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(420)
	:Chance (4)
	:SetType "Mask"
	:SetName "Skull Hockey Mask"
	:SetDesc "Made from the Skull of a previous victim."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (11)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(11)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(421)
	:Chance (4)
	:SetType "Mask"
	:SetName "Patch Hockey Mask"
	:SetDesc "Made from the skin of previous victims."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (12)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(12)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(422)
	:Chance (4)
	:SetType "Mask"
	:SetName "Patch 2 Hockey Mask"
	:SetDesc "The Highly Anticipated Sequel to Patch Hockey Mask."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (13)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(13)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(423)
	:Chance (4)
	:SetType "Mask"
	:SetName "Something Hockey Mask"
	:SetDesc "It could be anything."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (14)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(14)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(424)
	:Chance (4)
	:SetType "Mask"
	:SetName "Wolf Hockey Mask"
	:SetDesc "How is a Wolf meant to hold the Hockey Stick."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(425)
	:Chance (4)
	:SetType "Mask"
	:SetName "Bear Hockey Mask"
	:SetDesc "I'd love to actually see Bears playing Hockey."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(426)
	:Chance (4)
	:SetType "Mask"
	:SetName "Dog Hockey Mask"
	:SetDesc "Dog backwards is God."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(427)
	:Chance (4)
	:SetType "Mask"
	:SetName "Crown Hockey Mask"
	:SetDesc "This does not make you the new Queen of England.."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(428)
	:Chance (4)
	:SetType "Mask"
	:SetName "Monster Hockey Mask"
	:SetDesc "Sponsored by Monster Energy Drink."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(429)
	:Chance (4)
	:SetType "Mask"
	:SetName "Monster 2 Hockey Mask"
	:SetDesc "The Highly Anticipated Sequel to Monster Hockey Mask."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(430)
	:Chance (4)
	:SetType "Mask"
	:SetName "Flame Hockey Mask"
	:SetDesc "Keep away from Flamable objects."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(431)
	:Chance (4)
	:SetType "Mask"
	:SetName "GFlame Hockey Mask"
	:SetDesc "For when you want your flames a little more Green."
	:SetModel "models/sal/acc/fix/mask_2.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(432)
	:Chance (4)
	:SetType "Mask"
	:SetName "Steel Armor Mask"
	:SetDesc "Become a Knight of the Realm."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(433)
	:Chance (4)
	:SetType "Mask"
	:SetName "Circuit Armor Mask"
	:SetDesc "It's like an unmasked Robot Face."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(434)
	:Chance (4)
	:SetType "Mask"
	:SetName "Lava Armor Mask"
	:SetDesc "Feeling Hot Hot Hot."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(435)
	:Chance (4)
	:SetType "Mask"
	:SetName "Purple Armor Mask"
	:SetDesc "Bright Purple. Why not."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(436)
	:Chance (4)
	:SetType "Mask"
	:SetName "Carbon Armor Mask"
	:SetDesc "Although it's hard to break. This won't save you from Headshots."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(437)
	:Chance (4)
	:SetType "Mask"
	:SetName "Bullseye Armor Mask"
	:SetDesc "Aim for between the eyes."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(438)
	:Chance (4)
	:SetType "Mask"
	:SetName "Stone Armor Mask"
	:SetDesc "The weight of this seems impractical."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(439)
	:Chance (4)
	:SetType "Mask"
	:SetName "Lightning Armor Mask"
	:SetDesc "How long until you hear the thunder? Hmm..."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(440)
	:Chance (4)
	:SetType "Mask"
	:SetName "Wood Armor Mask"
	:SetDesc "Smells like paper."
	:SetModel "models/sal/acc/fix/mask_4.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(441)
	:Chance (4)
	:SetType "Mask"
	:SetName "Please Stop Mask"
	:SetDesc "Ripped straight from a Horror Movie."
	:SetModel "models/modified/mask5.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
		return model, pos, ang
	end)
	:Set "Urban Style"


------------------------------------
-- High-End Items
------------------------------------

i(569)
	:Chance (5)
	:SetType "Body"
	:SetName "Gray Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(570)
	:Chance (5)
	:SetType "Body"
	:SetName "BlueCABackpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(571)
	:Chance (5)
	:SetType "Body"
	:SetName "GreenCABackpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(572)
	:Chance (5)
	:SetType "Body"
	:SetName "RedCABackpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(573)
	:Chance (5)
	:SetType "Body"
	:SetName "Black Tactical Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(574)
	:Chance (5)
	:SetType "Body"
	:SetName "Grey Tactical Backpack"
	:SetDesc "I wonder what you're carrying inside? Perhaps a secret charm for increased luck..."
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
	:Set "Urban Style"

i(471)
	:Chance (5)
	:SetType "Mask"
	:SetName "Up-N-Atom Bag"
	:SetDesc "The place to go for the finest of Burgers."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(472)
	:Chance (5)
	:SetType "Mask"
	:SetName "Smiley Bag"
	:SetDesc "Colon Closed Parentheses."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(473)
	:Chance (5)
	:SetType "Mask"
	:SetName "Pig Bag"
	:SetDesc "Unlimited Bacon within."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(474)
	:Chance (5)
	:SetType "Mask"
	:SetName "Reptilian Bag"
	:SetDesc "Does not provide Camouflage capabilities."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (11)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(11)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(475)
	:Chance (5)
	:SetType "Mask"
	:SetName "Meanie Bag"
	:SetDesc "Why you gotta be so rude."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (12)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(12)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(476)
	:Chance (5)
	:SetType "Mask"
	:SetName "Queasy Bag"
	:SetDesc "Good thing you have this bag if you need to puke."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (13)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(13)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(477)
	:Chance (5)
	:SetType "Mask"
	:SetName "Skull Bag"
	:SetDesc "Spooky Scary Skeleton."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (14)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(14)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(478)
	:Chance (5)
	:SetType "Mask"
	:SetName "Puppy Bag"
	:SetDesc "I will skin you alive if you do not stop barking."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (15)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(15)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(479)
	:Chance (5)
	:SetType "Mask"
	:SetName "Pink Ghost Bag"
	:SetDesc "Like Pinky from Pacman. But not. For Legal Reasons."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (16)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(16)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(480)
	:Chance (5)
	:SetType "Mask"
	:SetName "Alien Bag"
	:SetDesc "Stolen from the depths of Uranus."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (17)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(17)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(481)
	:Chance (5)
	:SetType "Mask"
	:SetName "Help Me Bag"
	:SetDesc "Help Me... Please."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (18)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(18)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(482)
	:Chance (5)
	:SetType "Mask"
	:SetName "Maze Bag"
	:SetDesc "Why isn't this just called a Spiral Bag."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (19)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(19)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(483)
	:Chance (5)
	:SetType "Mask"
	:SetName "Pretty Cry Bag"
	:SetDesc "Am I still beautiful..."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(484)
	:Chance (5)
	:SetType "Mask"
	:SetName "FU Bag"
	:SetDesc "This bag sums up how you feel after doing 150 of these."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (20)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(20)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(485)
	:Chance (5)
	:SetType "Mask"
	:SetName "Sir Bag"
	:SetDesc "For the most dapper of Gentlemen."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (21)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(21)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(486)
	:Chance (5)
	:SetType "Mask"
	:SetName "Stickers Bag"
	:SetDesc "Release your inner college kid."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (22)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(22)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(487)
	:Chance (5)
	:SetType "Mask"
	:SetName "Sheman Bag"
	:SetDesc "Wanna kiss sweetheart? Hmm..."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (23)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(23)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(488)
	:Chance (5)
	:SetType "Mask"
	:SetName "Heart Bag"
	:SetDesc "Less than Three."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (24)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(24)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(489)
	:Chance (5)
	:SetType "Mask"
	:SetName "Brown Bag"
	:SetDesc "Otherwise known as the 'Blackout Bag'."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (25)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(25)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(490)
	:Chance (5)
	:SetType "Mask"
	:SetName "Shy Bag"
	:SetDesc "Not to be confused with Shy Guy."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(491)
	:Chance (5)
	:SetType "Mask"
	:SetName "Mob Boss Bag"
	:SetDesc "You are the Godfather."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(492)
	:Chance (5)
	:SetType "Mask"
	:SetName "Sharp Teeth Bag"
	:SetDesc "Jaws 5: Trouble in Terrorist Ocean."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(493)
	:Chance (5)
	:SetType "Mask"
	:SetName "Kiddo Bag"
	:SetDesc "Why would you bring Children into this."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(494)
	:Chance (5)
	:SetType "Mask"
	:SetName "Burger Shot Bag"
	:SetDesc "Let's hope Big Shot doesn't want to order from here."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(495)
	:Chance (5)
	:SetType "Mask"
	:SetName "Kill Me Bag"
	:SetDesc "That's pretty messed up."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(496)
	:Chance (5)
	:SetType "Mask"
	:SetName "Devil Bag"
	:SetDesc "Perfect for when you're setting people on fire."
	:SetModel "models/sal/halloween/bag.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(450)
	:Chance (5)
	:SetType "Mask"
	:SetName "Black Ninja Mask"
	:SetDesc "Disclaimer: Does not make you an actual Ninja."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(451)
	:Chance (5)
	:SetType "Mask"
	:SetName "White Ninja Mask"
	:SetDesc "How is this meant to help you stay hidden in the shadows."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(452)
	:Chance (5)
	:SetType "Mask"
	:SetName "Police Ninja Mask"
	:SetDesc "Police Ninja. Sounds like the best movie ever."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(453)
	:Chance (5)
	:SetType "Mask"
	:SetName "Tan Ninja Mask"
	:SetDesc "For when you want your Ninja Mask to look like your own face."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(454)
	:Chance (5)
	:SetType "Mask"
	:SetName "Benders Ninja Mask"
	:SetDesc "This is not related to Futurama. Unfortunately."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(455)
	:Chance (5)
	:SetType "Mask"
	:SetName "Justice Ninja Mask"
	:SetDesc "Become a member of the Justice League."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(456)
	:Chance (5)
	:SetType "Mask"
	:SetName "Camo Ninja Mask"
	:SetDesc "Who is that dude without a head."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(457)
	:Chance (5)
	:SetType "Mask"
	:SetName "Candy Ninja Mask"
	:SetDesc "The latest franchise in the Candy Crush saga."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (6)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(6)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(458)
	:Chance (5)
	:SetType "Mask"
	:SetName "LoveFist Ninja Mask"
	:SetDesc "Sounds like a Euphemism."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (7)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(7)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(459)
	:Chance (5)
	:SetType "Mask"
	:SetName "TPI Ninja Mask"
	:SetDesc "TPI: Turtle People Indeed."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (8)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(8)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(460)
	:Chance (5)
	:SetType "Mask"
	:SetName "Pink Ninja Mask"
	:SetDesc "The latest must-have accessory for Barbie."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (9)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(9)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(464)
	:Chance (5)
	:SetType "Mask"
	:SetName "Gray Skull Mask"
	:SetDesc "It's actually Purple with the Grayscale Filter applied."
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(465)
	:Chance (5)
	:SetType "Mask"
	:SetName "Brown Skull Mask"
	:SetDesc "Perfect whilst pulling off the perfect Heist."
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(466)
	:Chance (5)
	:SetType "Mask"
	:SetName "White Skull Mask"
	:SetDesc "We all have Skulls. Why not show it off."
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(467)
	:Chance (5)
	:SetType "Mask"
	:SetName "Black Skull Mask"
	:SetDesc "2spooky4me."
	:SetModel "models/sal/halloween/skull.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
		return model, pos, ang
	end)
	:Set "Urban Style"


------------------------------------
-- Ascended Items
------------------------------------

i(576)
	:Chance (6)
	:SetType "Body"
	:SetName "White Scarf"
	:SetDesc "It's getting chilly outside."
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
	:Set "Urban Style"

i(577)
	:Chance (6)
	:SetType "Body"
	:SetName "Gray Scarf"
	:SetDesc "It's getting chilly outside."
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
	:Set "Urban Style"

i(578)
	:Chance (6)
	:SetType "Body"
	:SetName "Black Scarf"
	:SetDesc "It's getting chilly outside."
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
	:Set "Urban Style"

i(579)
	:Chance (6)
	:SetType "Body"
	:SetName "Midnight Scarf"
	:SetDesc "It's getting chilly outside."
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
	:Set "Urban Style"

i(580)
	:Chance (6)
	:SetType "Body"
	:SetName "Red Scarf"
	:SetDesc "It's getting chilly outside."
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
	:Set "Urban Style"

i(581)
	:Chance (6)
	:SetType "Body"
	:SetName "Green Scarf"
	:SetDesc "It's getting chilly outside."
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
	:Set "Urban Style"

i(582)
	:Chance (6)
	:SetType "Body"
	:SetName "Pink Scarf"
	:SetDesc "It's getting chilly outside."
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
	:Set "Urban Style"

i(497)
	:Chance (6)
	:SetType "Mask"
	:SetName "Bear Mask"
	:SetDesc "Give me a hug."
	:SetModel "models/sal/bear.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.391235) + (ang:Right() * -0.229431) +  (ang:Up() * -0.777100)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(504)
	:Chance (6)
	:SetType "Mask"
	:SetName "Cat Mask"
	:SetDesc "Nine Lives not included."
	:SetModel "models/sal/cat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.390503) + (ang:Right() * -0.228668) +  (ang:Up() * -0.152496)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(508)
	:Chance (6)
	:SetType "Mask"
	:SetName "Fox Mask"
	:SetDesc "What does the fox say? Yep."
	:SetModel "models/sal/fox.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.561279) + (ang:Right() * 0.079376) +  (ang:Up() * -0.346680)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(401)
	:Chance (6)
	:SetType "Mask"
	:SetName "White Hawk Mask"
	:SetDesc "Show off your true Patriotism."
	:SetModel "models/sal/hawk_1.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(402)
	:Chance (6)
	:SetType "Mask"
	:SetName "Brown Hawk Mask"
	:SetDesc "Show off your true Patriotism."
	:SetModel "models/sal/hawk_2.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(446)
	:Chance (6)
	:SetType "Mask"
	:SetName "Monkey Mask"
	:SetDesc "Exactly what it says on the tin."
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(447)
	:Chance (6)
	:SetType "Mask"
	:SetName "Brown Monkey Mask"
	:SetDesc "King Kong. Is that you? Hmm..."
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(448)
	:Chance (6)
	:SetType "Mask"
	:SetName "Zombie Monkey Mask"
	:SetDesc "Please refrain from the dead Harambe memes."
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(449)
	:Chance (6)
	:SetType "Mask"
	:SetName "Old Monkey Mask"
	:SetDesc "Basically Cranky Kong."
	:SetModel "models/sal/halloween/monkey.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(461)
	:Chance (6)
	:SetType "Mask"
	:SetName "Owl Mask"
	:SetDesc "Does not improve Night Vision."
	:SetModel "models/sal/owl.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(462)
	:Chance (6)
	:SetType "Mask"
	:SetName "Pig Mask"
	:SetDesc "Bacon not included."
	:SetModel "models/sal/pig.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.220093) + (ang:Right() * 0.055542) +  (ang:Up() * -1.410973)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(463)
	:Chance (6)
	:SetType "Mask"
	:SetName "Zombie Pig Mask"
	:SetDesc "Please not another Minecraft Reference."
	:SetModel "models/sal/pig.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.220093) + (ang:Right() * 0.055542) +  (ang:Up() * -1.410973)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(468)
	:Chance (6)
	:SetType "Mask"
	:SetName "Wolf Mask"
	:SetDesc "May cause violent outbursts of howling at a Full Moon."
	:SetModel "models/sal/wolf.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.05)
		pos = pos + (ang:Forward() * -4.468628) + (ang:Right() * 0.039375) +  (ang:Up() * -2.770370)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(469)
	:Chance (6)
	:SetType "Mask"
	:SetName "Zombie Mask"
	:SetDesc "Unfortunately you can't eat the corpses while wearing this."
	:SetModel "models/sal/halloween/zombie.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(470)
	:Chance (6)
	:SetType "Mask"
	:SetName "Stone Zombie Mask"
	:SetDesc "For those who enjoy Roleplaying a Gargoyle."
	:SetModel "models/sal/halloween/zombie.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
		return model, pos, ang
	end)
	:Set "Urban Style"


------------------------------------
-- Cosmic Items
------------------------------------

i(575)
	:Chance (7)
	:SetType "Body"
	:SetName "Face Bandana"
	:SetDesc "True terrorists will always have a spare one of these on them."
	:SetModel "models/modified/bandana.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Right() * 0.1) + (ang:Up() * -4.5) + (ang:Forward() * -4.1)
		ang:RotateAroundAxis(ang:Up(), 0)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(442)
	:Chance (7)
	:SetType "Mask"
	:SetName "Black Skull Cover"
	:SetDesc "2spooky4me."
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(443)
	:Chance (7)
	:SetType "Mask"
	:SetName "Gray Skull Cover"
	:SetDesc "It's actually Purple with the Grayscale Filter applied."
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(444)
	:Chance (7)
	:SetType "Mask"
	:SetName "Tan Skull Cover"
	:SetDesc "Perfect whilst pulling off the perfect Heist."
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:Set "Urban Style"

i(445)
	:Chance (7)
	:SetType "Mask"
	:SetName "Green Skull Cover"
	:SetDesc "We all have Skulls. Why not show it off."
	:SetModel "models/modified/mask6.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
		return model, pos, ang
	end)
	:Set "Urban Style"





------------------------------------
--
-- Titan Collection
--
------------------------------------

i(1051)
	:Chance (4)
	:SetType "Crate"
	:SetName "Titan Crate"
	:SetDesc "This crate contains an item from the Titan Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/titan_crate64.png"
	:SetShop (2000, true)
	:Set "Titan"


------------------------------------
-- Specialized Items
------------------------------------

i(1107)
	:Chance (3)
	:SetType "Model"
	:SetName "Arctic Model"
	:SetDesc "Chilli now isn't it..."
	:SetModel "models/player/arctic.mdl"
	:Set "Titan"

i(1108)
	:Chance (3)
	:SetType "Model"
	:SetName "Guerilla Model"
	:SetDesc "Go hide in the jungle."
	:SetModel "models/player/guerilla.mdl"
	:Set "Titan"

i(1109)
	:Chance (3)
	:SetType "Model"
	:SetName "Leet Model"
	:SetDesc "Rush B."
	:SetModel "models/player/leet.mdl"
	:Set "Titan"

i(1110)
	:Chance (3)
	:SetType "Model"
	:SetName "Phoenix Model"
	:SetDesc "Rush A."
	:SetModel "models/player/phoenix.mdl"
	:Set "Titan"

i(1111)
	:Chance (3)
	:SetType "Model"
	:SetName "Hobo Model"
	:SetDesc "Now you can collect IC and beg properly."
	:SetModel "models/player/corpse1.mdl"
	:Set "Titan"

i(1112)
	:Chance (3)
	:SetType "Model"
	:SetName "Urban Model"
	:SetDesc "Choose your team."
	:SetModel "models/player/urban.mdl"
	:Set "Titan"

i(1113)
	:Chance (3)
	:SetType "Model"
	:SetName "Riot Model"
	:SetDesc "I think they're going B guys."
	:SetModel "models/player/riot.mdl"
	:Set "Titan"

i(1114)
	:Chance (3)
	:SetType "Model"
	:SetName "SWAT Model"
	:SetDesc "Don't stand out too much from the terrorists."
	:SetModel "models/player/swat.mdl"
	:Set "Titan"

i(1115)
	:Chance (3)
	:SetType "Model"
	:SetName "Gasmask Model"
	:SetDesc "Don't stand out too much from the terrorists."
	:SetModel "models/player/gasmask.mdl"
	:Set "Titan"


------------------------------------
-- Superior Items
------------------------------------

i(1150)
	:Chance (4)
	:SetType "Tier"
	:SetName "Titan T4"
	:SetEffect "electric"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Titan"

i(1121)
	:Chance (4)
	:SetType "Unique"
	:SetName "Berattapo"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_m9"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Titan"

i(1122)
	:Chance (4)
	:SetType "Unique"
	:SetName "Counterpart"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_mp5"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Titan"

i(1123)
	:Chance (4)
	:SetType "Unique"
	:SetName "Camoldaci"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_m14"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Titan"

i(1124)
	:Chance (4)
	:SetType "Unique"
	:SetName "Frenchi"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_famas"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Titan"

i(1125)
	:Chance (4)
	:SetType "Unique"
	:SetName "Heavina"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_sg550"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Titan"

i(1105)
	:Chance (4)
	:SetType "Special"
	:SetName "Glacies"
	:SetDesc "A throwable ball of frost. Targets are frozen for %s seconds, slowing their speed by ^%s_ percent, and apply 2 damage every ^%s seconds."
	:SetWeapon "weapon_frostball"
	:SetStats (3, 3)
		:Stat (1, 15, 30)
		:Stat (2, 25, 50)
		:Stat (3, 5, 8)
	:Set "Titan"

i(1116)
	:Chance (4)
	:SetType "Model"
	:SetName "Super Soldier Model"
	:SetDesc "Don't stand out too much from the terrorists."
	:SetModel "models/player/combine_super_soldier.mdl"
	:Set "Titan"

i(1117)
	:Chance (4)
	:SetType "Model"
	:SetName "Combine Model"
	:SetDesc "Don't stand out too much from the terrorists."
	:SetModel "models/player/combine_soldier.mdl"
	:Set "Titan"

i(1118)
	:Chance (4)
	:SetType "Model"
	:SetName "Combine Prison Model"
	:SetDesc "Don't stand out too much from the terrorists."
	:SetModel "models/player/combine_soldier_prisonguard.mdl"
	:Set "Titan"

i(1119)
	:Chance (4)
	:SetType "Model"
	:SetName "Police Model"
	:SetDesc "Wow the police are here."
	:SetModel "models/player/police.mdl"
	:Set "Titan"

i(1120)
	:Chance (4)
	:SetType "Model"
	:SetName "Female Police Model"
	:SetDesc "Wow the police are here."
	:SetModel "models/player/police_fem.mdl"
	:Set "Titan"


------------------------------------
-- High-End Items
------------------------------------

i(1149)
	:Chance (5)
	:SetType "Tier"
	:SetName "Titan T3"
	:SetEffect "electric"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Titan"

i(1102)
	:Chance (5)
	:SetType "Unique"
	:SetName "The Apprentice"
	:SetEffect "glow"
	:SetWeapon "weapon_mor_bonemold"
	:SetStats (6, 7)
		:Stat ("Chargerate", 22, 38)
	:SetTalents (2, 2)
	:Set "Titan"

i(1126)
	:Chance (5)
	:SetType "Unique"
	:SetName "Ectopati"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_1911"
	:SetStats (5, 6)
	:SetTalents (2, 2)
	:Set "Titan"

i(1127)
	:Chance (5)
	:SetType "Unique"
	:SetName "Slypinu"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_m9s"
	:SetStats (5, 6)
	:SetTalents (2, 2)
	:Set "Titan"

i(1128)
	:Chance (5)
	:SetType "Unique"
	:SetName "Obicanobi"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_g36c"
	:SetStats (5, 6)
	:SetTalents (2, 2)
	:Set "Titan"

i(1129)
	:Chance (5)
	:SetType "Unique"
	:SetName "Big Deal"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_deagle"
	:SetStats (5, 6)
	:SetTalents (2, 2)
	:Set "Titan"

i(1130)
	:Chance (5)
	:SetType "Unique"
	:SetName "Blastinati"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_benelli"
	:SetStats (5, 6)
	:SetTalents (2, 2)
	:Set "Titan"

i(1131)
	:Chance (5)
	:SetType "Unique"
	:SetName "Goonstar"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_mac"
	:SetStats (5, 6)
	:SetTalents (2, 2)
	:Set "Titan"

i(1104)
	:Chance (5)
	:SetType "Special"
	:SetName "Contagio"
	:SetDesc "A throwable ball of contagious. Infected targets take %s damage every ^%s seconds ^%s times."
	:SetWeapon "weapon_acidball"
	:SetStats (3, 3)
		:Stat (1, 3, 5)
		:Stat (2, 3, 6)
		:Stat (3, 5, 10)
	:Set "Titan"


------------------------------------
-- Ascended Items
------------------------------------

i(1148)
	:Chance (6)
	:SetType "Tier"
	:SetName "Titan T2"
	:SetEffect "electric"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Titan"

i(1101)
	:Chance (6)
	:SetType "Unique"
	:SetName "The Master"
	:SetEffect "glow"
	:SetWeapon "weapon_mor_auriel"
	:SetStats (7, 7)
		:Stat ("Chargerate", 28, 46)
	:SetTalents (2, 3)
	:Set "Titan"

i(1132)
	:Chance (6)
	:SetType "Unique"
	:SetName "Jungle Tap"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_fal"
	:SetStats (6, 6)
	:SetTalents (2, 3)
	:Set "Titan"

i(1133)
	:Chance (6)
	:SetType "Unique"
	:SetName "Cheng Feng"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_cf05"
	:SetStats (6, 6)
	:SetTalents (2, 3)
	:Set "Titan"

i(1134)
	:Chance (6)
	:SetType "Unique"
	:SetName "Annihilator"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_g36c"
	:SetStats (6, 6)
	:SetTalents (2, 3)
	:Set "Titan"

i(1135)
	:Chance (6)
	:SetType "Unique"
	:SetName "Sharpisto"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_ots33"
	:SetStats (6, 6)
	:SetTalents (2, 3)
	:Set "Titan"

i(1136)
	:Chance (6)
	:SetType "Unique"
	:SetName "Deadeye"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_m24"
	:SetStats (6, 6)
	:SetTalents (2, 3)
	:Set "Titan"

i(1137)
	:Chance (6)
	:SetType "Unique"
	:SetName "Policia"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_glock"
	:SetStats (6, 6)
	:SetTalents (2, 3)
	:Set "Titan"


------------------------------------
-- Cosmic Items
------------------------------------

i(1147)
	:Chance (7)
	:SetType "Tier"
	:SetName "Titan T1"
	:SetEffect "electric"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Titan"

i(1100)
	:Chance (7)
	:SetType "Unique"
	:SetName "The Hand"
	:SetEffect "glow"
	:SetWeapon "weapon_mor_daedric"
	:SetStats (8, 8)
		:Stat ("Chargerate", 34, 56)
	:SetTalents (3, 3)
	:Set "Titan"

i(1138)
	:Chance (7)
	:SetType "Unique"
	:SetName "Bond's Best Peep"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_deagle"
	:SetStats (7, 7)
		:Stat ("Firerate", 20, 38)
		:Stat ("Accuracy", 40, 75)
		:Stat ("Damage", 28, 45)
	:SetTalents (3, 3)
	:Set "Titan"

i(1139)
	:Chance (7)
	:SetType "Unique"
	:SetName "MachitoP5"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_vollmer"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Titan"

i(1140)
	:Chance (7)
	:SetType "Unique"
	:SetName "Akaline Killer"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_ak47"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Titan"

i(1141)
	:Chance (7)
	:SetType "Unique"
	:SetName "Beastmode"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_m4a1"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Titan"

i(1142)
	:Chance (7)
	:SetType "Unique"
	:SetName "Trepaci"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_sterlings"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Titan"

i(1143)
	:Chance (7)
	:SetType "Unique"
	:SetName "Trepaco"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_sterling"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Titan"

i(1106)
	:Chance (7)
	:SetType "Special"
	:SetName "Ignis"
	:SetDesc "A throwable ball of inferno. Targets are ignited for %s seconds, applying 1 damage every 0.2 seconds."
	:SetWeapon "weapon_fireball"
	:SetStats (1, 1)
		:Stat (1, 4, 8)
	:Set "Titan"


------------------------------------
-- Planetary Items
------------------------------------

i(1146)
	:Chance (9)
	:SetType "Tier"
	:SetName "Titan T0"
	:SetEffect "electric"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Titan"

i(1144)
	:Chance (9)
	:SetType "Unique"
	:SetName "Warriochi"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_sako"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Titan"

i(1145)
	:Chance (9)
	:SetType "Unique"
	:SetName "Astronado"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_sr25"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Titan"





------------------------------------
--
-- Testing Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(10101)
	:Chance (8)
	:SetType "Tier"
	:SetName "Meepen's"
	:SetColor {255, 255, 0}
	:SetEffect "fire"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -13)
		:Stat ("Firerate", 15, 30)
		:Stat ("Magazine", 30, 50)
		:Stat ("Accuracy", 15, 25)
		:Stat ("Damage", 20, 30)
		:Stat ("Kick", -15, -30)
		:Stat ("Range", 40, 50)
	:SetTalents (4, 4)
	:Set "Testing"

i(12)
	:Chance (8)
	:SetType "Tier"
	:SetName "TalentTest"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -13)
		:Stat ("Firerate", 15, 30)
		:Stat ("Magazine", 30, 50)
		:Stat ("Accuracy", 15, 25)
		:Stat ("Damage", 20, 30)
		:Stat ("Kick", -15, -30)
		:Stat ("Range", 40, 50)
	:SetTalents (3, 3)
		:SetTalent (3, "Phoenix")
	:Set "Testing"

i(6119)
	:Chance (8)
	:SetType "Skin"
	:SetName "Test Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/2198b5d9d5c8a1e35fe2a4c833556fd6.png"
	:Set "Testing"





------------------------------------
--
-- Supreme Collection
--
------------------------------------

i(10)
	:Chance (0)
	:SetType "Usable"
	:SetName "Traitor Token"
	:SetDesc "Use this item during the preparing phase to be guaranteed to be a Traitor next round."
	:SetIcon "https://cdn.moat.gg/ttt/traitor_token.png"
	:SetShop (75000, false)
	:Set "Supreme"





------------------------------------
--
-- Summer Climb Collection
--
------------------------------------


------------------------------------
-- Superior Items
------------------------------------

i(9614)
	:Chance (4)
	:SetType "Tier"
	:SetName "Ripe"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Summer Climb"

i(9621)
	:Chance (4)
	:SetType "Tier"
	:SetName "Humid"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Summer Climb"

i(9603)
	:Chance (4)
	:SetType "Tier"
	:SetName "Fun"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Summer Climb"

i(9606)
	:Chance (4)
	:SetType "Tier"
	:SetName "Blistering"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Summer Climb"

i(9609)
	:Chance (4)
	:SetType "Tier"
	:SetName "Poolside"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Summer Climb"


------------------------------------
-- High-End Items
------------------------------------

i(9601)
	:Chance (5)
	:SetType "Tier"
	:SetName "Splashing"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9610)
	:Chance (5)
	:SetType "Tier"
	:SetName "Refreshing"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9611)
	:Chance (5)
	:SetType "Tier"
	:SetName "Delightful"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9613)
	:Chance (5)
	:SetType "Tier"
	:SetName "Hazy"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9615)
	:Chance (5)
	:SetType "Tier"
	:SetName "Sunburnt"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9619)
	:Chance (5)
	:SetType "Tier"
	:SetName "Tropical"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9620)
	:Chance (5)
	:SetType "Tier"
	:SetName "Outdoor"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9604)
	:Chance (5)
	:SetType "Tier"
	:SetName "Beach"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9605)
	:Chance (5)
	:SetType "Tier"
	:SetName "Blazing"
	:SetStats (5, 5)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(9607)
	:Chance (5)
	:SetType "Tier"
	:SetName "Breezy"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Summer Climb"

i(45)
	:Chance (5)
	:SetType "Model"
	:SetName "Aperture Containment Model"
	:SetDesc "The Enrichment Center is committed to the well being of all participants."
	:SetModel "models/player/aphaztech.mdl"
	:Set "Summer Climb"

i(46)
	:Chance (5)
	:SetType "Model"
	:SetName "Veteran Soldier Model"
	:SetDesc "He's seen some stuff."
	:SetModel "models/player/clopsy.mdl"
	:Set "Summer Climb"

i(53)
	:Chance (5)
	:SetType "Model"
	:SetName "Stormtrooper Model"
	:SetDesc "Victory is written in the stars."
	:SetModel "models/player/stormtrooper.mdl"
	:Set "Summer Climb"


------------------------------------
-- Ascended Items
------------------------------------

i(9612)
	:Chance (6)
	:SetType "Tier"
	:SetName "Scorching"
	:SetEffect "fire"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Summer Climb"

i(9616)
	:Chance (6)
	:SetType "Tier"
	:SetName "Aquaholic"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Summer Climb"

i(9617)
	:Chance (6)
	:SetType "Tier"
	:SetName "Ablaze"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Summer Climb"

i(9618)
	:Chance (6)
	:SetType "Tier"
	:SetName "Backyard"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Summer Climb"

i(9608)
	:Chance (6)
	:SetType "Tier"
	:SetName "Fragrant"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Summer Climb"

i(10120)
	:Chance (6)
	:SetType "Unique"
	:SetName "Energizing MAC10"
	:SetEffect "electric"
	:SetWeapon "weapon_zm_mac10"
	:SetStats (6, 8)
		:Stat ("Kick", -17, -28)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
	:SetTalents (3, 4)
		:SetTalent (1, "PEW")
	:Set "Summer Climb"

i(10106)
	:Chance (6)
	:SetType "Unique"
	:SetName "Energizing Deadshot"
	:SetEffect "electric"
	:SetWeapon "weapon_ttt_sg550"
	:SetStats (6, 8)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
		:Stat ("Firerate", 22, 33)
	:SetTalents (3, 4)
		:SetTalent (1, "PEW")
	:Set "Summer Climb"

i(10112)
	:Chance (6)
	:SetType "Unique"
	:SetName "Zapper Capper"
	:SetEffect "electric"
	:SetWeapon "weapon_zapperpvp"
	:SetStats (6, 7)
		:Stat ("Reloadrate", 30, 40)
		:Stat ("Weight", -10, -15)
		:Stat ("Firerate", 22, 33)
	:SetTalents (2, 3)
		:SetTalent (1, "PEW")
	:Set "Summer Climb"

i(10110)
	:Chance (6)
	:SetType "Unique"
	:SetName "Smear Cavalier"
	:SetWeapon "weapon_ttt_famas"
	:SetStats (6, 7)
		:Stat ("Deployrate", 20, 40)
		:Stat ("Reloadrate", 20, 40)
	:SetTalents (3, 3)
		:SetTalent (1, "PAINTBALLS")
	:Set "Summer Climb"

i(10111)
	:Chance (6)
	:SetType "Unique"
	:SetName "Varnish Star"
	:SetWeapon "weapon_ttt_galil"
	:SetStats (6, 7)
		:Stat ("Deployrate", 20, 40)
		:Stat ("Reloadrate", 20, 40)
	:SetTalents (3, 3)
		:SetTalent (1, "PAINTBALLS")
	:Set "Summer Climb"

i(10105)
	:Chance (6)
	:SetType "Unique"
	:SetName "Brain Stain"
	:SetWeapon "weapon_ttt_mp40"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Magazine", 23, 33)
		:Stat ("Kick", -17, -28)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 3, 13)
		:Stat ("Firerate", 5, 16)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
		:SetTalent (1, "PAINTBALLS")
	:Set "Summer Climb"

i(10104)
	:Chance (6)
	:SetType "Unique"
	:SetName "Spanish Splatter"
	:SetWeapon "weapon_sp"
	:SetStats (6, 7)
		:Stat ("Deployrate", 20, 40)
		:Stat ("Reloadrate", 20, 40)
	:SetTalents (3, 3)
		:SetTalent (1, "PAINTBALLS")
	:Set "Summer Climb"

i(50)
	:Chance (6)
	:SetType "Model"
	:SetName "Ash Ketchum Model"
	:SetDesc "Gotta catch em all."
	:SetModel "models/player/red.mdl"
	:Set "Summer Climb"


------------------------------------
-- Cosmic Items
------------------------------------

i(10107)
	:Chance (7)
	:SetType "Unique"
	:SetName "Energizing AK47"
	:SetEffect "electric"
	:SetWeapon "weapon_ttt_ak47"
	:SetStats (6, 8)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
	:SetTalents (3, 4)
		:SetTalent (1, "PEW")
	:Set "Summer Climb"

i(10109)
	:Chance (7)
	:SetType "Unique"
	:SetName "La Vaux Gloss"
	:SetWeapon "weapon_sp"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Magazine", 19, 28)
		:Stat ("Kick", -14, -23)
		:Stat ("Deployrate", 20, 40)
		:Stat ("Reloadrate", 20, 40)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Firerate", 14, 23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
		:SetTalent (1, "PAINTBALLS")
	:Set "Summer Climb"

i(49)
	:Chance (7)
	:SetType "Model"
	:SetName "Zelda Model"
	:SetDesc "It's dangerous to go alone! Take this... model."
	:SetModel "models/player/zelda.mdl"
	:Set "Summer Climb"


------------------------------------
-- Extinct Items
------------------------------------

i(9602)
	:Chance (8)
	:SetType "Tier"
	:SetName "June"
	:SetColor {255, 255, 0}
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Summer Climb"


------------------------------------
-- Planetary Items
------------------------------------

i(10108)
	:Chance (9)
	:SetType "Unique"
	:SetName "Joule Newell"
	:SetEffect "electric"
	:SetWeapon "weapon_ttt_mp40"
	:SetStats (8, 9)
		:Stat ("Weight", -5, -7)
		:Stat ("Magazine", 23, 33)
		:Stat ("Kick", -17, -28)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Firerate", 17, 28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 4)
		:SetTalent (1, "PEW")
	:Set "Summer Climb"





------------------------------------
--
-- Summer 2017 Event Collection
--
------------------------------------


------------------------------------
-- Worn Items
------------------------------------

i(3251)
	:Chance (1)
	:SetType "Tier"
	:SetName "Novice"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Summer 2017 Event"


------------------------------------
-- Standard Items
------------------------------------

i(3252)
	:Chance (2)
	:SetType "Tier"
	:SetName "Amateur"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Summer 2017 Event"


------------------------------------
-- Specialized Items
------------------------------------

i(3253)
	:Chance (3)
	:SetType "Tier"
	:SetName "Apprentice"
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Summer 2017 Event"


------------------------------------
-- Superior Items
------------------------------------

i(3254)
	:Chance (4)
	:SetType "Tier"
	:SetName "Professional"
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Summer 2017 Event"


------------------------------------
-- High-End Items
------------------------------------

i(3256)
	:Chance (5)
	:SetType "Tier"
	:SetName "Expert"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Summer 2017 Event"

i(3255)
	:Chance (5)
	:SetType "Tier"
	:SetName "Master"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Summer 2017 Event"


------------------------------------
-- Ascended Items
------------------------------------

i(3257)
	:Chance (6)
	:SetType "Tier"
	:SetName "Legend"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Summer 2017 Event"


------------------------------------
-- Planetary Items
------------------------------------

i(3258)
	:Chance (9)
	:SetType "Tier"
	:SetName "God"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Summer 2017 Event"





------------------------------------
--
-- Sugar Daddy Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(212)
	:Chance (8)
	:SetType "Effect"
	:SetName "Dola Effect"
	:SetDesc "A special item given as a thanks to the sugar daddies of MG."
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
		return model, pos, ang
	end)
	:Set "Sugar Daddy"

i(66)
	:Chance (8)
	:SetType "Model"
	:SetName "Skeleton Model"
	:SetDesc "An exclusive item given to Shiny Mega Gallade, first donator of $100."
	:SetModel "models/player/skeleton.mdl"
	:Set "Sugar Daddy"





------------------------------------
--
-- Spring Collection
--
------------------------------------

i(810)
	:Chance (2)
	:SetType "Crate"
	:SetName "Spring Crate"
	:SetDesc "This crate contains an item from the Spring Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/spring_crate64.png"
	:SetShop (175, true)
	:Set "Spring"


------------------------------------
-- Worn Items
------------------------------------

i(737)
	:Chance (1)
	:SetType "Tier"
	:SetName "Petty"
	:SetColor {255, 182, 193}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Spring"

i(738)
	:Chance (1)
	:SetType "Tier"
	:SetName "Soft"
	:SetColor {175, 238, 238}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Spring"

i(736)
	:Chance (1)
	:SetType "Tier"
	:SetName "Weak"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Spring"


------------------------------------
-- Standard Items
------------------------------------

i(740)
	:Chance (2)
	:SetType "Tier"
	:SetName "Crisp"
	:SetColor {123, 104, 238}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Spring"

i(739)
	:Chance (2)
	:SetType "Tier"
	:SetName "Fair"
	:SetColor {135, 206, 250}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Spring"

i(741)
	:Chance (2)
	:SetType "Tier"
	:SetName "Fresh"
	:SetColor {102, 205, 170}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Spring"

i(742)
	:Chance (2)
	:SetType "Tier"
	:SetName "Pure"
	:SetColor {64, 224, 208}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Spring"

i(775)
	:Chance (2)
	:SetType "Unique"
	:SetName "Trenchinator"
	:SetWeapon "weapon_ttt_m590"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Spring"

i(710)
	:Chance (2)
	:SetType "Special"
	:SetName "Agree Taunt"
	:SetDesc "I concur doctor."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_agree"
	:Set "Spring"

i(715)
	:Chance (2)
	:SetType "Special"
	:SetName "Disagree Taunt"
	:SetDesc "I don't think so."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_disagree"
	:Set "Spring"


------------------------------------
-- Specialized Items
------------------------------------

i(729)
	:Chance (3)
	:SetType "Melee"
	:SetName "A Fish"
	:SetColor {255, 160, 122}
	:SetWeapon "weapon_fish"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -5, -15)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(730)
	:Chance (3)
	:SetType "Melee"
	:SetName "Fists"
	:SetIcon "https://cdn.moat.gg/f/96f183e138d991a720cdebb89f1fd137.png"
	:SetWeapon "weapon_ttt_fists"
	:SetStats (5, 5)
		:Stat ("Firerate", 20, 50)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -10, -20)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(746)
	:Chance (3)
	:SetType "Tier"
	:SetName "Bright"
	:SetColor {199, 21, 133}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Spring"

i(745)
	:Chance (3)
	:SetType "Tier"
	:SetName "Lush"
	:SetColor {154, 205, 50}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Spring"

i(743)
	:Chance (3)
	:SetType "Tier"
	:SetName "Sweet"
	:SetColor {221, 160, 221}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Spring"

i(744)
	:Chance (3)
	:SetType "Tier"
	:SetName "Warm"
	:SetColor {173, 255, 47}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Spring"

i(785)
	:Chance (3)
	:SetType "Unique"
	:SetName "Akimbonators"
	:SetWeapon "weapon_akimbo"
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Spring"

i(773)
	:Chance (3)
	:SetType "Unique"
	:SetName "Alien Poo90"
	:SetWeapon "weapon_rcp120"
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Spring"

i(792)
	:Chance (3)
	:SetType "Unique"
	:SetName "Intruder Killer"
	:SetWeapon "weapon_doubleb"
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Spring"

i(725)
	:Chance (3)
	:SetType "Special"
	:SetName "Smokinator"
	:SetDesc "A smoke grenade that's %s_ more dense than a regular smoke grenade."
	:SetWeapon "weapon_ttt_smokegrenade"
	:SetStats (1, 1)
		:Stat (1, 25, 100)
	:Set "Spring"

i(711)
	:Chance (3)
	:SetType "Special"
	:SetName "Call For Taunt"
	:SetDesc "Come over here please."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_beacon"
	:Set "Spring"

i(712)
	:Chance (3)
	:SetType "Special"
	:SetName "Bow Taunt"
	:SetDesc "Thank you very much, I know I'm awesome."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_bow"
	:Set "Spring"

i(721)
	:Chance (3)
	:SetType "Special"
	:SetName "Salute Taunt"
	:SetDesc "Press F to pay respects."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_salute"
	:Set "Spring"


------------------------------------
-- Superior Items
------------------------------------

i(801)
	:Chance (4)
	:SetType "Melee"
	:SetName "A Sword"
	:SetColor {70, 130, 180}
	:SetWeapon "weapon_pvpsword"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -5, -20)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(734)
	:Chance (4)
	:SetType "Melee"
	:SetName "A Tomahawk"
	:SetColor {47, 79, 79}
	:SetWeapon "weapon_tomahawk"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -5, -15)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(747)
	:Chance (4)
	:SetType "Tier"
	:SetName "Airy"
	:SetColor {0, 191, 255}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(749)
	:Chance (4)
	:SetType "Tier"
	:SetName "Floral"
	:SetColor {144, 238, 144}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(748)
	:Chance (4)
	:SetType "Tier"
	:SetName "Fluffy"
	:SetColor {238, 130, 238}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(750)
	:Chance (4)
	:SetType "Tier"
	:SetName "Joyful"
	:SetColor {147, 112, 219}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(800)
	:Chance (4)
	:SetType "Unique"
	:SetName "Goongsto"
	:SetWeapon "weapon_thompson"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(784)
	:Chance (4)
	:SetType "Unique"
	:SetName "Hedge Shooter"
	:SetWeapon "weapon_spas12pvp"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(778)
	:Chance (4)
	:SetType "Unique"
	:SetName "Semi-Glock-17"
	:SetWeapon "weapon_semiauto"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(780)
	:Chance (4)
	:SetType "Unique"
	:SetName "Space90"
	:SetWeapon "weapon_rcp120"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(770)
	:Chance (4)
	:SetType "Unique"
	:SetName "Trusty Steed"
	:SetWeapon "weapon_supershotty"
	:SetStats (6, 6)
		:Stat ("Firerate", 10, 30)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Spring"

i(701)
	:Chance (4)
	:SetType "Special"
	:SetName "Confusionade"
	:SetDesc "A throwable grenade that discombobulates enimies %s_ more than a regular discombobulator."
	:SetWeapon "weapon_ttt_confgrenade"
	:SetStats (1, 1)
		:Stat (1, 25, 100)
	:Set "Spring"

i(713)
	:Chance (4)
	:SetType "Special"
	:SetName "Cheer Taunt"
	:SetDesc "WOOOOO."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_cheer"
	:Set "Spring"

i(717)
	:Chance (4)
	:SetType "Special"
	:SetName "Hands Up Taunt"
	:SetDesc "Please don't shoot me."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_hands"
	:Set "Spring"

i(723)
	:Chance (4)
	:SetType "Special"
	:SetName "Wave Taunt"
	:SetDesc "Hey Guys."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_wave"
	:Set "Spring"


------------------------------------
-- High-End Items
------------------------------------

i(728)
	:Chance (5)
	:SetType "Melee"
	:SetName "A Diamond Pickaxe"
	:SetColor {0, 255, 255}
	:SetWeapon "weapon_diamond_pick"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -15, -30)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(735)
	:Chance (5)
	:SetType "Melee"
	:SetName "A Toy Hammer"
	:SetWeapon "weapon_toy_hammer"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -5, -15)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(754)
	:Chance (5)
	:SetType "Tier"
	:SetName "Blissful"
	:SetColor {200, 200, 0}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(751)
	:Chance (5)
	:SetType "Tier"
	:SetName "Blooming"
	:SetColor {220, 20, 60}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(753)
	:Chance (5)
	:SetType "Tier"
	:SetName "Energized"
	:SetColor {65, 105, 225}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(752)
	:Chance (5)
	:SetType "Tier"
	:SetName "Vibrant"
	:SetColor {255, 105, 180}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(776)
	:Chance (5)
	:SetType "Unique"
	:SetName "Akimbonitos"
	:SetWeapon "weapon_akimbo"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(771)
	:Chance (5)
	:SetType "Unique"
	:SetName "The Patriot"
	:SetWeapon "weapon_patriot"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(772)
	:Chance (5)
	:SetType "Unique"
	:SetName "Raginator"
	:SetWeapon "weapon_ragingbull"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(793)
	:Chance (5)
	:SetType "Unique"
	:SetName "Stealthano"
	:SetWeapon "weapon_sp"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Spring"

i(805)
	:Chance (5)
	:SetType "Special"
	:SetName "Angry Shoe"
	:SetDesc "A shoe you can annoy and distract enimes with."
	:SetWeapon "weapon_angryhobo"
	:Set "Spring"

i(726)
	:Chance (5)
	:SetType "Special"
	:SetName "Molotovian"
	:SetDesc "A molotov grenade that lasts %s_ longer than a regular molotov grenade.."
	:SetWeapon "weapon_zm_molotov"
	:SetStats (1, 1)
		:Stat (1, 25, 100)
	:Set "Spring"

i(716)
	:Chance (5)
	:SetType "Special"
	:SetName "Flail Taunt"
	:SetDesc "Asdfghjkl;'."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_flail"
	:Set "Spring"

i(718)
	:Chance (5)
	:SetType "Special"
	:SetName "Laugh Taunt"
	:SetDesc "haHA."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_laugh"
	:Set "Spring"

i(808)
	:Chance (5)
	:SetType "Special"
	:SetName "Dynamite"
	:SetDesc "A throwable set of TNT that detonates a few seconds after being thrown."
	:SetWeapon "weapon_virustnt"
	:Set "Spring"


------------------------------------
-- Ascended Items
------------------------------------

i(731)
	:Chance (6)
	:SetType "Melee"
	:SetName "A Katana"
	:SetWeapon "weapon_katana"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -20, -30)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(733)
	:Chance (6)
	:SetType "Melee"
	:SetName "A Diamond Sword"
	:SetColor {0, 255, 255}
	:SetWeapon "weapon_diamond_sword"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -20, -30)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(802)
	:Chance (6)
	:SetType "Melee"
	:SetName "A Smart Pen"
	:SetWeapon "weapon_smartpen"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Damage", 15, 35)
		:Stat ("Weight", -20, -30)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(757)
	:Chance (6)
	:SetType "Tier"
	:SetName "Flourishing"
	:SetColor {255, 20, 147}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(755)
	:Chance (6)
	:SetType "Tier"
	:SetName "Heavenly"
	:SetColor {255, 215, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(756)
	:Chance (6)
	:SetType "Tier"
	:SetName "Spectacular"
	:SetColor {0, 255, 127}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(758)
	:Chance (6)
	:SetType "Tier"
	:SetName "Sunny"
	:SetColor {255, 255, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(782)
	:Chance (6)
	:SetType "Unique"
	:SetName "Bond's Double Friend"
	:SetWeapon "weapon_virussil"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(804)
	:Chance (6)
	:SetType "Unique"
	:SetName "Compactachi"
	:SetWeapon "weapon_xm8b"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(789)
	:Chance (6)
	:SetType "Unique"
	:SetName "DBMonster"
	:SetWeapon "weapon_doubleb"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(779)
	:Chance (6)
	:SetType "Unique"
	:SetName "Executioner"
	:SetWeapon "weapon_flakgun"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Spring"

i(806)
	:Chance (6)
	:SetType "Special"
	:SetName "Babynade"
	:SetDesc "A throwable baby that explodes like dynamite."
	:SetWeapon "weapon_babynade"
	:Set "Spring"

i(719)
	:Chance (6)
	:SetType "Special"
	:SetName "Play Dead Taunt"
	:SetDesc "Too bad you don't get a treat for this one diggity dog."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_lay"
	:Set "Spring"

i(720)
	:Chance (6)
	:SetType "Special"
	:SetName "Robot Taunt"
	:SetDesc "Beep boop beep bop beep."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_robot"
	:Set "Spring"


------------------------------------
-- Cosmic Items
------------------------------------

i(732)
	:Chance (7)
	:SetType "Melee"
	:SetName "A Lightsaber"
	:SetWeapon "weapon_light_saber"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -20, -35)
		:Stat ("Pushrate", 5, 10)
	:Set "Spring"

i(761)
	:Chance (7)
	:SetType "Tier"
	:SetName "Cloudless"
	:SetColor {0, 191, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Spring"

i(759)
	:Chance (7)
	:SetType "Tier"
	:SetName "Incredible"
	:SetColor {255, 0, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Spring"

i(760)
	:Chance (7)
	:SetType "Tier"
	:SetName "Stunning"
	:SetColor {148, 0, 211}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Spring"

i(774)
	:Chance (7)
	:SetType "Unique"
	:SetName "Bond's Worst Friend"
	:SetWeapon "weapon_golden_revolver"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Spring"

i(783)
	:Chance (7)
	:SetType "Unique"
	:SetName "Nintendo Switchpa"
	:SetWeapon "weapon_zapperpvp"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Spring"

i(790)
	:Chance (7)
	:SetType "Unique"
	:SetName "Spasinator"
	:SetWeapon "weapon_spas12pvp"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Spring"

i(807)
	:Chance (7)
	:SetType "Special"
	:SetName "Stealth Box"
	:SetDesc "A box you can use to hide from enimes. Crouching makes the box completely still."
	:SetWeapon "weapon_stealthbox"
	:Set "Spring"

i(714)
	:Chance (7)
	:SetType "Special"
	:SetName "Dab Taunt"
	:SetDesc "Hit em with it."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_dab"
	:Set "Spring"

i(722)
	:Chance (7)
	:SetType "Special"
	:SetName "Sexy Taunt"
	:SetDesc "Work that big booty of yours you sexy thang."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_sexy"
	:Set "Spring"

i(724)
	:Chance (7)
	:SetType "Special"
	:SetName "Zombie Climb Taunt"
	:SetDesc "Best dance move eva."
	:SetIcon "https://cdn.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
	:SetWeapon "weapon_ttt_taunt_climb"
	:Set "Spring"





------------------------------------
--
-- Space Collection
--
------------------------------------


------------------------------------
-- Ascended Items
------------------------------------

i(769)
	:Chance (6)
	:SetType "Unique"
	:SetName "The Gauntlet"
	:SetWeapon "weapon_ttt_te_deagle"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", -10, -1)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 15, 25)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (3, 3)
		:SetTalent (1, "Space")
		:SetTalent (2, "Reality")
		:SetTalent (3, "Power Stone")
	:Set "Space"





------------------------------------
--
-- Shouldn't be in inventory
--
------------------------------------

i(969)
	:Chance (8)
	:SetType "Special"
	:SetName "A Random Vape"
	:SetDesc "Shouldn't be in inventory."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_ttt_unarmed"
	:SetShop (64999, false)
	:Set "Shouldn't be in inventory"





------------------------------------
--
-- Santa's Collection
--
------------------------------------

i(7101)
	:Chance (8)
	:SetType "Usable"
	:SetName "Santa's Present"
	:SetDesc "Every player will receive a Holiday Crate when this item is used."
	:SetIcon "https://cdn.moat.gg/f/gift_usable64.png"
	:SetShop (50000, false)
	:Set "Santa's"





------------------------------------
--
-- Pumpkin Collection
--
------------------------------------

i(2001)
	:Chance (8)
	:SetType "Crate"
	:SetName "Pumpkin Crate"
	:SetDesc "This crate contains an item from the Pumpkin Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/pumpkin64.png"
	:SetShop (50000, false)
	:Set "Pumpkin"


------------------------------------
-- Extinct Items
------------------------------------

i(5136)
	:Chance (8)
	:SetType "Tier"
	:SetName "Scary"
	:SetColor {255, 0, 0}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Pumpkin"

i(5137)
	:Chance (8)
	:SetType "Tier"
	:SetName "Creepy"
	:SetColor {255, 0, 0}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Pumpkin"

i(5138)
	:Chance (8)
	:SetType "Tier"
	:SetName "Haunting"
	:SetColor {255, 0, 0}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Pumpkin"

i(5139)
	:Chance (8)
	:SetType "Tier"
	:SetName "Mystical"
	:SetColor {255, 0, 0}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Pumpkin"

i(5140)
	:Chance (8)
	:SetType "Tier"
	:SetName "Moonlit"
	:SetColor {255, 0, 0}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Pumpkin"

i(5141)
	:Chance (8)
	:SetType "Tier"
	:SetName "Startling"
	:SetColor {255, 0, 0}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Pumpkin"

i(5142)
	:Chance (8)
	:SetType "Tier"
	:SetName "Bloody"
	:SetColor {255, 0, 0}
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Pumpkin"

i(5143)
	:Chance (8)
	:SetType "Tier"
	:SetName "Ghostly"
	:SetColor {255, 255, 0}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Pumpkin"

i(5144)
	:Chance (8)
	:SetType "Tier"
	:SetName "Spooky"
	:SetColor {255, 255, 0}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Pumpkin"

i(5145)
	:Chance (8)
	:SetType "Tier"
	:SetName "Undead"
	:SetColor {255, 255, 0}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Pumpkin"

i(5146)
	:Chance (8)
	:SetType "Tier"
	:SetName "Ghoulish"
	:SetColor {255, 255, 0}
	:SetEffect "glow"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Pumpkin"

i(5147)
	:Chance (8)
	:SetType "Tier"
	:SetName "Spooktacular"
	:SetColor {0, 255, 0}
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "Pumpkin"

i(5148)
	:Chance (8)
	:SetType "Tier"
	:SetName "Supernatural"
	:SetColor {0, 255, 0}
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "Pumpkin"

i(5149)
	:Chance (8)
	:SetType "Tier"
	:SetName "Boo-Tiful"
	:SetColor {0, 255, 255}
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Pumpkin"

i(5134)
	:Chance (8)
	:SetType "Model"
	:SetName "Halloween King Model"
	:SetDesc "Truely the king of halloween, so let's party bitches."
	:SetModel "models/player/zack/zackhalloween.mdl"
	:Set "Pumpkin"

i(5135)
	:Chance (8)
	:SetType "Model"
	:SetName "Scream Model"
	:SetDesc "Please do not scream as loud as you can when wearing this model."
	:SetModel "models/player/screamplayermodel/scream/scream.mdl"
	:Set "Pumpkin"

i(5101)
	:Chance (8)
	:SetType "Mask"
	:SetName "Evil Clown Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/evil_clown.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5102)
	:Chance (8)
	:SetType "Mask"
	:SetName "Boar Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_boar.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5103)
	:Chance (8)
	:SetType "Mask"
	:SetName "White Bunny Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_bunny.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5104)
	:Chance (8)
	:SetType "Mask"
	:SetName "Gold Bunny Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_bunny_gold.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5105)
	:Chance (8)
	:SetType "Mask"
	:SetName "Chicken Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_chicken.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5106)
	:Chance (8)
	:SetType "Mask"
	:SetName "Devil Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_devil_plastic.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5107)
	:Chance (8)
	:SetType "Mask"
	:SetName "Blue Doll Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_porcelain_doll_kabuki.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5108)
	:Chance (8)
	:SetType "Mask"
	:SetName "Pumpkin Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_pumpkin.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5109)
	:Chance (8)
	:SetType "Mask"
	:SetName "Samurai Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_samurai.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5110)
	:Chance (8)
	:SetType "Mask"
	:SetName "Bloody Sheep Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_sheep_bloody.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5111)
	:Chance (8)
	:SetType "Mask"
	:SetName "Gold Sheep Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_sheep_gold.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5112)
	:Chance (8)
	:SetType "Mask"
	:SetName "Sheep Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_sheep_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5113)
	:Chance (8)
	:SetType "Mask"
	:SetName "Skull Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_skull.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5114)
	:Chance (8)
	:SetType "Mask"
	:SetName "Gold Skull Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_skull_gold.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5115)
	:Chance (8)
	:SetType "Mask"
	:SetName "Target Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_template.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5116)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Demo Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_demo_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5117)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Engineer Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_engi_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5118)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Heavy Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_heavy_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5119)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Medic Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_medic_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5120)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Pyro Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_pyro_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5121)
	:Chance (8)
	:SetType "Mask"
	:SetName "Chains Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_chains.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5122)
	:Chance (8)
	:SetType "Mask"
	:SetName "Dallas Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_dallas.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5123)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Scout Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_scout_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5124)
	:Chance (8)
	:SetType "Mask"
	:SetName "Hoxton Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_hoxton.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5125)
	:Chance (8)
	:SetType "Mask"
	:SetName "Wolf Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_wolf.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5133)
	:Chance (8)
	:SetType "Mask"
	:SetName "Pumpkin Head"
	:SetDesc "An exclusive head mask from the Pumpkin Event."
	:SetModel "models/gmod_tower/halloween_pumpkinhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.875, 0)
		pos = pos + (ang:Forward() * -3.1) + (ang:Up() * -7.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5126)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Sniper Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_sniper_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5127)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Soldier Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_soldier_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5128)
	:Chance (8)
	:SetType "Mask"
	:SetName "TF2 Spy Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tf2_spy_model.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5129)
	:Chance (8)
	:SetType "Mask"
	:SetName "Tiki Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_tiki.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5130)
	:Chance (8)
	:SetType "Mask"
	:SetName "Zombie Fortune Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/facemask_zombie_fortune_plastic.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(5131)
	:Chance (8)
	:SetType "Mask"
	:SetName "Doll Facemask"
	:SetDesc "An exclusive face mask from the Pumpkin Event."
	:SetModel "models/player/holiday/facemasks/porcelain_doll.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.225, 0)
		pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Pumpkin"

i(6257)
	:Chance (8)
	:SetType "Skin"
	:SetName "Deep Journey Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/47.png"
	:Set "Pumpkin"

i(6273)
	:Chance (8)
	:SetType "Skin"
	:SetName "Parallel Cosmos Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/23.png"
	:Set "Pumpkin"

i(6289)
	:Chance (8)
	:SetType "Skin"
	:SetName "Untouched Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/20.png"
	:Set "Pumpkin"

i(6258)
	:Chance (8)
	:SetType "Skin"
	:SetName "Deluded Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/16.png"
	:Set "Pumpkin"

i(6290)
	:Chance (8)
	:SetType "Skin"
	:SetName "Vibestrus Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/33.png"
	:Set "Pumpkin"

i(6259)
	:Chance (8)
	:SetType "Skin"
	:SetName "Driptina Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/24.png"
	:Set "Pumpkin"

i(6291)
	:Chance (8)
	:SetType "Skin"
	:SetName "Wavelength Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/31.png"
	:Set "Pumpkin"

i(6260)
	:Chance (8)
	:SetType "Skin"
	:SetName "Eighteye Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/11.png"
	:Set "Pumpkin"

i(6276)
	:Chance (8)
	:SetType "Skin"
	:SetName "Pringle Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/7.png"
	:Set "Pumpkin"

i(6292)
	:Chance (8)
	:SetType "Skin"
	:SetName "Witchpink Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/9.png"
	:Set "Pumpkin"

i(6261)
	:Chance (8)
	:SetType "Skin"
	:SetName "Factorion Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/46.png"
	:Set "Pumpkin"

i(6277)
	:Chance (8)
	:SetType "Skin"
	:SetName "Pumpzag Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/6.png"
	:Set "Pumpkin"

i(6293)
	:Chance (8)
	:SetType "Skin"
	:SetName "Zygzag Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/28.png"
	:Set "Pumpkin"

i(6262)
	:Chance (8)
	:SetType "Skin"
	:SetName "Felice Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/45.png"
	:Set "Pumpkin"

i(6247)
	:Chance (8)
	:SetType "Skin"
	:SetName "Acid Crater Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/34.png"
	:Set "Pumpkin"

i(6263)
	:Chance (8)
	:SetType "Skin"
	:SetName "Gatsby Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/37.png"
	:Set "Pumpkin"

i(6279)
	:Chance (8)
	:SetType "Skin"
	:SetName "Purpendicular Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/26.png"
	:Set "Pumpkin"

i(6248)
	:Chance (8)
	:SetType "Skin"
	:SetName "Alduinity Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/14.png"
	:Set "Pumpkin"

i(6264)
	:Chance (8)
	:SetType "Skin"
	:SetName "Granbow Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/30.png"
	:Set "Pumpkin"

i(6280)
	:Chance (8)
	:SetType "Skin"
	:SetName "Quantum Realm Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/21.png"
	:Set "Pumpkin"

i(6249)
	:Chance (8)
	:SetType "Skin"
	:SetName "Archaic Arcade Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/8.png"
	:Set "Pumpkin"

i(6265)
	:Chance (8)
	:SetType "Skin"
	:SetName "Heavens Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/35.png"
	:Set "Pumpkin"

i(6281)
	:Chance (8)
	:SetType "Skin"
	:SetName "Rajah Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/44.png"
	:Set "Pumpkin"

i(6250)
	:Chance (8)
	:SetType "Skin"
	:SetName "Burple Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/25.png"
	:Set "Pumpkin"

i(6266)
	:Chance (8)
	:SetType "Skin"
	:SetName "Hellbolt Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/29.png"
	:Set "Pumpkin"

i(6251)
	:Chance (8)
	:SetType "Skin"
	:SetName "Californication Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/41.png"
	:Set "Pumpkin"

i(6267)
	:Chance (8)
	:SetType "Skin"
	:SetName "Krakatoa Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/15.png"
	:Set "Pumpkin"

i(6283)
	:Chance (8)
	:SetType "Skin"
	:SetName "Rygan Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/43.png"
	:Set "Pumpkin"

i(6252)
	:Chance (8)
	:SetType "Skin"
	:SetName "Candypot Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/5.png"
	:Set "Pumpkin"

i(6268)
	:Chance (8)
	:SetType "Skin"
	:SetName "Lost In Divine Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/19.png"
	:Set "Pumpkin"

i(6284)
	:Chance (8)
	:SetType "Skin"
	:SetName "Splatter Space Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/18.png"
	:Set "Pumpkin"

i(6253)
	:Chance (8)
	:SetType "Skin"
	:SetName "Choropleth Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/39.png"
	:Set "Pumpkin"

i(6269)
	:Chance (8)
	:SetType "Skin"
	:SetName "Matrix Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/32.png"
	:Set "Pumpkin"

i(6285)
	:Chance (8)
	:SetType "Skin"
	:SetName "Stained Glass Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/42.png"
	:Set "Pumpkin"

i(6254)
	:Chance (8)
	:SetType "Skin"
	:SetName "Cuddly Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/12.png"
	:Set "Pumpkin"

i(6270)
	:Chance (8)
	:SetType "Skin"
	:SetName "Neuralite Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/3.png"
	:Set "Pumpkin"

i(6286)
	:Chance (8)
	:SetType "Skin"
	:SetName "Tiki Oasis Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2.png"
	:Set "Pumpkin"

i(6255)
	:Chance (8)
	:SetType "Skin"
	:SetName "Cyter Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/17.png"
	:Set "Pumpkin"

i(6271)
	:Chance (8)
	:SetType "Skin"
	:SetName "Nightmare Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/36.png"
	:Set "Pumpkin"

i(6287)
	:Chance (8)
	:SetType "Skin"
	:SetName "Trilogy Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/22.png"
	:Set "Pumpkin"

i(6256)
	:Chance (8)
	:SetType "Skin"
	:SetName "Daydream Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/27.png"
	:Set "Pumpkin"

i(6272)
	:Chance (8)
	:SetType "Skin"
	:SetName "ŌKami Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/38.png"
	:Set "Pumpkin"

i(6282)
	:Chance (8)
	:SetType "Skin"
	:SetName "Reppit Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1.png"
	:Set "Pumpkin"

i(6278)
	:Chance (8)
	:SetType "Skin"
	:SetName "Pupa Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/4.png"
	:Set "Pumpkin"

i(6275)
	:Chance (8)
	:SetType "Skin"
	:SetName "Phoenix Feather Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/13.png"
	:Set "Pumpkin"

i(6274)
	:Chance (8)
	:SetType "Skin"
	:SetName "Party City Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/10.png"
	:Set "Pumpkin"

i(6288)
	:Chance (8)
	:SetType "Skin"
	:SetName "Ultrabeam Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/40.png"
	:Set "Pumpkin"





------------------------------------
--
-- Paint Collection
--
------------------------------------

i(6000)
	:Chance (3)
	:SetType "Crate"
	:SetName "Paint Crate"
	:SetDesc "This crate contains an item from the Paint Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/paint64.png"
	:SetShop (1400, true)
	:Set "Paint"


------------------------------------
-- Specialized Items
------------------------------------

i(6017)
	:Chance (3)
	:SetType "Tint"
	:SetName "Detox Purple Tint"
	:SetColor {157, 153, 188}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6049)
	:Chance (3)
	:SetType "Tint"
	:SetName "Pure Orange Tint"
	:SetColor {100, 60, 0}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6002)
	:Chance (3)
	:SetType "Tint"
	:SetName "Joker Green Tint"
	:SetColor {2, 153, 57}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6018)
	:Chance (3)
	:SetType "Tint"
	:SetName "Glossy Green Tint"
	:SetColor {0, 70, 0}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6050)
	:Chance (3)
	:SetType "Tint"
	:SetName "Very Soft Pink Tint"
	:SetColor {97, 69, 72}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6047)
	:Chance (3)
	:SetType "Tint"
	:SetName "Electric Lime Tint"
	:SetColor {80, 100, 0}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6045)
	:Chance (3)
	:SetType "Tint"
	:SetName "Glycerine Green Tint"
	:SetColor {3, 51, 9}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6042)
	:Chance (3)
	:SetType "Tint"
	:SetName "Serpentine Green Tint"
	:SetColor {64, 124, 132}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6040)
	:Chance (3)
	:SetType "Tint"
	:SetName "Chameleon Green Tint"
	:SetColor {0, 43, 21}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6039)
	:Chance (3)
	:SetType "Tint"
	:SetName "Bleak Banana Tint"
	:SetColor {236, 255, 140}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6051)
	:Chance (3)
	:SetType "Tint"
	:SetName "New Lime Tint"
	:SetColor {3, 39, 15}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6004)
	:Chance (3)
	:SetType "Tint"
	:SetName "Bleek Banana Tint"
	:SetColor {236, 255, 140}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6030)
	:Chance (3)
	:SetType "Tint"
	:SetName "Dr. Pepper Red Tint"
	:SetColor {153, 34, 34}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6029)
	:Chance (3)
	:SetType "Tint"
	:SetName "Monster Energy Neon Green Tint"
	:SetColor {51, 255, 153}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6028)
	:Chance (3)
	:SetType "Tint"
	:SetName "Red Bull Blue Tint"
	:SetColor {51, 51, 153}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6025)
	:Chance (3)
	:SetType "Tint"
	:SetName "Deep Red Tint"
	:SetColor {229, 14, 6}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6032)
	:Chance (3)
	:SetType "Tint"
	:SetName "Electric Lime Tint"
	:SetColor {206, 250, 5}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6006)
	:Chance (3)
	:SetType "Tint"
	:SetName "Magnetic Blue Tint"
	:SetColor {73, 76, 153}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6033)
	:Chance (3)
	:SetType "Tint"
	:SetName "Blazing Blue Tint"
	:SetColor {44, 117, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6087)
	:Chance (3)
	:SetType "Paint"
	:SetName "Monster Energy Neon Green Paint"
	:SetColor {51, 255, 153}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6100)
	:Chance (3)
	:SetType "Paint"
	:SetName "Serpentine Green Paint"
	:SetColor {64, 124, 132}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6098)
	:Chance (3)
	:SetType "Paint"
	:SetName "Chameleon Green Paint"
	:SetColor {0, 43, 21}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6062)
	:Chance (3)
	:SetType "Paint"
	:SetName "Bleek Banana Paint"
	:SetColor {236, 255, 140}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6109)
	:Chance (3)
	:SetType "Paint"
	:SetName "New Lime Paint"
	:SetColor {3, 39, 15}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6108)
	:Chance (3)
	:SetType "Paint"
	:SetName "Very Soft Pink Paint"
	:SetColor {97, 69, 72}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6107)
	:Chance (3)
	:SetType "Paint"
	:SetName "Pure Orange Paint"
	:SetColor {100, 60, 0}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6105)
	:Chance (3)
	:SetType "Paint"
	:SetName "Electric Lime Paint"
	:SetColor {80, 100, 0}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6103)
	:Chance (3)
	:SetType "Paint"
	:SetName "Glycerine Green Paint"
	:SetColor {3, 51, 9}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6083)
	:Chance (3)
	:SetType "Paint"
	:SetName "Deep Red Paint"
	:SetColor {229, 14, 6}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6091)
	:Chance (3)
	:SetType "Paint"
	:SetName "Blazing Blue Paint"
	:SetColor {44, 117, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6090)
	:Chance (3)
	:SetType "Paint"
	:SetName "Electric Lime Paint"
	:SetColor {206, 250, 5}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6088)
	:Chance (3)
	:SetType "Paint"
	:SetName "Dr. Pepper Red Paint"
	:SetColor {153, 34, 34}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6086)
	:Chance (3)
	:SetType "Paint"
	:SetName "Red Bull Blue Paint"
	:SetColor {51, 51, 153}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6064)
	:Chance (3)
	:SetType "Paint"
	:SetName "Magnetic Blue Paint"
	:SetColor {73, 76, 153}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6060)
	:Chance (3)
	:SetType "Paint"
	:SetName "Joker Green Paint"
	:SetColor {2, 153, 57}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6076)
	:Chance (3)
	:SetType "Paint"
	:SetName "Glossy Green Paint"
	:SetColor {0, 70, 0}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6075)
	:Chance (3)
	:SetType "Paint"
	:SetName "Detox Purple Paint"
	:SetColor {157, 153, 188}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6097)
	:Chance (3)
	:SetType "Paint"
	:SetName "Bleak Banana Paint"
	:SetColor {236, 255, 140}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"


------------------------------------
-- Superior Items
------------------------------------

i(6056)
	:Chance (4)
	:SetType "Tint"
	:SetName "Neon Lime Tint"
	:SetColor {0, 150, 45}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6054)
	:Chance (4)
	:SetType "Tint"
	:SetName "Light Teal Tint"
	:SetColor {103, 186, 181}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6034)
	:Chance (4)
	:SetType "Tint"
	:SetName "Sunshine Orange Tint"
	:SetColor {255, 65, 5}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6052)
	:Chance (4)
	:SetType "Tint"
	:SetName "Brown Town Tint"
	:SetColor {39, 15, 3}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6037)
	:Chance (4)
	:SetType "Tint"
	:SetName "Lazer Blue Tint"
	:SetColor {0, 15, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6043)
	:Chance (4)
	:SetType "Tint"
	:SetName "Menacing Red Tint"
	:SetColor {52, 0, 17}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6041)
	:Chance (4)
	:SetType "Tint"
	:SetName "Perpiling Purple Tint"
	:SetColor {140, 138, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6005)
	:Chance (4)
	:SetType "Tint"
	:SetName "Water Melon Tint"
	:SetColor {187, 235, 42}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6031)
	:Chance (4)
	:SetType "Tint"
	:SetName "Razer Green Tint"
	:SetColor {71, 225, 12}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6027)
	:Chance (4)
	:SetType "Tint"
	:SetName "Freeze Green Tint"
	:SetColor {140, 255, 50}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6026)
	:Chance (4)
	:SetType "Tint"
	:SetName "Flueorescent Blue Tint"
	:SetColor {5, 193, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6013)
	:Chance (4)
	:SetType "Tint"
	:SetName "Neon Green Tint"
	:SetColor {5, 193, 25}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6009)
	:Chance (4)
	:SetType "Tint"
	:SetName "Bright Purple Tint"
	:SetColor {96, 62, 148}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6007)
	:Chance (4)
	:SetType "Tint"
	:SetName "Aqua Blue Tint"
	:SetColor {66, 208, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6065)
	:Chance (4)
	:SetType "Paint"
	:SetName "Aqua Blue Paint"
	:SetColor {66, 208, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6085)
	:Chance (4)
	:SetType "Paint"
	:SetName "Freeze Green Paint"
	:SetColor {140, 255, 50}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6114)
	:Chance (4)
	:SetType "Paint"
	:SetName "Neon Lime Paint"
	:SetColor {0, 150, 45}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6110)
	:Chance (4)
	:SetType "Paint"
	:SetName "Brown Town Paint"
	:SetColor {39, 15, 3}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6099)
	:Chance (4)
	:SetType "Paint"
	:SetName "Perpiling Purple Paint"
	:SetColor {140, 138, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6101)
	:Chance (4)
	:SetType "Paint"
	:SetName "Menacing Red Paint"
	:SetColor {52, 0, 17}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6071)
	:Chance (4)
	:SetType "Paint"
	:SetName "Neon Green Paint"
	:SetColor {5, 193, 25}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6067)
	:Chance (4)
	:SetType "Paint"
	:SetName "Bright Purple Paint"
	:SetColor {96, 62, 148}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6095)
	:Chance (4)
	:SetType "Paint"
	:SetName "Lazer Blue Paint"
	:SetColor {0, 15, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6092)
	:Chance (4)
	:SetType "Paint"
	:SetName "Sunshine Orange Paint"
	:SetColor {255, 65, 5}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6089)
	:Chance (4)
	:SetType "Paint"
	:SetName "Razer Green Paint"
	:SetColor {71, 225, 12}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6112)
	:Chance (4)
	:SetType "Paint"
	:SetName "Light Teal Paint"
	:SetColor {103, 186, 181}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6084)
	:Chance (4)
	:SetType "Paint"
	:SetName "Flueorescent Blue Paint"
	:SetColor {5, 193, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6063)
	:Chance (4)
	:SetType "Paint"
	:SetName "Water Melon Paint"
	:SetColor {187, 235, 42}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"


------------------------------------
-- High-End Items
------------------------------------

i(6055)
	:Chance (5)
	:SetType "Tint"
	:SetName "Neon Mint Tint"
	:SetColor {0, 204, 120}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6053)
	:Chance (5)
	:SetType "Tint"
	:SetName "Nardo Grey Tint"
	:SetColor {104, 106, 118}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6003)
	:Chance (5)
	:SetType "Tint"
	:SetName "Pindel Pink Tint"
	:SetColor {247, 136, 206}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6046)
	:Chance (5)
	:SetType "Tint"
	:SetName "Corrosive Green Tint"
	:SetColor {132, 255, 10}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6044)
	:Chance (5)
	:SetType "Tint"
	:SetName "Creamsicle Orange Tint"
	:SetColor {242, 80, 32}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6035)
	:Chance (5)
	:SetType "Tint"
	:SetName "Electric Indigo Tint"
	:SetColor {111, 0, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6019)
	:Chance (5)
	:SetType "Tint"
	:SetName "Sky Blue Tint"
	:SetColor {127, 200, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6038)
	:Chance (5)
	:SetType "Tint"
	:SetName "Neon Aqua Blue Tint"
	:SetColor {123, 255, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6048)
	:Chance (5)
	:SetType "Tint"
	:SetName "Deep Pink Tint"
	:SetColor {100, 0, 40}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6012)
	:Chance (5)
	:SetType "Tint"
	:SetName "Turkey Stuffer Green Tint"
	:SetColor {22, 161, 18}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6010)
	:Chance (5)
	:SetType "Tint"
	:SetName "Neon Pink Tint"
	:SetColor {255, 105, 180}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6061)
	:Chance (5)
	:SetType "Paint"
	:SetName "Pindel Pink Paint"
	:SetColor {247, 136, 206}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6068)
	:Chance (5)
	:SetType "Paint"
	:SetName "Neon Pink Paint"
	:SetColor {255, 105, 180}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6111)
	:Chance (5)
	:SetType "Paint"
	:SetName "Nardo Grey Paint"
	:SetColor {104, 106, 118}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6106)
	:Chance (5)
	:SetType "Paint"
	:SetName "Deep Pink Paint"
	:SetColor {100, 0, 40}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6104)
	:Chance (5)
	:SetType "Paint"
	:SetName "Corrosive Green Paint"
	:SetColor {132, 255, 10}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6102)
	:Chance (5)
	:SetType "Paint"
	:SetName "Creamsicle Orange Paint"
	:SetColor {242, 80, 32}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6093)
	:Chance (5)
	:SetType "Paint"
	:SetName "Electric Indigo Paint"
	:SetColor {111, 0, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6096)
	:Chance (5)
	:SetType "Paint"
	:SetName "Neon Aqua Blue Paint"
	:SetColor {123, 255, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6070)
	:Chance (5)
	:SetType "Paint"
	:SetName "Turkey Stuffer Green Paint"
	:SetColor {22, 161, 18}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6077)
	:Chance (5)
	:SetType "Paint"
	:SetName "Sky Blue Paint"
	:SetColor {127, 200, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6113)
	:Chance (5)
	:SetType "Paint"
	:SetName "Neon Mint Paint"
	:SetColor {0, 204, 120}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"


------------------------------------
-- Ascended Items
------------------------------------

i(6057)
	:Chance (6)
	:SetType "Tint"
	:SetName "Pure White Tint"
	:SetColor {255, 255, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6021)
	:Chance (6)
	:SetType "Tint"
	:SetName "Pure Black Tint"
	:SetColor {0, 0, 0}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6036)
	:Chance (6)
	:SetType "Tint"
	:SetName "American Rose Tint"
	:SetColor {255, 3, 62}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6023)
	:Chance (6)
	:SetType "Tint"
	:SetName "Bright Orange Tint"
	:SetColor {251, 86, 4}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6024)
	:Chance (6)
	:SetType "Tint"
	:SetName "Cotton Candy Pink Tint"
	:SetColor {249, 82, 107}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6022)
	:Chance (6)
	:SetType "Tint"
	:SetName "Sharpe Yellow Tint"
	:SetColor {255, 255, 1}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6020)
	:Chance (6)
	:SetType "Tint"
	:SetName "Neon Sky Blue Tint"
	:SetColor {123, 255, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6001)
	:Chance (6)
	:SetType "Tint"
	:SetName "Mint Green Tint"
	:SetColor {3, 255, 171}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6014)
	:Chance (6)
	:SetType "Tint"
	:SetName "Neon Purple Tint"
	:SetColor {27, 29, 163}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6008)
	:Chance (6)
	:SetType "Tint"
	:SetName "Toxic Yellow Tint"
	:SetColor {221, 225, 3}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6082)
	:Chance (6)
	:SetType "Paint"
	:SetName "Cotton Candy Pink Paint"
	:SetColor {249, 82, 107}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6066)
	:Chance (6)
	:SetType "Paint"
	:SetName "Toxic Yellow Paint"
	:SetColor {221, 225, 3}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6115)
	:Chance (6)
	:SetType "Paint"
	:SetName "Pure White Paint"
	:SetColor {255, 255, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6059)
	:Chance (6)
	:SetType "Paint"
	:SetName "Mint Green Paint"
	:SetColor {3, 255, 171}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6094)
	:Chance (6)
	:SetType "Paint"
	:SetName "American Rose Paint"
	:SetColor {255, 3, 62}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6080)
	:Chance (6)
	:SetType "Paint"
	:SetName "Sharpe Yellow Paint"
	:SetColor {255, 255, 1}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6079)
	:Chance (6)
	:SetType "Paint"
	:SetName "Pure Black Paint"
	:SetColor {0, 0, 0}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6078)
	:Chance (6)
	:SetType "Paint"
	:SetName "Neon Sky Blue Paint"
	:SetColor {123, 255, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6072)
	:Chance (6)
	:SetType "Paint"
	:SetName "Neon Purple Paint"
	:SetColor {27, 29, 163}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6081)
	:Chance (6)
	:SetType "Paint"
	:SetName "Bright Orange Paint"
	:SetColor {251, 86, 4}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"


------------------------------------
-- Cosmic Items
------------------------------------

i(6058)
	:Chance (7)
	:SetType "Tint"
	:SetName "George's Surprise Tint"
	:SetColor {115, 34, 136}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6016)
	:Chance (7)
	:SetType "Tint"
	:SetName "Hot Pink Tint"
	:SetColor {255, 105, 180}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6015)
	:Chance (7)
	:SetType "Tint"
	:SetName "Dark Gold Chrome Tint"
	:SetColor {251, 184, 41}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6011)
	:Chance (7)
	:SetType "Tint"
	:SetName "Bright Gold Tint"
	:SetColor {227, 190, 70}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
	:Set "Paint"

i(6116)
	:Chance (7)
	:SetType "Paint"
	:SetName "George's Surprise Paint"
	:SetColor {115, 34, 136}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6074)
	:Chance (7)
	:SetType "Paint"
	:SetName "Hot Pink Paint"
	:SetColor {255, 105, 180}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6073)
	:Chance (7)
	:SetType "Paint"
	:SetName "Dark Gold Chrome Paint"
	:SetColor {251, 184, 41}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6069)
	:Chance (7)
	:SetType "Paint"
	:SetName "Bright Gold Paint"
	:SetColor {227, 190, 70}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
	:Set "Paint"

i(6117)
	:Chance (7)
	:SetType "Skin"
	:SetName "Flesh Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/63853522385224562742.png"
	:Set "Paint"


------------------------------------
-- Planetary Items
------------------------------------

i(6566)
	:Chance (9)
	:SetType "Tint"
	:SetName "Infinity Tint"
	:SetColor {255, 255, 255}
	:SetDesc "Right click this tint to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/57731eec78594998cdfecf618fdb3cad.png"
	:Set "Paint"

i(6565)
	:Chance (9)
	:SetType "Paint"
	:SetName "Infinity Paint"
	:SetColor {255, 255, 255}
	:SetDesc "Right click this paint to use it on an item."
	:SetIcon "https://cdn.moat.gg/f/57731eec78594998cdfecf618fdb3cad.png"
	:Set "Paint"





------------------------------------
--
-- New Years Collection
--
------------------------------------


------------------------------------
-- Planetary Items
------------------------------------

i(6666)
	:Chance (9)
	:SetType "Tier"
	:SetName "Celebratory"
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "New Years"





------------------------------------
--
-- Never Dropping Again Collection
--
------------------------------------


------------------------------------
-- Planetary Items
------------------------------------

i(3423)
	:Chance (9)
	:SetType "Tier"
	:SetName "Priceless"
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Never Dropping Again"





------------------------------------
--
-- Model Collection
--
------------------------------------

i(211)
	:Chance (3)
	:SetType "Crate"
	:SetName "Model Crate"
	:SetDesc "This crate contains an item from the Model Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/model_crate64.png"
	:SetShop (450, true)
	:Set "Model"


------------------------------------
-- Worn Items
------------------------------------

i(161)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Female 1"
	:SetDesc "Just your average female citizen."
	:SetModel "models/player/Group01/female_01.mdl"
	:Set "Model"

i(162)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Female 2"
	:SetDesc "Just your average female citizen."
	:SetModel "models/player/Group01/female_02.mdl"
	:Set "Model"

i(163)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Female 3"
	:SetDesc "Just your average female citizen."
	:SetModel "models/player/Group01/female_03.mdl"
	:Set "Model"

i(164)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Female 4"
	:SetDesc "Just your average female citizen."
	:SetModel "models/player/Group01/female_04.mdl"
	:Set "Model"

i(165)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Female 5"
	:SetDesc "Just your average female citizen."
	:SetModel "models/player/Group01/female_05.mdl"
	:Set "Model"

i(166)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Female 6"
	:SetDesc "Just your average female citizen."
	:SetModel "models/player/Group01/female_06.mdl"
	:Set "Model"

i(167)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 1"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_01.mdl"
	:Set "Model"

i(168)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 2"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_02.mdl"
	:Set "Model"

i(169)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 3"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_03.mdl"
	:Set "Model"

i(170)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 4"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_04.mdl"
	:Set "Model"

i(171)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 5"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_05.mdl"
	:Set "Model"

i(172)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 6"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_06.mdl"
	:Set "Model"

i(173)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 7"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_07.mdl"
	:Set "Model"

i(174)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 8"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_08.mdl"
	:Set "Model"

i(175)
	:Chance (1)
	:SetType "Model"
	:SetName "Citizen Male 9"
	:SetDesc "Just your average male citizen."
	:SetModel "models/player/Group01/male_09.mdl"
	:Set "Model"


------------------------------------
-- Standard Items
------------------------------------

i(185)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Female 1"
	:SetDesc "Just your average rebel female citizen."
	:SetModel "models/player/Group03/female_01.mdl"
	:Set "Model"

i(186)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Female 2"
	:SetDesc "Just your average rebel female citizen."
	:SetModel "models/player/Group03/female_02.mdl"
	:Set "Model"

i(187)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Female 3"
	:SetDesc "Just your average rebel female citizen."
	:SetModel "models/player/Group03/female_03.mdl"
	:Set "Model"

i(188)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Female 4"
	:SetDesc "Just your average rebel female citizen."
	:SetModel "models/player/Group03/female_04.mdl"
	:Set "Model"

i(189)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Female 5"
	:SetDesc "Just your average rebel female citizen."
	:SetModel "models/player/Group03/female_05.mdl"
	:Set "Model"

i(190)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Female 6"
	:SetDesc "Just your average rebel female citizen."
	:SetModel "models/player/Group03/female_06.mdl"
	:Set "Model"

i(177)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 9"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_09.mdl"
	:Set "Model"

i(176)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 1"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_01.mdl"
	:Set "Model"

i(178)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 2"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_02.mdl"
	:Set "Model"

i(179)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 3"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_03.mdl"
	:Set "Model"

i(180)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 4"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_04.mdl"
	:Set "Model"

i(181)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 5"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_05.mdl"
	:Set "Model"

i(182)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 6"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_06.mdl"
	:Set "Model"

i(183)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 7"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_07.mdl"
	:Set "Model"

i(184)
	:Chance (2)
	:SetType "Model"
	:SetName "Rebel Male 8"
	:SetDesc "Just your average rebel male citizen."
	:SetModel "models/player/Group03/male_08.mdl"
	:Set "Model"


------------------------------------
-- Specialized Items
------------------------------------

i(200)
	:Chance (3)
	:SetType "Model"
	:SetName "Barney Model"
	:SetDesc "I'm not a bad guy."
	:SetModel "models/player/barney.mdl"
	:Set "Model"

i(199)
	:Chance (3)
	:SetType "Model"
	:SetName "Eli Model"
	:SetDesc "I bet you can't guess why he lost a leg."
	:SetModel "models/player/eli.mdl"
	:Set "Model"

i(191)
	:Chance (3)
	:SetType "Model"
	:SetName "Working Asian"
	:SetDesc "Just your average male worker."
	:SetModel "models/player/hostage/hostage_01.mdl"
	:Set "Model"

i(192)
	:Chance (3)
	:SetType "Model"
	:SetName "Working Man"
	:SetDesc "Just your average male worker."
	:SetModel "models/player/hostage/hostage_02.mdl"
	:Set "Model"

i(193)
	:Chance (3)
	:SetType "Model"
	:SetName "Working Older Man"
	:SetDesc "Just your average male worker."
	:SetModel "models/player/hostage/hostage_03.mdl"
	:Set "Model"

i(194)
	:Chance (3)
	:SetType "Model"
	:SetName "Working Grandpa"
	:SetDesc "Just your average male worker."
	:SetModel "models/player/hostage/hostage_04.mdl"
	:Set "Model"

i(195)
	:Chance (3)
	:SetType "Model"
	:SetName "Magnusson Model"
	:SetDesc "Hello doctor."
	:SetModel "models/player/magnusson.mdl"
	:Set "Model"

i(196)
	:Chance (3)
	:SetType "Model"
	:SetName "Bald Monk Model"
	:SetDesc "Hummmmmm....."
	:SetModel "models/player/monk.mdl"
	:Set "Model"

i(198)
	:Chance (3)
	:SetType "Model"
	:SetName "Mossman Model"
	:SetDesc "Not as slutty as Alyx, but gettin' there."
	:SetModel "models/player/mossman.mdl"
	:Set "Model"

i(197)
	:Chance (3)
	:SetType "Model"
	:SetName "Odessa Model"
	:SetDesc "Security guard for hire."
	:SetModel "models/player/odessa.mdl"
	:Set "Model"


------------------------------------
-- Superior Items
------------------------------------

i(201)
	:Chance (4)
	:SetType "Model"
	:SetName "Breen Model"
	:SetDesc "The wise man."
	:SetModel "models/player/breen.mdl"
	:Set "Model"

i(529)
	:Chance (4)
	:SetType "Model"
	:SetName "Chris Redfield Model"
	:SetDesc "Just your typical Hunky, Sexy Military Man. All Homo."
	:SetModel "models/player/chris.mdl"
	:Set "Model"

i(534)
	:Chance (4)
	:SetType "Model"
	:SetName "Dude Model"
	:SetDesc "Just Piss on everything."
	:SetModel "models/player/dude.mdl"
	:Set "Model"

i(535)
	:Chance (4)
	:SetType "Model"
	:SetName "Ninja Model"
	:SetDesc "Hide in the shadows comrade."
	:SetModel "models/moat/player/ninja_player.mdl"
	:Set "Model"

i(202)
	:Chance (4)
	:SetType "Model"
	:SetName "GMan Model"
	:SetDesc "Good Morning."
	:SetModel "models/player/gman_high.mdl"
	:Set "Model"

i(537)
	:Chance (4)
	:SetType "Model"
	:SetName "Gordon Freeman Model"
	:SetDesc "Before I actually played the game, I thought Morgan Freeman played Gordon Freeman."
	:SetModel "models/moat/player/gordon.mdl"
	:Set "Model"

i(540)
	:Chance (4)
	:SetType "Model"
	:SetName "Hunter Model"
	:SetDesc "You are probably expecting a Zombie joke here about how you were Left 4 Dead. But I guess you're now only a Half-Life."
	:SetModel "models/player/hunter.mdl"
	:Set "Model"

i(550)
	:Chance (4)
	:SetType "Model"
	:SetName "Robber Model"
	:SetDesc "Maybe when he's not looking you could rob some of Moat's Cosmics."
	:SetModel "models/player/robber.mdl"
	:Set "Model"

i(555)
	:Chance (4)
	:SetType "Model"
	:SetName "Shaun Model"
	:SetDesc "Why are you still here? You should be watching Shaun of the Dead right now."
	:SetModel "models/player/shaun.mdl"
	:Set "Model"

i(557)
	:Chance (4)
	:SetType "Model"
	:SetName "Stripped Soldier Model"
	:SetDesc "Be careful in the Cold Weather with those Nips out. You might get Banned for possession of two extra weapons."
	:SetModel "models/player/soldier_stripped.mdl"
	:Set "Model"

i(564)
	:Chance (4)
	:SetType "Model"
	:SetName "Zoey Model"
	:SetDesc "Killing Terrorists is the same as killing Infected \"Zombies\", right? Hmm...."
	:SetModel "models/player/zoey.mdl"
	:Set "Model"


------------------------------------
-- High-End Items
------------------------------------

i(566)
	:Chance (5)
	:SetType "Model"
	:SetName "Walter White Model"
	:SetDesc "\"Say my name\". \"I am the one who knocks\". \"You're Goddamn Right\". I could go on all day, but there's only do much room in this box."
	:SetModel "models/agent_47/agent_47.mdl"
	:Set "Model"

i(526)
	:Chance (5)
	:SetType "Model"
	:SetName "Altair Model"
	:SetDesc "Actually gives you the ability to jump 200ft into hay."
	:SetModel "models/burd/player/altair.mdl"
	:Set "Model"

i(528)
	:Chance (5)
	:SetType "Model"
	:SetName "Chewbacca Model"
	:SetDesc "WUUH HUUGUUGHGHG HUURH UUH UGGGUH."
	:SetModel "models/moat/player/chewbacca.mdl"
	:Set "Model"

i(533)
	:Chance (5)
	:SetType "Model"
	:SetName "Dishonored Assassin Model"
	:SetDesc "This model is an Assassin from the game Dishonored. Who would have guessed that? Hmm..."
	:SetModel "models/player/dishonored_assassin1.mdl"
	:Set "Model"

i(536)
	:Chance (5)
	:SetType "Model"
	:SetName "Freddy Kruger Model"
	:SetDesc "Invading people's dreams since 1984."
	:SetModel "models/player/freddykruger.mdl"
	:Set "Model"

i(538)
	:Chance (5)
	:SetType "Model"
	:SetName "Chell Model"
	:SetDesc "How nice. There are no jiggle boobs."
	:SetModel "models/player/p2_chell.mdl"
	:Set "Model"

i(539)
	:Chance (5)
	:SetType "Model"
	:SetName "Harold Lott Model"
	:SetDesc "LOADSA MONEY."
	:SetModel "models/player/haroldlott.mdl"
	:Set "Model"

i(546)
	:Chance (5)
	:SetType "Model"
	:SetName "Masked Breen Model"
	:SetDesc "It's got to be said. There's something very BDSM about this Model."
	:SetModel "models/moat/player/sunabouzu.mdl"
	:Set "Model"

i(548)
	:Chance (5)
	:SetType "Model"
	:SetName "Niko Model"
	:SetDesc "Brother. Let's go Traitor Hunting."
	:SetModel "models/player/niko.mdl"
	:Set "Model"

i(551)
	:Chance (5)
	:SetType "Model"
	:SetName "Obama Model"
	:SetDesc "I was better than Trump."
	:SetModel "models/moat/player/obama.mdl"
	:Set "Model"

i(552)
	:Chance (5)
	:SetType "Model"
	:SetName "Rorschach Model"
	:SetDesc "Somebody help him! He's spilt ink all over his face."
	:SetModel "models/player/rorschach.mdl"
	:Set "Model"

i(556)
	:Chance (5)
	:SetType "Model"
	:SetName "Agent Smith Model"
	:SetDesc "This model looks an awful lot like Agent K from Men in Black."
	:SetModel "models/player/smith.mdl"
	:Set "Model"

i(560)
	:Chance (5)
	:SetType "Model"
	:SetName "TF2 Spy Model"
	:SetDesc "Everyone's favourite Back Stabbing, Invisible, Rage Inducing Frenchman."
	:SetModel "models/moat/player/spy.mdl"
	:Set "Model"


------------------------------------
-- Ascended Items
------------------------------------

i(527)
	:Chance (6)
	:SetType "Model"
	:SetName "Boba Fett Model"
	:SetDesc "Unfortunatley your Jetpack is out of fuel on this model."
	:SetModel "models/moat/player/bobafett.mdl"
	:Set "Model"

i(531)
	:Chance (6)
	:SetType "Model"
	:SetName "Inferno Armor Model"
	:SetDesc "Now you can survive a wild volcano attack."
	:SetModel "models/moat/player/inferno_armour.mdl"
	:Set "Model"

i(532)
	:Chance (6)
	:SetType "Model"
	:SetName "Deathstroke Model"
	:SetDesc "The result of Two-Face and Deadpool having a Baby."
	:SetModel "models/burd/norpo/arkhamorigins/assassins/deathstroke_valvebiped.mdl"
	:Set "Model"

i(543)
	:Chance (6)
	:SetType "Model"
	:SetName "Spider-Man Model"
	:SetDesc "My spider senses are starting to tingle!."
	:SetModel "models/otv/scarletspider.mdl"
	:Set "Model"

i(544)
	:Chance (6)
	:SetType "Model"
	:SetName "Joker Model"
	:SetDesc "You wanna know how I got these Scars? HAHA."
	:SetModel "models/player/joker.mdl"
	:Set "Model"

i(545)
	:Chance (6)
	:SetType "Model"
	:SetName "Knight Model"
	:SetDesc "Fixed."
	:SetModel "models/moat/player/knight_fixed.mdl"
	:Set "Model"

i(547)
	:Chance (6)
	:SetType "Model"
	:SetName "Master Chief Model"
	:SetDesc "Master Chief is not a Master Chef."
	:SetModel "models/player/lordvipes/haloce/spartan_classic.mdl"
	:Set "Model"

i(553)
	:Chance (6)
	:SetType "Model"
	:SetName "Scarecrow Model"
	:SetDesc "Now you have a Model to match Yourself. Someone who scares off Birds."
	:SetModel "models/player/scarecrow.mdl"
	:Set "Model"

i(554)
	:Chance (6)
	:SetType "Model"
	:SetName "Scorpion Model"
	:SetDesc "(From Mortal Kombat) Just incase you thought it was the insect and you had a Giant Stinger."
	:SetModel "models/player/scorpion.mdl"
	:Set "Model"

i(558)
	:Chance (6)
	:SetType "Model"
	:SetName "Solid Snake Model"
	:SetDesc "Wait. Did that Cardboard Box just move? What..."
	:SetModel "models/player/big_boss.mdl"
	:Set "Model"

i(561)
	:Chance (6)
	:SetType "Model"
	:SetName "Sub Zero Model"
	:SetDesc "About -1472.18 to be exact."
	:SetModel "models/player/subzero.mdl"
	:Set "Model"


------------------------------------
-- Cosmic Items
------------------------------------

i(541)
	:Chance (7)
	:SetType "Model"
	:SetName "Iron Man Model"
	:SetDesc "He will get your Laundry ironed in mere seconds."
	:SetModel "models/avengers/iron man/mark7_player.mdl"
	:Set "Model"

i(542)
	:Chance (7)
	:SetType "Model"
	:SetName "Isaac Clarke Model"
	:SetDesc "You may not be in Space, but you're sure as Hell Dead."
	:SetModel "models/player/security_suit.mdl"
	:Set "Model"

i(567)
	:Chance (7)
	:SetType "Model"
	:SetName "Black Mask Model"
	:SetDesc "I can see the darkness inside of you."
	:SetModel "models/player/bobert/aoblackmask.mdl"
	:Set "Model"

i(549)
	:Chance (7)
	:SetType "Model"
	:SetName "Normal Model"
	:SetDesc "This isn't a Normal Model. A Normal Model is Gigi Hadid."
	:SetModel "models/moat/player/normal.mdl"
	:Set "Model"

i(559)
	:Chance (7)
	:SetType "Model"
	:SetName "Space Suit Model"
	:SetDesc "Went to the Moon and back. Killed a bunch of Terrorists. Didn't even take off the Suit."
	:SetModel "models/moat/player/spacesuit.mdl"
	:Set "Model"

i(562)
	:Chance (7)
	:SetType "Model"
	:SetName "Tesla Power Model"
	:SetDesc "Temporarily osama model until proper power replacement is found by a conscience scientist."
	:SetModel "models/code_gs/osama/osamaplayer.mdl"
	:Set "Model"

i(563)
	:Chance (7)
	:SetType "Model"
	:SetName "Osama Model"
	:SetDesc "The dead leader of the terrorists."
	:SetModel "models/code_gs/osama/osamaplayer.mdl"
	:Set "Model"





------------------------------------
--
-- Meta Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(17)
	:Chance (8)
	:SetType "Usable"
	:SetName "VIP Token"
	:SetDesc "Using this will grant VIP benefits permanently! Benefits of joining the VIP are in the 'Donate' tab."
	:SetIcon "https://cdn.moat.gg/ttt/vip_token.png"
	:Set "Meta"





------------------------------------
--
-- Meme Collection2
--
------------------------------------


------------------------------------
-- Planetary Items
------------------------------------

i(2670)
	:Chance (9)
	:SetType "Tier"
	:SetName "End Game"
	:SetStats (9, 9)
		:Stat ("Weight", 50, -50)
		:Stat ("Magazine", -70, 70)
		:Stat ("Kick", 45, -45)
		:Stat ("Deployrate", -90, 90)
		:Stat ("Reloadrate", -90, 90)
		:Stat ("Accuracy", -55, 55)
		:Stat ("Damage", -40, 40)
		:Stat ("Firerate", -45, 45)
		:Stat ("Range", -65, 65)
	:SetTalents (4, 4)
	:Set "Meme2"





------------------------------------
--
-- Meme Collection
--
------------------------------------

i(9990)
	:Chance (4)
	:SetType "Crate"
	:SetName "Meme Crate"
	:SetDesc "This crate contains an item from the Meme Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/3e013c11369ddb746408f8db62917f14.png"
	:SetShop (1420, true)
	:Set "Meme"


------------------------------------
-- Standard Items
------------------------------------

i(9999)
	:Chance (2)
	:SetType "Tier"
	:SetName "Dedotated"
	:SetStats (3, 4)
		:Stat ("Weight", 15, -10)
		:Stat ("Firerate", -15, 10)
		:Stat ("Magazine", -20, 30)
		:Stat ("Accuracy", -10, 15)
		:Stat ("Damage", -10, 15)
		:Stat ("Kick", 10, -10)
		:Stat ("Range", -20, 20)
	:SetTalents (2, 2)
	:Set "Meme"

i(9193)
	:Chance (2)
	:SetType "Tier"
	:SetName "Change My"
	:SetStats (3, 4)
		:Stat ("Weight", 15, -10)
		:Stat ("Firerate", -15, 10)
		:Stat ("Magazine", -20, 30)
		:Stat ("Accuracy", -10, 15)
		:Stat ("Damage", -10, 15)
		:Stat ("Kick", 10, -10)
		:Stat ("Range", -20, 20)
	:SetTalents (2, 2)
	:Set "Meme"

i(9199)
	:Chance (2)
	:SetType "Tier"
	:SetName "Don't Say"
	:SetStats (3, 4)
		:Stat ("Weight", 15, -10)
		:Stat ("Firerate", -15, 10)
		:Stat ("Magazine", -20, 30)
		:Stat ("Accuracy", -10, 15)
		:Stat ("Damage", -10, 15)
		:Stat ("Kick", 10, -10)
		:Stat ("Range", -20, 20)
	:SetTalents (2, 2)
	:Set "Meme"


------------------------------------
-- Specialized Items
------------------------------------

i(9192)
	:Chance (3)
	:SetType "Tier"
	:SetName "Bird Box"
	:SetStats (4, 4)
		:Stat ("Weight", 20, -20)
		:Stat ("Firerate", -20, 20)
		:Stat ("Magazine", -40, 40)
		:Stat ("Accuracy", -20, 25)
		:Stat ("Damage", -20, 25)
		:Stat ("Kick", 20, -20)
		:Stat ("Range", -30, 30)
	:SetTalents (2, 2)
	:Set "Meme"

i(9998)
	:Chance (3)
	:SetType "Tier"
	:SetName "Slaps Roof Of"
	:SetStats (4, 4)
		:Stat ("Weight", 20, -20)
		:Stat ("Firerate", -20, 20)
		:Stat ("Magazine", -40, 40)
		:Stat ("Accuracy", -20, 25)
		:Stat ("Damage", -20, 25)
		:Stat ("Kick", 20, -20)
		:Stat ("Range", -30, 30)
	:SetTalents (2, 2)
	:Set "Meme"

i(9198)
	:Chance (3)
	:SetType "Tier"
	:SetName "Is This Your"
	:SetStats (4, 4)
		:Stat ("Weight", 20, -20)
		:Stat ("Firerate", -20, 20)
		:Stat ("Magazine", -40, 40)
		:Stat ("Accuracy", -20, 25)
		:Stat ("Damage", -20, 25)
		:Stat ("Kick", 20, -20)
		:Stat ("Range", -30, 30)
	:SetTalents (2, 2)
	:Set "Meme"


------------------------------------
-- Superior Items
------------------------------------

i(17699)
	:Chance (4)
	:SetType "Melee"
	:SetName "Deep Frying Ban"
	:SetWeapon "weapon_ttt_fryingpan"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Damage", -95, -95)
		:Stat ("Weight", -30, 30)
		:Stat ("Pushrate", 5, 10)
	:SetTalents (1, 1)
		:SetTalent (1, "Acid Test")
	:Set "Meme"


------------------------------------
-- High-End Items
------------------------------------

i(9191)
	:Chance (5)
	:SetType "Tier"
	:SetName "Thank U, Next"
	:SetStats (5, 5)
		:Stat ("Weight", 30, -30)
		:Stat ("Firerate", -30, 30)
		:Stat ("Magazine", -50, 50)
		:Stat ("Accuracy", -35, 35)
		:Stat ("Damage", -25, 25)
		:Stat ("Kick", 30, -30)
		:Stat ("Range", -45, 45)
	:SetTalents (2, 2)
	:Set "Meme"

i(2659)
	:Chance (5)
	:SetType "Tier"
	:SetName "Despacito"
	:SetStats (5, 5)
		:Stat ("Weight", 30, -30)
		:Stat ("Firerate", -30, 30)
		:Stat ("Magazine", -50, 50)
		:Stat ("Accuracy", -35, 35)
		:Stat ("Damage", -25, 25)
		:Stat ("Kick", 30, -30)
		:Stat ("Range", -45, 45)
	:SetTalents (2, 2)
	:Set "Meme"

i(9997)
	:Chance (5)
	:SetType "Tier"
	:SetName "Boneless"
	:SetStats (5, 5)
		:Stat ("Weight", 30, -30)
		:Stat ("Firerate", -30, 30)
		:Stat ("Magazine", -50, 50)
		:Stat ("Accuracy", -35, 35)
		:Stat ("Damage", -25, 25)
		:Stat ("Kick", 30, -30)
		:Stat ("Range", -45, 45)
	:SetTalents (2, 2)
	:Set "Meme"

i(9197)
	:Chance (5)
	:SetType "Tier"
	:SetName "Netflix N'"
	:SetStats (5, 5)
		:Stat ("Weight", 30, -30)
		:Stat ("Firerate", -30, 30)
		:Stat ("Magazine", -50, 50)
		:Stat ("Accuracy", -35, 35)
		:Stat ("Damage", -25, 25)
		:Stat ("Kick", 30, -30)
		:Stat ("Range", -45, 45)
	:SetTalents (2, 2)
	:Set "Meme"


------------------------------------
-- Ascended Items
------------------------------------

i(9994)
	:Chance (6)
	:SetType "Tier"
	:SetName "30 Speed"
	:SetStats (3, 4)
		:Stat ("Weight", 0, -7)
		:Stat ("Firerate", 0, 23)
		:Stat ("Magazine", 0, 28)
		:Stat ("Accuracy", 0, 23)
		:Stat ("Damage", 0, 30)
		:Stat ("Kick", 0, -23)
		:Stat ("Range", 0, 28)
	:SetTalents (3, 3)
		:SetTalent (2, "Feather")
		:SetTalent (3, "Feather")
	:Set "Meme"

i(9993)
	:Chance (6)
	:SetType "Tier"
	:SetName "*Click*"
	:SetStats (3, 4)
		:Stat ("Firerate", 0, 23)
		:Stat ("Weight", 0, -7)
		:Stat ("Accuracy", 0, 23)
		:Stat ("Damage", 0, 30)
		:Stat ("Kick", 0, -23)
		:Stat ("Range", 0, 28)
	:SetTalents (3, 3)
		:SetTalent (2, "Juan")
	:Set "Meme"

i(2658)
	:Chance (6)
	:SetType "Tier"
	:SetName "Alexa Play"
	:SetStats (5, 5)
		:Stat ("Weight", 30, -30)
		:Stat ("Firerate", -30, 30)
		:Stat ("Magazine", -50, 50)
		:Stat ("Accuracy", -35, 35)
		:Stat ("Damage", -25, 25)
		:Stat ("Kick", 30, -30)
		:Stat ("Range", -45, 45)
	:SetTalents (2, 2)
	:Set "Meme"

i(2632)
	:Chance (6)
	:SetType "Tier"
	:SetName "AirPods Compatible"
	:SetColor {135, 0, 153}
	:SetStats (6, 6)
		:Stat ("Weight", 40, -40)
		:Stat ("Firerate", -40, 40)
		:Stat ("Magazine", -60, 60)
		:Stat ("Accuracy", -45, 45)
		:Stat ("Damage", -30, 30)
		:Stat ("Kick", 35, -35)
		:Stat ("Range", -55, 55)
	:SetTalents (3, 3)
	:Set "Meme"

i(9996)
	:Chance (6)
	:SetType "Tier"
	:SetName "Delet This"
	:SetColor {135, 0, 153}
	:SetStats (6, 6)
		:Stat ("Weight", 40, -40)
		:Stat ("Firerate", -40, 40)
		:Stat ("Magazine", -60, 60)
		:Stat ("Accuracy", -45, 45)
		:Stat ("Damage", -30, 30)
		:Stat ("Kick", 35, -35)
		:Stat ("Range", -55, 55)
	:SetTalents (3, 3)
	:Set "Meme"

i(9196)
	:Chance (6)
	:SetType "Tier"
	:SetName "Wooaah"
	:SetColor {135, 0, 153}
	:SetStats (6, 6)
		:Stat ("Weight", 40, -40)
		:Stat ("Firerate", -40, 40)
		:Stat ("Magazine", -60, 60)
		:Stat ("Accuracy", -45, 45)
		:Stat ("Damage", -30, 30)
		:Stat ("Kick", 35, -35)
		:Stat ("Range", -55, 55)
	:SetTalents (3, 3)
	:Set "Meme"


------------------------------------
-- Cosmic Items
------------------------------------

i(9195)
	:Chance (7)
	:SetType "Tier"
	:SetName "Brother, May I Have Some"
	:SetStats (7, 7)
		:Stat ("Weight", 50, -50)
		:Stat ("Firerate", -45, 45)
		:Stat ("Magazine", -70, 70)
		:Stat ("Accuracy", -55, 55)
		:Stat ("Damage", -40, 40)
		:Stat ("Kick", 45, -45)
		:Stat ("Range", -65, 65)
	:SetTalents (3, 3)
	:Set "Meme"

i(9194)
	:Chance (7)
	:SetType "Tier"
	:SetName "Donald Trump's"
	:SetStats (7, 7)
		:Stat ("Weight", 50, -50)
		:Stat ("Firerate", -45, 45)
		:Stat ("Magazine", -70, 70)
		:Stat ("Accuracy", -55, 55)
		:Stat ("Damage", -40, 40)
		:Stat ("Kick", 45, -45)
		:Stat ("Range", -65, 65)
	:SetTalents (3, 3)
	:Set "Meme"

i(3612)
	:Chance (7)
	:SetType "Tier"
	:SetName "World Record"
	:SetStats (7, 7)
		:Stat ("Weight", 50, -50)
		:Stat ("Firerate", -45, 45)
		:Stat ("Magazine", -70, 70)
		:Stat ("Accuracy", -55, 55)
		:Stat ("Damage", -40, 40)
		:Stat ("Kick", 45, -45)
		:Stat ("Range", -65, 65)
	:SetTalents (3, 3)
	:Set "Meme"

i(9995)
	:Chance (7)
	:SetType "Tier"
	:SetName "That's A Lotta"
	:SetStats (7, 7)
		:Stat ("Weight", 50, -50)
		:Stat ("Firerate", -45, 45)
		:Stat ("Magazine", -70, 70)
		:Stat ("Accuracy", -55, 55)
		:Stat ("Damage", -40, 40)
		:Stat ("Kick", 45, -45)
		:Stat ("Range", -65, 65)
	:SetTalents (3, 3)
	:Set "Meme"

i(7973)
	:Chance (7)
	:SetType "Unique"
	:SetName "FaZe Pro Player"
	:SetWeapon "weapon_zm_rifle"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 73, 92)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
		:SetTalent (1, "Accuracy")
		:SetTalent (2, "Juan")
	:Set "Meme"





------------------------------------
--
-- Melee Collection
--
------------------------------------

i(158)
	:Chance (2)
	:SetType "Crate"
	:SetName "Melee Crate"
	:SetDesc "This crate contains an item from the Melee Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/melee_crate64.png"
	:SetShop (200, true)
	:Set "Melee"


------------------------------------
-- Worn Items
------------------------------------

i(209)
	:Chance (1)
	:SetType "Melee"
	:SetName "Frying Pan"
	:SetColor {160, 160, 160}
	:SetWeapon "weapon_ttt_fryingpan"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -5, -10)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"


------------------------------------
-- Standard Items
------------------------------------

i(203)
	:Chance (2)
	:SetType "Melee"
	:SetName "Baseball Bat"
	:SetColor {255, 204, 153}
	:SetWeapon "weapon_ttt_baseballbat"
	:SetStats (5, 5)
		:Stat ("Firerate", 8, 12)
		:Stat ("Force", 40, 60)
		:Stat ("Damage", 4, 13)
		:Stat ("Weight", -5, -10)
		:Stat ("Pushrate", -20, -30)
	:Set "Melee"

i(208)
	:Chance (2)
	:SetType "Melee"
	:SetName "A Chair"
	:SetColor {255, 255, 0}
	:SetIcon "https://cdn.moat.gg/f/ec565c8080853a8074da82047026fdbb.png"
	:SetWeapon "weapon_ttt_chair"
	:SetStats (5, 5)
		:Stat ("Firerate", -20, -50)
		:Stat ("Force", 13, 35)
		:Stat ("Damage", 30, 50)
		:Stat ("Weight", -5, -10)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(210)
	:Chance (2)
	:SetType "Melee"
	:SetName "A Keyboard"
	:SetColor {127, 0, 255}
	:SetWeapon "weapon_ttt_keyboard"
	:SetStats (5, 5)
		:Stat ("Firerate", 20, 40)
		:Stat ("Force", 13, 20)
		:Stat ("Weight", -5, -15)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(204)
	:Chance (2)
	:SetType "Melee"
	:SetName "A Pot"
	:SetColor {255, 128, 0}
	:SetWeapon "weapon_ttt_rollingpin"
	:SetStats (5, 5)
		:Stat ("Firerate", 15, 25)
		:Stat ("Force", 15, 40)
		:Stat ("Damage", 5, 10)
		:Stat ("Weight", -5, -10)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"


------------------------------------
-- Specialized Items
------------------------------------

i(10729)
	:Chance (3)
	:SetType "Melee"
	:SetName "A Fish"
	:SetColor {255, 160, 122}
	:SetWeapon "weapon_fish"
	:SetStats (5, 5)
		:Stat ("Weight", -5, -15)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(10730)
	:Chance (3)
	:SetType "Melee"
	:SetName "Fists"
	:SetIcon "https://cdn.moat.gg/f/96f183e138d991a720cdebb89f1fd137.png"
	:SetWeapon "weapon_ttt_fists"
	:SetStats (5, 5)
		:Stat ("Weight", -10, -20)
		:Stat ("Firerate", 20, 50)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(206)
	:Chance (3)
	:SetType "Melee"
	:SetName "Meat Cleaver"
	:SetColor {51, 0, 0}
	:SetWeapon "weapon_ttt_meatcleaver"
	:SetStats (5, 5)
		:Stat ("Firerate", 20, 40)
		:Stat ("Force", 5, 10)
		:Stat ("Damage", 10, 20)
		:Stat ("Weight", -5, -15)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(160)
	:Chance (3)
	:SetType "Melee"
	:SetName "Pipe Wrench"
	:SetColor {153, 0, 0}
	:SetWeapon "weapon_ttt_pipewrench"
	:SetStats (5, 5)
		:Stat ("Firerate", 15, 25)
		:Stat ("Force", 15, 40)
		:Stat ("Damage", 5, 10)
		:Stat ("Weight", -5, -15)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"


------------------------------------
-- Superior Items
------------------------------------

i(207)
	:Chance (4)
	:SetType "Melee"
	:SetName "A Baton"
	:SetColor {0, 76, 153}
	:SetIcon "https://cdn.moat.gg/f/ff9f07c2181f584aefc6f8312a27e417.png"
	:SetWeapon "weapon_ttt_baton"
	:SetStats (5, 5)
		:Stat ("Firerate", 30, 60)
		:Stat ("Force", 13, 20)
		:Stat ("Damage", 5, 10)
		:Stat ("Weight", -15, -25)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(27699)
	:Chance (4)
	:SetType "Melee"
	:SetName "Deep Frying Ban"
	:SetWeapon "weapon_ttt_fryingpan"
	:SetStats (5, 5)
		:Stat ("Weight", -30, 30)
		:Stat ("Force", 13, 35)
		:Stat ("Damage", -95, -95)
		:Stat ("Pushrate", 5, 10)
	:SetTalents (1, 1)
		:SetTalent (1, "Acid Test")
	:Set "Melee"

i(10801)
	:Chance (4)
	:SetType "Melee"
	:SetName "A Sword"
	:SetColor {70, 130, 180}
	:SetWeapon "weapon_pvpsword"
	:SetStats (5, 5)
		:Stat ("Weight", -5, -20)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(10734)
	:Chance (4)
	:SetType "Melee"
	:SetName "A Tomahawk"
	:SetColor {47, 79, 79}
	:SetWeapon "weapon_tomahawk"
	:SetStats (5, 5)
		:Stat ("Weight", -5, -15)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"


------------------------------------
-- High-End Items
------------------------------------

i(205)
	:Chance (5)
	:SetType "Melee"
	:SetName "Cardboard Knife"
	:SetColor {50, 50, 200}
	:SetWeapon "weapon_ttt_cardboardknife"
	:SetStats (5, 5)
		:Stat ("Firerate", 30, 60)
		:Stat ("Force", 13, 20)
		:Stat ("Damage", 5, 10)
		:Stat ("Weight", -10, -20)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(10728)
	:Chance (5)
	:SetType "Melee"
	:SetName "A Diamond Pickaxe"
	:SetColor {0, 255, 255}
	:SetWeapon "weapon_diamond_pick"
	:SetStats (5, 5)
		:Stat ("Weight", -15, -30)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(10735)
	:Chance (5)
	:SetType "Melee"
	:SetName "A Toy Hammer"
	:SetWeapon "weapon_toy_hammer"
	:SetStats (5, 5)
		:Stat ("Weight", -5, -15)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"


------------------------------------
-- Ascended Items
------------------------------------

i(10731)
	:Chance (6)
	:SetType "Melee"
	:SetName "A Katana"
	:SetWeapon "weapon_katana"
	:SetStats (5, 5)
		:Stat ("Weight", -20, -30)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(10733)
	:Chance (6)
	:SetType "Melee"
	:SetName "A Diamond Sword"
	:SetColor {0, 255, 255}
	:SetWeapon "weapon_diamond_sword"
	:SetStats (5, 5)
		:Stat ("Weight", -20, -30)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"

i(10802)
	:Chance (6)
	:SetType "Melee"
	:SetName "A Smart Pen"
	:SetWeapon "weapon_smartpen"
	:SetStats (5, 5)
		:Stat ("Weight", -20, -30)
		:Stat ("Force", 13, 35)
		:Stat ("Damage", 15, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"


------------------------------------
-- Cosmic Items
------------------------------------

i(10732)
	:Chance (7)
	:SetType "Melee"
	:SetName "A Lightsaber"
	:SetWeapon "weapon_light_saber"
	:SetStats (5, 5)
		:Stat ("Weight", -20, -35)
		:Stat ("Force", 13, 35)
		:Stat ("Pushrate", 5, 10)
	:Set "Melee"





------------------------------------
--
-- Limited Collection
--
------------------------------------

i(35)
	:Chance (8)
	:SetType "Tier"
	:SetName "Wild!"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 10, 20)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 2)
		:SetTalent (1, "Wild! - Tier 1")
		:SetTalent (2, "Wild! - Tier 2")
		:SetTalent (3, "Wild! - Tier 3")
	:SetShop (59999, false)
	:Set "Limited"


------------------------------------
-- Extinct Items
------------------------------------

i(4082)
	:Chance (8)
	:SetType "Usable"
	:SetName "Dog Talent Mutator"
	:SetDesc "Using this item will add the Dog Lover talent to any weapon. It will replace the tier two talent if one already exists. Only 200 of these mutators can be produced.."
	:SetIcon "https://cdn.moat.gg/f/name_mutator64.png"
	:Set "Limited"

i(909)
	:Chance (8)
	:SetType "Special"
	:SetName "Mega Vape"
	:SetDesc "An exclusive collectors item. Causes BIG smoke every 30 minutes, just like a very expensive smoke grenade if you think about it."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_mega"
	:Set "Limited"





------------------------------------
--
-- Independence Collection
--
------------------------------------

i(1991)
	:Chance (8)
	:SetType "Crate"
	:SetName "Independence Crate"
	:SetColor {0, 255, 255}
	:SetEffect "enchanted"
	:SetDesc "This crate contains an item from the Independence Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/usa_crate64.png"
	:SetShop (25000, true)
	:Set "Independence"


------------------------------------
-- Extinct Items
------------------------------------

i(2007)
	:Chance (8)
	:SetType "Melee"
	:SetName "American Baton"
	:SetIcon "https://cdn.moat.gg/f/ff9f07c2181f584aefc6f8312a27e417.png"
	:SetWeapon "weapon_ttt_baton"
	:SetStats (5, 5)
		:Stat ("Firerate", 30, 60)
		:Stat ("Force", 13, 20)
		:Stat ("Damage", 5, 20)
		:Stat ("Weight", -15, -25)
		:Stat ("Pushrate", 50, 100)
	:Set "Independence"

i(2550)
	:Chance (8)
	:SetType "Tier"
	:SetName "Patriotic"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2551)
	:Chance (8)
	:SetType "Tier"
	:SetName "Military-Grade"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2561)
	:Chance (8)
	:SetType "Tier"
	:SetName "AMERICAN"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
		:SetTalent (1, "Brutality")
		:SetTalent (2, "BOOM")
	:Set "Independence"

i(2552)
	:Chance (8)
	:SetType "Tier"
	:SetName "Independent"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2553)
	:Chance (8)
	:SetType "Tier"
	:SetName "Redneck"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2554)
	:Chance (8)
	:SetType "Tier"
	:SetName "Bombing"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2555)
	:Chance (8)
	:SetType "Tier"
	:SetName "Freedom"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2556)
	:Chance (8)
	:SetType "Tier"
	:SetName "Country"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2557)
	:Chance (8)
	:SetType "Tier"
	:SetName "Western"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2558)
	:Chance (8)
	:SetType "Tier"
	:SetName "Trumping"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2559)
	:Chance (8)
	:SetType "Tier"
	:SetName "Explosive"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
		:SetTalent (2, "BOOM")
	:Set "Independence"

i(2097)
	:Chance (8)
	:SetType "Body"
	:SetName "Balloonicorn"
	:SetDesc "Hey look, you finally have a friend now."
	:SetModel "models/gmod_tower/balloonicorn_nojiggle.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.3, 0)
		pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -20) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), -90)
		return model, pos, ang
	end)
	:Set "Independence"

i(2067)
	:Chance (8)
	:SetType "Body"
	:SetName "Duck Tube"
	:SetDesc "The king of the pool party."
	:SetModel "models/captainbigbutt/skeyler/accessories/duck_tube.mdl"
	:SetRender ("ValveBiped.Bip01_Spine1", function(ply, model, pos, ang)
		model:SetModelScale(1.65, 0)
		pos = pos + (ang:Forward() * 0) + (ang:Right() * -0) +  (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 270)
		ang:RotateAroundAxis(ang:Up(), 90)
		pos = pos + Vector(-5,3,0)
		return model, pos, ang
	end)
	:Set "Independence"

i(2562)
	:Chance (8)
	:SetType "Unique"
	:SetName "The Nationalist"
	:SetWeapon "weapon_patriot"
	:SetStats (5, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Independence"

i(2580)
	:Chance (8)
	:SetType "Special"
	:SetName "USA American Vape"
	:SetDesc "We're free nigga."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_american"
	:Set "Independence"

i(2673)
	:Chance (8)
	:SetType "Hat"
	:SetName "USA Bear Hat"
	:SetDesc "Now you will always have your teddy bear with you, in a hat form."
	:SetModel "models/captainbigbutt/skeyler/hats/bear_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Independence"

i(2498)
	:Chance (8)
	:SetType "Hat"
	:SetName "USA Piswasser Beer Hat"
	:SetDesc "It's true. German beer is literally Piss Water."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (0)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(0)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Independence"

i(2499)
	:Chance (8)
	:SetType "Hat"
	:SetName "USA Super Wet Beer Hat"
	:SetDesc "It was so tempting to put a 'Yo Mama' joke here."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(1)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Independence"

i(2500)
	:Chance (8)
	:SetType "Hat"
	:SetName "USA Patriot Beer Hat"
	:SetDesc "For the True Redneck."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(2)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Independence"

i(2501)
	:Chance (8)
	:SetType "Hat"
	:SetName "USA Benedict Beer Hat"
	:SetDesc "Clench your thirst with this Hat."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(3)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Independence"

i(2502)
	:Chance (8)
	:SetType "Hat"
	:SetName "USA Blarneys Beer Hat"
	:SetDesc "Sounds like a knock off Barney the Dinosaur."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(4)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Independence"

i(2503)
	:Chance (8)
	:SetType "Hat"
	:SetName "USA J Lager Beer Hat"
	:SetDesc "Jelly Lager? Delicious."
	:SetModel "models/sal/acc/fix/beerhat.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(5)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
		return model, pos, ang
	end)
	:Set "Independence"

i(2096)
	:Chance (8)
	:SetType "Mask"
	:SetName "USA 3D Glasses"
	:SetDesc "The most practical way to get your head in the game."
	:SetModel "models/gmod_tower/3dglasses.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Independence"

i(2057)
	:Chance (8)
	:SetType "Mask"
	:SetName "USA Aviators"
	:SetDesc "You look like the terminator with these badass glasses on."
	:SetModel "models/gmod_tower/aviators.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2) + (ang:Up() * -0.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Independence"

i(2401)
	:Chance (8)
	:SetType "Mask"
	:SetName "USA White Hawk Mask"
	:SetDesc "Show off your true Patriotism."
	:SetModel "models/sal/hawk_1.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
		return model, pos, ang
	end)
	:Set "Independence"

i(2402)
	:Chance (8)
	:SetType "Mask"
	:SetName "USA Brown Hawk Mask"
	:SetDesc "Show off your true Patriotism."
	:SetModel "models/sal/hawk_2.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
		return model, pos, ang
	end)
	:Set "Independence"

i(2452)
	:Chance (8)
	:SetType "Mask"
	:SetName "USA Police Ninja Mask"
	:SetDesc "Police Ninja. Sounds like the best movie ever."
	:SetModel "models/sal/halloween/ninja.mdl"
	:SetSkin (10)
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetSkin(10)
		model:SetModelScale(1.1)
		pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
		return model, pos, ang
	end)
	:Set "Independence"

i(2070)
	:Chance (8)
	:SetType "Mask"
	:SetName "USA Shutter Glasses"
	:SetDesc "The party is just getting started."
	:SetModel "models/captainbigbutt/skeyler/accessories/glasses03.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:Set "Independence"





------------------------------------
--
-- Hype Collection
--
------------------------------------

i(8151)
	:Chance (3)
	:SetType "Crate"
	:SetName "Hype Crate"
	:SetDesc "This crate contains an item from the Hype Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/bfdaa65ad7342e8fe539f0b2305e3d62.png"
	:SetShop (625, true)
	:Set "Hype"


------------------------------------
-- Worn Items
------------------------------------

i(8095)
	:Chance (1)
	:SetType "Hat"
	:SetName "Floral Giggle"
	:SetDesc "My goodness! Don't you just love flower tracking on a warm sunny day?!."
	:SetModel "models/moat/mg_hat_sun.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.759)+ (a:Right() * 0.098)+ (a:Up() * 4.55)
		return m, p, a
	end)
	:Set "Hype"

i(8006)
	:Chance (1)
	:SetType "Hat"
	:SetName "Pipo Helmet"
	:SetDesc "The Peak Point Helmet, also known as Pipo Helmet, is an experimental device made by the developers. This device controls the wearer and increases its intelligence.."
	:SetModel "models/custom_prop/moatgaming/apeescape/apeescape.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.125)
		p = p + (a:Forward() * -3.877)+ (a:Right() * -0.867)+ (a:Up() * 2.149)
		return m, p, a
	end)
	:Set "Hype"

i(8029)
	:Chance (1)
	:SetType "Mask"
	:SetName "Hannibal Mask"
	:SetDesc "Clarice...."
	:SetModel "models/custom_prop/moatgaming/hannibal/hannibal.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * -3.679)+ (a:Right() * -0.002)+ (a:Up() * -0.31)
		return m, p, a
	end)
	:Set "Hype"

i(8101)
	:Chance (1)
	:SetType "Mask"
	:SetName "Liberal Hattington"
	:SetDesc "Oh what the f... fart.."
	:SetModel "models/moat/mg_mask_hattington.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.45)
		p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
		return m, p, a
	end)
	:Set "Hype"

i(8102)
	:Chance (1)
	:SetType "Mask"
	:SetName "Pensive Hattington"
	:SetDesc "Avert your eyes children! AVERT THEM!."
	:SetModel "models/moat/mg_mask_hattington.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.45)
		p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
		return m, p, a
	end)
	:Set "Hype"

i(8103)
	:Chance (1)
	:SetType "Mask"
	:SetName "Cold Hattington"
	:SetDesc "Good try, but try gooder.."
	:SetModel "models/moat/mg_mask_hattington.mdl"
	:SetSkin (2)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.45)
		p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
		return m, p, a
	end)
	:Set "Hype"


------------------------------------
-- Standard Items
------------------------------------

i(8012)
	:Chance (2)
	:SetType "Hat"
	:SetName "Bunny Hood"
	:SetDesc "You got the Bunny Hood! My, what long ears it has! Will the power of the wild spring forth?."
	:SetModel "models/custom_prop/moatgaming/bunnyhood/bunnyhood.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.875)
		p = p + (a:Forward() * -3.479)+ (a:Right() * 0.112)+ (a:Up() * 4.168)
		a:RotateAroundAxis(a:Up(), 90)
		a:RotateAroundAxis(a:Forward(), -0.1)
		return m, p, a
	end)
	:Set "Hype"

i(8020)
	:Chance (2)
	:SetType "Hat"
	:SetName "Doctor Fez Cap"
	:SetDesc "A fez is another name for a condom. Kind of like a fez but for your other head.."
	:SetModel "models/custom_prop/moatgaming/doctorfez/doctorfez.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.025)
		p = p + (a:Forward() * -3.492)+ (a:Right() * -0.428)+ (a:Up() * 3.722)
		a:RotateAroundAxis(a:Forward(), -17.1)
		return m, p, a
	end)
	:Set "Hype"

i(8025)
	:Chance (2)
	:SetType "Hat"
	:SetName "Foolish Topper"
	:SetDesc "You must have sucked someone to get this... (kirby joke lol)."
	:SetModel "models/custom_prop/moatgaming/foolish/foolish.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * -6.627)+ (a:Right() * 0.328)+ (a:Up() * 2.637)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8005)
	:Chance (2)
	:SetType "Mask"
	:SetName "Anonymous Mask"
	:SetDesc "KNOWLEDGE IS EXPENSIVE. WE ARE IDENTIFIED. WE ARE FEW. WE DO FORGIVE. WE DO FORGET. DO NOT EXPECT US."
	:SetModel "models/custom_prop/moatgaming/anonymous/anonymous.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.075)
		p = p + (a:Forward() * -4.595)+ (a:Right() * 0.047)+ (a:Up() * -3.804)
		return m, p, a
	end)
	:Set "Hype"

i(8027)
	:Chance (2)
	:SetType "Mask"
	:SetName "Gas Mask"
	:SetDesc "This allows whoever is wearing the gas mask to inhale farts without plugging their nose.."
	:SetModel "models/custom_prop/moatgaming/gasmask/gasmask.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * -4.534)+ (a:Right() * -0.258)+ (a:Up() * -2.983)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8105)
	:Chance (2)
	:SetType "Mask"
	:SetName "Anxious Hattington"
	:SetDesc "Oh no! This isn't going to be good. Clench your butt! AHHHHHHHH."
	:SetModel "models/moat/mg_mask_hattington.mdl"
	:SetSkin (4)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.45)
		p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
		return m, p, a
	end)
	:Set "Hype"

i(8106)
	:Chance (2)
	:SetType "Mask"
	:SetName "Ecstatic Hattington"
	:SetDesc "Give yourself a round of applause. You're not banned!."
	:SetModel "models/moat/mg_mask_hattington.mdl"
	:SetSkin (5)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.45)
		p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
		return m, p, a
	end)
	:Set "Hype"

i(8104)
	:Chance (2)
	:SetType "Mask"
	:SetName "Impartial Hattington"
	:SetDesc "I was going tell you how much you suck. Turns out you don't!."
	:SetModel "models/moat/mg_mask_hattington.mdl"
	:SetSkin (3)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.45)
		p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
		return m, p, a
	end)
	:Set "Hype"

i(8040)
	:Chance (2)
	:SetType "Mask"
	:SetName "Majora's Moon Mask"
	:SetDesc "I... I shall consume. Consume... Consume everything..."
	:SetModel "models/custom_prop/moatgaming/moon/moon.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.979)+ (a:Right() * -0.001)+ (a:Up() * -0.718)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8049)
	:Chance (2)
	:SetType "Mask"
	:SetName "ReDead Mask"
	:SetDesc "Reeeeeee!."
	:SetModel "models/custom_prop/moatgaming/redead/redead.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.025)
		p = p + (a:Forward() * 0.942)+ (a:Right() * 0.253)+ (a:Up() * -1.381)
		return m, p, a
	end)
	:Set "Hype"


------------------------------------
-- Specialized Items
------------------------------------

i(8041)
	:Chance (3)
	:SetType "Hat"
	:SetName "Olimar's Helmet"
	:SetDesc "Though it does no longer work, this helmet was said to track down Traitors in 2001.."
	:SetModel "models/custom_prop/moatgaming/olimar/olimar.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.9)
		p = p + (a:Forward() * -3.685)+ (a:Right() * 1.373)+ (a:Up() * -6.748)
		return m, p, a
	end)
	:Set "Hype"

i(8083)
	:Chance (3)
	:SetType "Hat"
	:SetName "Smore Chef"
	:SetDesc "Warning! This cozy comfy smores like hat is not edible while shooting terrorists!."
	:SetModel "models/moat/mg_hat_law.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.035)+ (a:Right() * 0.136)+ (a:Up() * 6.665)
		return m, p, a
	end)
	:Set "Hype"

i(8094)
	:Chance (3)
	:SetType "Hat"
	:SetName "Spinny Hat"
	:SetDesc "You can sexually identify as an attack helicopter with this propeller on your head.."
	:SetModel "models/moat/mg_hat_spinny.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.975)
		p = p + (a:Forward() * -3.765)+ (a:Right() * 0.07)+ (a:Up() * 1.862)
		return m, p, a
	end)
	:Set "Hype"

i(8099)
	:Chance (3)
	:SetType "Hat"
	:SetName "Steampunk Tophat"
	:SetDesc "OMG YOU GUYS it has come to my attention that SOMEONE on the internet is saying that my fictional 19th century zombies are NOT SCIENTIFICALLY SOUND. Naturally, I am crushed. To think, IF ONLY I’d consulted with a zombologist or two before sitting down to write, I could’ve avoided ALL THIS EMBARRASSMENT.."
	:SetModel "models/sterling/mg_hat_punk.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.35)
		p = p + (a:Forward() * -3.161)+ (a:Right() * 0.133)+ (a:Up() * 7.737)
		return m, p, a
	end)
	:Set "Hype"

i(8010)
	:Chance (3)
	:SetType "Mask"
	:SetName "Billy Mask"
	:SetDesc "The prettiest boy in all the land.."
	:SetModel "models/custom_prop/moatgaming/billy/billy.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -4.454)+ (a:Right() * 0.008)+ (a:Up() * -5.909)
		return m, p, a
	end)
	:Set "Hype"

i(8013)
	:Chance (3)
	:SetType "Mask"
	:SetName "Crusaders Helment"
	:SetDesc "Join for Glory so all will remember you as a soldier of Moat."
	:SetModel "models/custom_prop/moatgaming/crusaders/crusaders.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.15)
		p = p + (a:Forward() * -4.982)+ (a:Right() * 0.003)+ (a:Up() * -4.512)
		return m, p, a
	end)
	:Set "Hype"

i(8037)
	:Chance (3)
	:SetType "Mask"
	:SetName "Metroid Hat"
	:SetDesc "I first battled the Metroids on planet Zebes. It was there that I foiled the plans of the Space Pirate leader, Mother Brain, to use the creatures to attack galactic civilization.."
	:SetModel "models/custom_prop/moatgaming/metroid/metroid.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -7.034)+ (a:Right() * -0.001)+ (a:Up() * 7.255)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8039)
	:Chance (3)
	:SetType "Mask"
	:SetName "Monstro Head"
	:SetDesc "Biblethump had a baby, and it's pretty weird looking.."
	:SetModel "models/custom_prop/moatgaming/monstro/monstro.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.76)
		p = p + (a:Forward() * -4.334)+ (a:Right() * -0.005)+ (a:Up() * -5.066)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8051)
	:Chance (3)
	:SetType "Mask"
	:SetName "Saiyan Scouter"
	:SetDesc "Something, something, power level, something, 9000...."
	:SetModel "models/custom_prop/moatgaming/saiyanvisor/saiyanvisor.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.051)+ (a:Right() * 0.689)+ (a:Up() * 0.917)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8062)
	:Chance (3)
	:SetType "Mask"
	:SetName "Trapper's Mask"
	:SetDesc "Perfect to cover a bald head and an ugly face!."
	:SetModel "models/custom_prop/moatgaming/trapper/trapper.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * 0.378)+ (a:Right() * 0.243)+ (a:Up() * -0.971)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"


------------------------------------
-- Superior Items
------------------------------------

i(8021)
	:Chance (4)
	:SetType "Hat"
	:SetName "Crocodile Dundee Hat"
	:SetDesc "That's not a knife. [draws a large Bowie knife] That's a knife.."
	:SetModel "models/custom_prop/moatgaming/dundee/dundee.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.746)+ (a:Right() * 0.874)+ (a:Up() * 0.029)
		a:RotateAroundAxis(a:Up(), 90)
		a:RotateAroundAxis(a:Forward(), -9.6)
		return m, p, a
	end)
	:Set "Hype"

i(8022)
	:Chance (4)
	:SetType "Hat"
	:SetName "Evil Plant Head"
	:SetDesc "The cutest little horrific flower baby!."
	:SetModel "models/custom_prop/moatgaming/evilplant/evilplant.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.9)
		p = p + (a:Forward() * -6.648)+ (a:Right() * -0.004)+ (a:Up() * -4.964)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8082)
	:Chance (4)
	:SetType "Hat"
	:SetName "Kung Lao's Hat"
	:SetDesc "I will not be so passive in your demise.."
	:SetModel "models/moat/mg_hat_kunglao.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.9)
		p = p + (a:Forward() * -4.054)+ (a:Right() * 0.119)+ (a:Up() * 4.079)
		return m, p, a
	end)
	:Set "Hype"

i(8088)
	:Chance (4)
	:SetType "Hat"
	:SetName "Naruto's Sleeping Cap"
	:SetDesc "A Shinobi's life is not measured by how they lived but rather what they managed to accomplish before their death.."
	:SetModel "models/moat/mg_hat_narutosleeping.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.982)+ (a:Right() * 0.045)+ (a:Up() * 3.56)
		return m, p, a
	end)
	:Set "Hype"

i(8096)
	:Chance (4)
	:SetType "Hat"
	:SetName "Teemo Hat"
	:SetDesc "Never underestimate the power of the Scout's code.."
	:SetModel "models/moat/mg_hat_teemo.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.566)+ (a:Right() * 0.143)+ (a:Up() * 4.251)
		return m, p, a
	end)
	:Set "Hype"

i(8004)
	:Chance (4)
	:SetType "Mask"
	:SetName "Alien Head"
	:SetDesc "The head of a person from outerspace. It was generally peace loving and wise, but it only came to Earth because we've got velcro and it loved that shit. Save velcro!."
	:SetModel "models/custom_prop/moatgaming/alien/alien.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.075)
		p = p + (a:Forward() * -6.061)+ (a:Right() * 0.031)+ (a:Up() * -3.541)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8009)
	:Chance (4)
	:SetType "Mask"
	:SetName "Bender Head"
	:SetDesc "Blackmail is such an ugly word. I prefer extortion. The 'x' makes it sound cool.."
	:SetModel "models/custom_prop/moatgaming/bender/bender.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.15)
		p = p + (a:Forward() * -4.861)+ (a:Right() * 0.314)+ (a:Up() * -6.522)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8093)
	:Chance (4)
	:SetType "Mask"
	:SetName "Confined Cranium"
	:SetDesc "Your thoughts will be trapped for eternity.."
	:SetModel "models/moat/mg_hat_skullcage.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.6)
		p = p + (a:Forward() * -4.078)+ (a:Right() * 0.088)+ (a:Up() * 0.208)
		return m, p, a
	end)
	:Set "Hype"

i(8017)
	:Chance (4)
	:SetType "Mask"
	:SetName "Demon Shank Mask"
	:SetDesc "Raised from the depths of hell, to die, again and again."
	:SetModel "models/custom_prop/moatgaming/demonshank/demonshank.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.125)
		p = p + (a:Forward() * -4.646)+ (a:Right() * 0.009)+ (a:Up() * -3.553)
		return m, p, a
	end)
	:Set "Hype"

i(8075)
	:Chance (4)
	:SetType "Mask"
	:SetName "Hei Mask"
	:SetDesc "Bearing the sins of the children of earth, the moon begins to consume it's light. What's Darker than Black?."
	:SetModel "models/moat/mg_hat_darkerthenblack.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * 1.361)+ (a:Up() * 0.001)
		return m, p, a
	end)
	:Set "Hype"

i(8098)
	:Chance (4)
	:SetType "Mask"
	:SetName "Iron Helmet"
	:SetDesc "+42 Damage resistance against dragons."
	:SetModel "models/moat/mg_helmet_iron.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * -2.956)+ (a:Right() * -0.043)+ (a:Up() * 1.603)
		return m, p, a
	end)
	:Set "Hype"

i(8046)
	:Chance (4)
	:SetType "Mask"
	:SetName "Jack-O-Lantern Mask"
	:SetDesc "The pumpkin king comes to freight tonight...."
	:SetModel "models/custom_prop/moatgaming/pumpkin/pumpkin.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -5.234)+ (a:Right() * -0.005)+ (a:Up() * -5.159)
		a:RotateAroundAxis(a:Up(), 93.9)
		return m, p, a
	end)
	:Set "Hype"

i(8043)
	:Chance (4)
	:SetType "Mask"
	:SetName "Pennywise Mask"
	:SetDesc "You'll float too.."
	:SetModel "models/custom_prop/moatgaming/pennywise/pennywise.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.206)+ (a:Right() * -0.004)+ (a:Up() * -2.71)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8053)
	:Chance (4)
	:SetType "Mask"
	:SetName "Scream Mask"
	:SetDesc "You're not going to pee alone any more. If you pee, I pee. Is that clear?."
	:SetModel "models/custom_prop/moatgaming/scream/scream.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * 0.517)+ (a:Up() * -3.868)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"


------------------------------------
-- High-End Items
------------------------------------

i(8074)
	:Chance (5)
	:SetType "Hat"
	:SetName "A Crown"
	:SetDesc "The eastern-american pronounciation of the word 'crayons', but in hat form.."
	:SetModel "models/moat/mg_hat_crown.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.35)
		p = p + (a:Forward() * -3.575)+ (a:Right() * 0.102)+ (a:Up() * 3.485)
		return m, p, a
	end)
	:Set "Hype"

i(8078)
	:Chance (5)
	:SetType "Hat"
	:SetName "Estilo Muerto"
	:SetDesc "Help the traitors celebrate Day of the Dead by wearing this hat and then killing them.."
	:SetModel "models/moat/mg_hat_estilomuerto.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.024)+ (a:Right() * 0.038)+ (a:Up() * 3.298)
		return m, p, a
	end)
	:Set "Hype"

i(8089)
	:Chance (5)
	:SetType "Hat"
	:SetName "King Neptune's Crown"
	:SetDesc "I win!."
	:SetModel "models/moat/mg_hat_neptune.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.8)
		p = p + (a:Forward() * -3.981)+ (a:Right() * 0.046)+ (a:Up() * 8.859)
		return m, p, a
	end)
	:Set "Hype"

i(8081)
	:Chance (5)
	:SetType "Hat"
	:SetName "Krusty Krab Hat"
	:SetDesc "I'm ready! I'm ready! I'm ready!."
	:SetModel "models/moat/mg_hat_krustykrab.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.5)
		p = p + (a:Forward() * -3.779)+ (a:Right() * 0.091)+ (a:Up() * 9.58)
		return m, p, a
	end)
	:Set "Hype"

i(8086)
	:Chance (5)
	:SetType "Hat"
	:SetName "Mad Hatter Hat"
	:SetDesc "We're all mad here! or Whats the hatter with me! (get it? it's a pun)."
	:SetModel "models/moat/mg_hat_madhatter.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.969)+ (a:Right() * 0.068)+ (a:Up() * 5.221)
		return m, p, a
	end)
	:Set "Hype"

i(8044)
	:Chance (5)
	:SetType "Hat"
	:SetName "Princess Peach's Crown"
	:SetDesc "I am in another castle!."
	:SetModel "models/custom_prop/moatgaming/princess/princess.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.454)+ (a:Right() * 0.845)+ (a:Up() * 5.339)
		return m, p, a
	end)
	:Set "Hype"

i(8092)
	:Chance (5)
	:SetType "Hat"
	:SetName "Robot Chicken Hat"
	:SetDesc "Why did the chicken REALLY cross the road? To get hit by a car, stolen by a mad scientist, and transformed into a terrifying cyborg that you can wear on your head. So the next time you hear someone telling you that joke, set that smug joke-teller straight, because you've got the FACTS.."
	:SetModel "models/moat/mg_hat_robotchicken.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.775)
		p = p + (a:Forward() * -4.184)+ (a:Right() * 0.081)+ (a:Up() * 6.122)
		return m, p, a
	end)
	:Set "Hype"

i(8060)
	:Chance (5)
	:SetType "Hat"
	:SetName "Straw Hat"
	:SetDesc "Welcome to the rice fields, mutha fucka.."
	:SetModel "models/custom_prop/moatgaming/strawhat/strawhat.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.161)+ (a:Right() * -1.299)+ (a:Up() * 0.491)
		return m, p, a
	end)
	:Set "Hype"

i(8007)
	:Chance (5)
	:SetType "Mask"
	:SetName "Arkham Knight Helmet "
	:SetDesc "The damn straight best super hero ever.."
	:SetModel "models/custom_prop/moatgaming/arkham/arkham.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.125)
		p = p + (a:Forward() * -5.484)+ (a:Right() * 0.001)+ (a:Up() * 0.106)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8008)
	:Chance (5)
	:SetType "Mask"
	:SetName "Bane Mask"
	:SetDesc "ass batman villian that uses a super steroid called 'Venom' to destroy anything with brute strength.."
	:SetModel "models/custom_prop/moatgaming/bane/bane.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.861)+ (a:Up() * -1.637)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8032)
	:Chance (5)
	:SetType "Mask"
	:SetName "Biblethump Mask"
	:SetDesc "The face of a crying baby from the indie game The Binding of Isaac. Also a Twitch emote.."
	:SetModel "models/custom_prop/moatgaming/isaac/isaac.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.9)
		p = p + (a:Forward() * -4.675)+ (a:Right() * -0.003)+ (a:Up() * -7.871)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8016)
	:Chance (5)
	:SetType "Mask"
	:SetName "Darth Vader Helmet"
	:SetDesc "Give yourself to the Dark Side. It is the only way you can save your friends. Yes, your thoughts betray you. Your feelings for them are strong.."
	:SetModel "models/custom_prop/moatgaming/darthvader/darthvader.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.125)
		p = p + (a:Forward() * -4.859)+ (a:Right() * 0.003)+ (a:Up() * -1.382)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8028)
	:Chance (5)
	:SetType "Mask"
	:SetName "Gray Fox Mask"
	:SetDesc "Make me feel alive again!."
	:SetModel "models/custom_prop/moatgaming/greyfox/greyfox.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -5.26)+ (a:Right() * -0.044)+ (a:Up() * -4.198)
		return m, p, a
	end)
	:Set "Hype"

i(8034)
	:Chance (5)
	:SetType "Mask"
	:SetName "Magneto's Helmet"
	:SetDesc "Mankind has always feared what it doesn't understand."
	:SetModel "models/custom_prop/moatgaming/magneto/magneto.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.075)
		p = p + (a:Forward() * -4.701)+ (a:Right() * -0.002)+ (a:Up() * -1.711)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8036)
	:Chance (5)
	:SetType "Mask"
	:SetName "Mega Man Helmet"
	:SetDesc "Watch out for the spikes blocks.."
	:SetModel "models/custom_prop/moatgaming/megaman/megaman.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -11.287)+ (a:Right() * -0.006)+ (a:Up() * -1.14)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8038)
	:Chance (5)
	:SetType "Mask"
	:SetName "Miraak's Mask"
	:SetDesc "That name sounds familiar, but I just can't put my finger on it..."
	:SetModel "models/custom_prop/moatgaming/miraak/miraak.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.986)+ (a:Right() * -0.002)+ (a:Up() * -3.053)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8045)
	:Chance (5)
	:SetType "Mask"
	:SetName "Psycho Mask"
	:SetDesc "Strip the flesh, Salt the wound.."
	:SetModel "models/custom_prop/moatgaming/psycho/psycho.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.987)+ (a:Right() * -0.002)+ (a:Up() * -5.456)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8050)
	:Chance (5)
	:SetType "Mask"
	:SetName "Robocop Helmet"
	:SetDesc "Dead or Alive, you're coming with me.."
	:SetModel "models/custom_prop/moatgaming/robocop/robocop.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -4.054)+ (a:Right() * 0.079)+ (a:Up() * 2.747)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8052)
	:Chance (5)
	:SetType "Mask"
	:SetName "Sauron's Helmet"
	:SetDesc "Kneel before the witch king!."
	:SetModel "models/custom_prop/moatgaming/sauron/sauron.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.075)
		p = p + (a:Forward() * -3.261)+ (a:Right() * -0.597)+ (a:Up() * -3.087)
		return m, p, a
	end)
	:Set "Hype"

i(8067)
	:Chance (5)
	:SetType "Mask"
	:SetName "Zahkriisos' Mask"
	:SetDesc "The dragon mask acquired from the remains of Zahkriisos, one of four named Dragon Priests on Solstheim.."
	:SetModel "models/custom_prop/moatgaming/zhariisos/zhariisos.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * 0.111)+ (a:Up() * -3.485)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"


------------------------------------
-- Ascended Items
------------------------------------

i(8073)
	:Chance (6)
	:SetType "Hat"
	:SetName "Chicken Hat"
	:SetDesc "The paramount of stealth.."
	:SetModel "models/moat/mg_hat_chicken.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.2)
		p = p + (a:Forward() * -4.189)+ (a:Right() * 0.065)+ (a:Up() * 2.904)
		return m, p, a
	end)
	:Set "Hype"

i(8090)
	:Chance (6)
	:SetType "Hat"
	:SetName "Pac-Man Helmet"
	:SetDesc "Waka Waka Waka Waka...."
	:SetModel "models/moat/mg_hat_packman.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -7.723)+ (a:Right() * 0.064)+ (a:Up() * 0.957)
		return m, p, a
	end)
	:Set "Hype"

i(8085)
	:Chance (6)
	:SetType "Hat"
	:SetName "Philosophy Bulb"
	:SetDesc "Basically gives you a headache with pictures.."
	:SetModel "models/moat/mg_hat_lightb.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.075)
		p = p + (a:Forward() * -3.602)+ (a:Right() * 0.092)+ (a:Up() * 2.62)
		return m, p, a
	end)
	:Set "Hype"

i(8069)
	:Chance (6)
	:SetType "Hat"
	:SetName "Pimp Hat"
	:SetDesc "25% off. Everything must go. Maybe even you.."
	:SetModel "models/moat/mg_fedora.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -3.92)+ (a:Right() * 0.018)+ (a:Up() * 2.601)
		a:RotateAroundAxis(a:Up(), 180)
		return m, p, a
	end)
	:Set "Hype"

i(8056)
	:Chance (6)
	:SetType "Hat"
	:SetName "Shredder Helmet"
	:SetDesc "TEENAGE MUTANT NINJA TURTLES."
	:SetModel "models/custom_prop/moatgaming/shredder/shredder.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.075)
		p = p + (a:Forward() * -4.59)+ (a:Right() * 0.03)+ (a:Up() * 0.677)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8079)
	:Chance (6)
	:SetType "Hat"
	:SetName "The Goofy Goober"
	:SetDesc "I'm a goofy goober, ROCK! You're a goofy goober, ROCK! We're all goofy goobers, ROCK! Goofy goofy goober goober!, ROCK!."
	:SetModel "models/moat/mg_hat_goofygoober.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -2.733)+ (a:Right() * 0.01)+ (a:Up() * -0.255)
		return m, p, a
	end)
	:Set "Hype"

i(8076)
	:Chance (6)
	:SetType "Hat"
	:SetName "The Stout Shako"
	:SetDesc "The grand achievement of Victorian military fashion.."
	:SetModel "models/moat/mg_hat_drummer.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.832)+ (a:Right() * 0.044)+ (a:Up() * 8.242)
		return m, p, a
	end)
	:Set "Hype"

i(8091)
	:Chance (6)
	:SetType "Hat"
	:SetName "Top Hat Of Bling Bling"
	:SetDesc "For those times when a plain old top hat made out of solid gold just won't do.."
	:SetModel "models/moat/mg_hat_robloxmoney.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.667)+ (a:Right() * 0.1)+ (a:Up() * 5.519)
		return m, p, a
	end)
	:Set "Hype"

i(8097)
	:Chance (6)
	:SetType "Hat"
	:SetName "Umbrella Hat"
	:SetDesc "You can stand under my umbrella, ella, ella, eh, eh, eh...."
	:SetModel "models/moat/mg_hat_unbrella.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * -4.134)+ (a:Right() * 0.177)+ (a:Up() * 5.8)
		a:RotateAroundAxis(a:Right(), 11.1)
		return m, p, a
	end)
	:Set "Hype"

i(8072)
	:Chance (6)
	:SetType "Hat"
	:SetName "Zeppeli Hat"
	:SetDesc "What is Courage? Courage is owning your fear!."
	:SetModel "models/moat/mg_hat_checkered_top.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.2)
		p = p + (a:Forward() * -3.877)+ (a:Right() * 0.036)+ (a:Up() * 3.853)
		return m, p, a
	end)
	:Set "Hype"

i(8002)
	:Chance (6)
	:SetType "Mask"
	:SetName "Aku Aku Mask"
	:SetDesc "A floating mask from the Crash Bandicoot game series. He aids Crash & co. in some way.."
	:SetModel "models/custom_prop/moatgaming/aku/aku.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.3)
		p = p + (a:Forward() * -5.52)+ (a:Right() * 0.001)+ (a:Up() * -0.621)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8011)
	:Chance (6)
	:SetType "Mask"
	:SetName "Bondrewd's Helmet"
	:SetDesc "World's best dad."
	:SetModel "models/custom_prop/moatgaming/bondrewd/bondrewd.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -2.268)+ (a:Right() * -2.339)+ (a:Up() * 0.071)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8023)
	:Chance (6)
	:SetType "Mask"
	:SetName "Captain Falcon's Helmet"
	:SetDesc "FALCOOOOON PUNCH!!!"
	:SetModel "models/custom_prop/moatgaming/falcon/falcon.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -5.152)+ (a:Right() * -0.002)+ (a:Up() * 0.055)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8024)
	:Chance (6)
	:SetType "Mask"
	:SetName "Helmet Of Fate"
	:SetDesc "This is the Helmet of Fate. It is not a 'shiny target'. It holds untold power.."
	:SetModel "models/custom_prop/moatgaming/fate/fate.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -5.006)+ (a:Right() * -0.002)+ (a:Up() * -1.971)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8031)
	:Chance (6)
	:SetType "Mask"
	:SetName "Hollow Knight Mask"
	:SetDesc "Brave the depths of a forgotten kingdom with this mask.."
	:SetModel "models/custom_prop/moatgaming/hollow/hollow.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.369)+ (a:Right() * 0)+ (a:Up() * -5.281)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8057)
	:Chance (6)
	:SetType "Mask"
	:SetName "Kawaii Dozer Mask"
	:SetDesc "SENPAI NOTICED ME."
	:SetModel "models/custom_prop/moatgaming/skullgirl/skullgirl.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.467)+ (a:Up() * -3.063)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8033)
	:Chance (6)
	:SetType "Mask"
	:SetName "Level 3 Helmet"
	:SetDesc "Bite the bullet."
	:SetModel "models/custom_prop/moatgaming/lvl3/lvl3.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.479)+ (a:Right() * -0.001)+ (a:Up() * -1.422)
		a:RotateAroundAxis(a:Up(), 90)
		a:RotateAroundAxis(a:Forward(), 7.1)
		return m, p, a
	end)
	:Set "Hype"

i(8035)
	:Chance (6)
	:SetType "Mask"
	:SetName "Marshmello's Helmet"
	:SetDesc "I heard you keeping it 'Mello' Eh Eh no okay...."
	:SetModel "models/custom_prop/moatgaming/marshmello/marshmello.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * -4.226)+ (a:Right() * 0.023)+ (a:Up() * -5.588)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8063)
	:Chance (6)
	:SetType "Mask"
	:SetName "Night Vision Goggles"
	:SetDesc "Either this guy is hacking, or he actually managed to turn on the goggles...."
	:SetModel "models/custom_prop/moatgaming/trihelmet/trihelmet.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.437)+ (a:Right() * 0.185)+ (a:Up() * 0.442)
		return m, p, a
	end)
	:Set "Hype"

i(8055)
	:Chance (6)
	:SetType "Mask"
	:SetName "Shovel Knight Helmet"
	:SetDesc "SHOVEL JUSTICE!"
	:SetModel "models/custom_prop/moatgaming/shovel/shovel.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -4.488)+ (a:Right() * 0.009)+ (a:Up() * -5.436)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8065)
	:Chance (6)
	:SetType "Mask"
	:SetName "Vault Boy Mask"
	:SetDesc "The real pussy destroyer. I'm a motherfuckin' pimp-ass mask who loves hot babes on the daily.."
	:SetModel "models/custom_prop/moatgaming/vaultboy/vaultboy.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -4.758)+ (a:Right() * 0.015)+ (a:Up() * 1.482)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8066)
	:Chance (6)
	:SetType "Mask"
	:SetName "Zer0's Mask"
	:SetDesc "Your eyes deceive you, an illusion fools you all.."
	:SetModel "models/custom_prop/moatgaming/zero/zero.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.427)+ (a:Up() * -5.324)
		return m, p, a
	end)
	:Set "Hype"


------------------------------------
-- Cosmic Items
------------------------------------

i(8026)
	:Chance (7)
	:SetType "Hat"
	:SetName "Galactus Helmet"
	:SetDesc "Behold... The Power Cosmic itself!."
	:SetModel "models/custom_prop/moatgaming/galactus/galactus.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.3)
		p = p + (a:Forward() * -5.157)+ (a:Right() * -0.125)+ (a:Up() * -5.757)
		return m, p, a
	end)
	:Set "Hype"

i(8054)
	:Chance (7)
	:SetType "Hat"
	:SetName "Sharky Hat"
	:SetDesc "Your friend from the ocean!."
	:SetModel "models/custom_prop/moatgaming/shark/shark.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.15)
		p = p + (a:Forward() * -2.451)+ (a:Right() * -0.109)+ (a:Up() * 6.517)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8058)
	:Chance (7)
	:SetType "Hat"
	:SetName "Sorting Hat"
	:SetDesc "Hmm, difficult. VERY difficult. Plenty of courage, I see. Not a bad mind, either. There's talent, oh yes. And a thirst to prove yourself. But where to put you?."
	:SetModel "models/custom_prop/moatgaming/sortinghat/sortinghat.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -4.208)+ (a:Right() * -0.965)+ (a:Up() * 1.495)
		return m, p, a
	end)
	:Set "Hype"

i(8061)
	:Chance (7)
	:SetType "Hat"
	:SetName "Thor's Helmet"
	:SetDesc "The god of Thunder. Can drink anyone under the table. Not a deity to fuck with.."
	:SetModel "models/custom_prop/moatgaming/thundergod/thundergod.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.05)
		p = p + (a:Forward() * -3.531)+ (a:Right() * -2.098)+ (a:Up() * -88.611)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8087)
	:Chance (7)
	:SetType "Hat"
	:SetName "Towering Pillar Of Hats"
	:SetDesc "A-ha-ha! You are as PRESUMPTUOUS as you are POOR and IRISH. Tarnish notte the majesty of my TOWER of HATS.."
	:SetModel "models/moat/mg_hat_multi.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.275)
		p = p + (a:Forward() * -3.901)+ (a:Right() * 0.059)+ (a:Up() * 3.53)
		return m, p, a
	end)
	:Set "Hype"

i(8068)
	:Chance (7)
	:SetType "Mask"
	:SetName "Clout Goggles"
	:SetDesc "A pair of iconic glasses that should be treasured and only worn by the best of people.."
	:SetModel "models/moat/mg_clout_goggles.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.8)
		p = p + (a:Forward() * -1.075)+ (a:Right() * 0.002)+ (a:Up() * 0.793)
		return m, p, a
	end)
	:Set "Hype"

i(8014)
	:Chance (7)
	:SetType "Mask"
	:SetName "Daft Punk Helmet"
	:SetDesc "She's up all night to the sun, I'm up all night to get some, She's up all night for good fun, I'm up all night to get lucky."
	:SetModel "models/custom_prop/moatgaming/daft/daft.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.15)
		p = p + (a:Forward() * -4.608)+ (a:Right() * 0.006)+ (a:Up() * -4.951)
		return m, p, a
	end)
	:Set "Hype"

i(8001)
	:Chance (7)
	:SetType "Mask"
	:SetName "Duck Mask"
	:SetDesc "The name is supposed to be Fuck Mask, but it was auto-corrected to Duck Mask?."
	:SetModel "models/custom_prop/moatgaming/duck/duck.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.025)
		p = p + (a:Forward() * -6.317)+ (a:Right() * -0.03)+ (a:Up() * -5.161)
		a:RotateAroundAxis(a:Right(), 0.1)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8042)
	:Chance (7)
	:SetType "Mask"
	:SetName "Ori Mask"
	:SetDesc "When my child's strength faltered, and the last breath was drawn, my light revived Ori, a new age had dawned.."
	:SetModel "models/custom_prop/moatgaming/ori/ori.mdl"
	:SetSkin (1)
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.8)
		p = p + (a:Forward() * -5.785)+ (a:Right() * 0.154)+ (a:Up() * -4.91)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Hype"

i(8059)
	:Chance (7)
	:SetType "Mask"
	:SetName "Spawn Mask"
	:SetDesc "You sent me to Hell. I'm here to return the favor.."
	:SetModel "models/custom_prop/moatgaming/spawn/spawn.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -5.296)+ (a:Right() * 2.1)+ (a:Up() * -93.192)
		a:RotateAroundAxis(a:Up(), -90)
		return m, p, a
	end)
	:Set "Hype"

i(8064)
	:Chance (7)
	:SetType "Mask"
	:SetName "Stormtrooper Helmet"
	:SetDesc "You can go about your business.."
	:SetModel "models/custom_prop/moatgaming/trooperhelmet/trooperhelmet.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -4.786)+ (a:Right() * 0.008)+ (a:Up() * -5.99)
		return m, p, a
	end)
	:Set "Hype"


------------------------------------
-- Planetary Items
------------------------------------

i(8080)
	:Chance (9)
	:SetType "Hat"
	:SetName "The IC Warrior"
	:SetDesc "A haiku for war. To default one's enemies. Honor the IC.."
	:SetModel "models/moat/mg_hat_killerskabuto.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.453)+ (a:Right() * 0.089)+ (a:Up() * 3.924)
		return m, p, a
	end)
	:Set "Hype"

i(8100)
	:Chance (9)
	:SetType "Hat"
	:SetName "The #1 Hat"
	:SetDesc "Hey man, that's Smitty Werben Man Jensen's hat, give it back! He was #1!."
	:SetModel "models/sterling/mg_hat_number1.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.558)+ (a:Right() * -0.002)+ (a:Up() * 0.848)
		return m, p, a
	end)
	:Set "Hype"





------------------------------------
--
-- Holiday Collection
--
------------------------------------

i(2002)
	:Chance (4)
	:SetType "Crate"
	:SetName "Holiday Crate"
	:SetDesc "This crate contains an item from the Holiday Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/holiday_crate64.png"
	:SetShop (2250, false)
	:Set "Holiday"


------------------------------------
-- Specialized Items
------------------------------------

i(8506)
	:Chance (3)
	:SetType "Mask"
	:SetName "Holiday Star Glasses"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/moat/mg_glasses_stars.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * 0.524)+ (a:Right() * -0.035)+ (a:Up() * 1.509)
		return m, p, a
	end)
	:Set "Holiday"

i(8504)
	:Chance (3)
	:SetType "Mask"
	:SetName "Santa Glasses"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/moat/mg_glasses_santa.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * 0.741)+ (a:Right() * -0.029)+ (a:Up() * 1.508)
		return m, p, a
	end)
	:Set "Holiday"

i(8505)
	:Chance (3)
	:SetType "Mask"
	:SetName "Santa Hat Glasses"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/moat/mg_glasses_santahat.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * 0.524)+ (a:Right() * -0.035)+ (a:Up() * 1.509)
		return m, p, a
	end)
	:Set "Holiday"

i(8532)
	:Chance (3)
	:SetType "Mask"
	:SetName "Santa's Trash"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/custom_prop/moatgaming/trashbag/trashbag.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.8)
		p = p + (a:Forward() * -3.711)+ (a:Right() * -0.119)+ (a:Up() * -8.322)
		a:RotateAroundAxis(a:Up(), 180)
		return m, p, a
	end)
	:Set "Holiday"

i(6120)
	:Chance (3)
	:SetType "Skin"
	:SetName "Merry Poops Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/0.png"
	:Set "Holiday"


------------------------------------
-- Superior Items
------------------------------------

i(7023)
	:Chance (4)
	:SetType "Tier"
	:SetName "Cozy"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Holiday"

i(7025)
	:Chance (4)
	:SetType "Tier"
	:SetName "Decorated"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Holiday"

i(7027)
	:Chance (4)
	:SetType "Tier"
	:SetName "Friendly"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Holiday"

i(7035)
	:Chance (4)
	:SetType "Tier"
	:SetName "Snowy"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Holiday"

i(7019)
	:Chance (4)
	:SetType "Special"
	:SetName "Snowball"
	:SetDesc "I think your snow is too soft or something, cause this thing ain't killing anyone."
	:SetWeapon "snowball_harmless"
	:Set "Holiday"

i(7009)
	:Chance (4)
	:SetType "Model"
	:SetName "Green Lantern Model"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/superheroes/greenlantern.mdl"
	:Set "Holiday"

i(7012)
	:Chance (4)
	:SetType "Model"
	:SetName "Winter Male 1"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/portal/male_02_snow.mdl"
	:Set "Holiday"

i(7013)
	:Chance (4)
	:SetType "Model"
	:SetName "Winter Male 2"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/portal/male_04_snow.mdl"
	:Set "Holiday"

i(7014)
	:Chance (4)
	:SetType "Model"
	:SetName "Winter Male 3"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/portal/male_05_snow.mdl"
	:Set "Holiday"

i(7015)
	:Chance (4)
	:SetType "Model"
	:SetName "Winter Male 4"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/portal/male_07_snow.mdl"
	:Set "Holiday"

i(7016)
	:Chance (4)
	:SetType "Model"
	:SetName "Winter Male 5"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/portal/male_08_snow.mdl"
	:Set "Holiday"

i(7017)
	:Chance (4)
	:SetType "Model"
	:SetName "Winter Male 6"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/portal/male_09_snow.mdl"
	:Set "Holiday"

i(8503)
	:Chance (4)
	:SetType "Mask"
	:SetName "Reindeer Glasses"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/moat/mg_glasses_reindeer.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * 0.738)+ (a:Right() * -0.023)+ (a:Up() * 0.752)
		return m, p, a
	end)
	:Set "Holiday"

i(6123)
	:Chance (4)
	:SetType "Skin"
	:SetName "Blizzard Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/1.png"
	:Set "Holiday"

i(6127)
	:Chance (4)
	:SetType "Skin"
	:SetName "Pokemon Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/2.png"
	:Set "Holiday"

i(6128)
	:Chance (4)
	:SetType "Skin"
	:SetName "Playful Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/3.png"
	:Set "Holiday"


------------------------------------
-- High-End Items
------------------------------------

i(7004)
	:Chance (5)
	:SetType "Melee"
	:SetName "A Candy Cane"
	:SetWeapon "weapon_ttt_candycane"
	:SetStats (5, 5)
		:Stat ("Force", 13, 35)
		:Stat ("Weight", -15, -30)
		:Stat ("Pushrate", 5, 10)
	:Set "Holiday"

i(7024)
	:Chance (5)
	:SetType "Tier"
	:SetName "Dashin"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Holiday"

i(7029)
	:Chance (5)
	:SetType "Tier"
	:SetName "Giving"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Holiday"

i(7030)
	:Chance (5)
	:SetType "Tier"
	:SetName "Holiday"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Holiday"

i(7033)
	:Chance (5)
	:SetType "Tier"
	:SetName "Merry"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Holiday"

i(7022)
	:Chance (5)
	:SetType "Special"
	:SetName "Christmas Smoke"
	:SetDesc "Don't get lost in the smoke, you might miss santa claus."
	:SetWeapon "weapon_xmassmoke"
	:Set "Holiday"

i(7010)
	:Chance (5)
	:SetType "Model"
	:SetName "Cat Woman Model"
	:SetDesc "I'm a catist, not a feminist."
	:SetModel "models/kaesar/moat/catwoman/catwoman.mdl"
	:Set "Holiday"

i(7006)
	:Chance (5)
	:SetType "Model"
	:SetName "Batman Model"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/superheroes/batman.mdl"
	:Set "Holiday"

i(7007)
	:Chance (5)
	:SetType "Model"
	:SetName "Flash Model"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/superheroes/flash.mdl"
	:Set "Holiday"

i(7003)
	:Chance (5)
	:SetType "Mask"
	:SetName "Snowman Head"
	:SetDesc "Frosty the terrorist."
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
	:Set "Holiday"

i(8514)
	:Chance (5)
	:SetType "Mask"
	:SetName "Xmas Tree Glasses"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/moat/mg_glasses_xmastree.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -1.427)+ (a:Right() * 0.001)+ (a:Up() * 2.779)
		return m, p, a
	end)
	:Set "Holiday"

i(6136)
	:Chance (5)
	:SetType "Skin"
	:SetName "Riptide Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/14.png"
	:Set "Holiday"

i(6139)
	:Chance (5)
	:SetType "Skin"
	:SetName "Comic Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/18.png"
	:Set "Holiday"

i(6151)
	:Chance (5)
	:SetType "Skin"
	:SetName "Polkadot Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/9.png"
	:Set "Holiday"

i(6129)
	:Chance (5)
	:SetType "Skin"
	:SetName "Xmas Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/4.png"
	:Set "Holiday"

i(6131)
	:Chance (5)
	:SetType "Skin"
	:SetName "Stickers Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/6.png"
	:Set "Holiday"

i(6132)
	:Chance (5)
	:SetType "Skin"
	:SetName "Warrior Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/7.png"
	:Set "Holiday"

i(6133)
	:Chance (5)
	:SetType "Skin"
	:SetName "Scales Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/25.png"
	:Set "Holiday"


------------------------------------
-- Ascended Items
------------------------------------

i(7026)
	:Chance (6)
	:SetType "Tier"
	:SetName "Festive"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Holiday"

i(7031)
	:Chance (6)
	:SetType "Tier"
	:SetName "Jolly"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Holiday"

i(7032)
	:Chance (6)
	:SetType "Tier"
	:SetName "Magical"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Holiday"

i(7052)
	:Chance (6)
	:SetType "Unique"
	:SetName "Dasher"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_te_g36c"
	:SetStats (6, 7)
		:Stat ("Accuracy", 5, 10)
		:Stat ("Damage", 14, 20)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(7054)
	:Chance (6)
	:SetType "Unique"
	:SetName "Dancer"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m16"
	:SetStats (6, 7)
		:Stat ("Firerate", 5, 30)
		:Stat ("Accuracy", 2, 15)
		:Stat ("Kick", 14, 23)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(7055)
	:Chance (6)
	:SetType "Unique"
	:SetName "Prancer"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_p228"
	:SetStats (6, 7)
		:Stat ("Damage", 14, 28)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(7056)
	:Chance (6)
	:SetType "Unique"
	:SetName "Vixen"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_p228"
	:SetStats (6, 7)
		:Stat ("Firerate", 20, 40)
		:Stat ("Magazine", 30, 60)
		:Stat ("Damage", 6, 12)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(7057)
	:Chance (6)
	:SetType "Unique"
	:SetName "Comet"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_sg552"
	:SetStats (6, 7)
		:Stat ("Magazine", 14, 22)
		:Stat ("Damage", 14, 30)
		:Stat ("Kick", -20, -34)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(7058)
	:Chance (6)
	:SetType "Unique"
	:SetName "Cupid"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_p90"
	:SetStats (6, 7)
		:Stat ("Firerate", 2, 12)
		:Stat ("Accuracy", 4, 40)
		:Stat ("Damage", 12, 20)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(7059)
	:Chance (6)
	:SetType "Unique"
	:SetName "Dunder"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m03a3"
	:SetStats (6, 7)
		:Stat ("Magazine", 4, 8)
		:Stat ("Accuracy", 14, 30)
		:Stat ("Damage", 20, 35)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(7063)
	:Chance (6)
	:SetType "Unique"
	:SetName "Blixem"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_cz75"
	:SetStats (6, 7)
		:Stat ("Magazine", 5, 12)
		:Stat ("Damage", 23, 35)
		:Stat ("Kick", -5, -10)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(4641)
	:Chance (6)
	:SetType "Unique"
	:SetName "M4AFan"
	:SetWeapon "weapon_ttt_m4a1"
	:SetStats (6, 7)
		:Stat ("Damage", 14, 28)
	:SetTalents (2, 3)
	:Set "Holiday"

i(7020)
	:Chance (6)
	:SetType "Special"
	:SetName "Christmas Flash"
	:SetDesc "Don't blink, you might miss santa claus."
	:SetWeapon "weapon_xmasflash"
	:Set "Holiday"

i(8521)
	:Chance (6)
	:SetType "Hat"
	:SetName "Cat In the Hat"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/models/moat/mg_hat_catinthehat.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.325)
		p = p + (a:Forward() * -2.714)+ (a:Right() * 0)+ (a:Up() * 8.254)
		return m, p, a
	end)
	:Set "Holiday"

i(8522)
	:Chance (6)
	:SetType "Hat"
	:SetName "Elf #2 Hat"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/models/moat/mg_hat_elf.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -3.015)+ (a:Right() * 0.001)+ (a:Up() * 4.144)
		return m, p, a
	end)
	:Set "Holiday"

i(8533)
	:Chance (6)
	:SetType "Hat"
	:SetName "Elf #1 Hat"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/models/moat/mg_hat_elf2.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -2.73)+ (a:Right() * -0.135)+ (a:Up() * 1.204)
		return m, p, a
	end)
	:Set "Holiday"

i(7005)
	:Chance (6)
	:SetType "Model"
	:SetName "Superman Model"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/superheroes/superman.mdl"
	:Set "Holiday"

i(7002)
	:Chance (6)
	:SetType "Mask"
	:SetName "Gingerbread Mask"
	:SetDesc "Please don't eat my face."
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
	:Set "Holiday"

i(6135)
	:Chance (6)
	:SetType "Skin"
	:SetName "Lightning Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/17.png"
	:Set "Holiday"

i(6137)
	:Chance (6)
	:SetType "Skin"
	:SetName "Magma Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/12.png"
	:Set "Holiday"

i(6138)
	:Chance (6)
	:SetType "Skin"
	:SetName "Polygon Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/16.png"
	:Set "Holiday"

i(6140)
	:Chance (6)
	:SetType "Skin"
	:SetName "Flourish Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/20.png"
	:Set "Holiday"

i(6141)
	:Chance (6)
	:SetType "Skin"
	:SetName "Zebra Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/19.png"
	:Set "Holiday"

i(6130)
	:Chance (6)
	:SetType "Skin"
	:SetName "Hype Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/5.png"
	:Set "Holiday"


------------------------------------
-- Cosmic Items
------------------------------------

i(7028)
	:Chance (7)
	:SetType "Tier"
	:SetName "Gift-Wrapped"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Holiday"

i(7034)
	:Chance (7)
	:SetType "Tier"
	:SetName "Santa's Own"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Holiday"

i(7053)
	:Chance (7)
	:SetType "Unique"
	:SetName "Rudolph"
	:SetEffect "glow"
	:SetWeapon "weapon_mor_daedric"
	:SetStats (7, 8)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 40)
		:Stat ("Chargerate", 28, 46)
		:Stat ("Kick", -14, -23)
	:SetTalents (2, 3)
		:SetTalent (2, "SNOWBALLS")
	:Set "Holiday"

i(4642)
	:Chance (7)
	:SetType "Unique"
	:SetName "M4APartner"
	:SetWeapon "weapon_ttt_m4a1"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Holiday"

i(7036)
	:Chance (7)
	:SetType "Special"
	:SetName "Frozen Snowball"
	:SetDesc "A deadly snowball made of hard ice probably."
	:SetWeapon "snowball_harmful"
	:Set "Holiday"

i(7021)
	:Chance (7)
	:SetType "Special"
	:SetName "Christmas Frag"
	:SetDesc "Don't run away, you might miss santa claus."
	:SetWeapon "weapon_xmasfrag"
	:Set "Holiday"

i(8535)
	:Chance (7)
	:SetType "Hat"
	:SetName "Suess Santa Hat"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/models/moat/mg_xmasfestive01.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -2.798)+ (a:Right() * -0.191)+ (a:Up() * 2.377)
		return m, p, a
	end)
	:Set "Holiday"

i(8539)
	:Chance (7)
	:SetType "Hat"
	:SetName "Rudolph Hat"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/models/moat/mg_hat_rudolph.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(0.825)
		p = p + (a:Forward() * -2.738)+ (a:Right() * -0.167)+ (a:Up() * 2.144)
		return m, p, a
	end)
	:Set "Holiday"

i(7001)
	:Chance (7)
	:SetType "Hat"
	:SetName "Santa's Cap"
	:SetDesc "Ho Ho Ho Merry Christmas."
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
	:Set "Holiday"

i(7008)
	:Chance (7)
	:SetType "Model"
	:SetName "Jolly Santa Model"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/christmas/santa.mdl"
	:Set "Holiday"

i(7011)
	:Chance (7)
	:SetType "Model"
	:SetName "Jesus Model"
	:SetDesc "A special model from the holiday season."
	:SetModel "models/player/jesus/jesus.mdl"
	:Set "Holiday"

i(8513)
	:Chance (7)
	:SetType "Mask"
	:SetName "Merry Xmas Glasses"
	:SetDesc "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size.."
	:SetModel "models/moat/mg_glasses_xmas.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -1.135)+ (a:Right() * 0.002)+ (a:Up() * 2.996)
		return m, p, a
	end)
	:Set "Holiday"

i(6134)
	:Chance (7)
	:SetType "Skin"
	:SetName "Holo Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/21.png"
	:Set "Holiday"

i(6149)
	:Chance (7)
	:SetType "Skin"
	:SetName "Skrilla Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/f/26.png"
	:Set "Holiday"

i(6142)
	:Chance (7)
	:SetType "Skin"
	:SetName "Sherbert Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/24.png"
	:Set "Holiday"

i(6154)
	:Chance (7)
	:SetType "Skin"
	:SetName "Elevate Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/27.png"
	:Set "Holiday"

i(6143)
	:Chance (7)
	:SetType "Skin"
	:SetName "Trippin Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/23.png"
	:Set "Holiday"

i(6144)
	:Chance (7)
	:SetType "Skin"
	:SetName "Gold Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/11.png"
	:Set "Holiday"


------------------------------------
-- Planetary Items
------------------------------------

i(7095)
	:Chance (9)
	:SetType "Tier"
	:SetName "Coal"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Holiday"

i(6145)
	:Chance (9)
	:SetType "Skin"
	:SetName "Hotline Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/8.png"
	:Set "Holiday"

i(6146)
	:Chance (9)
	:SetType "Skin"
	:SetName "Galaxy Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/1/13.png"
	:Set "Holiday"





------------------------------------
--
-- Golden Easter 2019 Collection
--
------------------------------------

i(8997)
	:Chance (8)
	:SetType "Crate"
	:SetName "Golden Easter Basket"
	:SetDesc "This basket contains a rare item from the Easter 2019 Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/easter_basket64.png"
	:SetShop (350, false)
	:Set "Golden Easter 2019"





------------------------------------
--
-- Gift Collection
--
------------------------------------

i(7820)
	:Chance (0)
	:SetType "Usable"
	:SetName "Empty Gift Package"
	:SetDesc "Right click to insert an item into the gift package."
	:SetIcon "https://cdn.moat.gg/f/present-empty.png"
	:SetShop (5000, true)
	:Set "Gift"





------------------------------------
--
-- George Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(530)
	:Chance (8)
	:SetType "Model"
	:SetName "Classy Gentleman Model"
	:SetDesc "Only for the Most Dapper of Tea-Sipping Gentlemen."
	:SetModel "models/player/macdguy.mdl"
	:Set "George"





------------------------------------
--
-- Gamma Collection
--
------------------------------------

i(4005)
	:Chance (9)
	:SetType "Usable"
	:SetName "Planetary Talents Mutator"
	:SetDesc "Using this item allows you to re-roll the talents of any Planetary item. This will reset the item's LVL and XP."
	:SetIcon "https://cdn.moat.gg/f/planetary_talent64.png"
	:SetShop (600000, false)
	:Set "Gamma"





------------------------------------
--
-- Extinct IRL Collection
--
------------------------------------


------------------------------------
-- Planetary Items
------------------------------------

i(42)
	:Chance (9)
	:SetType "Model"
	:SetName "T-Rex Modwl"
	:SetDesc "Tyrannosaurus is a genus of coelurosaurian theropod dinosaur. The species Tyrannosaurus rex, often called T. rex or colloquially T-Rex, is one of the most well-represented of the large theropods. Tyrannosaurus lived throughout what is now western North America, on what was then an island continent known as Laramidia.."
	:SetModel "models/moat/player/foohysaurusrex_fixed.mdl"
	:Set "Extinct IRL"





------------------------------------
--
-- Effect Collection
--
------------------------------------

i(275)
	:Chance (5)
	:SetType "Crate"
	:SetName "Effect Crate"
	:SetDesc "This crate contains an item from the Effect Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/effect_crate64.png"
	:SetShop (3950, true)
	:Set "Effect"


------------------------------------
-- High-End Items
------------------------------------

i(213)
	:Chance (5)
	:SetType "Effect"
	:SetName "Black Hole Effect"
	:SetDesc "The center of the universe."
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
	:Set "Effect"

i(215)
	:Chance (5)
	:SetType "Effect"
	:SetName "Black Ice Effect"
	:SetDesc "Don't drive on this."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(216)
	:Chance (5)
	:SetType "Effect"
	:SetName "Blue Data Effect"
	:SetDesc "This is what's left from the DDoS attack."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(217)
	:Chance (5)
	:SetType "Effect"
	:SetName "Burger Effect"
	:SetDesc "Welcome to good burger, home of the good burger, can I take your order."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(218)
	:Chance (5)
	:SetType "Effect"
	:SetName "Robot Effect"
	:SetDesc "Boop beep bop boop."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(219)
	:Chance (5)
	:SetType "Effect"
	:SetName "Combine Ball Effect"
	:SetDesc "Stop right there civilian scum."
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
	:Set "Effect"

i(220)
	:Chance (5)
	:SetType "Effect"
	:SetName "Confusion Effect"
	:SetDesc "uh ... huh."
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
	:Set "Effect"

i(221)
	:Chance (5)
	:SetType "Effect"
	:SetName "WASD Effect"
	:SetDesc "Just use WASD."
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
	:Set "Effect"

i(223)
	:Chance (5)
	:SetType "Effect"
	:SetName "Diamond Effect"
	:SetDesc "Shine bright."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(224)
	:Chance (5)
	:SetType "Effect"
	:SetName "Donut Effect"
	:SetDesc "This donut reminds me so much of Homer from the Simpsons."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(225)
	:Chance (5)
	:SetType "Effect"
	:SetName "Dr. Danger Effect"
	:SetDesc "Woooah watch out guys."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(226)
	:Chance (5)
	:SetType "Effect"
	:SetName "Explosion Effect"
	:SetDesc "This is so pretty."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(227)
	:Chance (5)
	:SetType "Effect"
	:SetName "Duhaf Effect"
	:SetDesc "What the duhaf."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(228)
	:Chance (5)
	:SetType "Effect"
	:SetName "Dungo Effect"
	:SetDesc "Stop looking at me."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(229)
	:Chance (5)
	:SetType "Effect"
	:SetName "Editor Effect"
	:SetDesc "Use this to help you edit your life."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(230)
	:Chance (5)
	:SetType "Effect"
	:SetName "GMan Effect"
	:SetDesc "Good morning Mr. Freeman."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(231)
	:Chance (5)
	:SetType "Effect"
	:SetName "Koi Effect"
	:SetDesc "Just keep swimming, just keep swimming swimming swimming."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(233)
	:Chance (5)
	:SetType "Effect"
	:SetName "Holy Effect"
	:SetDesc ":O WOAH."
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
	:Set "Effect"

i(234)
	:Chance (5)
	:SetType "Effect"
	:SetName "Horse Effect"
	:SetDesc "Neighhhh."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(235)
	:Chance (5)
	:SetType "Effect"
	:SetName "Hotdog Effect"
	:SetDesc "Hotdogs here! Get your hotdogs."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(236)
	:Chance (5)
	:SetType "Effect"
	:SetName "Huladoll Effect"
	:SetDesc "That's racist to my culture sir."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(237)
	:Chance (5)
	:SetType "Effect"
	:SetName "Snowman Effect"
	:SetDesc "Frosty the snowman was jolly good fellow."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(238)
	:Chance (5)
	:SetType "Effect"
	:SetName "ILLIN Effect"
	:SetDesc "That's sick."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(239)
	:Chance (5)
	:SetType "Effect"
	:SetName "Lamar Effect"
	:SetDesc "Wazzup people."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(240)
	:Chance (5)
	:SetType "Effect"
	:SetName "LAPIZ Effect"
	:SetDesc "Oh great, another Minecraft reference."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(241)
	:Chance (5)
	:SetType "Effect"
	:SetName "L.F. Effect"
	:SetDesc "This only helps you if you're drowning."
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
	:Set "Effect"

i(242)
	:Chance (5)
	:SetType "Effect"
	:SetName "Potke Effect"
	:SetDesc "You a sexy motherfucka."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(243)
	:Chance (5)
	:SetType "Effect"
	:SetName "Lovd Effect"
	:SetDesc "Why can't you lovd me."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(244)
	:Chance (5)
	:SetType "Effect"
	:SetName "M Effect"
	:SetDesc "Not any other letter."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(245)
	:Chance (5)
	:SetType "Effect"
	:SetName "Mage Effect"
	:SetDesc "Nice magic."
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
	:Set "Effect"

i(246)
	:Chance (5)
	:SetType "Effect"
	:SetName "Math Effect"
	:SetDesc "I was never good at math, but hey, I made this description."
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
	:Set "Effect"

i(248)
	:Chance (5)
	:SetType "Effect"
	:SetName "Metrocop Effect"
	:SetDesc "Not as cool as Robocop."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(249)
	:Chance (5)
	:SetType "Effect"
	:SetName "Trees Effect"
	:SetDesc "God of trees."
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
	:Set "Effect"

i(250)
	:Chance (5)
	:SetType "Effect"
	:SetName "Nature Effect"
	:SetDesc "God of nature."
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
	:Set "Effect"

i(251)
	:Chance (5)
	:SetType "Effect"
	:SetName "Pantom Effect"
	:SetDesc "You're a fucking demon."
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
	:Set "Effect"

i(252)
	:Chance (5)
	:SetType "Effect"
	:SetName "Paradigm Effect"
	:SetDesc "Be careful not to break the space time continuum."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(253)
	:Chance (5)
	:SetType "Effect"
	:SetName "Quartz Effect"
	:SetDesc "George6120: Thats a tricky one - Unless you want to reference Minecraft (^:."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(254)
	:Chance (5)
	:SetType "Effect"
	:SetName "Dead Bush Effect"
	:SetDesc "Don't fuck with this shrub."
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
	:Set "Effect"

i(255)
	:Chance (5)
	:SetType "Effect"
	:SetName "Scan Effect"
	:SetDesc "Scanning for possible scrub ... SCRUB FOUND."
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
	:Set "Effect"

i(256)
	:Chance (5)
	:SetType "Effect"
	:SetName "Rocket Effect"
	:SetDesc "5 .. 4 .. 3 .. 2 .. 1 .. LIFT OFF."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(257)
	:Chance (5)
	:SetType "Effect"
	:SetName "QT Effect"
	:SetDesc "I hope this helps you."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(258)
	:Chance (5)
	:SetType "Effect"
	:SetName "Particle Effect"
	:SetDesc "So pretty."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(259)
	:Chance (5)
	:SetType "Effect"
	:SetName "Lava Effect"
	:SetDesc "Feel the BURN."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(260)
	:Chance (5)
	:SetType "Effect"
	:SetName "Toxin Effect"
	:SetDesc "You're toxic."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(261)
	:Chance (5)
	:SetType "Effect"
	:SetName "Wisp Effect"
	:SetDesc "Woah that's pretty cool."
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
	:Set "Effect"

i(262)
	:Chance (5)
	:SetType "Effect"
	:SetName "Stone Effect"
	:SetDesc "You are the king of stone."
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
	:Set "Effect"

i(264)
	:Chance (5)
	:SetType "Effect"
	:SetName "Gordon Effect"
	:SetDesc "What small body you have there Mr. Freeman."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(265)
	:Chance (5)
	:SetType "Effect"
	:SetName "Tornado Effect"
	:SetDesc "Don't let your house get swept up."
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
	:Set "Effect"

i(266)
	:Chance (5)
	:SetType "Effect"
	:SetName "Turtle Effect"
	:SetDesc "Awww it's a turtle."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(267)
	:Chance (5)
	:SetType "Effect"
	:SetName "Valve Effect"
	:SetDesc "The annoying intro everyone watches because it's cool anyways."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(268)
	:Chance (5)
	:SetType "Effect"
	:SetName "White Snake Effect"
	:SetDesc "You sneaky bastard."
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
		return model, pos, ang
	end)
	:Set "Effect"

i(269)
	:Chance (5)
	:SetType "Effect"
	:SetName "Acid Effect"
	:SetDesc "Get slimed."
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
	:Set "Effect"

i(270)
	:Chance (5)
	:SetType "Effect"
	:SetName "Yellow Data Effect"
	:SetDesc "This is what's left from the yellow DDoS attack."
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
		return model, pos, ang
	end)
	:Set "Effect"





------------------------------------
--
-- Easter Collection
--
------------------------------------

i(851)
	:Chance (8)
	:SetType "Crate"
	:SetName "Easter Egg"
	:SetDesc "This egg contains an item from the Easter 2017 Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/easter_egg64.png"
	:SetShop (350, false)
	:Set "Easter"


------------------------------------
-- Extinct Items
------------------------------------

i(867)
	:Chance (8)
	:SetType "Tier"
	:SetName "Egg-Cellent"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Easter"

i(868)
	:Chance (8)
	:SetType "Tier"
	:SetName "Egg-Citing"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Easter"

i(869)
	:Chance (8)
	:SetType "Tier"
	:SetName "Egg-Sposed"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Easter"

i(870)
	:Chance (8)
	:SetType "Tier"
	:SetName "Egg-Straodinary"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Easter"

i(865)
	:Chance (8)
	:SetType "Tier"
	:SetName "Egg-Stravaganza"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "Easter"

i(871)
	:Chance (8)
	:SetType "Tier"
	:SetName "Egg-Streme"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (2, 2)
	:Set "Easter"

i(863)
	:Chance (8)
	:SetType "Tier"
	:SetName "Hippity"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Easter"

i(864)
	:Chance (8)
	:SetType "Tier"
	:SetName "Hoppity"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Easter"

i(872)
	:Chance (8)
	:SetType "Unique"
	:SetName "Bunny-N-Clyde"
	:SetEffect "glow"
	:SetWeapon "weapon_thompson"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Easter"

i(873)
	:Chance (8)
	:SetType "Unique"
	:SetName "Easter90"
	:SetEffect "glow"
	:SetWeapon "weapon_rcp120"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Easter"

i(874)
	:Chance (8)
	:SetType "Unique"
	:SetName "Easternator"
	:SetEffect "glow"
	:SetWeapon "weapon_virus9mm"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Easter"

i(875)
	:Chance (8)
	:SetType "Unique"
	:SetName "Hippity Hoppity"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m1911"
	:SetStats (6, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Easter"

i(861)
	:Chance (8)
	:SetType "Model"
	:SetName "Bunny Model"
	:SetDesc "Eh... What's up doc? Hehe..."
	:SetModel "models/player/bugsb/bugsb.mdl"
	:Set "Easter"

i(862)
	:Chance (8)
	:SetType "Model"
	:SetName "Eastertrooper Model"
	:SetDesc "You sure this is where we're supposed to wait? - Yes."
	:SetModel "models/burd/player/eastertrooper/eastertrooper.mdl"
	:Set "Easter"

i(853)
	:Chance (8)
	:SetType "Mask"
	:SetName "Alien Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(854)
	:Chance (8)
	:SetType "Mask"
	:SetName "Blue Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(852)
	:Chance (8)
	:SetType "Mask"
	:SetName "Lava Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(855)
	:Chance (8)
	:SetType "Mask"
	:SetName "Money Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(856)
	:Chance (8)
	:SetType "Mask"
	:SetName "Mysterious Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(857)
	:Chance (8)
	:SetType "Mask"
	:SetName "Slime Sheet Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(858)
	:Chance (8)
	:SetType "Mask"
	:SetName "Stained Glass Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(859)
	:Chance (8)
	:SetType "Mask"
	:SetName "Wireframe Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"

i(860)
	:Chance (8)
	:SetType "Mask"
	:SetName "Wooden Egg Mask"
	:SetDesc "Quite the pretty egg head you got there."
	:SetModel "models/props_phx/misc/egg.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		local mat = Matrix()
		mat:Scale(Vector(3, 3, 3))
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial(self.EggMaterial)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Easter"





------------------------------------
--
-- Easter 2019 Collection
--
------------------------------------

i(8998)
	:Chance (8)
	:SetType "Crate"
	:SetName "Easter Basket 2019"
	:SetDesc "This basket contains an item from the Easter 2018 and 2019 Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/easter_basket64.png"
	:SetShop (350, false)
	:Set "Easter 2019"


------------------------------------
-- Specialized Items
------------------------------------

i(4532)
	:Chance (3)
	:SetType "Hat"
	:SetName "Hatching Noob"
	:SetDesc "I like to hide in my shell some times."
	:SetIcon "https://cdn.moat.gg/f/24e1b504b09d4c6625e51cd2f7140b3b.png"
	:SetModel "models/custom_prop/moatgaming/eastegg/eastegg.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -3.8)+ (a:Right() * -1.007)+ (a:Up() * -9.757)
		return m, p, a
	end)
	:Set "Easter 2019"

i(6226)
	:Chance (3)
	:SetType "Skin"
	:SetName "Mirrored Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/e12490e67e214bf4f597f29dcbd43313.jpg.png"
	:Set "Easter 2019"

i(6245)
	:Chance (3)
	:SetType "Skin"
	:SetName "Yellow Bricks Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/0e53fbc7723ee02365d27f35c378fdd9.jpg.png"
	:Set "Easter 2019"

i(6246)
	:Chance (3)
	:SetType "Skin"
	:SetName "Yellow Flowe Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/b3e968f6ac6c99c6c3f9cd0320d1c0fa.jpg.png"
	:Set "Easter 2019"

i(6203)
	:Chance (3)
	:SetType "Skin"
	:SetName "Camo Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/26999dfcaa29a2f603624dd2e7578a5c.jpg.png"
	:Set "Easter 2019"


------------------------------------
-- Superior Items
------------------------------------

i(4530)
	:Chance (4)
	:SetType "Hat"
	:SetName "Playboy Parti Bunni"
	:SetDesc "Catch me wearing this around the mansion."
	:SetIcon "https://cdn.moat.gg/f/8cd435b47a8606ad6f0112eeb870085f.png"
	:SetModel "models/moat/mg_hat_easterhat.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -2.8)+ (a:Right() * 0)+ (a:Up() * 4.104)
		return m, p, a
	end)
	:Set "Easter 2019"

i(6241)
	:Chance (4)
	:SetType "Skin"
	:SetName "Tiles Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/f1ef513d825b3b75061c2040f67f25e2.jpg.png"
	:Set "Easter 2019"

i(6210)
	:Chance (4)
	:SetType "Skin"
	:SetName "Energy Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/4e50c2f170712682f3ce78f0c1d93168.jpg.png"
	:Set "Easter 2019"

i(6214)
	:Chance (4)
	:SetType "Skin"
	:SetName "Halo Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/f2a69a05c99bb506d028be0e31d7d615.jpg.png"
	:Set "Easter 2019"

i(6234)
	:Chance (4)
	:SetType "Skin"
	:SetName "Splat Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/f68e6ba244a2643979b3f25c5c694049.jpg.png"
	:Set "Easter 2019"

i(6202)
	:Chance (4)
	:SetType "Skin"
	:SetName "Butterflies Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/2e098152134e19a1d46b70e3891915e0.jpg.png"
	:Set "Easter 2019"

i(6221)
	:Chance (4)
	:SetType "Skin"
	:SetName "Lava Lamp Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/98cddcb0be672f1edf9a025368387046.png"
	:Set "Easter 2019"

i(6237)
	:Chance (4)
	:SetType "Skin"
	:SetName "Sunflower Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/93a14c7f43cfbc4909c2bdc547aae2f5.jpg.png"
	:Set "Easter 2019"

i(6205)
	:Chance (4)
	:SetType "Skin"
	:SetName "Cheetah Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/2bca40a67181b8140ca9c08e4fbf3ce1.jpg.png"
	:Set "Easter 2019"

i(6206)
	:Chance (4)
	:SetType "Skin"
	:SetName "Dew Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/3c7169761fb38e824f85a3934a0339a6.jpg.png"
	:Set "Easter 2019"


------------------------------------
-- High-End Items
------------------------------------

i(4531)
	:Chance (5)
	:SetType "Hat"
	:SetName "Pot Head"
	:SetDesc "Don't forget to water your flowers."
	:SetIcon "https://cdn.moat.gg/f/7e81543cab4cc40c0414fe1ff9d17d75.png"
	:SetModel "models/moat/mg_hat_easterflowers.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -2.801)+ (a:Right() * 0)+ (a:Up() * 5.267)
		return m, p, a
	end)
	:Set "Easter 2019"

i(6209)
	:Chance (5)
	:SetType "Skin"
	:SetName "Energy Flower Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/3370671649f4764afc07574466d85e05.jpg.png"
	:Set "Easter 2019"

i(6242)
	:Chance (5)
	:SetType "Skin"
	:SetName "Triangles Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/f7b3d0c70bfbe27b4d0716dde28c1e44.jpg.png"
	:Set "Easter 2019"

i(6227)
	:Chance (5)
	:SetType "Skin"
	:SetName "Missing Green Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/2f78bfbc6eb50ed5fbb62b955cb42cef.jpg.png"
	:Set "Easter 2019"

i(6228)
	:Chance (5)
	:SetType "Skin"
	:SetName "Mosaic Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/ffcec3d022cb2c72fdb327bec38a5d88.png"
	:Set "Easter 2019"

i(6244)
	:Chance (5)
	:SetType "Skin"
	:SetName "Watery Night Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/1d6c0535501256cae3d4b9d00ec45011.jpg.png"
	:Set "Easter 2019"

i(6229)
	:Chance (5)
	:SetType "Skin"
	:SetName "Motherboard Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/94fd7c9226bd7a6c9bd379c95fc553b0.png"
	:Set "Easter 2019"

i(6215)
	:Chance (5)
	:SetType "Skin"
	:SetName "Heatwave Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/d58bf097bad54764a67b37088437dc31.png"
	:Set "Easter 2019"

i(6232)
	:Chance (5)
	:SetType "Skin"
	:SetName "Penguins Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/bb5f686263b962c0f180aa12731c0038.png"
	:Set "Easter 2019"

i(6200)
	:Chance (5)
	:SetType "Skin"
	:SetName "Blurred Neon Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/8386aa028923f6a3dd29c47ef921858c.png"
	:Set "Easter 2019"

i(6217)
	:Chance (5)
	:SetType "Skin"
	:SetName "Hypno Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/aa9c50ad672c54e36ee5df8de15eb102.jpg.png"
	:Set "Easter 2019"

i(6201)
	:Chance (5)
	:SetType "Skin"
	:SetName "Bubbles Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/6e44b0bdd0825e94314b7c3213b826c3.png"
	:Set "Easter 2019"

i(6218)
	:Chance (5)
	:SetType "Skin"
	:SetName "Illusion Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/73ddf39d987cf26bff825a807e64ee32.jpg.png"
	:Set "Easter 2019"

i(6219)
	:Chance (5)
	:SetType "Skin"
	:SetName "Kaleidoscope Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/9527ea7c171b0f03b3d37c9f8c92f522.png"
	:Set "Easter 2019"

i(6220)
	:Chance (5)
	:SetType "Skin"
	:SetName "Kali Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/4e3671954223fe4e55e25a24850da1de.jpg.png"
	:Set "Easter 2019"

i(6204)
	:Chance (5)
	:SetType "Skin"
	:SetName "Caution Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/efb9e85dcbc8d7e8d1f26e829754d192.jpg.png"
	:Set "Easter 2019"

i(6223)
	:Chance (5)
	:SetType "Skin"
	:SetName "Loofa Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/096d3872874a46ab8b7c90a3c11b1722.png"
	:Set "Easter 2019"

i(6207)
	:Chance (5)
	:SetType "Skin"
	:SetName "Electric Current Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/763b8407dba8b2102880b2210d679220.png"
	:Set "Easter 2019"


------------------------------------
-- Ascended Items
------------------------------------

i(4529)
	:Chance (6)
	:SetType "Hat"
	:SetName "Holy Cuteness"
	:SetDesc "OMFGGG MOM ITS SO CUTE!!!! CAN WE KEEP ITT PELASE PLEASE PELASEEEE .."
	:SetIcon "https://cdn.moat.gg/f/bd134f0c72698bc5e8df2bede9015f1f.png"
	:SetModel "models/moat/mg_hat_easterchick.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -2.04)+ (a:Right() * 0.001)+ (a:Up() * 9.416)
		return m, p, a
	end)
	:Set "Easter 2019"

i(6243)
	:Chance (6)
	:SetType "Skin"
	:SetName "Void Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/41c59ed5285ec1793ad8ddcd7402f7a9.jpg.png"
	:Set "Easter 2019"

i(6213)
	:Chance (6)
	:SetType "Skin"
	:SetName "Hairy Dragon Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/9d832c58737ea628dfefe14ddf62010c.jpg.png"
	:Set "Easter 2019"

i(6230)
	:Chance (6)
	:SetType "Skin"
	:SetName "Neon Rider Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/80599b6d0f3a3733d12a0e76343f5c0c.png"
	:Set "Easter 2019"

i(6231)
	:Chance (6)
	:SetType "Skin"
	:SetName "Pattern Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/e9f95060477c24caa31d27206e08b980.jpg.png"
	:Set "Easter 2019"

i(6216)
	:Chance (6)
	:SetType "Skin"
	:SetName "Hyperdrive Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/05789d96474c80c2bb9a6e86b11dcf2a.png"
	:Set "Easter 2019"

i(6233)
	:Chance (6)
	:SetType "Skin"
	:SetName "Refraction Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/2dd95e12a6c1bfbb96b50c49ece779af.jpg.png"
	:Set "Easter 2019"

i(6235)
	:Chance (6)
	:SetType "Skin"
	:SetName "Starry Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/6a57bc4a867ea83dba4bc95270663ae7.jpg.png"
	:Set "Easter 2019"

i(6236)
	:Chance (6)
	:SetType "Skin"
	:SetName "Stem Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/94aa34eb2558a67ae37041b9812ab485.jpg.png"
	:Set "Easter 2019"

i(6222)
	:Chance (6)
	:SetType "Skin"
	:SetName "Light Show Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/f4b666942ba450e36a81ddcb4deae445.jpg.png"
	:Set "Easter 2019"

i(6238)
	:Chance (6)
	:SetType "Skin"
	:SetName "Sunset Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/c6c34740a195115ef61f5f785fc96974.jpg.png"
	:Set "Easter 2019"

i(6239)
	:Chance (6)
	:SetType "Skin"
	:SetName "Swirls Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/0209a13a0c4a8fc15e8a0a934dc02969.png"
	:Set "Easter 2019"

i(6208)
	:Chance (6)
	:SetType "Skin"
	:SetName "Encrypted Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/b21555007ac41a2902398a462560affa.png"
	:Set "Easter 2019"

i(6224)
	:Chance (6)
	:SetType "Skin"
	:SetName "Lunar Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/1bec49a349602c7f1e8103deec138311.png"
	:Set "Easter 2019"

i(6240)
	:Chance (6)
	:SetType "Skin"
	:SetName "Techno Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/69b5ad1fa4b5b0085239a6388f6d5e11.jpg.png"
	:Set "Easter 2019"


------------------------------------
-- Cosmic Items
------------------------------------

i(4539)
	:Chance (7)
	:SetType "Hat"
	:SetName "Easter Icon"
	:SetDesc "But from this earth, this grave, this dust, my God shall raise me up, I trust."
	:SetIcon "https://cdn.moat.gg/f/6ad1a835688e7dd265fdda23e405f2c2.png"
	:SetModel "models/moat/mg_hat_easteregg.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		p = p + (a:Forward() * -2.801)+ (a:Right() * 0)+ (a:Up() * 9.259)
		return m, p, a
	end)
	:Set "Easter 2019"

i(6225)
	:Chance (7)
	:SetType "Skin"
	:SetName "Magikarp Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/4f7f00786c835fb61c4dde9d888c3aa5.jpg.png"
	:Set "Easter 2019"

i(6211)
	:Chance (7)
	:SetType "Skin"
	:SetName "Fantasy Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/9df22d8c941edfa345c794c6f6343aa8.png"
	:Set "Easter 2019"

i(6212)
	:Chance (7)
	:SetType "Skin"
	:SetName "Glitch Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/owo/2/300d4710501cc1332f1030a9cd80fe17.png"
	:Set "Easter 2019"


------------------------------------
-- Extinct Items
------------------------------------

i(13375)
	:Chance (8)
	:SetType "Unique"
	:SetName "Dual Glocks"
	:SetWeapon "weapon_ttt_dual_glock"
	:SetStats (6, 7)
		:Stat ("Weight", 7, 4)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (2, 3)
	:Set "Easter 2019"

i(13377)
	:Chance (8)
	:SetType "Unique"
	:SetName "Dual H.U.G.E-249s"
	:SetWeapon "weapon_ttt_dual_huge"
	:SetStats (6, 7)
		:Stat ("Weight", 20, 10)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Easter 2019"

i(13374)
	:Chance (8)
	:SetType "Unique"
	:SetName "Dual MAC10s"
	:SetWeapon "weapon_ttt_dual_mac10"
	:SetStats (6, 7)
		:Stat ("Weight", 14, 8)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Easter 2019"

i(13378)
	:Chance (8)
	:SetType "Unique"
	:SetName "Dual SG550s"
	:SetWeapon "weapon_ttt_dual_sg550"
	:SetStats (6, 7)
		:Stat ("Weight", 16, 8)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Easter 2019"

i(13373)
	:Chance (8)
	:SetType "Unique"
	:SetName "Dual TMPs"
	:SetWeapon "weapon_ttt_dual_tmp"
	:SetStats (6, 7)
		:Stat ("Weight", 4, -4)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Easter 2019"

i(13376)
	:Chance (8)
	:SetType "Unique"
	:SetName "Dual UMPs"
	:SetWeapon "weapon_ttt_dual_ump"
	:SetStats (6, 7)
		:Stat ("Weight", 0, -4)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (3, 3)
	:Set "Easter 2019"


------------------------------------
-- Planetary Items
------------------------------------

i(4538)
	:Chance (9)
	:SetType "Hat"
	:SetName "The Easter Bunny"
	:SetDesc "Holy cowww."
	:SetModel "models/custom_prop/moatgaming/eastbunny/eastbunny.mdl"
	:SetRender ("eyes", function(pl, m, p, a)
		m:SetModelScale(1.1)
		p = p + (a:Forward() * -3.732)+ (a:Right() * 0.001)+ (a:Up() * -0.3)
		a:RotateAroundAxis(a:Up(), 90)
		return m, p, a
	end)
	:Set "Easter 2019"





------------------------------------
--
-- Easter 2018 Collection
--
------------------------------------

i(8983)
	:Chance (8)
	:SetType "Usable"
	:SetName "Old Timey Easter Egg"
	:SetDesc "A usable capable of summoning 2017's easter egg."
	:SetIcon "https://cdn.moat.gg/f/easter_eggold64.png"
	:SetShop (100, false)
	:Set "Easter 2018"


------------------------------------
-- Extinct Items
------------------------------------

i(9000)
	:Chance (8)
	:SetType "Mask"
	:SetName "Bluesteel Egg Of Genius"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/bluesteel_egg_of_genius.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9001)
	:Chance (8)
	:SetType "Mask"
	:SetName "Aqueous Egg Of River Riding"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/aqueous_egg_of_river_riding.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9002)
	:Chance (8)
	:SetType "Mask"
	:SetName "Wikipedian Egg Of Alien Mind Control"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/wikipedian_egg_of_alien_mind_control.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9003)
	:Chance (8)
	:SetType "Mask"
	:SetName "Vicious Egg Of Singularity"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/vicious_egg_of_singularity.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9004)
	:Chance (8)
	:SetType "Mask"
	:SetName "Chrome Egg Of Speeding Bullet"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/chrome_egg_of_speeding_bullet.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9005)
	:Chance (8)
	:SetType "Mask"
	:SetName "Dodge Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/dodge_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9006)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggotrip"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggotrip.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9007)
	:Chance (8)
	:SetType "Mask"
	:SetName "Unassuming Egg Of Shyness"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/unassuming_egg_of_shyness.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9008)
	:Chance (8)
	:SetType "Mask"
	:SetName "Dark Crimson Egg Of Nemesis"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/dark_crimson_egg_of_nemesis.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9009)
	:Chance (8)
	:SetType "Mask"
	:SetName "Duskeye Egg Of The Crossroads"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/duskeye_egg_of_the_crossroads.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9010)
	:Chance (8)
	:SetType "Mask"
	:SetName "Terrordactyl Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/terrordactyl_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9011)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggsplosive Bomb Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggsplosive_bomb_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9012)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggtus"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggtus.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9013)
	:Chance (8)
	:SetType "Mask"
	:SetName "Strawbeggy"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/strawbeggy.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9014)
	:Chance (8)
	:SetType "Mask"
	:SetName "Stooge Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/stooge_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9015)
	:Chance (8)
	:SetType "Mask"
	:SetName "Blinking Egg Of Relocation"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/blinking_egg_of_relocation.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9016)
	:Chance (8)
	:SetType "Mask"
	:SetName "Starry Egg Of The Wild Ride"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/starry_egg_of_the_wild_ride.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9017)
	:Chance (8)
	:SetType "Mask"
	:SetName "Self Replicating Egg Of Grey Goo"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/self_replicating_egg_of_grey_goo.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9018)
	:Chance (8)
	:SetType "Mask"
	:SetName "Rusty Egg Of Magnetism"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/rusty_egg_of_magnetism.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9019)
	:Chance (8)
	:SetType "Mask"
	:SetName "Ruby Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/ruby_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9020)
	:Chance (8)
	:SetType "Mask"
	:SetName "Beehive Egg Of Infinite Stings"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/beehive_egg_of_infinite_stings.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9021)
	:Chance (8)
	:SetType "Mask"
	:SetName "Puzzling Egg Of Enigma"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/puzzling_egg_of_enigma.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9022)
	:Chance (8)
	:SetType "Mask"
	:SetName "Organic Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/organic_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9023)
	:Chance (8)
	:SetType "Mask"
	:SetName "Normal Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/normal_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9024)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of All-Devouring Darkness"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_all-devouring_darkness.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9025)
	:Chance (8)
	:SetType "Mask"
	:SetName "Lumineggscence"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/lumineggscence.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9026)
	:Chance (8)
	:SetType "Mask"
	:SetName "Kind Egg Of Sharing"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/kind_egg_of_sharing.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9027)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggvertisement Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggvertisement_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9028)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Flawless Teamwork"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_flawless_teamwork.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9029)
	:Chance (8)
	:SetType "Mask"
	:SetName "Invisible Egg Of Shadow"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/invisible_egg_of_shadow.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9030)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggsterminator Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggsterminator_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9031)
	:Chance (8)
	:SetType "Mask"
	:SetName "Impossible Egg Of Genius"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/impossible_egg_of_genius.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9032)
	:Chance (8)
	:SetType "Mask"
	:SetName "Cataclysmic Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/cataclysmic_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9033)
	:Chance (8)
	:SetType "Mask"
	:SetName "Heat-Seeking Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/heat-seeking_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9034)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Four Wonders"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_four_wonders.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9035)
	:Chance (8)
	:SetType "Mask"
	:SetName "Golden Egg Of Kings"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/golden_egg_of_kings.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9036)
	:Chance (8)
	:SetType "Mask"
	:SetName "Full Moon Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/full_moon_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9037)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Equinox Day"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_equinox_day.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9038)
	:Chance (8)
	:SetType "Mask"
	:SetName "Extinct Egg Of Dino On Ice"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/extinct_egg_of_dino_on_ice.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9039)
	:Chance (8)
	:SetType "Mask"
	:SetName "Fiery Egg Of Egg Testing"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/fiery_egg_of_egg_testing.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9040)
	:Chance (8)
	:SetType "Mask"
	:SetName "Explosive Egg Of Kaboom"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/explosive_egg_of_kaboom.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9041)
	:Chance (8)
	:SetType "Mask"
	:SetName "Invisible Egg Of Shadow Notinvisible"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/invisible_egg_of_shadow_notinvisible.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9042)
	:Chance (8)
	:SetType "Mask"
	:SetName "Insanely Valuable Crystal Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/insanely_valuable_crystal_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9043)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Shield"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_shield.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9044)
	:Chance (8)
	:SetType "Mask"
	:SetName "Subterranean Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/subterranean_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9045)
	:Chance (8)
	:SetType "Mask"
	:SetName "Bouncing Egg Of Boing Boing"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/bouncing_egg_of_boing_boing.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9046)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg-Bit"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg-bit.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9047)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Verticality"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_verticality.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9048)
	:Chance (8)
	:SetType "Mask"
	:SetName "Basic Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/basic_egg_2014.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9049)
	:Chance (8)
	:SetType "Mask"
	:SetName "Colored Dot Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/colored_dot_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9050)
	:Chance (8)
	:SetType "Mask"
	:SetName "Frostbitten Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/frostbitten_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9051)
	:Chance (8)
	:SetType "Mask"
	:SetName "Bombastic Egg Of Annihilation"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/bombastic_egg_of_annihilation.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9052)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggmageddon"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggmageddon.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9053)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Epic Growth"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_epic_growth.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9054)
	:Chance (8)
	:SetType "Mask"
	:SetName "Dust Deviled Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/dust_deviled_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9055)
	:Chance (8)
	:SetType "Mask"
	:SetName "Chocolate Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/chocolate_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9056)
	:Chance (8)
	:SetType "Mask"
	:SetName "Brighteyes Pink Egg Of Anticipation"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/brighteyes_pink_egg_of_anticipation.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9057)
	:Chance (8)
	:SetType "Mask"
	:SetName "Brighteyes Lavender Egg Of Anticipation"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/brighteyes_lavender_egg_of_anticipation.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9058)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Equinox Night"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_equinox_night.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9059)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Destiny"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_destiny.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9060)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Frost"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_frost.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9061)
	:Chance (8)
	:SetType "Mask"
	:SetName "Arborists Verdant Egg Of Leafyness"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/arborists_verdant_egg_of_leafyness.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9062)
	:Chance (8)
	:SetType "Mask"
	:SetName "Royal Agate Egg Of Beautiful Dreams"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/royal_agate_egg_of_beautiful_dreams.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9063)
	:Chance (8)
	:SetType "Mask"
	:SetName "Radioactive Egg Of Undead Apocalypse"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/radioactive_egg_of_undead_apocalypse.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9064)
	:Chance (8)
	:SetType "Mask"
	:SetName "Tiger Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/tiger_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9065)
	:Chance (8)
	:SetType "Mask"
	:SetName "Tldr Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/tldr_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9066)
	:Chance (8)
	:SetType "Mask"
	:SetName "Violently Pink Egg Of Violent Opinions"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/violently_pink_egg_of_violent_opinions.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9067)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Friendship"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_friendship.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9068)
	:Chance (8)
	:SetType "Mask"
	:SetName "Futuristic Egg Of Antigravity"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/futuristic_egg_of_antigravity.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9069)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggscrutiatingly Deviled Scripter"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggscrutiatingly_deviled_scripter.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9070)
	:Chance (8)
	:SetType "Mask"
	:SetName "Scenic Egg Of The Clouds"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/scenic_egg_of_the_clouds.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9071)
	:Chance (8)
	:SetType "Mask"
	:SetName "Preggstoric Fossil"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/preggstoric_fossil.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9072)
	:Chance (8)
	:SetType "Mask"
	:SetName "Shiny Gold Egg Of Switcheroo"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/shiny_gold_egg_of_switcheroo.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9073)
	:Chance (8)
	:SetType "Mask"
	:SetName "Yolks On Us"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/yolks_on_us.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9074)
	:Chance (8)
	:SetType "Mask"
	:SetName "Mean Eggstructor"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/mean_eggstructor.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9075)
	:Chance (8)
	:SetType "Mask"
	:SetName "Aqua Pal Of Egglantis"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/aqua_pal_of_egglantis.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9077)
	:Chance (8)
	:SetType "Mask"
	:SetName "Wanwood Egg Of Zomg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/wanwood_egg_of_zomg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9078)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Last Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_last_egg_2013.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9079)
	:Chance (8)
	:SetType "Mask"
	:SetName "Fiery Dreggon"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/fiery_dreggon.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9080)
	:Chance (8)
	:SetType "Mask"
	:SetName "Elevated Egg Of The Eyrie"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/elevated_egg_of_the_eyrie.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9081)
	:Chance (8)
	:SetType "Mask"
	:SetName "Cracked Egg Of Pwnage"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/cracked_egg_of_pwnage.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9082)
	:Chance (8)
	:SetType "Mask"
	:SetName "Rabid Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/rabid_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.4830322265625) + (ang:Right() * 0.535400390625) +  (ang:Up() * 6.05029296875)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9083)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Easiest Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_easiest_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9084)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggcellent Pearl"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggcellent_pearl.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9085)
	:Chance (8)
	:SetType "Mask"
	:SetName "Bird Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/bird_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9086)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of The Phoenix"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_the_phoenix.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9087)
	:Chance (8)
	:SetType "Mask"
	:SetName "Watermelon"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/watermelon.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9088)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Mad Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_mad_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.75)
		pos = pos + (ang:Forward() * -3.113525390625) + (ang:Right() * 1.1524658203125) +  (ang:Up() * -0.19969940185547)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9089)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Cooperation"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_cooperation.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9090)
	:Chance (8)
	:SetType "Mask"
	:SetName "Cracked Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/cracked_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9091)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Cloud Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_cloud_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9092)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Partnership"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_partnership.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9093)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggsplosion"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggsplosion.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9094)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Last Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_last_egg_2012.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9095)
	:Chance (8)
	:SetType "Mask"
	:SetName "Thundering Egg Of Lightning Strikes"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/thundering_egg_of_lightning_strikes.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9096)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Eggverse"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_eggverse.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9097)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Obsidian Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_obsidian_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9098)
	:Chance (8)
	:SetType "Mask"
	:SetName "Pow To The Moon Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/pow_to_the_moon_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9099)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggdress Of The Chief"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggdress_of_the_chief.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9100)
	:Chance (8)
	:SetType "Mask"
	:SetName "IEgg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/iegg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9101)
	:Chance (8)
	:SetType "Mask"
	:SetName "Tldr Egg Of Eggstreme Aggravation"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/tldr_egg_of_eggstreme_aggravation.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9102)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Timer"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_timer.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9103)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggy Pop"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggy_pop.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9104)
	:Chance (8)
	:SetType "Mask"
	:SetName "Top Of The World Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/top_of_the_world_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9105)
	:Chance (8)
	:SetType "Mask"
	:SetName "Luregg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/luregg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9106)
	:Chance (8)
	:SetType "Mask"
	:SetName "Scrambled Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/scrambled_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9107)
	:Chance (8)
	:SetType "Mask"
	:SetName "Vanishing Ninja Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/vanishing_ninja_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9108)
	:Chance (8)
	:SetType "Mask"
	:SetName "Vampiric Egg Of Twilight"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/vampiric_egg_of_twilight.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9109)
	:Chance (8)
	:SetType "Mask"
	:SetName "Dicey Egg Of Chance"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/dicey_egg_of_chance.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9110)
	:Chance (8)
	:SetType "Mask"
	:SetName "Unstable Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/unstable_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9111)
	:Chance (8)
	:SetType "Mask"
	:SetName "Phantom Of The Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/phantom_of_the_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9112)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Pirate Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_pirate_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9113)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Answer Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_answer_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9114)
	:Chance (8)
	:SetType "Mask"
	:SetName "Lost In Transit Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/lost_in_transit_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9115)
	:Chance (8)
	:SetType "Mask"
	:SetName "Plum Nesting Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/plum_nesting_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9116)
	:Chance (8)
	:SetType "Mask"
	:SetName "Lemon Nesting Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/lemon_nesting_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9117)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Amber Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_amber_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.75)
		pos = pos + (ang:Forward() * -3.130859375) + (ang:Right() * 0.0819091796875) +  (ang:Up() * -0.20054626464844)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9118)
	:Chance (8)
	:SetType "Mask"
	:SetName "Fancy Egg Of Fabulous"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/fancy_egg_of_fabulous.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9119)
	:Chance (8)
	:SetType "Mask"
	:SetName "Last Egg Standing"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/last_egg_standing.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9120)
	:Chance (8)
	:SetType "Mask"
	:SetName "Mystical Eggchemist"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/mystical_eggchemist.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9121)
	:Chance (8)
	:SetType "Mask"
	:SetName "Cherry Nesting Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/cherry_nesting_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9122)
	:Chance (8)
	:SetType "Mask"
	:SetName "Tesla Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/tesla_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.725)
		pos = pos + (ang:Forward() * -3.4835205078125) + (ang:Right() * -0.01953125) +  (ang:Up() * 5.1614456176758)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9123)
	:Chance (8)
	:SetType "Mask"
	:SetName "Tabby Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/tabby_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9124)
	:Chance (8)
	:SetType "Mask"
	:SetName "Super Bomb Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/super_bomb_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9125)
	:Chance (8)
	:SetType "Mask"
	:SetName "Pompeiian Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/pompeiian_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9126)
	:Chance (8)
	:SetType "Mask"
	:SetName "Specular Egg Of Red No Blue"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/specular_egg_of_red_no_blue.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9127)
	:Chance (8)
	:SetType "Mask"
	:SetName "Petrified Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/petrified_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9128)
	:Chance (8)
	:SetType "Mask"
	:SetName "Hyperactive Egg Of Hyperactivity"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/hyperactive_egg_of_hyperactivity.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9129)
	:Chance (8)
	:SetType "Mask"
	:SetName "Seal Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/seal_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9130)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggvertisement Egg  Pastel Boogaloo"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggvertisement_egg_2_pastel_boogaloo.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9131)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggcano"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggcano.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9132)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggrachnophobia"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggrachnophobia.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9133)
	:Chance (8)
	:SetType "Mask"
	:SetName "Zenos Egg Of Paradox"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/zenos_egg_of_paradox.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9134)
	:Chance (8)
	:SetType "Mask"
	:SetName "Stationary Egg Of Boring"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/stationary_egg_of_boring.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9135)
	:Chance (8)
	:SetType "Mask"
	:SetName "Sharing Egg Of Gifting"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/sharing_egg_of_gifting.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9136)
	:Chance (8)
	:SetType "Mask"
	:SetName "Billy The Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/billy_the_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9137)
	:Chance (8)
	:SetType "Mask"
	:SetName "Pegguin"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/pegguin.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9138)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Ra"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_ra.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9139)
	:Chance (8)
	:SetType "Mask"
	:SetName "Scramblin Egg Of Teleporting"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/scramblin_egg_of_teleporting.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9140)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Abyssal Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_abyssal_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9141)
	:Chance (8)
	:SetType "Mask"
	:SetName "Office Professional Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/office_professional_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9142)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg 9000"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg9000.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9143)
	:Chance (8)
	:SetType "Mask"
	:SetName "Agonizingly Ugly Egg Of Screensplat"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/agonizingly_ugly_egg_of_screensplat.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9144)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Farmer"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_farmer.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9145)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Luck"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_luck.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9146)
	:Chance (8)
	:SetType "Mask"
	:SetName "Deviled Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/deviled_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.66796875) + (ang:Right() * -2.6796875) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9147)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Flawless Deduction"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_flawless_deduction.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9148)
	:Chance (8)
	:SetType "Mask"
	:SetName "Humpty Dumpty"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/humpty_dumpty.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9149)
	:Chance (8)
	:SetType "Mask"
	:SetName "Martian Egghunter"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/martian_egghunter.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9150)
	:Chance (8)
	:SetType "Mask"
	:SetName "Ebr Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/ebr_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9151)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggressor"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggressor.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9152)
	:Chance (8)
	:SetType "Mask"
	:SetName "Peep-A-Boo Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/peep-a-boo_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9153)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggvalanche!"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggvalanche!.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9154)
	:Chance (8)
	:SetType "Mask"
	:SetName "Mummy Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/mummy_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9155)
	:Chance (8)
	:SetType "Mask"
	:SetName "Faster Than Light Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/faster_than_light_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.8)
		pos = pos + (ang:Forward() * -3.838623046875) + (ang:Right() * 0.036529541015625) +  (ang:Up() * 0.59132385253906)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9156)
	:Chance (8)
	:SetType "Mask"
	:SetName "Admin Egg Of Mischief"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/admin_egg_of_mischief.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -3.1535034179688) + (ang:Right() * -0.13259887695313) +  (ang:Up() * 3.657112121582)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9157)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Pearl"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_pearl.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.735)
		pos = pos + (ang:Forward() * -3.7059326171875) + (ang:Right() * -0.14248657226563) +  (ang:Up() * 1.8225250244141)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9158)
	:Chance (8)
	:SetType "Mask"
	:SetName "Leftover Egg Of Whatevers Left"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/leftover_egg_of_whatevers_left.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.8)
		pos = pos + (ang:Forward() * -0.37835693359375) + (ang:Right() * 0.055572509765625) +  (ang:Up() * 0.68265533447266)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9159)
	:Chance (8)
	:SetType "Mask"
	:SetName "Ethereal Ghost Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/ethereal_ghost_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.675)
		pos = pos + (ang:Forward() * -2.8767700195313) + (ang:Right() * 0.020477294921875) +  (ang:Up() * -0.04473876953125)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9160)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggtraterrestrial"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggtraterrestrial.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -2.8681640625) + (ang:Right() * 0.01214599609375) +  (ang:Up() * 1.1173782348633)
		ang:RotateAroundAxis(ang:Right(), -107.69999694824)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9161)
	:Chance (8)
	:SetType "Mask"
	:SetName "Gge"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/gge.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.306884765625) + (ang:Right() * 0.04052734375) +  (ang:Up() * 0.5899658203125)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 180)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9162)
	:Chance (8)
	:SetType "Mask"
	:SetName "Basket Of Eggception"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/basket_of_eggception.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.75)
		pos = pos + (ang:Forward() * -2.7950134277344) + (ang:Right() * -0) +  (ang:Up() * 4.0573883056641)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9163)
	:Chance (8)
	:SetType "Mask"
	:SetName "Air Balloon Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/s.s_egg_-_the_mighty_dirigible.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.475)
		pos = pos + (ang:Forward() * -3.213623046875) + (ang:Right() * 0.0863037109375) +  (ang:Up() * -1.3739624023438)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9164)
	:Chance (8)
	:SetType "Mask"
	:SetName "Wizard Of Astral Isles"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/wizard_of_astral_isles.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.575)
		pos = pos + (ang:Forward() * -3.4381103515625) + (ang:Right() * -0.14047241210938) +  (ang:Up() * 4.5401077270508)
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9165)
	:Chance (8)
	:SetType "Mask"
	:SetName "Racin Egg Of Fast Cars"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/racin_egg_of_fast_cars.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.65)
		pos = pos + (ang:Forward() * -3.1922607421875) + (ang:Right() * 0.07916259765625) +  (ang:Up() * 0.7210693359375)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9166)
	:Chance (8)
	:SetType "Mask"
	:SetName "Tiny Egg Of Nonexistence"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/tiny_egg_of_nonexistence.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		pos = pos + (ang:Forward() * -3.373779296875) + (ang:Right() * -0.1636962890625) +  (ang:Up() * 7.4242324829102)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9167)
	:Chance (8)
	:SetType "Mask"
	:SetName "Treasure Eggland"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/treasure_eggland.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.85)
		pos = pos + (ang:Forward() * -3.4093017578125) + (ang:Right() * -0.14895629882813) +  (ang:Up() * 4.0108642578125)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9168)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Space"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_space.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.65)
		pos = pos + (ang:Forward() * -3.9876098632813) + (ang:Right() * -0.25494384765625) +  (ang:Up() * 0.9698486328125)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), -280.20001220703)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9169)
	:Chance (8)
	:SetType "Mask"
	:SetName "Eggcognito Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/eggcognito_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.6)
		pos = pos + (ang:Forward() * -2.7053833007813) + (ang:Right() * -0) +  (ang:Up() * 0.72085571289063)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9170)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Innocence"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_innocence.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.35)
		pos = pos + (ang:Forward() * -3.1703491210938) + (ang:Right() * 0.00592041015625) +  (ang:Up() * 1.5388488769531)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9171)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Sands Of Time"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_sands_of_time.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.81)
		pos = pos + (ang:Forward() * -2.5338745117188) + (ang:Right() * 0.51425170898438) +  (ang:Up() * 0.95062255859375)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9172)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Eggteen-Twelve Overture"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_eggteen-twelve_overture.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.66)
		pos = pos + (ang:Forward() * -2.2990112304688) + (ang:Right() * -0.16574096679688) +  (ang:Up() * 1.9350891113281)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9173)
	:Chance (8)
	:SetType "Mask"
	:SetName "Cannonical Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/cannonical_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.75)
		pos = pos + (ang:Forward() * -4.3116989135742) + (ang:Right() * 0.001953125) +  (ang:Up() * 1.3859100341797)
		ang:RotateAroundAxis(ang:Right(), -36.900001525879)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9174)
	:Chance (8)
	:SetType "Mask"
	:SetName "Alien Arteggfact"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/alien_arteggfact.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.75)
		pos = pos + (ang:Forward() * -2.7769999504089) + (ang:Right() * -0) +  (ang:Up() * 1.1000000238419)
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9175)
	:Chance (8)
	:SetType "Mask"
	:SetName "Bellegg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/bellegg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.75)
		pos = pos + (ang:Forward() * -2.7950134277344) + (ang:Right() * -0) +  (ang:Up() * 4.0573883056641)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9176)
	:Chance (8)
	:SetType "Mask"
	:SetName "Scribbled Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/scribbled_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.525)
		pos = pos + (ang:Forward() * -3.6149291992188) + (ang:Right() * 0.11465454101563) +  (ang:Up() * 2.0404052734375)
		ang:RotateAroundAxis(ang:Right(), -180)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9177)
	:Chance (8)
	:SetType "Mask"
	:SetName "Malicious Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/malicious_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.925)
		pos = pos + (ang:Forward() * -3.4658203125) + (ang:Right() * 0.069549560546875) +  (ang:Up() * 0.090347290039063)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9178)
	:Chance (8)
	:SetType "Mask"
	:SetName "Close Eggcounters"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/close_eggcounters.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.6)
		pos = pos + (ang:Forward() * -3.3329467773438) + (ang:Right() * 0.014404296875) +  (ang:Up() * 7.0184783935547)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9179)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Life"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_life.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		pos = pos + (ang:Forward() * -3.17578125) + (ang:Right() * 0.01104736328125) +  (ang:Up() * -2.2247161865234)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9180)
	:Chance (8)
	:SetType "Mask"
	:SetName "Sorcus Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/sorcus_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.61)
		pos = pos + (ang:Forward() * -2.7235717773438) + (ang:Right() * -0.86248779296875) +  (ang:Up() * 1.7162933349609)
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9181)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Duty"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_duty.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.6)
		pos = pos + (ang:Forward() * -3.3696899414063) + (ang:Right() * -0.02252197265625) +  (ang:Up() * 0.21257019042969)
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 90)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9182)
	:Chance (8)
	:SetType "Mask"
	:SetName "Sand Shark Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/sand_shark_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.725)
		pos = pos + (ang:Forward() * -2.2077026367188) + (ang:Right() * 0.097442626953125) +  (ang:Up() * 1.2389678955078)
		ang:RotateAroundAxis(ang:Right(), 102.5)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9183)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Golden Achievement"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_golden_achievement.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.3)
		pos = pos + (ang:Forward() * -3.373779296875) + (ang:Right() * 0.003173828125) +  (ang:Up() * 3.6561584472656)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9184)
	:Chance (8)
	:SetType "Mask"
	:SetName "Egg Of Scales"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/egg_of_scales.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.575)
		pos = pos + (ang:Forward() * -3.9340209960938) + (ang:Right() * 0.02142333984375) +  (ang:Up() * 2.0720672607422)
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 180)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9185)
	:Chance (8)
	:SetType "Mask"
	:SetName "Combo Egg Of Trolllolol"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/combo_egg_of_trolllolol.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.6)
		pos = pos + (ang:Forward() * -2.29052734375) + (ang:Right() * 0.00537109375) +  (ang:Up() * 1.2985763549805)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9186)
	:Chance (8)
	:SetType "Mask"
	:SetName "Snowspheroid"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/snowspheroid.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.81)
		pos = pos + (ang:Forward() * -2.9716796875) + (ang:Right() * 0.13156127929688) +  (ang:Up() * 2.1076202392578)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9187)
	:Chance (8)
	:SetType "Mask"
	:SetName "Mercurial Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/mercurial_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.65)
		pos = pos + (ang:Forward() * -3.898681640625) + (ang:Right() * 0.0714111328125) +  (ang:Up() * 2.8903656005859)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9188)
	:Chance (8)
	:SetType "Mask"
	:SetName "Supersonic Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/supersonic_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.61)
		pos = pos + (ang:Forward() * -2.2730712890625) + (ang:Right() * -0.17501831054688) +  (ang:Up() * 0.95858764648438)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9189)
	:Chance (8)
	:SetType "Mask"
	:SetName "The Eggtopus"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/the_eggtopus.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.735)
		pos = pos + (ang:Forward() * -3.684326171875) + (ang:Right() * -0.15023803710938) +  (ang:Up() * -2.4682464599609)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"

i(9190)
	:Chance (8)
	:SetType "Mask"
	:SetName "Gooey Egg"
	:SetDesc "A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.."
	:SetModel "models/roblox_assets/gooey_egg.mdl"
	:SetRender ("eyes", function(pl, mdl, pos, ang)
		mdl:SetModelScale(0.625)
		pos = pos + (ang:Forward() * -3.310546875) + (ang:Right() * 0.044525146484375) +  (ang:Up() * 7.1444625854492)
		return mdl, pos, ang
	end)
	:Set "Easter 2018"





------------------------------------
--
-- Dual Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(13372)
	:Chance (8)
	:SetType "Tier"
	:SetName "Dual"
	:SetColor {0, 255, 128}
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
		:SetTalent (1, "Twins")
	:Set "Dual"





------------------------------------
--
-- Developer Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(3424)
	:Chance (8)
	:SetType "Tier"
	:SetName "HANDS OFF MY"
	:SetEffect "glow"
	:SetStats (9, 9)
		:Stat ("Weight", -5, -7)
		:Stat ("Magazine", 23, 33)
		:Stat ("Kick", -17, -28)
		:Stat ("Deployrate", -60, -40)
		:Stat ("Reloadrate", 80, 120)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Firerate", 17, 28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "Developer"





------------------------------------
--
-- Dev Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(222)
	:Chance (8)
	:SetType "Effect"
	:SetName "Developer Effect"
	:SetDesc "Time for the dev to get sxy."
	:SetModel "models/props_c17/tools_wrench01a.mdl"
	:SetRender ("ValveBiped.Bip01_Spine4", function(ply, model, pos, ang)
		local Size = Vector(0.8000, 0.5, 0.5)
		local mat = Matrix()
		local CT = CurTime()
		mat:Scale(Size)
		model:EnableMatrix("RenderMultiply", mat)
		model:SetMaterial("models/gibs/metalgibs/metal_gibs")
		local MAngle = Angle(236.35000,277.04002,360)
		local MPos = Vector(10.22000,-1,-8.220)
		pos = pos + ang:Forward() * MPos.x + ang:Up() * MPos.z + ang:Right() * MPos.y
		ang:RotateAroundAxis(ang:Forward(), MAngle.p)
		ang:RotateAroundAxis(ang:Up(), MAngle.y)
		ang:RotateAroundAxis(ang:Right(), MAngle.r)
		model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
		model.ModelDrawingAngle.p = CT * 0 * 90
		model.ModelDrawingAngle.y = CT * 1.129 * 90
		model.ModelDrawingAngle.r = CT * 1.039 * 90
		ang:RotateAroundAxis(ang:Forward(), model.ModelDrawingAngle.p)
		ang:RotateAroundAxis(ang:Up(), model.ModelDrawingAngle.y)
		ang:RotateAroundAxis(ang:Right(), model.ModelDrawingAngle.r)
		return model, pos, ang
	end)
	:Set "Dev"

i(90)
	:Chance (8)
	:SetType "Hat"
	:SetName "Developer Hat"
	:SetDesc "This is an exclusive hat given to people that have created content for MG."
	:SetModel "models/captainbigbutt/skeyler/hats/devhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Dev"





------------------------------------
--
-- Crimson Collection
--
------------------------------------

i(700)
	:Chance (2)
	:SetType "Crate"
	:SetName "Crimson Crate"
	:SetDesc "This crate contains an item from the Crimson Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/5ce300e78199481c28d09aebae2e0701.png"
	:SetShop (200, true)
	:Set "Crimson"


------------------------------------
-- Worn Items
------------------------------------

i(606)
	:Chance (1)
	:SetType "Tier"
	:SetName "Busted"
	:SetColor {255, 229, 204}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Crimson"

i(607)
	:Chance (1)
	:SetType "Tier"
	:SetName "Faulty"
	:SetColor {188, 143, 143}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Crimson"

i(608)
	:Chance (1)
	:SetType "Tier"
	:SetName "Rough"
	:SetColor {255, 160, 122}
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Crimson"

i(632)
	:Chance (1)
	:SetType "Unique"
	:SetName "Old Comrade"
	:SetColor {210, 180, 140}
	:SetWeapon "weapon_ttt_glock"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Crimson"

i(631)
	:Chance (1)
	:SetType "Unique"
	:SetName "Ruscelenas"
	:SetColor {245, 222, 179}
	:SetWeapon "weapon_ttt_dual_elites"
	:SetStats (1, 3)
	:SetTalents (1, 1)
	:Set "Crimson"

i(668)
	:Chance (1)
	:SetType "Mask"
	:SetName "Bloody Bird Mask"
	:SetDesc "A very pale vulture feasts on terrorist souls."
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
	:Set "Crimson"

i(650)
	:Chance (1)
	:SetType "Mask"
	:SetName "Bloody Butterfly Mask"
	:SetDesc "A very pale butterfly feasts on terrorist souls."
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
	:Set "Crimson"

i(651)
	:Chance (1)
	:SetType "Mask"
	:SetName "Bloody Rabbit Mask"
	:SetDesc "Who knew the easter bunny was hungry enough to eat human flesh."
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
	:Set "Crimson"


------------------------------------
-- Standard Items
------------------------------------

i(609)
	:Chance (2)
	:SetType "Tier"
	:SetName "Feeble"
	:SetColor {135, 206, 235}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Crimson"

i(610)
	:Chance (2)
	:SetType "Tier"
	:SetName "Retracted"
	:SetColor {176, 224, 230}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Crimson"

i(611)
	:Chance (2)
	:SetType "Tier"
	:SetName "Sustainable"
	:SetColor {152, 251, 152}
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Crimson"

i(634)
	:Chance (2)
	:SetType "Unique"
	:SetName "Shoopan"
	:SetColor {176, 196, 222}
	:SetWeapon "weapon_ttt_shotgun"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Crimson"

i(633)
	:Chance (2)
	:SetType "Unique"
	:SetName "Taluhoo"
	:SetWeapon "weapon_ttt_famas"
	:SetStats (2, 4)
	:SetTalents (1, 1)
	:Set "Crimson"

i(655)
	:Chance (2)
	:SetType "Mask"
	:SetName "Bloody Cat Mask"
	:SetDesc "Tearing up one face at a time."
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
	:Set "Crimson"

i(652)
	:Chance (2)
	:SetType "Mask"
	:SetName "Colorful Bird Mask"
	:SetDesc "You are a colorful human bird."
	:SetModel "models/splicermasks/birdmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Crimson"

i(653)
	:Chance (2)
	:SetType "Mask"
	:SetName "Royal Rabbit Mask"
	:SetDesc "Hop hop hop... here comes the royal easter bunny."
	:SetModel "models/splicermasks/rabbitmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 0.8) + (ang:Right() * 0) + (ang:Up() * -2.4)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Crimson"

i(654)
	:Chance (2)
	:SetType "Mask"
	:SetName "Royal Spider Mask"
	:SetDesc "The itsy bitsy spider crawled up the royal kingdom."
	:SetModel "models/splicermasks/spidermask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1) + (ang:Right() * 0) + (ang:Up() * -1.8)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Crimson"


------------------------------------
-- Specialized Items
------------------------------------

i(601)
	:Chance (3)
	:SetType "Power-Up"
	:SetName "Flame Retardant"
	:SetColor {255, 60, 0}
	:SetDesc "Fire and explosion damage is reduced by %s_ when using this powerup."
	:SetIcon "https://cdn.moat.gg/f/7d05b151a4f6536508979e4edc065afd.png"
	:SetStats (1, 1)
		:Stat (1, -35, -75)
	:Set "Crimson"

i(612)
	:Chance (3)
	:SetType "Tier"
	:SetName "Infringed"
	:SetColor {128, 128, 0}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Crimson"

i(614)
	:Chance (3)
	:SetType "Tier"
	:SetName "Unpassable"
	:SetColor {60, 179, 113}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Crimson"

i(613)
	:Chance (3)
	:SetType "Tier"
	:SetName "Tolerable"
	:SetColor {221, 160, 221}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Crimson"

i(636)
	:Chance (3)
	:SetType "Unique"
	:SetName "Kahtinga"
	:SetWeapon "weapon_ttt_aug"
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Crimson"

i(635)
	:Chance (3)
	:SetType "Unique"
	:SetName "Pocketier"
	:SetWeapon "weapon_ttt_p228"
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Crimson"

i(657)
	:Chance (3)
	:SetType "Mask"
	:SetName "Royal Cat Mask"
	:SetDesc "Don't touch me, I'm fabulous."
	:SetModel "models/splicermasks/catmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * 1) + (ang:Right() * 0.6) + (ang:Up() * -4.6)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Crimson"

i(656)
	:Chance (3)
	:SetType "Mask"
	:SetName "Turqoise Bird Mask"
	:SetDesc "I'm feelying quite blue and gray right now."
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
	:Set "Crimson"


------------------------------------
-- Superior Items
------------------------------------

i(600)
	:Chance (4)
	:SetType "Power-Up"
	:SetName "Credit Hoarder"
	:SetColor {255, 255, 0}
	:SetDesc "Start with %s extra credits as a detective/traitor when using this powerup."
	:SetIcon "https://cdn.moat.gg/f/78738ccf67e834f86317059b2dd06caf.png"
	:SetStats (1, 1)
		:Stat (1, 1, 5)
	:Set "Crimson"

i(616)
	:Chance (4)
	:SetType "Tier"
	:SetName "Kosher"
	:SetColor {186, 85, 211}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Crimson"

i(617)
	:Chance (4)
	:SetType "Tier"
	:SetName "Pleasant"
	:SetColor {218, 112, 214}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Crimson"

i(615)
	:Chance (4)
	:SetType "Tier"
	:SetName "Touted"
	:SetColor {34, 139, 34}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Crimson"

i(638)
	:Chance (4)
	:SetType "Unique"
	:SetName "Ecopati"
	:SetColor {0, 139, 139}
	:SetWeapon "weapon_ttt_m1911"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Crimson"

i(637)
	:Chance (4)
	:SetType "Unique"
	:SetName "Goongsta"
	:SetColor {139, 0, 0}
	:SetWeapon "weapon_ttt_mac11"
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Crimson"

i(659)
	:Chance (4)
	:SetType "Hat"
	:SetName "Heart Hat"
	:SetDesc "I'm in love with my head."
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
	:Set "Crimson"

i(658)
	:Chance (4)
	:SetType "Mask"
	:SetName "Arnold Mask"
	:SetDesc "Grrr.. I'm a mean dog."
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
	:Set "Crimson"

i(660)
	:Chance (4)
	:SetType "Mask"
	:SetName "Peacock Butterfly Mask"
	:SetDesc "Don't put me in a zoo please."
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
	:Set "Crimson"


------------------------------------
-- High-End Items
------------------------------------

i(604)
	:Chance (5)
	:SetType "Power-Up"
	:SetName "Experience Lover"
	:SetColor {255, 0, 255}
	:SetDesc "Gain %s_ more weapon XP after a rightfull kill when using this powerup."
	:SetIcon "https://cdn.moat.gg/f/1114672223ae94d7d0ea360abf9924e0.png"
	:SetStats (1, 1)
		:Stat (1, 25, 75)
	:Set "Crimson"

i(619)
	:Chance (5)
	:SetType "Tier"
	:SetName "Devoted"
	:SetColor {220, 20, 60}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Crimson"

i(620)
	:Chance (5)
	:SetType "Tier"
	:SetName "Lovely"
	:SetColor {255, 0, 255}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Crimson"

i(618)
	:Chance (5)
	:SetType "Tier"
	:SetName "Crimson"
	:SetColor {178, 34, 34}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Crimson"

i(639)
	:Chance (5)
	:SetType "Unique"
	:SetName "Breach-N-Clear"
	:SetWeapon "weapon_ttt_mp5k"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Crimson"

i(641)
	:Chance (5)
	:SetType "Unique"
	:SetName "M4ALover"
	:SetColor {220, 20, 60}
	:SetWeapon "weapon_ttt_m4a1"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Crimson"

i(640)
	:Chance (5)
	:SetType "Unique"
	:SetName "The Deliverer"
	:SetColor {0, 128, 0}
	:SetWeapon "weapon_ttt_deliverer"
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Crimson"

i(662)
	:Chance (5)
	:SetType "Mask"
	:SetName "Chuck Mask"
	:SetDesc "God Bless the Badass America."
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
	:Set "Crimson"

i(661)
	:Chance (5)
	:SetType "Mask"
	:SetName "Dolph Mask"
	:SetDesc "My horns will pierce any terrorist that gets in my way."
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
	:Set "Crimson"

i(663)
	:Chance (5)
	:SetType "Mask"
	:SetName "Heart Welder Mask"
	:SetDesc "You weld broken hearts back together."
	:SetModel "models/splicermasks/weldingmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Right() * 2.6) + (ang:Up() * -7.6)
		ang:RotateAroundAxis(ang:Right(), -0)
		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), 0)
		return model, pos, ang
	end)
	:Set "Crimson"


------------------------------------
-- Ascended Items
------------------------------------

i(602)
	:Chance (6)
	:SetType "Power-Up"
	:SetName "Hard Hat"
	:SetColor {0, 255, 255}
	:SetDesc "Headshot damage is reduced by %s_ when using this power-up."
	:SetIcon "https://cdn.moat.gg/f/ddaebffd6d2f4cdf354479e029426159.png"
	:SetStats (1, 1)
		:Stat (1, -15, -38)
	:Set "Crimson"

i(622)
	:Chance (6)
	:SetType "Tier"
	:SetName "Charismatic"
	:SetColor {199, 21, 133}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Crimson"

i(621)
	:Chance (6)
	:SetType "Tier"
	:SetName "Divine"
	:SetColor {0, 250, 154}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Crimson"

i(623)
	:Chance (6)
	:SetType "Tier"
	:SetName "Sacred"
	:SetColor {100, 149, 237}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Crimson"

i(642)
	:Chance (6)
	:SetType "Unique"
	:SetName "Autocatis"
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_cz75"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Crimson"

i(643)
	:Chance (6)
	:SetType "Unique"
	:SetName "Collectinator"
	:SetColor {255, 165, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m03a3"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Crimson"

i(644)
	:Chance (6)
	:SetType "Unique"
	:SetName "Deadshot"
	:SetColor {0, 206, 209}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_sg550"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Crimson"

i(645)
	:Chance (6)
	:SetType "Unique"
	:SetName "Westernaci"
	:SetColor {218, 165, 32}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_mr96"
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Crimson"

i(665)
	:Chance (6)
	:SetType "Mask"
	:SetName "Brown Horsie Mask"
	:SetDesc "Neihhhh, feed me apples and take me to water."
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
	:Set "Crimson"

i(664)
	:Chance (6)
	:SetType "Mask"
	:SetName "Po Mask"
	:SetDesc "The panda is a great animal and will always be named Po."
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
	:Set "Crimson"


------------------------------------
-- Cosmic Items
------------------------------------

i(625)
	:Chance (7)
	:SetType "Tier"
	:SetName "Righteous"
	:SetColor {255, 255, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Crimson"

i(626)
	:Chance (7)
	:SetType "Tier"
	:SetName "Saintlike"
	:SetColor {255, 69, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Crimson"

i(648)
	:Chance (7)
	:SetType "Unique"
	:SetName "Bond's Best Friend"
	:SetColor {255, 215, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_golden_deagle"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Crimson"

i(646)
	:Chance (7)
	:SetType "Unique"
	:SetName "Mohtuanica"
	:SetColor {220, 20, 60}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_mp5k"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Crimson"

i(647)
	:Chance (7)
	:SetType "Unique"
	:SetName "Ratisaci"
	:SetColor {0, 255, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_msbs"
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Crimson"

i(666)
	:Chance (7)
	:SetType "Mask"
	:SetName "Stallion Mask"
	:SetDesc "You are a beautiful horse."
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
	:Set "Crimson"





------------------------------------
--
-- Crescent Infinity Collection
--
------------------------------------

i(7332)
	:Chance (4)
	:SetType "Crate"
	:SetName "Crescent Infinity Crate"
	:SetDesc "This crate contains a blood skin from Crescent Infinity! Right click to open."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/crate_icon128.png"
	:SetShop (2000, true)
	:Set "Crescent Infinity"


------------------------------------
-- Worn Items
------------------------------------

i(6304)
	:Chance (1)
	:SetType "Skin"
	:SetName "Midnight Sun Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Midnight_Sun.png"
	:Set "Crescent Infinity"

i(6320)
	:Chance (1)
	:SetType "Skin"
	:SetName "Yore Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Yore.png"
	:Set "Crescent Infinity"

i(6307)
	:Chance (1)
	:SetType "Skin"
	:SetName "Nimbus Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Nimbus.png"
	:Set "Crescent Infinity"

i(6294)
	:Chance (1)
	:SetType "Skin"
	:SetName "Alabaster Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Alabaster.png"
	:Set "Crescent Infinity"

i(6301)
	:Chance (1)
	:SetType "Skin"
	:SetName "Interconnected Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Interconnected.png"
	:Set "Crescent Infinity"


------------------------------------
-- Standard Items
------------------------------------

i(6305)
	:Chance (2)
	:SetType "Skin"
	:SetName "Milky Way Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Milky_Way.png"
	:Set "Crescent Infinity"

i(6323)
	:Chance (2)
	:SetType "Skin"
	:SetName "Zodiac Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Zodiac.png"
	:Set "Crescent Infinity"

i(6308)
	:Chance (2)
	:SetType "Skin"
	:SetName "Nippon Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Nippon.png"
	:Set "Crescent Infinity"

i(6310)
	:Chance (2)
	:SetType "Skin"
	:SetName "Pollution Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Pollution.png"
	:Set "Crescent Infinity"

i(6326)
	:Chance (2)
	:SetType "Skin"
	:SetName "Crepuscule Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Crepuscule.png"
	:Set "Crescent Infinity"

i(6312)
	:Chance (2)
	:SetType "Skin"
	:SetName "Scintilla Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Scintilla.png"
	:Set "Crescent Infinity"

i(6300)
	:Chance (2)
	:SetType "Skin"
	:SetName "Ignite Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Ignite.png"
	:Set "Crescent Infinity"

i(6316)
	:Chance (2)
	:SetType "Skin"
	:SetName "Tsunami Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Tsunami.png"
	:Set "Crescent Infinity"


------------------------------------
-- Specialized Items
------------------------------------

i(6309)
	:Chance (3)
	:SetType "Skin"
	:SetName "Overwrought Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Overwrought.png"
	:Set "Crescent Infinity"

i(6296)
	:Chance (3)
	:SetType "Skin"
	:SetName "Good Fortune Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Good_Fortune.png"
	:Set "Crescent Infinity"

i(6299)
	:Chance (3)
	:SetType "Skin"
	:SetName "Hyper Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Hyper.png"
	:Set "Crescent Infinity"

i(6331)
	:Chance (3)
	:SetType "Skin"
	:SetName "Frigid Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Frigid.png"
	:Set "Crescent Infinity"

i(6317)
	:Chance (3)
	:SetType "Skin"
	:SetName "Verge Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Verge.png"
	:Set "Crescent Infinity"


------------------------------------
-- Superior Items
------------------------------------

i(6306)
	:Chance (4)
	:SetType "Skin"
	:SetName "Nemesis Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Nemesis.png"
	:Set "Crescent Infinity"

i(6322)
	:Chance (4)
	:SetType "Skin"
	:SetName "Zircon Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Zircon.png"
	:Set "Crescent Infinity"

i(6325)
	:Chance (4)
	:SetType "Skin"
	:SetName "Contrast Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Contrast.png"
	:Set "Crescent Infinity"

i(6298)
	:Chance (4)
	:SetType "Skin"
	:SetName "Hellbent Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Hellbent.png"
	:Set "Crescent Infinity"

i(6314)
	:Chance (4)
	:SetType "Skin"
	:SetName "Stigma Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Stigma.png"
	:Set "Crescent Infinity"

i(6318)
	:Chance (4)
	:SetType "Skin"
	:SetName "Viscous Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Viscous.png"
	:Set "Crescent Infinity"


------------------------------------
-- High-End Items
------------------------------------

i(6324)
	:Chance (5)
	:SetType "Skin"
	:SetName "Amaterasu Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Amaterasu.png"
	:Set "Crescent Infinity"

i(6295)
	:Chance (5)
	:SetType "Skin"
	:SetName "Gleam Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Gleam.png"
	:Set "Crescent Infinity"

i(6311)
	:Chance (5)
	:SetType "Skin"
	:SetName "Sardonyx Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Sardonyx.png"
	:Set "Crescent Infinity"

i(6303)
	:Chance (5)
	:SetType "Skin"
	:SetName "Megatherm Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Megatherm.png"
	:Set "Crescent Infinity"

i(6319)
	:Chance (5)
	:SetType "Skin"
	:SetName "Whimsical Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Whimsical.png"
	:Set "Crescent Infinity"


------------------------------------
-- Ascended Items
------------------------------------

i(6327)
	:Chance (6)
	:SetType "Skin"
	:SetName "Daybreak Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Daybreak.png"
	:Set "Crescent Infinity"

i(6328)
	:Chance (6)
	:SetType "Skin"
	:SetName "Descent Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Descent.png"
	:Set "Crescent Infinity"

i(6297)
	:Chance (6)
	:SetType "Skin"
	:SetName "Heavenly Body Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Heavenly_Body.png"
	:Set "Crescent Infinity"

i(6330)
	:Chance (6)
	:SetType "Skin"
	:SetName "Ethereal Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Ethereal.png"
	:Set "Crescent Infinity"

i(6315)
	:Chance (6)
	:SetType "Skin"
	:SetName "The Starry Night Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/The_Starry_Night.png"
	:Set "Crescent Infinity"


------------------------------------
-- Cosmic Items
------------------------------------

i(6329)
	:Chance (7)
	:SetType "Skin"
	:SetName "Drift Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Drift.png"
	:Set "Crescent Infinity"

i(6332)
	:Chance (7)
	:SetType "Skin"
	:SetName "Gaia Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Gaia.png"
	:Set "Crescent Infinity"

i(6302)
	:Chance (7)
	:SetType "Skin"
	:SetName "Manic Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Manic.png"
	:Set "Crescent Infinity"


------------------------------------
-- Planetary Items
------------------------------------

i(6321)
	:Chance (9)
	:SetType "Skin"
	:SetName "Zed Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Zed.png"
	:Set "Crescent Infinity"

i(6313)
	:Chance (9)
	:SetType "Skin"
	:SetName "Spectrum Skin"
	:SetDesc "Right click this skin to use it on a weapon."
	:SetIcon "https://cdn.moat.gg/ttt/uwu/pluto/Spectrum.png"
	:Set "Crescent Infinity"





------------------------------------
--
-- Cosmetic Collection
--
------------------------------------

i(157)
	:Chance (3)
	:SetType "Crate"
	:SetName "Cosmetic Crate"
	:SetDesc "This crate contains an item from the Cosmetic Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/ccec866eabde09c133a3f6301d558179.png"
	:SetShop (300, true)
	:Set "Cosmetic"


------------------------------------
-- Worn Items
------------------------------------

i(107)
	:Chance (1)
	:SetType "Hat"
	:SetName "Headphones"
	:SetDesc "I can't hear you, I'm listeng to a game."
	:SetModel "models/gmod_tower/headphones.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(137)
	:Chance (1)
	:SetType "Hat"
	:SetName "Klonoa Hat"
	:SetDesc "Become the ultimate hipster."
	:SetModel "models/lordvipes/klonoahat/klonoahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.77, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(82)
	:Chance (1)
	:SetType "Hat"
	:SetName "Star Headband"
	:SetDesc "You are amazing."
	:SetModel "models/captainbigbutt/skeyler/hats/starband.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"


------------------------------------
-- Standard Items
------------------------------------

i(95)
	:Chance (2)
	:SetType "Hat"
	:SetName "Bunny Ears"
	:SetDesc "Hello there Mr Bunny."
	:SetModel "models/captainbigbutt/skeyler/hats/bunny_ears.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(88)
	:Chance (2)
	:SetType "Hat"
	:SetName "Frog Hat"
	:SetDesc "Ribbit ribbit bitch."
	:SetModel "models/captainbigbutt/skeyler/hats/frog_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.6, 0)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(135)
	:Chance (2)
	:SetType "Hat"
	:SetName "General Pepper"
	:SetDesc "Commander of the great and kind."
	:SetModel "models/lordvipes/generalpepperhat/generalpepperhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -4.2) + (ang:Right() * 0.4) +  (ang:Up() * 0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(108)
	:Chance (2)
	:SetType "Hat"
	:SetName "Popcorn Bucket"
	:SetDesc "Incoming racist joke."
	:SetModel "models/gmod_tower/kfcbucket.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -2.6) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 25.8)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(143)
	:Chance (2)
	:SetType "Hat"
	:SetName "Kitty Hat"
	:SetDesc "Aww so cute."
	:SetModel "models/gmod_tower/toetohat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 0.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(116)
	:Chance (2)
	:SetType "Hat"
	:SetName "Party Hat"
	:SetDesc "Raise the ruff."
	:SetModel "models/gmod_tower/partyhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) + (ang:Right() * 1.2) +  (ang:Up() * 2.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(81)
	:Chance (2)
	:SetType "Hat"
	:SetName "Straw Hat"
	:SetDesc "Old McDonald had a farm."
	:SetModel "models/captainbigbutt/skeyler/hats/strawhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(71)
	:Chance (2)
	:SetType "Mask"
	:SetName "Grandma Glasses"
	:SetDesc "I hope these are big enough for you."
	:SetModel "models/captainbigbutt/skeyler/accessories/glasses04.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -1.4) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(110)
	:Chance (2)
	:SetType "Mask"
	:SetName "Lego Head"
	:SetDesc "Everything is awesome."
	:SetModel "models/gmod_tower/legohead.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(140)
	:Chance (2)
	:SetType "Mask"
	:SetName "Makar's Mask"
	:SetDesc "That's a very nice leaf you have there."
	:SetModel "models/lordvipes/makarmask/makarmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(2.2, 0)
		pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -9.6) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), -16)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(69)
	:Chance (2)
	:SetType "Mask"
	:SetName "Stylish Glasses"
	:SetDesc "Work those pretty little things gurl."
	:SetModel "models/captainbigbutt/skeyler/accessories/glasses02.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1.2) + (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"


------------------------------------
-- Specialized Items
------------------------------------

i(73)
	:Chance (3)
	:SetType "Hat"
	:SetName "Bear Hat"
	:SetDesc "Now you will always have your teddy bear with you, in a hat form."
	:SetModel "models/captainbigbutt/skeyler/hats/bear_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(132)
	:Chance (3)
	:SetType "Hat"
	:SetName "Black Mage Hat"
	:SetDesc "Do you know what happens to a giant when it gets blasted with a fireball? The same thing that happens to everything else."
	:SetModel "models/lordvipes/blackmage/blackmage_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.3, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -12) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(94)
	:Chance (3)
	:SetType "Hat"
	:SetName "Large Cat Ears"
	:SetDesc "What big ears you have you majestic beast."
	:SetModel "models/captainbigbutt/skeyler/hats/cat_ears.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * -0.2) +  (ang:Up() * -5.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(93)
	:Chance (3)
	:SetType "Hat"
	:SetName "Cat Hat"
	:SetDesc "This does not give you 9 lives."
	:SetModel "models/captainbigbutt/skeyler/hats/cat_hat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(87)
	:Chance (3)
	:SetType "Hat"
	:SetName "Heartband"
	:SetDesc "Wear this if you have no friends and want people to love you."
	:SetModel "models/captainbigbutt/skeyler/hats/heartband.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(111)
	:Chance (3)
	:SetType "Hat"
	:SetName "Link Hat"
	:SetDesc "Hyeeeh kyaah hyaaah haa hyet haa haa jum jum haaa."
	:SetModel "models/gmod_tower/linkhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) +(ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(114)
	:Chance (3)
	:SetType "Hat"
	:SetName "Midna Hat"
	:SetDesc "EPIC."
	:SetModel "models/gmod_tower/midnahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -1.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(142)
	:Chance (3)
	:SetType "Hat"
	:SetName "Red's Hat"
	:SetDesc "Pokemon red hat."
	:SetModel "models/lordvipes/redshat/redshat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.75, 0)
		pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 18)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(96)
	:Chance (3)
	:SetType "Mask"
	:SetName "3D Glasses"
	:SetDesc "The most practical way to get your head in the game."
	:SetModel "models/gmod_tower/3dglasses.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(139)
	:Chance (3)
	:SetType "Mask"
	:SetName "Majora's Mask"
	:SetDesc "It is a colorful mask."
	:SetModel "models/lordvipes/majoramask/majoramask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -9.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(113)
	:Chance (3)
	:SetType "Mask"
	:SetName "Metaknight Mask"
	:SetDesc "Where the fuck is Kirby."
	:SetModel "models/gmod_tower/metaknight_mask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -4.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(115)
	:Chance (3)
	:SetType "Mask"
	:SetName "No Face Mask"
	:SetDesc "Where did your face go?."
	:SetModel "models/gmod_tower/noface.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(70)
	:Chance (3)
	:SetType "Mask"
	:SetName "Shutter Glasses"
	:SetDesc "The party is just getting started."
	:SetModel "models/captainbigbutt/skeyler/accessories/glasses03.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(122)
	:Chance (3)
	:SetType "Mask"
	:SetName "Snowboard Goggles"
	:SetDesc "We don't need snow to wear these."
	:SetModel "models/gmod_tower/snowboardgoggles.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(128)
	:Chance (3)
	:SetType "Mask"
	:SetName "Toro Mask"
	:SetDesc ":3."
	:SetModel "models/gmod_tower/toromask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -4.6) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 10.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"


------------------------------------
-- Superior Items
------------------------------------

i(74)
	:Chance (4)
	:SetType "Hat"
	:SetName "Wooden Comb Afro"
	:SetDesc "You're as OG as OG can get my black friend."
	:SetModel "models/captainbigbutt/skeyler/hats/afro.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(98)
	:Chance (4)
	:SetType "Hat"
	:SetName "Baseball Cap"
	:SetDesc "Never forget the GMod Tower games. May they rest in peace."
	:SetModel "models/gmod_tower/baseballcap.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * 1.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), -20)
		ang:RotateAroundAxis(ang:Up(), 180)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(92)
	:Chance (4)
	:SetType "Hat"
	:SetName "Cowboy Hat"
	:SetDesc "It's hiiiigh nooon."
	:SetModel "models/captainbigbutt/skeyler/hats/cowboyhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 3.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 13.2)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(91)
	:Chance (4)
	:SetType "Hat"
	:SetName "Deadmau5"
	:SetDesc "A musicly talented deceased rodent."
	:SetModel "models/captainbigbutt/skeyler/hats/deadmau5.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(138)
	:Chance (4)
	:SetType "Hat"
	:SetName "Luigi Hat"
	:SetDesc "Taller and jumps higher than mario. Still doesn't get to be the main character. (no this does not change jump height)."
	:SetModel "models/lordvipes/luigihat/luigihat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * -3) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(77)
	:Chance (4)
	:SetType "Hat"
	:SetName "Mario Hat"
	:SetDesc "Shut up you fat italian."
	:SetModel "models/lordvipes/mariohat/mariohat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -1.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(117)
	:Chance (4)
	:SetType "Hat"
	:SetName "Pilgrim Hat"
	:SetDesc "What is a Mayflower."
	:SetModel "models/gmod_tower/pilgrimhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 1.2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 16.4)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(121)
	:Chance (4)
	:SetType "Hat"
	:SetName "Seuss Hat"
	:SetDesc "Thing 1 and Thing 2 are not a thing here."
	:SetModel "models/gmod_tower/seusshat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(80)
	:Chance (4)
	:SetType "Hat"
	:SetName "Sun Hat"
	:SetDesc "It has flowers and protects you from the sun."
	:SetModel "models/captainbigbutt/skeyler/hats/sunhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -5) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(125)
	:Chance (4)
	:SetType "Hat"
	:SetName "Team Rocket Hat"
	:SetDesc "Prepare for trouble, and make it double!."
	:SetModel "models/gmod_tower/teamrockethat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 18.2)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(127)
	:Chance (4)
	:SetType "Hat"
	:SetName "Top Hat"
	:SetDesc "If only you had a suit."
	:SetModel "models/gmod_tower/tophat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 0.6) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 10.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(130)
	:Chance (4)
	:SetType "Hat"
	:SetName "Witch Hat"
	:SetDesc "Mwahahaha."
	:SetModel "models/gmod_tower/witchhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 1.4) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 22.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(7755)
	:Chance (4)
	:SetType "Mask"
	:SetName "Andross Mask"
	:SetDesc "I've been waiting for you, Star Fox. You know that I control the galaxy. It's foolish to come against me. You will die just like your father."
	:SetModel "models/gmod_tower/androssmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1) + (ang:Up() * -2.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(72)
	:Chance (4)
	:SetType "Mask"
	:SetName "El Mustache"
	:SetDesc "You sir are the most handsome and dashing man in all of the server."
	:SetModel "models/captainbigbutt/skeyler/accessories/mustache.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -2.4) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 7.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(103)
	:Chance (4)
	:SetType "Mask"
	:SetName "Jason Mask"
	:SetDesc "Boo."
	:SetModel "models/gmod_tower/halloween_jasonmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -6.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(124)
	:Chance (4)
	:SetType "Mask"
	:SetName "Star Glasses"
	:SetDesc "Too good for regular glasses."
	:SetModel "models/gmod_tower/starglasses.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1.4) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"


------------------------------------
-- High-End Items
------------------------------------

i(131)
	:Chance (5)
	:SetType "Hat"
	:SetName "Billy Hatcher Hat"
	:SetDesc "Good Morning."
	:SetModel "models/lordvipes/billyhatcherhat/billyhatcherhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0.6) +  (ang:Up() * -1) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(106)
	:Chance (5)
	:SetType "Hat"
	:SetName "Headcrab"
	:SetDesc "You will be eaten alive."
	:SetModel "models/gmod_tower/headcrabhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(104)
	:Chance (5)
	:SetType "Hat"
	:SetName "Nightmare Hat"
	:SetDesc "Jack is on your head..."
	:SetModel "models/gmod_tower/halloween_nightmarehat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -4.2) + (ang:Up() * 1.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(78)
	:Chance (5)
	:SetType "Hat"
	:SetName "Gangsta Hat"
	:SetDesc "sup fam."
	:SetModel "models/captainbigbutt/skeyler/hats/zhat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.68) + (ang:Right() * -0.013) +  (ang:Up() * 1.693) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(99)
	:Chance (5)
	:SetType "Mask"
	:SetName "Batman Mask"
	:SetDesc "Where the fuck is Rachel."
	:SetModel "models/gmod_tower/batmanmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.2) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(100)
	:Chance (5)
	:SetType "Mask"
	:SetName "Bomberman Helmet"
	:SetDesc "FOR THE GLORY OF ALLAH!!!"
	:SetModel "models/gmod_tower/bombermanhelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(133)
	:Chance (5)
	:SetType "Mask"
	:SetName "Cubone Skull"
	:SetDesc "I choose you."
	:SetModel "models/lordvipes/cuboneskull/cuboneskull.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.3, 0)
		pos = pos + (ang:Forward() * 0.2) + (ang:Up() * -6.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(136)
	:Chance (5)
	:SetType "Mask"
	:SetName "Keaton Mask"
	:SetDesc "What did the fox say."
	:SetModel "models/lordvipes/keatonmask/keatonmask.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.9, 0)
		pos = pos + (ang:Forward() * -5.6) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(84)
	:Chance (5)
	:SetType "Mask"
	:SetName "Scary Pumpkin"
	:SetDesc "Shine bright like a pumpkin."
	:SetModel "models/captainbigbutt/skeyler/hats/pumpkin.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -3) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(119)
	:Chance (5)
	:SetType "Mask"
	:SetName "Samus Helmet"
	:SetDesc "It's a girl."
	:SetModel "models/gmod_tower/samushelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.05, 0)
		pos = pos + (ang:Forward() * -2.05) + (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(7756)
	:Chance (5)
	:SetType "Mask"
	:SetName "Servbot Head"
	:SetDesc "Smile."
	:SetModel "models/lordvipes/servbothead/servbothead.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -2.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"


------------------------------------
-- Ascended Items
------------------------------------

i(109)
	:Chance (6)
	:SetType "Hat"
	:SetName "King Boo's Crown"
	:SetDesc "Boo, bitch."
	:SetModel "models/gmod_tower/king_boos_crown.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.2, 0)
		pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 2.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), -19.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(83)
	:Chance (6)
	:SetType "Hat"
	:SetName "Santa Hat"
	:SetDesc "It's Christmas."
	:SetModel "models/gmod_tower/santahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2) + (ang:Right() * -0.2) +  (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(123)
	:Chance (6)
	:SetType "Hat"
	:SetName "Sombrero"
	:SetDesc "Arriba."
	:SetModel "models/gmod_tower/sombrero.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 12.6)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(129)
	:Chance (6)
	:SetType "Hat"
	:SetName "Turkey"
	:SetDesc "Stick this hot thing on your head."
	:SetModel "models/gmod_tower/turkey.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 1.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(85)
	:Chance (6)
	:SetType "Mask"
	:SetName "Monocle"
	:SetDesc "You probably think you're smart now. That's incorrect."
	:SetModel "models/captainbigbutt/skeyler/accessories/monocle.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -2.8) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 22.4)
		ang:RotateAroundAxis(ang:Up(),-9)
		ang:RotateAroundAxis(ang:Forward(), 153.8)
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(118)
	:Chance (6)
	:SetType "Mask"
	:SetName "Rubiks Cube"
	:SetDesc "You can't solve this one."
	:SetModel "models/gmod_tower/rubikscube.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.6, 0)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"


------------------------------------
-- Cosmic Items
------------------------------------

i(144)
	:Chance (7)
	:SetType "Hat"
	:SetName "Viewtiful Joe Helmet"
	:SetDesc "Shoot em up."
	:SetModel "models/lordvipes/viewtifuljoehelmet/viewtifuljoehelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.8, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"

i(134)
	:Chance (7)
	:SetType "Mask"
	:SetName "Tomas Helmet"
	:SetDesc "Hit that."
	:SetModel "models/lordvipes/daftpunk/thomas.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Cosmetic"





------------------------------------
--
-- Community Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(1574)
	:Chance (8)
	:SetType "Tier"
	:SetName "Soulbound"
	:SetColor {112, 176, 74}
	:SetStats (7, 7)
		:Stat ("Weight", -0, -5)
		:Stat ("Firerate", 0, 5)
		:Stat ("Magazine", 0, 5)
		:Stat ("Accuracy", 0, 5)
		:Stat ("Damage", 0, 5)
		:Stat ("Kick", 0, -5)
		:Stat ("Range", 0, 5)
	:SetTalents (3, 3)
	:Set "Community"

i(1575)
	:Chance (8)
	:SetType "Tier"
	:SetName "Self-Made"
	:SetColor {112, 176, 74}
	:SetStats (7, 7)
		:Stat ("Weight", -4, -7)
		:Stat ("Firerate", 14, 23)
		:Stat ("Magazine", 19, 28)
		:Stat ("Accuracy", 14, 23)
		:Stat ("Damage", 14, 23)
		:Stat ("Kick", -14, -23)
		:Stat ("Range", 19, 28)
	:SetTalents (4, 4)
	:Set "Community"





------------------------------------
--
-- Beta Collection
--
------------------------------------

i(365)
	:Chance (2)
	:SetType "Crate"
	:SetName "Beta Crate"
	:SetDesc "This crate contains an item from the Beta Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/4110e1152fb08b79d71114627012391a.png"
	:SetShop (150, true)
	:Set "Beta"


------------------------------------
-- Worn Items
------------------------------------

i(331)
	:Chance (1)
	:SetType "Tier"
	:SetName "Shabby"
	:SetColor {215, 255, 224}
	:SetStats (1, 3)
	:Set "Beta"

i(330)
	:Chance (1)
	:SetType "Tier"
	:SetName "Tattered"
	:SetColor {69, 87, 71}
	:SetStats (1, 3)
	:Set "Beta"


------------------------------------
-- Standard Items
------------------------------------

i(334)
	:Chance (2)
	:SetType "Tier"
	:SetName "Mediocre"
	:SetStats (3, 4)
	:Set "Beta"

i(333)
	:Chance (2)
	:SetType "Tier"
	:SetName "Passable"
	:SetColor {153, 255, 204}
	:SetStats (3, 4)
	:Set "Beta"

i(332)
	:Chance (2)
	:SetType "Tier"
	:SetName "Trifling"
	:SetColor {56, 64, 92}
	:SetStats (3, 4)
	:Set "Beta"


------------------------------------
-- Specialized Items
------------------------------------

i(336)
	:Chance (3)
	:SetType "Tier"
	:SetName "Dynamic"
	:SetColor {153, 153, 255}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Beta"

i(337)
	:Chance (3)
	:SetType "Tier"
	:SetName "Peppy"
	:SetColor {255, 151, 210}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Beta"

i(335)
	:Chance (3)
	:SetType "Tier"
	:SetName "Zesty"
	:SetColor {92, 169, 76}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Beta"

i(317)
	:Chance (3)
	:SetType "Unique"
	:SetName "Hawkeyo"
	:SetColor {255, 0, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_sledge"
	:SetStats (5, 5)
		:Stat ("Firerate", 1, 10)
		:Stat ("Magazine", 5, 10)
		:Stat ("Accuracy", 10, 50)
		:Stat ("Damage", 1, 10)
		:Stat ("Range", 1, 10)
	:SetTalents (1, 1)
	:Set "Beta"

i(318)
	:Chance (3)
	:SetType "Unique"
	:SetName "Holukis"
	:SetColor {133, 213, 239}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_shotgun"
	:SetStats (3, 3)
		:Stat ("Damage", -50, -70)
		:Stat ("Firerate", 80, 100)
		:Stat ("Magazine", 10, 30)
	:Set "Beta"

i(320)
	:Chance (3)
	:SetType "Unique"
	:SetName "Kik-Back"
	:SetColor {171, 1, 37}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_ak47"
	:SetStats (3, 3)
		:Stat ("Accuracy", 10, 20)
		:Stat ("Damage", 15, 30)
		:Stat ("Kick", 60, 70)
	:SetTalents (1, 1)
	:Set "Beta"

i(325)
	:Chance (3)
	:SetType "Unique"
	:SetName "Slowihux"
	:SetColor {212, 44, 151}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_shotgun"
	:SetStats (4, 4)
		:Stat ("Magazine", 5, 10)
		:Stat ("Damage", 10, 30)
		:Stat ("Firerate", -40, -50)
		:Stat ("Range", 1, 10)
	:Set "Beta"

i(326)
	:Chance (3)
	:SetType "Unique"
	:SetName "Spray-N-Pray"
	:SetColor {27, 126, 7}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_galil"
	:SetStats (4, 4)
		:Stat ("Kick", -1, -19)
		:Stat ("Damage", -10, -30)
		:Stat ("Firerate", 30, 60)
		:Stat ("Magazine", 5, 10)
	:Set "Beta"


------------------------------------
-- Superior Items
------------------------------------

i(338)
	:Chance (4)
	:SetType "Tier"
	:SetName "Deranged"
	:SetColor {255, 102, 102}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Beta"

i(341)
	:Chance (4)
	:SetType "Tier"
	:SetName "Erratic"
	:SetColor {153, 255, 153}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Beta"

i(340)
	:Chance (4)
	:SetType "Tier"
	:SetName "Haywire"
	:SetColor {255, 178, 102}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Beta"

i(339)
	:Chance (4)
	:SetType "Tier"
	:SetName "Turbid"
	:SetColor {228, 232, 107}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Beta"

i(321)
	:Chance (4)
	:SetType "Unique"
	:SetName "Karitichu"
	:SetColor {255, 233, 109}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_rifle"
	:SetStats (5, 5)
		:Stat ("Firerate", 30, 60)
		:Stat ("Magazine", 5, 10)
		:Stat ("Accuracy", 10, 20)
		:Stat ("Damage", 5, 10)
		:Stat ("Kick", -11, -19)
	:SetTalents (1, 1)
	:Set "Beta"


------------------------------------
-- High-End Items
------------------------------------

i(347)
	:Chance (5)
	:SetType "Tier"
	:SetName "Eccentric"
	:SetColor {255, 102, 178}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Beta"

i(342)
	:Chance (5)
	:SetType "Tier"
	:SetName "Marvelous"
	:SetColor {215, 121, 255}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Beta"

i(346)
	:Chance (5)
	:SetType "Tier"
	:SetName "Quaint"
	:SetColor {59, 132, 172}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Beta"

i(345)
	:Chance (5)
	:SetType "Tier"
	:SetName "Uncanny"
	:SetColor {157, 120, 158}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Beta"

i(319)
	:Chance (5)
	:SetType "Unique"
	:SetName "Headcrusher"
	:SetColor {29, 201, 150}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_revolver"
	:SetStats (5, 5)
		:Stat ("Firerate", -50, -95)
		:Stat ("Magazine", -40, -80)
		:Stat ("Accuracy", 10, 30)
		:Stat ("Damage", 25, 50)
		:Stat ("Range", 1, 20)
	:SetTalents (1, 1)
		:SetTalent (1, "Brutality")
	:Set "Beta"

i(323)
	:Chance (5)
	:SetType "Unique"
	:SetName "Headbanger"
	:SetColor {23, 116, 89}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_pistol"
	:SetStats (5, 5)
		:Stat ("Firerate", -50, -95)
		:Stat ("Magazine", -40, -80)
		:Stat ("Accuracy", 10, 30)
		:Stat ("Damage", 25, 50)
		:Stat ("Range", 1, 20)
	:SetTalents (1, 1)
		:SetTalent (1, "Brutality")
	:Set "Beta"

i(324)
	:Chance (5)
	:SetType "Unique"
	:SetName "SGLento"
	:SetColor {0, 97, 179}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_sg552"
	:SetStats (7, 7)
		:Stat ("Weight", 0, -20)
		:Stat ("Firerate", -20, -30)
		:Stat ("Magazine", 20, 30)
		:Stat ("Accuracy", 10, 20)
		:Stat ("Damage", 10, 25)
		:Stat ("Kick", 0, 10)
		:Stat ("Range", 5, 10)
	:Set "Beta"

i(300)
	:Chance (5)
	:SetType "Unique"
	:SetName "Zeusitae"
	:SetColor {255, 255, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_revolver"
	:SetStats (5, 7)
	:SetTalents (1, 1)
		:SetTalent (1, "Electricity")
	:Set "Beta"


------------------------------------
-- Ascended Items
------------------------------------

i(348)
	:Chance (6)
	:SetType "Tier"
	:SetName "Eternal"
	:SetColor {153, 51, 255}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Beta"

i(349)
	:Chance (6)
	:SetType "Tier"
	:SetName "Evergreen"
	:SetColor {0, 204, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Beta"

i(351)
	:Chance (6)
	:SetType "Tier"
	:SetName "Partisan"
	:SetColor {189, 255, 145}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Beta"

i(350)
	:Chance (6)
	:SetType "Tier"
	:SetName "Satanic"
	:SetColor {102, 0, 0}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Beta"

i(316)
	:Chance (6)
	:SetType "Unique"
	:SetName "Doomladen"
	:SetColor {231, 213, 11}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_m16"
	:SetStats (9, 9)
		:Stat ("Weight", 6, 18)
		:Stat ("Magazine", 6, 18)
		:Stat ("Kick", 15, 32)
		:Stat ("Deployrate", -12, -25)
		:Stat ("Reloadrate", 15, 30)
		:Stat ("Accuracy", 15, 30)
		:Stat ("Damage", 20, 32)
		:Stat ("Firerate", 16, 28)
		:Stat ("Range", 10, 25)
	:SetTalents (2, 2)
	:Set "Beta"

i(322)
	:Chance (6)
	:SetType "Unique"
	:SetName "Miscordia"
	:SetColor {0, 189, 71}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_glock"
	:SetStats (6, 6)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (1, 1)
		:SetTalent (1, "Sustained")
	:Set "Beta"


------------------------------------
-- Cosmic Items
------------------------------------

i(353)
	:Chance (7)
	:SetType "Tier"
	:SetName "Astral"
	:SetColor {255, 255, 0}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Beta"

i(352)
	:Chance (7)
	:SetType "Tier"
	:SetName "Shiny"
	:SetColor {0, 255, 200}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Beta"

i(354)
	:Chance (7)
	:SetType "Tier"
	:SetName "Virtuous"
	:SetColor {213, 0, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Beta"

i(55)
	:Chance (7)
	:SetType "Unique"
	:SetName "Bond's First Friend"
	:SetColor {255, 215, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_revolver"
	:SetStats (9, 9)
		:Stat ("Magazine", 6, 10)
		:Stat ("Kick", -17, -30)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
		:Stat ("Accuracy", 55, 80)
		:Stat ("Firerate", 20, 38)
		:Stat ("Range", 25, 55)
	:SetTalents (3, 3)
	:Set "Beta"

i(64)
	:Chance (7)
	:SetType "Unique"
	:SetName "Monte Carlo"
	:SetColor {231, 55, 55}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_mp5"
	:SetStats (6, 8)
		:Stat ("Weight", -7, -10)
		:Stat ("Magazine", 25, 35)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
		:Stat ("Damage", 17, 22)
		:Stat ("Firerate", 10, 24)
		:Stat ("Range", 23, 32)
	:SetTalents (3, 3)
	:Set "Beta"

i(65)
	:Chance (7)
	:SetType "Unique"
	:SetName "Traitor Killa"
	:SetColor {255, 153, 10}
	:SetEffect "glow"
	:SetWeapon "weapon_zm_sledge"
	:SetStats (9, 9)
		:Stat ("Deployrate", 30, 40)
		:Stat ("Reloadrate", 30, 40)
	:SetTalents (3, 3)
	:Set "Beta"





------------------------------------
--
-- Beginners Collection
--
------------------------------------





------------------------------------
--
-- April Fools Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(850)
	:Chance (8)
	:SetType "Tier"
	:SetName "Jokesters"
	:SetColor {255, 0, 255}
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (3, 3)
	:Set "April Fools"





------------------------------------
--
-- Alpha Collection
--
------------------------------------

i(22)
	:Chance (2)
	:SetType "Crate"
	:SetName "Alpha Crate"
	:SetDesc "This crate contains an item from the Alpha Collection! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/b49edbc96b010036c2bfbb15fa186987.png"
	:SetShop (300, true)
	:Set "Alpha"


------------------------------------
-- Worn Items
------------------------------------

i(27)
	:Chance (1)
	:SetType "Tier"
	:SetName "Junky"
	:SetColor {149, 129, 115}
	:SetStats (1, 3)
	:Set "Alpha"

i(1)
	:Chance (1)
	:SetType "Tier"
	:SetName "Recycled"
	:SetColor {181, 128, 117}
	:SetStats (1, 3)
	:Set "Alpha"


------------------------------------
-- Standard Items
------------------------------------

i(24)
	:Chance (2)
	:SetType "Power-Up"
	:SetName "Cat Sense"
	:SetColor {139, 0, 166}
	:SetDesc "Fall damage is reduced by %s_ when using this power-up."
	:SetIcon "https://cdn.moat.gg/f/e62954919e052ed558d6b2e451badd24.png"
	:SetStats (1, 1)
		:Stat (1, -35, -75)
	:Set "Alpha"

i(11)
	:Chance (2)
	:SetType "Power-Up"
	:SetName "Froghopper"
	:SetColor {255, 0, 0}
	:SetEffect "bounce"
	:SetDesc "Froghoppers can jump 70 times their body height. Too bad this only allows you to jump +%s_ higher."
	:SetIcon "https://cdn.moat.gg/f/efbb38256abb921e7cc3425819f80949.png"
	:SetStats (1, 1)
		:Stat (1, 15, 50)
	:Set "Alpha"

i(4)
	:Chance (2)
	:SetType "Tier"
	:SetName "Moderate"
	:SetColor {153, 255, 255}
	:SetStats (3, 4)
	:Set "Alpha"

i(29)
	:Chance (2)
	:SetType "Tier"
	:SetName "Ordinary"
	:SetColor {204, 229, 255}
	:SetStats (3, 4)
	:Set "Alpha"

i(28)
	:Chance (2)
	:SetType "Tier"
	:SetName "Stable"
	:SetColor {255, 255, 255}
	:SetStats (3, 4)
	:Set "Alpha"

i(19)
	:Chance (2)
	:SetType "Hat"
	:SetName "Bucket Helmet"
	:SetDesc "It's a bucket."
	:SetModel "models/props_junk/MetalBucket01a.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * -5) + (ang:Up() * 5)// + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Right(), 200)
		return model, pos, ang
	end)
	:Set "Alpha"

i(18)
	:Chance (2)
	:SetType "Hat"
	:SetName "Turtle Hat"
	:SetDesc "This cute little turtle can sit on your head and give you amazing love."
	:SetModel "models/props/de_tides/Vending_turtle.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) + m_IsTerroristModel(ply:GetModel())
		ang:RotateAroundAxis(ang:Up(), -90)
		return model, pos, ang
	end)
	:Set "Alpha"

i(21)
	:Chance (2)
	:SetType "Model"
	:SetName "Kliener Model"
	:SetDesc "The smartest of them all."
	:SetModel "models/player/kleiner.mdl"
	:Set "Alpha"

i(20)
	:Chance (2)
	:SetType "Mask"
	:SetName "No Entry Mask"
	:SetDesc "No man shall enter your face again."
	:SetModel "models/props_c17/streetsign004f.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(0.7, 0)
		pos = pos + (ang:Forward() * 3)
		ang:RotateAroundAxis(ang:Up(), -90)
		return model, pos, ang
	end)
	:Set "Alpha"


------------------------------------
-- Specialized Items
------------------------------------

i(26)
	:Chance (3)
	:SetType "Power-Up"
	:SetName "Marathon Runner"
	:SetColor {85, 85, 255}
	:SetDesc "Movement speed is increased by +%s_ when using this power-up."
	:SetIcon "https://cdn.moat.gg/f/3860e90ff93a1fb663421ddf92fbbffa.png"
	:SetStats (1, 1)
		:Stat (1, 5, 15)
	:Set "Alpha"

i(31)
	:Chance (3)
	:SetType "Tier"
	:SetName "Dashing"
	:SetColor {255, 153, 153}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Alpha"

i(30)
	:Chance (3)
	:SetType "Tier"
	:SetName "Frisky"
	:SetColor {204, 255, 153}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Alpha"

i(32)
	:Chance (3)
	:SetType "Tier"
	:SetName "Harmful"
	:SetColor {255, 86, 44}
	:SetStats (6, 6)
		:Stat ("Firerate", -10, -20)
		:Stat ("Accuracy", -10, -25)
		:Stat ("Damage", 20, 35)
		:Stat ("Weight", 10, 15)
		:Stat ("Kick", 5, 10)
	:SetTalents (1, 1)
	:Set "Alpha"

i(5)
	:Chance (3)
	:SetType "Tier"
	:SetName "Odd"
	:SetColor {153, 255, 153}
	:SetStats (3, 5)
		:Stat ("Damage", 5, 10)
	:SetTalents (1, 1)
	:Set "Alpha"

i(33)
	:Chance (3)
	:SetType "Tier"
	:SetName "Precise"
	:SetColor {153, 204, 255}
	:SetStats (5, 5)
		:Stat ("Firerate", 0, 5)
		:Stat ("Magazine", 15, 20)
		:Stat ("Accuracy", 30, 60)
		:Stat ("Damage", 5, 10)
		:Stat ("Kick", 5, 10)
	:SetTalents (1, 1)
	:Set "Alpha"

i(34)
	:Chance (3)
	:SetType "Tier"
	:SetName "Steady"
	:SetColor {153, 255, 153}
	:SetStats (6, 6)
		:Stat ("Damage", 5, 10)
		:Stat ("Weight", 3, 5)
		:Stat ("Kick", -20, -50)
	:SetTalents (1, 1)
	:Set "Alpha"

i(54)
	:Chance (3)
	:SetType "Hat"
	:SetName "Afro"
	:SetDesc "Become a jazzy man with this afro."
	:SetModel "models/gmod_tower/afro.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Up() * 2.5) + (ang:Forward() * -4.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"

i(60)
	:Chance (3)
	:SetType "Hat"
	:SetName "Drink Cap"
	:SetDesc "The server drunk."
	:SetModel "models/sam/drinkcap.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3.1) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"

i(62)
	:Chance (3)
	:SetType "Hat"
	:SetName "Fedora"
	:SetDesc "You're the best meme of them all."
	:SetModel "models/gmod_tower/fedorahat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		model:SetModelScale(1.1, 0)
		pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"


------------------------------------
-- Superior Items
------------------------------------

i(23)
	:Chance (4)
	:SetType "Power-Up"
	:SetName "Ammo Hoarder"
	:SetColor {255, 102, 0}
	:SetDesc "Begin the round with +%s_ more ammo in your reserves."
	:SetIcon "https://cdn.moat.gg/f/62a7db51574ae4a341e61c4174866816.png"
	:SetStats (1, 1)
		:Stat (1, 45, 125)
	:Set "Alpha"

i(25)
	:Chance (4)
	:SetType "Power-Up"
	:SetName "Health Bloom"
	:SetColor {0, 204, 0}
	:SetDesc "Health is increased by +%s when using this power-up."
	:SetIcon "https://moat.gg/assets/img/smithhealicon.png"
	:SetStats (1, 1)
		:Stat (1, 5, 25)
	:Set "Alpha"

i(39)
	:Chance (4)
	:SetType "Tier"
	:SetName "Ammofull"
	:SetColor {255, 128, 0}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 20, 50)
		:Stat ("Accuracy", -13, -17)
		:Stat ("Damage", 4, 13)
	:SetTalents (1, 2)
	:Set "Alpha"

i(6)
	:Chance (4)
	:SetType "Tier"
	:SetName "Chaotic"
	:SetColor {255, 255, 0}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Alpha"

i(36)
	:Chance (4)
	:SetType "Tier"
	:SetName "Fearful"
	:SetColor {92, 50, 176}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Alpha"

i(40)
	:Chance (4)
	:SetType "Tier"
	:SetName "Global"
	:SetColor {0, 153, 0}
	:SetStats (6, 6)
		:Stat ("Firerate", 8, 12)
		:Stat ("Magazine", 8, 15)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 4, 8)
		:Stat ("Range", 30, 60)
	:SetTalents (1, 2)
	:Set "Alpha"

i(37)
	:Chance (4)
	:SetType "Tier"
	:SetName "Intimidating"
	:SetColor {162, 0, 0}
	:SetStats (4, 6)
	:SetTalents (1, 2)
	:Set "Alpha"

i(41)
	:Chance (4)
	:SetType "Tier"
	:SetName "Lightweight"
	:SetColor {152, 255, 255}
	:SetStats (5, 5)
		:Stat ("Firerate", 8, 12)
		:Stat ("Accuracy", 5, 12)
		:Stat ("Damage", 5, 12)
		:Stat ("Weight", -9, -17)
	:SetTalents (1, 2)
	:Set "Alpha"

i(38)
	:Chance (4)
	:SetType "Tier"
	:SetName "Rapid"
	:SetColor {255, 178, 102}
	:SetStats (6, 6)
		:Stat ("Firerate", 20, 35)
		:Stat ("Accuracy", -15, -5)
		:Stat ("Damage", -2, -20)
		:Stat ("Range", -13, -20)
	:SetTalents (2, 2)
	:Set "Alpha"

i(16)
	:Chance (4)
	:SetType "Unique"
	:SetName "Volcanica"
	:SetColor {255, 0, 0}
	:SetEffect "glow"
	:SetWeapon "weapon_ttt_ak47"
	:SetStats (5, 7)
		:Stat ("Weight", -3, -7)
		:Stat ("Firerate", 11, 19)
		:Stat ("Magazine", 16, 24)
		:Stat ("Accuracy", 11, 19)
		:Stat ("Damage", 11, 19)
		:Stat ("Kick", -11, -19)
		:Stat ("Range", 16, 24)
	:SetTalents (1, 1)
		:SetTalent (1, "Phoenix")
	:Set "Alpha"

i(56)
	:Chance (4)
	:SetType "Hat"
	:SetName "Astronaut Helmet"
	:SetDesc "Instantly become a space god with this helmet."
	:SetModel "models/astronauthelmet/astronauthelmet.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -3) + (ang:Up() * -5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"

i(58)
	:Chance (4)
	:SetType "Hat"
	:SetName "Cake Hat"
	:SetDesc "This cake is a lie."
	:SetModel "models/cakehat/cakehat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Up() * 1.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"

i(59)
	:Chance (4)
	:SetType "Hat"
	:SetName "Cat Ears"
	:SetDesc "You look so cute with these cat ears on, omfg."
	:SetModel "models/gmod_tower/catears.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2.5) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"

i(61)
	:Chance (4)
	:SetType "Hat"
	:SetName "Dunce Hat"
	:SetDesc "You must sit in the corner and think of your terrible actions."
	:SetModel "models/duncehat/duncehat.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		ang:RotateAroundAxis(ang:Right(), 25)
		pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"


------------------------------------
-- High-End Items
------------------------------------

i(43)
	:Chance (5)
	:SetType "Tier"
	:SetName "Remarkable"
	:SetColor {255, 102, 178}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Alpha"

i(44)
	:Chance (5)
	:SetType "Tier"
	:SetName "Strange"
	:SetColor {255, 0, 102}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Alpha"

i(7)
	:Chance (5)
	:SetType "Tier"
	:SetName "Unusual"
	:SetColor {178, 205, 255}
	:SetStats (5, 7)
	:SetTalents (2, 2)
	:Set "Alpha"


------------------------------------
-- Ascended Items
------------------------------------

i(48)
	:Chance (6)
	:SetType "Tier"
	:SetName "Heroic"
	:SetColor {51, 51, 255}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Alpha"

i(8)
	:Chance (6)
	:SetType "Tier"
	:SetName "Legendary"
	:SetColor {255, 255, 51}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Alpha"

i(47)
	:Chance (6)
	:SetType "Tier"
	:SetName "Mythical"
	:SetColor {178, 102, 255}
	:SetStats (6, 7)
	:SetTalents (2, 3)
	:Set "Alpha"

i(63)
	:Chance (6)
	:SetType "Model"
	:SetName "Alyx Model"
	:SetDesc "slut."
	:SetModel "models/player/alyx.mdl"
	:Set "Alpha"

i(57)
	:Chance (6)
	:SetType "Mask"
	:SetName "Aviators"
	:SetDesc "You look like the terminator with these badass glasses on."
	:SetModel "models/gmod_tower/aviators.mdl"
	:SetRender ("eyes", function(ply, model, pos, ang)
		pos = pos + (ang:Forward() * -2) + (ang:Up() * -0.5) + m_IsTerroristModel(ply:GetModel())
		return model, pos, ang
	end)
	:Set "Alpha"


------------------------------------
-- Cosmic Items
------------------------------------

i(52)
	:Chance (7)
	:SetType "Tier"
	:SetName "Angelic"
	:SetColor {255, 0, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Alpha"

i(9)
	:Chance (7)
	:SetType "Tier"
	:SetName "Celestial"
	:SetColor {0, 255, 128}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Alpha"

i(51)
	:Chance (7)
	:SetType "Tier"
	:SetName "Immortal"
	:SetColor {0, 255, 255}
	:SetStats (7, 7)
	:SetTalents (3, 3)
	:Set "Alpha"





------------------------------------
--
-- 50/50 Collection
--
------------------------------------

i(159)
	:Chance (4)
	:SetType "Crate"
	:SetName "50/50 Crate"
	:SetEffect "enchanted"
	:SetDesc "This crate has a 50/50 chance of returning a terrible item, or a great item! Right click to open."
	:SetIcon "https://cdn.moat.gg/f/fiftyfifty_crate64.png"
	:SetShop (2000, true)
	:Set "50/50"





------------------------------------
--
-- 4/20 2017 Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(900)
	:Chance (8)
	:SetType "Special"
	:SetName "American Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_american"
	:Set "4/20 2017"





------------------------------------
--
-- 4/20 - 2017 Collection
--
------------------------------------


------------------------------------
-- Extinct Items
------------------------------------

i(901)
	:Chance (8)
	:SetType "Special"
	:SetName "Butterfly Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_butterfly"
	:Set "4/20 - 2017"

i(902)
	:Chance (8)
	:SetType "Special"
	:SetName "Custom Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_custom"
	:Set "4/20 - 2017"

i(903)
	:Chance (8)
	:SetType "Special"
	:SetName "Dragon Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_dragon"
	:Set "4/20 - 2017"

i(904)
	:Chance (8)
	:SetType "Special"
	:SetName "Golden Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_golden"
	:Set "4/20 - 2017"

i(905)
	:Chance (8)
	:SetType "Special"
	:SetName "Hallucinogenic Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_hallucinogenic"
	:Set "4/20 - 2017"

i(906)
	:Chance (8)
	:SetType "Special"
	:SetName "Helium Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_helium"
	:Set "4/20 - 2017"

i(907)
	:Chance (8)
	:SetType "Special"
	:SetName "Juicy Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_juicy"
	:Set "4/20 - 2017"

i(908)
	:Chance (8)
	:SetType "Special"
	:SetName "Medicinal Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape_medicinal"
	:Set "4/20 - 2017"

i(910)
	:Chance (8)
	:SetType "Special"
	:SetName "White Vape"
	:SetDesc "A special item given to people as a remembrance of 4/20."
	:SetIcon "https://cdn.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
	:SetWeapon "weapon_vape"
	:Set "4/20 - 2017"





------------------------------------
--
-- 24 Hour Marathon Collection
--
------------------------------------


------------------------------------
-- Planetary Items
------------------------------------

i(912)
	:Chance (9)
	:SetType "Tier"
	:SetName "Insomnious"
	:SetEffect "glow"
	:SetStats (7, 7)
		:Stat ("Weight", -5, -7)
		:Stat ("Firerate", 17, 28)
		:Stat ("Magazine", 23, 33)
		:Stat ("Accuracy", 17, 28)
		:Stat ("Damage", 17, 28)
		:Stat ("Kick", -17, -28)
		:Stat ("Range", 23, 33)
	:SetTalents (4, 4)
	:Set "24 Hour Marathon"
