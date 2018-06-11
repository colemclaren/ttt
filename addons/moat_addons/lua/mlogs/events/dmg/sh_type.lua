local me = "dmg"

mlogs.events.register(mlogs.eventids.EVENT_PLY_HURT, {
	name = "Damaged Player",
	type = me,
	color = Color(0, 0, 0),
	display = mlogs.str.DamagedPlayer,
	log = mlogs.enums.LOG_DAMAGE,
	witness = true
})

mlogs.events.register(mlogs.eventids.EVENT_PLY_HURT_TEAM, {
	name = "Damaged Team",
	type = me,
	color = Color(200, 0, 0),
	display = mlogs.str.DamagedPlayer,
	log = mlogs.enums.LOG_DAMAGE,
	witness = true
})