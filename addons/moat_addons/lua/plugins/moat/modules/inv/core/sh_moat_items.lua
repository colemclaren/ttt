function GetItemName(data)
	local ITEM_NAME_FULL = ""

    if (data and data.item and data.item.Kind == "tier") then
        local ITEM_NAME = util.GetWeaponName(data.w)

        if (string.EndsWith(ITEM_NAME, "_name")) then
            ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
            ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
        end

        ITEM_NAME_FULL = data.item.Name .. " " .. ITEM_NAME

        if (data.item.Rarity == 0 and data.item.ID and data.item.ID ~= 7820 and data.item.ID ~= 7821) then
            ITEM_NAME_FULL = ITEM_NAME
        end
    else
        ITEM_NAME_FULL = data.item and data.item.Name or "Error with Item Name"
    end
	
	if (data and data.item and data.item.Kind ~= "Unique" and data.Talents and data.Talents[1] and (data.Talents[1].Suffix or data.Talents[1].Name)) then
		local suffix = (data.Talents[5] and (data.Talents[5].Suffix or data.Talents[5].Name)) or (data.Talents[4] and (data.Talents[4].Suffix or data.Talents[4].Name)) or (data.Talents[3] and (data.Talents[3].Suffix or data.Talents[3].Name)) or (data.Talents[2] and (data.Talents[2].Suffix or data.Talents[2].Name)) or (data.Talents[1].Suffix or data.Talents[1].Name)
		ITEM_NAME_FULL = ITEM_NAME_FULL .. " of " .. suffix
	end

	if (data.n) then
		ITEM_NAME_FULL = data.n:Replace("''", "'") -- "\"" .. data.n:Replace("''", "'") .. "\""
	end

	return ITEM_NAME_FULL
end