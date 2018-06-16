mlogs.events.hook("mlogs.slay", function(pl, staff)
	mlogs.log.event(MLOGS_AUTOSLAY, {
		["player_id1"] = mlogs.PlayerID(pl)
	})
end)