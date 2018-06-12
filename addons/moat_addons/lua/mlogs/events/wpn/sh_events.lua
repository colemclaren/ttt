mlogs.events.register(MLOGS_SWITCH_FROM, {
	name = "Switch from Traitor Weapon",
	color = Color(0, 0, 200),
	display = "{player_id} switched FROM traitor weapon {weapon_id}",
	log = MLOG_PLAYER,
	show = false,
	witness = true
})

mlogs.events.register(MLOGS_SWITCH_TO, {
	name = "Switch to Traitor Weapon",
	color = Color(0, 0, 200),
	display = "{player_id} switched TO traitor weapon {weapon_id}",
	format = "weapon",
	log = MLOG_PLAYER,
	show = false,
	witness = true
})