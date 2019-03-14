ENT.Type = "anim"

CreateConVar("ttt_hermesboots_detective", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Should Detectives be able to buy the Hermes Boots?")
CreateConVar("ttt_hermesboots_traitor", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Should Traitors be able to buy the Hermes Boots?")

-- feel for to use this function for your own perk, but please credit me
local function getNextFreeID()
	local freeID, i = 1, 1
	while (freeID == 1) do
		if (!istable(GetEquipmentItem(ROLE_DETECTIVE, i))
			and !istable(GetEquipmentItem(ROLE_TRAITOR, i))) then
			freeID = i
		end
		i = i * 2
	end

	return freeID
end

EQUIP_HERMES_BOOTS = getNextFreeID()

local perk = {
	id = EQUIP_HERMES_BOOTS,
	loadout = false,
	type = "item_passive",
	material = "vgui/ttt/icon_hermes_boots",
	name = "hermes_boots_name",
	desc = "hermes_boots_desc",
	hud = true
}

if (GetConVar("ttt_hermesboots_detective"):GetBool()) then
	if SERVER then
		perk["loadout"] = GetConVar("ttt_hermesboots_detective_loadout"):GetBool()
	end
	table.insert(EquipmentItems[ROLE_DETECTIVE], perk)
end
if (GetConVar("ttt_hermesboots_traitor"):GetBool()) then
	if SERVER then
		perk["loadout"] = GetConVar("ttt_hermesboots_traitor_loadout"):GetBool()
	end
	table.insert(EquipmentItems[ROLE_TRAITOR], perk)
end
