AddCSLuaFile()

MOAT_PAINT = MOAT_PAINT or {}

MOAT_PAINT.Colors = MOAT_PAINT.Colors or {
  {"Mint Green", {3, 255, 171}, 6},
  {"Joker Green", {2, 153, 57}, 3},
  {"Pindel Pink", {247, 136, 206}, 5},
  {"Bleek Banana", {236, 255, 140}, 3},
  {"Water Melon", {187, 235, 42}, 4},
  {"Magnetic Blue", {73, 76, 153}, 3},
  {"Aqua Blue", {66, 208, 255}, 4},
  {"Toxic Yellow", {221, 225, 3}, 6},
  {"Bright Purple", {96, 62, 148}, 4},
  {"Neon Pink", {255, 105, 180}, 5},
  {"Bright Gold", {227, 190, 70}, 7},
  {"Turkey Stuffer Green", {22, 161, 18}, 5},
  {"Neon Green", {5, 193, 25}, 4},
  {"Neon Purple", {27, 29, 163}, 6},
  {"Dark Gold Chrome", {251, 184, 41}, 7},
  {"Hot Pink", {255, 105, 180}, 7},
  {"Detox Purple", {157, 153, 188}, 3},
  {"Glossy Green", {0, 70, 0}, 3},
  {"Sky Blue", {127, 200, 255}, 5},
  {"Neon Sky Blue", {123, 255, 255}, 6},
  {"Pure Black", {0, 0, 0}, 6},
  {"Sharpe Yellow", {255, 255, 1}, 6},
  {"Bright Orange", {251, 86, 4}, 6},
  {"Cotton Candy Pink", {249, 82, 107}, 6},
  {"Deep Red", {229, 14, 6}, 3},
  {"Flueorescent Blue", {5, 193, 255}, 4},
  {"Freeze Green", {140, 255, 50}, 4},
  {"Red Bull Blue", {51, 51, 153}, 3},
  {"Monster Energy Neon Green", {51, 255, 153}, 3},
  {"Dr. Pepper Red", {153, 34, 34}, 3},
  {"Razer Green", {71, 225, 12}, 4},
  {"Electric Lime", {206, 250, 5}, 3},
  {"Blazing Blue", {44, 117, 255}, 3},
  {"Sunshine Orange", {255, 65, 5}, 4},
  {"Electric Indigo", {111, 0, 255}, 5},
  {"American Rose", {255, 3, 62}, 6},
  {"Lazer Blue", {0, 15, 255}, 4},
  {"Neon Aqua Blue", {123, 255,255}, 5},
  {"Bleak Banana", {236, 255, 140}, 3},
  {"Chameleon Green", {0, 43, 21}, 3},
  {"Perpiling Purple", {140, 138, 255}, 4},
  {"Serpentine Green", {64, 124, 132}, 3},
  {"Menacing Red", {52, 0, 17}, 4},
  {"Creamsicle Orange", {242, 80, 32}, 5},
  {"Glycerine Green", {3, 51, 9}, 3},
  {"Corrosive Green", {132, 255, 10}, 5},
  {"Electric Lime", {80, 100, 0}, 3},
  {"Deep Pink", {100, 0, 40}, 5},
  {"Pure Orange", {100, 60, 0}, 3},
  {"Very Soft Pink", {97, 69, 72}, 3},
  {"New Lime", {3, 39, 15}, 3},
  {"Brown Town", {39, 15, 3}, 4},
  {"Nardo Grey", {104, 106, 118}, 5},
  {"Light Teal", {103, 186, 181}, 4},
  {"Neon Mint", {0, 204, 120}, 5},
  {"Neon Lime", {0, 150, 45}, 4},
  {"Pure White", {255, 255, 255}, 6},
  {"George's Surprise", {115, 34, 136}, 7},
}
/*
MOAT_PAINT.Textures = {
  {"Flesh", "models/flesh", 7}
}
*/
MOAT_PAINT.Tints = MOAT_PAINT.Tints or {
	[6001] = {'Mint Green Tint', {3, 255, 171}, 6},
	[6002] = {'Joker Green Tint', {2, 153, 57}, 3},
	[6003] = {'Pindel Pink Tint', {247, 136, 206}, 5},
	[6004] = {'Bleek Banana Tint', {236, 255, 140}, 3},
	[6005] = {'Water Melon Tint', {187, 235, 42}, 4},
	[6006] = {'Magnetic Blue Tint', {73, 76, 153}, 3},
	[6007] = {'Aqua Blue Tint', {66, 208, 255}, 4},
	[6008] = {'Toxic Yellow Tint', {221, 225, 3}, 6},
	[6009] = {'Bright Purple Tint', {96, 62, 148}, 4},
	[6010] = {'Neon Pink Tint', {255, 105, 180}, 5},
	[6011] = {'Bright Gold Tint', {227, 190, 70}, 7},
	[6012] = {'Turkey Stuffer Green Tint', {22, 161, 18}, 5},
	[6013] = {'Neon Green Tint', {5, 193, 25}, 4},
	[6014] = {'Neon Purple Tint', {27, 29, 163}, 6},
	[6015] = {'Dark Gold Chrome Tint', {251, 184, 41}, 7},
	[6016] = {'Hot Pink Tint', {255, 105, 180}, 7},
	[6017] = {'Detox Purple Tint', {157, 153, 188}, 3},
	[6018] = {'Glossy Green Tint', {0, 70, 0}, 3},
	[6019] = {'Sky Blue Tint', {127, 200, 255}, 5},
	[6020] = {'Neon Sky Blue Tint', {123, 255, 255}, 6},
	[6021] = {'Pure Black Tint', {0, 0, 0}, 6},
	[6022] = {'Sharpe Yellow Tint', {255, 255, 1}, 6},
	[6023] = {'Bright Orange Tint', {251, 86, 4}, 6},
	[6024] = {'Cotton Candy Pink Tint', {249, 82, 107}, 6},
	[6025] = {'Deep Red Tint', {229, 14, 6}, 3},
	[6026] = {'Flueorescent Blue Tint', {5, 193, 255}, 4},
	[6027] = {'Freeze Green Tint', {140, 255, 50}, 4},
	[6028] = {'Red Bull Blue Tint', {51, 51, 153}, 3},
	[6029] = {'Monster Energy Neon Green Tint', {51, 255, 153}, 3},
	[6030] = {'Dr. Pepper Red Tint', {153, 34, 34}, 3},
	[6031] = {'Razer Green Tint', {71, 225, 12}, 4},
	[6032] = {'Electric Lime Tint', {206, 250, 5}, 3},
	[6033] = {'Blazing Blue Tint', {44, 117, 255}, 3},
	[6034] = {'Sunshine Orange Tint', {255, 65, 5}, 4},
	[6035] = {'Electric Indigo Tint', {111, 0, 255}, 5},
	[6036] = {'American Rose Tint', {255, 3, 62}, 6},
	[6037] = {'Lazer Blue Tint', {0, 15, 255}, 4},
	[6038] = {'Neon Aqua Blue Tint', {123, 255, 255}, 5},
	[6039] = {'Bleak Banana Tint', {236, 255, 140}, 3},
	[6040] = {'Chameleon Green Tint', {0, 43, 21}, 3},
	[6041] = {'Perpiling Purple Tint', {140, 138, 255}, 4},
	[6042] = {'Serpentine Green Tint', {64, 124, 132}, 3},
	[6043] = {'Menacing Red Tint', {52, 0, 17}, 4},
	[6044] = {'Creamsicle Orange Tint', {242, 80, 32}, 5},
	[6045] = {'Glycerine Green Tint', {3, 51, 9}, 3},
	[6046] = {'Corrosive Green Tint', {132, 255, 10}, 5},
	[6047] = {'Electric Lime Tint', {80, 100, 0}, 3},
	[6048] = {'Deep Pink Tint', {100, 0, 40}, 5},
	[6049] = {'Pure Orange Tint', {100, 60, 0}, 3},
	[6050] = {'Very Soft Pink Tint', {97, 69, 72}, 3},
	[6051] = {'New Lime Tint', {3, 39, 15}, 3},
	[6052] = {'Brown Town Tint', {39, 15, 3}, 4},
	[6053] = {'Nardo Grey Tint', {104, 106, 118}, 5},
	[6054] = {'Light Teal Tint', {103, 186, 181}, 4},
	[6055] = {'Neon Mint Tint', {0, 204, 120}, 5},
	[6056] = {'Neon Lime Tint', {0, 150, 45}, 4},
	[6057] = {'Pure White Tint', {255, 255, 255}, 6},
	[6058] = {'George\'s Surprise Tint', {115, 34, 136}, 7},
	[6566] = {'Infinity Tint', {255, 255, 255}, 9, 'https://cdn.moat.gg/f/57731eec78594998cdfecf618fdb3cad.png', Dream = true}
}

MOAT_PAINT.Paints = MOAT_PAINT.Paints or {
	[6059] = {'Mint Green Paint', {3, 255, 171}, 6},
	[6060] = {'Joker Green Paint', {2, 153, 57}, 3},
	[6061] = {'Pindel Pink Paint', {247, 136, 206}, 5},
	[6062] = {'Bleek Banana Paint', {236, 255, 140}, 3},
	[6063] = {'Water Melon Paint', {187, 235, 42}, 4},
	[6064] = {'Magnetic Blue Paint', {73, 76, 153}, 3},
	[6065] = {'Aqua Blue Paint', {66, 208, 255}, 4},
	[6066] = {'Toxic Yellow Paint', {221, 225, 3}, 6},
	[6067] = {'Bright Purple Paint', {96, 62, 148}, 4},
	[6068] = {'Neon Pink Paint', {255, 105, 180}, 5},
	[6069] = {'Bright Gold Paint', {227, 190, 70}, 7},
	[6070] = {'Turkey Stuffer Green Paint', {22, 161, 18}, 5},
	[6071] = {'Neon Green Paint', {5, 193, 25}, 4},
	[6072] = {'Neon Purple Paint', {27, 29, 163}, 6},
	[6073] = {'Dark Gold Chrome Paint', {251, 184, 41}, 7},
	[6074] = {'Hot Pink Paint', {255, 105, 180}, 7},
	[6075] = {'Detox Purple Paint', {157, 153, 188}, 3},
	[6076] = {'Glossy Green Paint', {0, 70, 0}, 3},
	[6077] = {'Sky Blue Paint', {127, 200, 255}, 5},
	[6078] = {'Neon Sky Blue Paint', {123, 255, 255}, 6},
	[6079] = {'Pure Black Paint', {0, 0, 0}, 6},
	[6080] = {'Sharpe Yellow Paint', {255, 255, 1}, 6},
	[6081] = {'Bright Orange Paint', {251, 86, 4}, 6},
	[6082] = {'Cotton Candy Pink Paint', {249, 82, 107}, 6},
	[6083] = {'Deep Red Paint', {229, 14, 6}, 3},
	[6084] = {'Flueorescent Blue Paint', {5, 193, 255}, 4},
	[6085] = {'Freeze Green Paint', {140, 255, 50}, 4},
	[6086] = {'Red Bull Blue Paint', {51, 51, 153}, 3},
	[6087] = {'Monster Energy Neon Green Paint', {51, 255, 153}, 3},
	[6088] = {'Dr. Pepper Red Paint', {153, 34, 34}, 3},
	[6089] = {'Razer Green Paint', {71, 225, 12}, 4},
	[6090] = {'Electric Lime Paint', {206, 250, 5}, 3},
	[6091] = {'Blazing Blue Paint', {44, 117, 255}, 3},
	[6092] = {'Sunshine Orange Paint', {255, 65, 5}, 4},
	[6093] = {'Electric Indigo Paint', {111, 0, 255}, 5},
	[6094] = {'American Rose Paint', {255, 3, 62}, 6},
	[6095] = {'Lazer Blue Paint', {0, 15, 255}, 4},
	[6096] = {'Neon Aqua Blue Paint', {123, 255, 255}, 5},
	[6097] = {'Bleak Banana Paint', {236, 255, 140}, 3},
	[6098] = {'Chameleon Green Paint', {0, 43, 21}, 3},
	[6099] = {'Perpiling Purple Paint', {140, 138, 255}, 4},
	[6100] = {'Serpentine Green Paint', {64, 124, 132}, 3},
	[6101] = {'Menacing Red Paint', {52, 0, 17}, 4},
	[6102] = {'Creamsicle Orange Paint', {242, 80, 32}, 5},
	[6103] = {'Glycerine Green Paint', {3, 51, 9}, 3},
	[6104] = {'Corrosive Green Paint', {132, 255, 10}, 5},
	[6105] = {'Electric Lime Paint', {80, 100, 0}, 3},
	[6106] = {'Deep Pink Paint', {100, 0, 40}, 5},
	[6107] = {'Pure Orange Paint', {100, 60, 0}, 3},
	[6108] = {'Very Soft Pink Paint', {97, 69, 72}, 3},
	[6109] = {'New Lime Paint', {3, 39, 15}, 3},
	[6110] = {'Brown Town Paint', {39, 15, 3}, 4},
	[6111] = {'Nardo Grey Paint', {104, 106, 118}, 5},
	[6112] = {'Light Teal Paint', {103, 186, 181}, 4},
	[6113] = {'Neon Mint Paint', {0, 204, 120}, 5},
	[6114] = {'Neon Lime Paint', {0, 150, 45}, 4},
	[6115] = {'Pure White Paint', {255, 255, 255}, 6},
	[6116] = {'George\'s Surprise Paint', {115, 34, 136}, 7},
	[6565] = {'Infinity Paint', {255, 255, 255}, 9, 'https://cdn.moat.gg/f/57731eec78594998cdfecf618fdb3cad.png', Dream = true}
}

local holidays = 'Holiday Collection'

local function skin(icon, name, ext, rarity)
	if (rarity == nil) then
		rarity = ext
		ext = nil
	end
	local url  = name:lower():gsub(" ", "%%20")
	return {name .. ' Skin', 'https://cdn.moat.gg/f/' .. url .. '.vtf', rarity, icon or ('https://cdn.moat.gg/f/' .. url .. '.' .. (ext or 'jpg')), 'Easter 2019 Collection'}
end

MOAT_PAINT.Skins = MOAT_PAINT.Skins or {
	[6117] = {'Flesh Skin', 'https://cdn.moat.gg/f/1998b.vtf', 7, 'https://cdn.moat.gg/f/86cc6.png'},
	[6119] = {'Test Skin', 'https://i.imgur.com/dvRkf9t.png'/*'https://cdn.moat.gg/f/b4573.vtf'*/, 8, nil, 'Testing Collection'},
	[6120] = {'Merry Poops', 'https://cdn.moat.gg/f/209a2.vtf', 3, 'https://cdn.moat.gg/f/b70cb.png', holidays},
	[6123] = {'Blizzard Skin', 'https://cdn.moat.gg/f/37c4d.vtf', 4, 'https://cdn.moat.gg/f/2391e.png', holidays},
	[6127] = {'Pokemon Skin', 'https://cdn.moat.gg/f/442e1.vtf', 4, 'https://cdn.moat.gg/f/52336.png', holidays},
	[6128] = {'Playful Skin', 'https://cdn.moat.gg/f/058a0.vtf', 4, 'https://cdn.moat.gg/f/bb884.png', holidays},
	[6129] = {'Xmas Skin', 'https://cdn.moat.gg/f/63027.vtf', 5, 'https://cdn.moat.gg/f/86c64.png', holidays},
	[6131] = {'Stickers Skin', 'https://cdn.moat.gg/f/772c4.vtf', 5, 'https://cdn.moat.gg/f/0a0a7.png', holidays},
	[6132] = {'Warrior Skin', 'https://cdn.moat.gg/f/6d68e.vtf', 5, 'https://cdn.moat.gg/f/20ba2.png', holidays},
	[6133] = {'Scales Skin','https://cdn.moat.gg/f/a0a1b.vtf', 5, 'https://cdn.moat.gg/f/87d35.png', holidays},
	[6151] = {'Polkadot Skin', 'https://cdn.moat.gg/f/e5542.vtf', 5, 'https://cdn.moat.gg/f/07241.png', holidays},
	[6140] = {'Flourish Skin', 'https://cdn.moat.gg/f/6026a.vtf', 6, 'https://cdn.moat.gg/f/b75ae.png', holidays},
	[6136] = {'Riptide Skin', 'https://cdn.moat.gg/f/56632.vtf', 5, 'https://cdn.moat.gg/f/76abb.png', holidays},
	[6135] = {'Lightning Skin', 'https://cdn.moat.gg/f/eda6c.vtf', 6, 'https://cdn.moat.gg/f/a3745.png', holidays},
	[6137] = {'Magma Skin', 'https://cdn.moat.gg/f/46309.vtf', 6, 'https://cdn.moat.gg/f/6dc06.png', holidays},
	[6138] = {'Polygon Skin', 'https://cdn.moat.gg/f/a3915.vtf', 6, 'https://cdn.moat.gg/f/c250a.png', holidays},
	[6139] = {'Comic Skin', 'https://cdn.moat.gg/f/d2a02.vtf', 5, 'https://cdn.moat.gg/f/d7571.png', holidays},
	[6141] = {'Zebra Skin', 'https://cdn.moat.gg/f/e9d1e.vtf', 6, 'https://cdn.moat.gg/f/c5e26.png', holidays},
	[6130] = {'Hype Skin', 'https://cdn.moat.gg/f/67283.vtf', 6, 'https://cdn.moat.gg/f/1a72a.png', holidays},
	[6142] = {'Sherbert Skin', 'https://cdn.moat.gg/f/b4573.vtf', 7, 'https://cdn.moat.gg/f/50c8d.png', holidays},
	[6143] = {'Trippin Skin', 'https://cdn.moat.gg/f/89c31.vtf', 7, 'https://cdn.moat.gg/f/554a0.png', holidays},
	[6134] = {'Holo Skin', 'https://cdn.moat.gg/f/d5dc9.vtf', 7, 'https://cdn.moat.gg/f/ec9d7.png', holidays},
	[6144] = {'Gold Skin', 'https://cdn.moat.gg/f/84cae.vtf', 7, 'https://cdn.moat.gg/f/b1664.png', holidays},
	[6149] = {'Skrilla Skin', 'https://cdn.moat.gg/f/49737.vtf', 7, 'https://cdn.moat.gg/f/a3326.png', holidays},
	[6145] = {'Hotline Skin', 'https://cdn.moat.gg/f/5d256.vtf', 9, 'https://cdn.moat.gg/f/be68b.png', holidays},
	[6146] = {'Galaxy Skin', 'https://cdn.moat.gg/f/9a16b.vtf', 9, 'https://cdn.moat.gg/f/c009c.png', holidays},
	[6154] = {'Elevate Skin', 'https://cdn.moat.gg/f/bad8d.vtf', 7, 'https://cdn.moat.gg/f/9ccd6.png', holidays},
	[6200] = skin('https://cdn.moat.gg/f/EeOqLa9teqSydN58A66sXekooeoGGj83.png', 'Blurred Neon', 5),
	[6201] = skin('https://cdn.moat.gg/f/UnQ1nOcIksCiZRUcgIV1y5q8Mw2bYA11.png', 'Bubbles', 'png', 5),
	[6202] = skin('https://cdn.moat.gg/f/dgw8yc8CqfygBPwR8dfMZEPtICbsM7AE.png', 'Butterflies', 4),
	[6203] = skin('https://cdn.moat.gg/f/CyTfQ7da8xwBOwyDXyMPPjUwsU17KCXw.png', 'Camo', 3),
	[6204] = skin('https://cdn.moat.gg/f/Yyhx5mvgFtCvbhSPfKX6ZqcCJ25R1eio.png', 'Caution', 5),
	[6205] = skin('https://cdn.moat.gg/f/xm2FdGNobMc6wZ0NWJHU5wrg8nAgH33H.png', 'Cheetah', 4),
	[6206] = skin('https://cdn.moat.gg/f/utpKv02iXrf518oJOI6c2ujesxorQcj3.png', 'Dew', 4),
	[6207] = skin('https://cdn.moat.gg/f/UL3MhJAM91h4GLyZHKUUwveZJPi0P5k6.png', 'Electric Current', 5),
	[6208] = skin('https://cdn.moat.gg/f/x6sty0yyOHaSvZF0wup83FxJixgFs1bv.png', 'Encrypted', 'png', 6),
	[6209] = skin('https://cdn.moat.gg/f/maPRi1ymOlXAoAhNxJM7rE48VfRQUAwk.png', 'Energy Flower', 5),
	[6210] = skin('https://cdn.moat.gg/f/uYv3rMUyxruv06ImOv9ckUHIqrGiYa9a.png', 'Energy', 4),
	[6211] = skin('https://cdn.moat.gg/f/3BSJKgy05ypAvoL189SkQoB9q9StTndm.png', 'Fantasy', 'png', 7),
	[6212] = skin('https://cdn.moat.gg/f/NG7d1oy0sk67JUBrAe7ixZxvoVduqIiO.png', 'Glitch', 'png', 7),
	[6213] = skin('https://cdn.moat.gg/f/v5F8Y7GIcYi7ffAfrsLnaaZBbLkcPZ5q.png', 'Hairy Dragon', 6),
	[6214] = skin('https://cdn.moat.gg/f/nhoYUMS3dZJUus6kXlZ3dFY08ONe01xg.png', 'Halo', 4),
	[6215] = skin('https://cdn.moat.gg/f/NuLBvsPVxL9NGpHZ7BaFLxCW54Sbl1Mw.png', 'Heatwave', 'png', 5),
	[6216] = skin('https://cdn.moat.gg/f/GUv16WC3DxbCH2m7iFZ6bD4EHnMmFCFa.png', 'Hyperdrive', 6),
	[6217] = skin('https://cdn.moat.gg/f/FNbhdHkODAoQ0WbQyepba4GPVuDG7KmM.png', 'Hypno', 5),
	[6218] = skin('https://cdn.moat.gg/f/NHkLAFnyaxHawHiep7BgpLv5GZGI3gP6.png', 'Illusion', 5),
	[6219] = skin('https://cdn.moat.gg/f/5Gi7UUZiycSIWvYd4vnFwprh8432OBxp.png', 'Kaleidoscope', 5),
	[6220] = skin('https://cdn.moat.gg/f/RyH97UEhtxp2p2uMucj1KXdYSPoeBxbM.png', 'Kali', 5),
	[6221] = skin('https://cdn.moat.gg/f/XUAAia6I0ym559hDBmAOHI7ICrMBgqPJ.png', 'Lava Lamp', 4),
	[6222] = skin('https://cdn.moat.gg/f/Ksxhu8FY4KGvC1Aeijge2XrMWXf6SpaW.png', 'Light Show', 'png', 6),
	[6223] = skin('https://cdn.moat.gg/f/03SClSnZEUSA4nhi6vLynw0enk5wh19J.png', 'Loofa', 5),
	[6224] = skin('https://cdn.moat.gg/f/ESwT1fsj7mnOWArKTsHsVVPa4n0rlAlg.png', 'Lunar', 'png', 6),
	[6225] = skin('https://cdn.moat.gg/f/oscn0VNxutNPaOQXvy63hEDv5yxVpPHX.png', 'Magikarp', 7),
	[6226] = skin('https://cdn.moat.gg/f/7l4GyimLIsjlYdvJKYkxe7BQLELkXKCo.png', 'Mirrored', 3),
	[6227] = skin('https://cdn.moat.gg/f/HxSNIBEsFPcANCoSIOfkuyGJ2OhrolZu.png', 'Missing Green', 5),
	[6228] = skin('https://cdn.moat.gg/f/CusfBVZreZEvVSOppEDrnKmM9ncb3XT9.png', 'Mosaic', 'png', 5),
	[6229] = skin('https://cdn.moat.gg/f/Uc5q2WCQkJytuRATlrS9OEs6dfkSd8ar.png', 'Motherboard', 'png', 5),
	[6230] = skin('https://cdn.moat.gg/f/mvcOrQL62NjqTZbDuIBZaVkefLWHUEDJ.png', 'Neon Rider', 'png', 6),
	[6231] = skin('https://cdn.moat.gg/f/vhC5MUplPXleGnytdDFhs7hJRFmXwRgb.png', 'Pattern', 6),
	[6232] = skin('https://cdn.moat.gg/f/QkOICVPCfhoqeabqAdTtLD6rw2XD3yLF.png', 'Penguins', 'png', 5),
	[6233] = skin('https://cdn.moat.gg/f/xaBqBwcbIJIU6LcZQst6tIiCLbiMWUGT.png', 'Refraction', 6),
	[6234] = skin('https://cdn.moat.gg/f/K9XA31y3t7eF4Ye68jMRKUiMR1YJtQgV.png', 'Splat', 4),
	[6235] = skin('https://cdn.moat.gg/f/yLaZH9LQS2OSQ8MsxpEdcD678MSjT8UC.png', 'Starry', 6),
	[6236] = skin('https://cdn.moat.gg/f/oeNtwVoFuh6ydkMgv5n6uKuTd4abtZcA.png', 'Stem', 6),
	[6237] = skin('https://cdn.moat.gg/f/mRw0bBJfCsGsXljbOLJqTvC1FoVQcTN2.png', 'Sunflower', 4),
	[6238] = skin('https://cdn.moat.gg/f/JL8lkGvGcPCvcG02wM26Die35DomTtGU.png', 'Sunset', 6),
	[6239] = skin('https://cdn.moat.gg/f/ApY9xBC3V7CSMGGkjiM7SfFu5FeLgNCT.png', 'Swirls', 6),
	[6240] = skin('https://cdn.moat.gg/f/Udbjd6GmqFoMgngQB8evOeMcOTGhRegb.png', 'Techno', 6),
	[6241] = skin('https://cdn.moat.gg/f/SFi43iMRuKyjoRMNCDC6WQ8c74wGrGAC.png', 'Tiles', 4),
	[6242] = skin('https://cdn.moat.gg/f/FUQ3wJCTd1jJHcF0mtr0OaxStF1qBbYy.png', 'Triangles', 5),
	[6243] = skin('https://cdn.moat.gg/f/BoThiOs1q6IMyFwaOiiCNIr2jZncn4Xf.png', 'Void', 6),
	[6244] = skin('https://cdn.moat.gg/f/19H84NmrvDTlFaMAuIuLOZT3t3eF0hBw.png', 'Watery Night', 5),
	[6245] = skin('https://cdn.moat.gg/f/719wnSs1jkGtbFwP2ihsEBExtRKX8UQZ.png', 'Yellow Bricks', 3),
	[6246] = skin('https://cdn.moat.gg/f/FCgHthjSdL5WkvlIB6BOquRvI5a3xYMt.png', 'Yellow Flower', 3),

	-- [6247] = {' Skin', 'https://cdn.moat.gg/f/VgJRs.vtf', 1, '', 'Pumpkin Collection'},
	-- [6248] = {' Skin', 'https://cdn.moat.gg/f/JNm6y.vtf', 1, '', 'Pumpkin Collection'},
	-- [6249] = {' Skin', 'https://cdn.moat.gg/f/qPutA.vtf', 1, '', 'Pumpkin Collection'},
	-- [6250] = {' Skin', 'https://cdn.moat.gg/f/K9pRs.vtf', 1, '', 'Pumpkin Collection'},
	-- [6251] = {' Skin', 'https://cdn.moat.gg/f/vgl91.vtf', 1, '', 'Pumpkin Collection'},
	-- [6252] = {' Skin', 'https://cdn.moat.gg/f/heiSo.vtf', 1, '', 'Pumpkin Collection'},
	-- [6253] = {' Skin', 'https://cdn.moat.gg/f/AuhkX.vtf', 1, '', 'Pumpkin Collection'},
	-- [6254] = {' Skin', 'https://cdn.moat.gg/f/5UbnA.vtf', 1, '', 'Pumpkin Collection'},
	-- [6255] = {' Skin', 'https://cdn.moat.gg/f/j71qL.vtf', 1, '', 'Pumpkin Collection'},
	-- [6256] = {' Skin', 'https://cdn.moat.gg/f/HSOJL.vtf', 1, '', 'Pumpkin Collection'},
	-- [6257] = {' Skin', 'https://cdn.moat.gg/f/NxS5g.vtf', 1, '', 'Pumpkin Collection'},
	-- [6258] = {' Skin', 'https://cdn.moat.gg/f/oiImK.vtf', 1, '', 'Pumpkin Collection'},
	-- [6259] = {' Skin', 'https://cdn.moat.gg/f/sB3uc.vtf', 1, '', 'Pumpkin Collection'},
	-- [6260] = {' Skin', 'https://cdn.moat.gg/f/LR0cA.vtf', 1, '', 'Pumpkin Collection'},
	-- [6261] = {' Skin', 'https://cdn.moat.gg/f/OZZWN.vtf', 1, '', 'Pumpkin Collection'},
	-- [6262] = {' Skin', 'https://cdn.moat.gg/f/9Z4tP.vtf', 1, '', 'Pumpkin Collection'},
	-- [6263] = {' Skin', 'https://cdn.moat.gg/f/PmAgQ.vtf', 1, '', 'Pumpkin Collection'},
	-- [6264] = {' Skin', 'https://cdn.moat.gg/f/y7xF5.vtf', 1, '', 'Pumpkin Collection'},
	-- [6265] = {' Skin', 'https://cdn.moat.gg/f/QmeBw.vtf', 1, '', 'Pumpkin Collection'},
	-- [6266] = {' Skin', 'https://cdn.moat.gg/f/fH1bF.vtf', 1, '', 'Pumpkin Collection'},
	-- [6267] = {' Skin', 'https://cdn.moat.gg/f/whJlc.vtf', 1, '', 'Pumpkin Collection'},
	-- [6268] = {' Skin', 'https://cdn.moat.gg/f/TT7vd.vtf', 1, '', 'Pumpkin Collection'},
	-- [6269] = {' Skin', 'https://cdn.moat.gg/f/jL1Cn.vtf', 1, '', 'Pumpkin Collection'},
	-- [6270] = {' Skin', 'https://cdn.moat.gg/f/XpmM5.vtf', 1, '', 'Pumpkin Collection'},
	-- [6271] = {' Skin', 'https://cdn.moat.gg/f/KP0MG.vtf', 1, '', 'Pumpkin Collection'},
	-- [6272] = {' Skin', 'https://cdn.moat.gg/f/MI15o.vtf', 1, '', 'Pumpkin Collection'},
	-- [6273] = {' Skin', 'https://cdn.moat.gg/f/4s5BN.vtf', 1, '', 'Pumpkin Collection'},
	-- [6274] = {' Skin', 'https://cdn.moat.gg/f/SFjJr.vtf', 1, '', 'Pumpkin Collection'},
	-- [6275] = {' Skin', 'https://cdn.moat.gg/f/tySyU.vtf', 1, '', 'Pumpkin Collection'},
	-- [6276] = {' Skin', 'https://cdn.moat.gg/f/op8Ps.vtf', 1, '', 'Pumpkin Collection'},
	-- [6277] = {' Skin', 'https://cdn.moat.gg/f/gZMce.vtf', 1, '', 'Pumpkin Collection'},
	-- [6278] = {' Skin', 'https://cdn.moat.gg/f/BDBOG.vtf', 1, '', 'Pumpkin Collection'},
	-- [6279] = {' Skin', 'https://cdn.moat.gg/f/YMFgg.vtf', 1, '', 'Pumpkin Collection'},
	-- [6280] = {' Skin', 'https://cdn.moat.gg/f/pP5yy.vtf', 1, '', 'Pumpkin Collection'},
	-- [6281] = {' Skin', 'https://cdn.moat.gg/f/OICWd.vtf', 1, '', 'Pumpkin Collection'},
	-- [6282] = {' Skin', 'https://cdn.moat.gg/f/JIHLo.vtf', 1, '', 'Pumpkin Collection'},
	-- [6283] = {' Skin', 'https://cdn.moat.gg/f/Vjxab.vtf', 1, '', 'Pumpkin Collection'},
	-- [6284] = {' Skin', 'https://cdn.moat.gg/f/TeFiC.vtf', 1, '', 'Pumpkin Collection'},
	-- [6285] = {' Skin', 'https://cdn.moat.gg/f/IIGS2.vtf', 1, '', 'Pumpkin Collection'},
	-- [6286] = {' Skin', 'https://cdn.moat.gg/f/76C52.vtf', 1, '', 'Pumpkin Collection'},
	-- [6287] = {' Skin', 'https://cdn.moat.gg/f/Y2ZCW.vtf', 1, '', 'Pumpkin Collection'},
	-- [6288] = {' Skin', 'https://cdn.moat.gg/f/WuHev.vtf', 1, '', 'Pumpkin Collection'},
	-- [6289] = {' Skin', 'https://cdn.moat.gg/f/VIJGl.vtf', 1, '', 'Pumpkin Collection'},
	-- [6290] = {' Skin', 'https://cdn.moat.gg/f/rNs6m.vtf', 1, '', 'Pumpkin Collection'},
	-- [6291] = {' Skin', 'https://cdn.moat.gg/f/bcpAZ.vtf', 1, '', 'Pumpkin Collection'},
	-- [6292] = {' Skin', 'https://cdn.moat.gg/f/8SIax.vtf', 1, '', 'Pumpkin Collection'},
	-- [6293] = {' Skin', 'https://cdn.moat.gg/f/QL927.vtf', 1, '', 'Pumpkin Collection'},
	-- [6294] = {' Skin', 'https://cdn.moat.gg/f/XxygQ.vtf', 1, '', 'Pumpkin Collection'},

	-- https://cdn.moat.gg/f/8e376.png
	--[6120] = {'Puppy Skin', 'https://cdn.moat.gg/f/dbd23.png', 8}, --'https://cdn.moat.gg/f/91548.png', 8},
	--[6121] = {'Dev Team Stalker Skin', 'https://cdn.moat.gg/f/b8271.png', 8}
}

function GetPaintColor(id)
	return MOAT_PAINT.Paints[id] or MOAT_PAINT.Tints[id]
end

function ItemIsPaint(id)
	return id and MOAT_PAINT.Paints[id]
end

function ItemIsTint(id)
	return id and MOAT_PAINT.Tints[id]
end

function ItemIsSkin(id)
	return id and MOAT_PAINT.Skins[id]
end

function ItemPaints(id)
	return id and (MOAT_PAINT.Paints[id] or MOAT_PAINT.Tints[id] or MOAT_PAINT.Skins[id])
end

MOAT_PAINT.SkinCache = {}
function LoadSkin(id, cb)
	if (MOAT_PAINT.SkinCache[id]) then
		return cb(MOAT_PAINT.SkinCache[id])
	end
	
end

concommand.Add("moat_paint", function()
	local last_id = 6001
	for i = 1, #MOAT_PAINT.Colors do
		print("    ", "[" .. last_id .. "] = {'" .. MOAT_PAINT.Colors[i][1] .. " Tint', {" .. MOAT_PAINT.Colors[i][2][1] .. ", " .. MOAT_PAINT.Colors[i][2][2] .. ", " .. MOAT_PAINT.Colors[i][2][3] .. "}, " .. MOAT_PAINT.Colors[i][3] .. "}")
		last_id = last_id + 1
    end

	for i = 1, #MOAT_PAINT.Colors do
		print("    ", "[" .. last_id .. "] = {'" .. MOAT_PAINT.Colors[i][1] .. " Paint', {" .. MOAT_PAINT.Colors[i][2][1] .. ", " .. MOAT_PAINT.Colors[i][2][2] .. ", " .. MOAT_PAINT.Colors[i][2][3] .. "}, " .. MOAT_PAINT.Colors[i][3] .. "}")
		last_id = last_id + 1
    end

	for i = 1, #MOAT_PAINT.Skins do
		print("    ", "[" .. last_id .. "] = {'" .. MOAT_PAINT.Skins[i][1] .. " Texture', '" .. MOAT_PAINT.Skins[i][2] .. "', " .. MOAT_PAINT.Colors[i][3] .. "}")
		last_id = last_id + 1
    end
end)