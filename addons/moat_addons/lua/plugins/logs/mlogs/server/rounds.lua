mlogs.round = mlogs.round or {}
mlogs.log_str = ""
mlogs.time = 0
mlogs.roundid = 0
mlogs.cur_round = 0

function mlogs.round.start()
	mlogs.round.saveroles()

	mlogs.time = 0
	timer.Remove "mlogs.round.time"

	timer.Create("mlogs.round.time", 1, 0, function()
		if (mlogs.DontLog()) then mlogs.round.stop() return end
		mlogs.time = mlogs.time + 1

		if (mlogs.time % 10 == 0) then mlogs.round.savelog() end
	end)
end

function mlogs.round.stop(end_round)
	mlogs.round.savelog(end_round)
	mlogs.time = 0
	timer.Remove "mlogs.round.time"
end

function mlogs.round.savelog(end_round)
	if (mlogs.roundid == 0) then return end

	local ls = mlogs.log_str
	mlogs.log_str = ""

	if (end_round) then
		ls = ls .. mlogs:qf("UPDATE {database}.mlogs_rounds SET length = ?, outcome = ? WHERE rid = ?;", mlogs.time, end_round, mlogs.roundid)
	end

	if (ls == "") then return end
	mlogs:q(ls, function()
		print "saved log"
	end)
end

function mlogs.round.saveroles()
	if (mlogs.roundid == 0) then return end
	local rn, r = mlogs.GetRoles()
	if (rn == 0) then return end
	local sr, srn = {}, 0
	for i = 1, rn do
		srn = srn + 1
		sr[srn] = mlogs.roundid
		srn = srn + 1
		sr[srn] = r[i][1]
		srn = srn + 1
		sr[srn] = r[i][2]
	end

	local rs = "INSERT INTO {database}.mlogs_roles VALUES " .. string.rep("(?, ?, ?)", rn, ",") .. ";"
	rs = mlogs:qf(rs, sr)

	mlogs:q(rs, function()
		print "saved roles"
	end)
end

hook("mlogs.prep", function()
	mlogs.cur_round = mlogs.cur_round + 1

	mlogs:q("INSERT INTO {database}.mlogs_rounds (server_id, round, length, outcome, map_id) VALUES (?, ?, ?, ?, ?);", mlogs.serverid, mlogs.cur_round, 0, 0, mlogs.mapid, function(r, s)
		mlogs.roundid = s:lastInsert()
	end)
end)