MLOGS_SHOT = 1
mlogs.events.register(MLOGS_SHOT, {
	type 	= "WPN",
	name 	= "Used Weapon",
	desc	= "when a player shoots or uses a loadout item",
	color 	= Color(0, 255, 0),
	display = "{player_id1} has used {weapon_id}",
	show 	= false,
	witness = true
})