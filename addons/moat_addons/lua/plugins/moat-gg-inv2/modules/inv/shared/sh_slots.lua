local KindSlots, TypeSlots = {
	[WEAPON_HEAVY] = 1,
	[WEAPON_PISTOL] = 2,
	[WEAPON_MELEE] = 3
}, {
	["Power-Up"] = 4,
	["Other"] = 5,
	["Hat"] = 5,
	["Mask"] = 5,
	["Body"] = 5,
	["Effect"] = 5,
	["Model"] = 5
}

function mi.GetLoadoutSlot(tbl)
	if (not tbl.c) then
		return 0
	end

	if (tbl.item and tbl.item.Kind and TypeSlots[tbl.item.Kind]) then
		return TypeSlots[tbl.item.Kind]
	end

	if (not tbl.w) then
		return 0
	end

	return KindSlots[util.WeaponData(ITEM_TBL.w, "Kind")]
end