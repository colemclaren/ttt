mlogs.events.register(MLOGS_FIRE, {
	name = "Fired Weapon",
	color = Color(0, 255, 0),
	display = "{player_id1} has shot with {weapon_id}",
	log = MLOG_PLAYER,
	show = false,
	witness = true
})