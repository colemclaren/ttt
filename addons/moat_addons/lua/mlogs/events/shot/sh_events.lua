mlogs.events.register(MLOGS_SHOT, {
	name = "Fired Weapon",
	color = Color(0, 255, 0),
	display = "{player_id} has shot with {weapon_id}",
	format = "weapon",
	log = MLOG_PLAYER,
	show = false,
	witness = true
})