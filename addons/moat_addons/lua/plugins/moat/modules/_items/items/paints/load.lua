AddCSLuaFile()

MOAT_PAINT = MOAT_PAINT or {}

MOAT_PAINT.Colors = {
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
MOAT_PAINT.Tints = {
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
	[6058] = {'George\'s Surprise Tint', {115, 34, 136}, 7}
}

MOAT_PAINT.Paints = {
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
	[6116] = {'George\'s Surprise Paint', {115, 34, 136}, 7}
}

MOAT_PAINT.Skins = {
	[6117] = {'Flesh Skin', 'models/flesh', 7},
	--[6119] = {'Lit Blood Skin', 'models/camo_blood', 8},
	--[6120] = {'Puppy Skin', 'https://cdn.moat.gg/f/dbd23.png', 8}, --'https://cdn.moat.gg/f/91548.png', 8},
	--[6121] = {'Dev Team Stalker Skin', 'https://cdn.moat.gg/f/b8271.png', 8}
}

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