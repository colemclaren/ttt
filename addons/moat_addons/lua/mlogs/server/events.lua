mlogs.log = mlogs.log or {}
MLOG_DAMAGE 		= 0
MLOG_OTHER 			= 1
MLOG_SHOTS 			= 2
MLOG_PLAYER 		= 3
MLOG_PLAYERS 		= 4
MLOG_WITNESS 		= 5

local eq = "INSERT INTO {database}.mlogs_events (round_id, round_time, hook_id) VALUES (?, ?, ?);"
mlogs.event.logtype[MLOG_PLAYER] = function(id, args, witness)
	local qstr = mlogs:qf(eq, mlogs.roundid, mlogs.time, id)
	qstr = qstr .. mlogs:qf("INSERT INTO {database}.mlogs_events_player (events_id, player_id, player_val) VALUES (LAST_INSERT_ID(), ?, ?);", args[1], args[2])

	if (witness) then
		qstr = qstr .. mlogs:qf("INSERT INTO {database}.mlogs_events_witness (events_id, player_ids) VALUES (LAST_INSERT_ID(), COMPRESS(?));", witness)
	end

	mlogs:qq(qstr)
end

function mlogs.event.log(id, info, witness_pos)
	assert(mlogs.EventExists(id), "tried to log nil event")
	if (witness_pos) then witness_pos = mlogs.GetWitnesses(witness_pos) end

	mlogs.event.logtype[mlogs.EventLogType(id)](id, info, witness_pos)
end

function mlogs.hook()

end

function mlogs.log.time()

end



/*

function mlogs.EventName(id)
	return mlogs.events.stored[id].name or "???"
end

function mlogs.EventType(id)
	return mlogs.events.stored[id].type or "???"
end

function mlogs.EventColor(id)
	return mlogs.events.stored[id].color or mlogs.Color.Black
end

function mlogs.EventDisplay(id)
	return mlogs.events.stored[id].display or "???"
end

function mlogs.EventDisplay(id)
	return mlogs.events.stored[id].display or "???"
end

function mlogs.EventDefault(t, f)
	if (t == nil) then
		return f
	else
		return t
	end
end

function mlogs.EventLogType(id)
	return mlogs.EventDefault(mlogs.events.stored[id].logtype, false)
end

function mlogs.EventWitness(id)
	return mlogs.EventDefault(mlogs.events.stored[id].witness, false)
end

function mlogs.EventShow(id)
	return mlogs.EventDefault(mlogs.events.stored[id].show, true)
end

function mlogs.EventKeys(id)
	return mlogs.EventDefault(mlogs.events.stored[id].keys, false), mlogs.events.stored[id].keytable
end

*/