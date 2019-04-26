local equipables = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true, 
    ["powerup"] = true,
	["power-up"] = true,
	["hat"] = true, 
    ["other"] = true, 
    ["head"] = true, 
    ["mask"] = true, 
    ["body"] = true, 
    ["effect"] = true, 
    ["model"] = true
}

local paintable = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true,
    ["head"] = true, 
    ["mask"] = true, 
    ["body"] = true,
    ["model"] = true,
    ["hat"] = true
}

local tintable = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true,
    ["head"] = true, 
    ["mask"] = true, 
    ["body"] = true,
    ["hat"] = true
}

local textureable = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true,
}

local mdl_check_cache = {}

MOAT_ITEM_CHECK = {}
MOAT_ITEM_CHECK[1] = {function(i)
	return (i.item and equipables[i.item.Kind:lower()]) or (i.Kind and equipables[i.Kind:lower()])
end, "Item must be equippable!"}
MOAT_ITEM_CHECK[2] = {function(i)
	return (((i.Rarity and i.Rarity == 7) or (i.item and i.item.Rarity and i.item.Rarity == 7)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be Cosmic with talents!"}
MOAT_ITEM_CHECK[3] = {function(i)
	return (((i.Rarity and i.Rarity == 6) or (i.item and i.item.Rarity and i.item.Rarity == 6)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be Ascended with talents!"}
MOAT_ITEM_CHECK[4] = {function(i)
	return (((i.Rarity and i.Rarity <= 5) or (i.item and i.item.Rarity and i.item.Rarity <= 5)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be High-End or below with talents!"}
MOAT_ITEM_CHECK[5] = {function(i)
	return (((i.Rarity and i.Rarity == 9) or (i.item and i.item.Rarity and i.item.Rarity == 9)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be Planetary with talents!"}
MOAT_ITEM_CHECK[6] = {function(i)
	return (((i.Rarity and i.Rarity == 7) or (i.item and i.item.Rarity and i.item.Rarity == 7)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be Cosmic with stats!"}
MOAT_ITEM_CHECK[7] = {function(i)
	return (((i.Rarity and i.Rarity == 6) or (i.item and i.item.Rarity and i.item.Rarity == 6)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be Ascended with stats!"}
MOAT_ITEM_CHECK[8] = {function(i)
	return (((i.Rarity and i.Rarity <= 5) or (i.item and i.item.Rarity and i.item.Rarity <= 5)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be High-End or below with stats!"}
MOAT_ITEM_CHECK[9] = {function(i)
	return (((i.Rarity and i.Rarity == 9) or (i.item and i.item.Rarity and i.item.Rarity == 9)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be Planetary with stats!"}
MOAT_ITEM_CHECK[10] = {function(i)
	if (CLIENT and ((i.item and i.item.Kind:lower() == "model") or (i.Kind and i.Kind:lower() == "model"))) then
		local itm = i.item
		if (i.Kind) then itm = i end

		if (not mdl_check_cache[itm.Model]) then
			local mdl = ClientsideModel(itm.Model, RENDERGROUP_OPAQUE)
			mdl:SetNoDraw(true)

			local mats = mdl:GetMaterials()
			local found = false

    		for i = 1, #mats do
        		local str = file.Read("materials/" .. mats[i] .. ".vmt", "GAME")
        		if (str and str:find("PlayerColor")) then
        			found = true break
        		end
    		end

    		mdl:Remove()

			mdl_check_cache[itm.Model] = found
		end

		return mdl_check_cache[itm.Model]
	end

	if (i.item and i.item.Name == "Fists") or (i.Name == i.Name == "Fists") then
		return false
	end

	return i.item and paintable[i.item.Kind:lower()] or i.Kind and paintable[i.Kind:lower()]
end, "Item cannot be painted!"}
MOAT_ITEM_CHECK[11] = {function(i)
	if (i.item and i.item.Name == "Fists") or (i.Name == i.Name == "Fists") then
		return false
	end

	return i.item and tintable[i.item.Kind:lower()] or i.Kind and tintable[i.Kind:lower()]
end, "Item must be a weapon or hat/mask/body!"}
MOAT_ITEM_CHECK[12] = {function(i)
	if (i.item and i.item.Name == "Fists") or (i.Name == i.Name == "Fists") then
		return false
	end
	
	return i.item and textureable[i.item.Kind:lower()] or i.Kind and textureable[i.Kind:lower()]
end, "Item must be a weapon!"}
MOAT_ITEM_CHECK[13] = {function(i)
	return i.u ~= 7820 and i.u ~= 7821
end, "You can't wrap gift packages, sorry."}
MOAT_ITEM_CHECK[14] = {function(i)
	return i.p3 ~= nil
end, "Item must have a skin!"}