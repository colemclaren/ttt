mlogs.log = mlogs.log or {}
mlogs.logtype = {}

function mlogs.log.event(id, info, witness_pos)
	assert(mlogs.EventExists(id), "tried to log nil event")
	
	if (WITNESS_DEBUG) then
		Msg("\n\n")
		print(id)
		PrintTable(info)
		print(witness_pos)
		Msg("\n\n")
	end

	local qstr, tbl, args = "INSERT INTO {database}.mlogs_event (round_id, round_time, event_id", {}, 3
	tbl[1] = mlogs.roundid
	tbl[2] = mlogs.time
	tbl[3] = id

	if (info.player_id1) then
		qstr = qstr .. ", player_id1"
		args = args + 1
		tbl[args] = info.player_id1
	end

	if (info.player_id2) then
		qstr = qstr .. ", player_id2"
		args = args + 1
		tbl[args] = info.player_id2
	end

	if (info.weapon_id) then
		qstr = qstr .. ", weapon_id"
		args = args + 1
		tbl[args] = info.weapon_id
	end

	if (info.num_info) then
		qstr = qstr .. ", num_info"
		args = args + 1
		tbl[args] = info.num_info
	end

	if (info.str_info) then
		qstr = qstr .. ", str_info"
		args = args + 1
		tbl[args] = info.str_info
	end

	qstr = qstr .. ") VALUES (?, ?, ?"

	if (args > 3) then
		qstr = qstr .. string.rep(", ?", args - 3)
	end

	qstr = qstr .. ");"
	qstr = mlogs:qf(qstr, tbl)

	--local qstr = mlogs:qf("INSERT INTO {database}.mlogs_event (round_id, round_time, event_id, player_id1, weapon_id) VALUES (?, ?, ?, ?, ?);", mlogs.roundid, mlogs.time, id, info[1], info[2])

	if (witness_pos) then
		local w, wn = mlogs.GetWitnesses(witness_pos)
		if (w) then
			local ws = "INSERT INTO {database}.mlogs_event_witness VALUES " .. string.rep("(LAST_INSERT_ID(), ?)", wn, ",") .. ";"
			qstr = qstr .. mlogs:qf(ws, w)
		end
	end

	mlogs.log_str = mlogs.log_str .. qstr
end


/*
local eq = "INSERT INTO {database}.mlogs_events (round_id, round_time, hook_id) VALUES (?, ?, ?);"
mlogs.logtype[MLOG_PLAYER] = function(id, args, witness)
	local qstr = mlogs:qf(eq, mlogs.roundid, mlogs.time, id)
	qstr = qstr .. mlogs:qf("INSERT INTO {database}.mlogs_events_player (events_id, player_id, player_val) VALUES (LAST_INSERT_ID(), ?, ?);", args[1], args[2])

	if (witness) then
		qstr = qstr .. mlogs:qf("INSERT INTO {database}.mlogs_events_witness (events_id, player_ids) VALUES (LAST_INSERT_ID(), COMPRESS(?));", witness)
	end

	mlogs:qq(qstr)
end

function mlogs.event.logme(id, args, witness)
	-- gay
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
*/


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