
util.AddNetworkString("M_DL_AskLogsList")
util.AddNetworkString("M_DL_AskOldLog")
util.AddNetworkString("M_DL_SendOldLog")
util.AddNetworkString("M_DL_SendLogsList")
util.AddNetworkString("M_DL_AskOldLogRounds")
util.AddNetworkString("M_DL_SendOldLogRounds")

Damagelog.previous_reports = {}

local limit = os.time() - Damagelog.LogDays*24*60*60

local function GetLogsCount_SQLite()
	return sql.QueryValue("SELECT COUNT(id) FROM damagelog_oldlogs;")
end

require("mysqloo")
Damagelog.MySQL_Error = nil
file.Delete("damagelog/mysql_error.txt")

hook.Add("SQLConnected", "damagelogsSQL", function(db)
	Damagelog.database = db
	Damagelog.MySQL_Connected = true
	local create_table1 = db:query([[CREATE TABLE IF NOT EXISTS damagelog_oldlogs (
		id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		server TINYTEXT NOT NULL,
		map TINYTEXT NOT NULL,
		round TINYINT NOT NULL,
		damagelog LONGBLOB NOT NULL,
		PRIMARY KEY (id));
		]])
	create_table1:start()
	local create_table2 = db:query([[CREATE TABLE IF NOT EXISTS damagelog_weapons (
		class varchar(100) NOT NULL,
		name varchar(255) NOT NULL,
		PRIMARY KEY (class));
	]])
	
	create_table2:start()
	local list = db:query("SELECT MIN(UNIX_TIMESTAMP(date)), MAX(UNIX_TIMESTAMP(date)) FROM damagelog_oldlogs;")
	list.onSuccess = function(query)
		local data = query:getData()
		if not data[1] then return end
		Damagelog.OlderDate = tonumber(data[1]["MIN(UNIX_TIMESTAMP(date))"])
		Damagelog.LatestDate = tonumber(data[1]["MAX(UNIX_TIMESTAMP(date))"])
	end
	list:start()
	local delete_old = db:query("DELETE FROM damagelog_oldlogs WHERE date < DATE_SUB(NOW(), INTERVAL 1 YEAR);")
	delete_old:start()
	Damagelog:GetWepTable()
end)

hook.Add("SQLConnectionFailed", "damagelogsSQL", function(db, err)
	file.Write("damagelog/mysql_error.txt", err)
	Damagelog.MySQL_Error = err
end)

file.CreateDir "damagelog"

hook.Add("TTTEndRound", "Damagelog_EndRound", function()
	if Damagelog.DamageTable and (Damagelog.ShootTables and Damagelog.ShootTables[Damagelog.CurrentRound]) then
		local logs = {
			DamageTable = Damagelog.DamageTable,
			ShootTable = Damagelog.ShootTables[Damagelog.CurrentRound],
			Infos = Damagelog.OldLogsInfos
		}
		logs = util.TableToJSON(logs)
		if Damagelog.Use_MySQL and Damagelog.MySQL_Connected then
			Db("INSERT INTO damagelog_oldlogs (server, map, round, damagelog) VALUES (?, ?, ?, COMPRESS(?));", Damagelog.Server, game.GetMap(), Damagelog.CurrentRound, logs)
		end
	end
end)

net.Receive("M_DL_AskLogsList", function(_,ply)
	net.Start("M_DL_SendLogsList")
	if Damagelog.OlderDate and Damagelog.LatestDate then
		net.WriteUInt(1, 1)
		net.WriteUInt(Damagelog.OlderDate, 32)
		net.WriteUInt(Damagelog.LatestDate, 32)
	else
		net.WriteUInt(0, 1)
	end
	net.Send(ply)
end)

local function SendLogs(ply, compressed, cancel)
	net.Start("M_DL_SendOldLog")
	if cancel then
		net.WriteUInt(0,1)
	else
		net.WriteUInt(1,1)
		net.WriteUInt(#compressed, 32)
		net.WriteData(compressed, #compressed)		
	end
	net.Send(ply)
end

net.Receive("M_DL_AskOldLogRounds", function(_, ply)
	local id = net.ReadUInt(32)
	local year = net.ReadUInt(32)
	local month = string.format("%02d",net.ReadUInt(32))
	local day = string.format("%02d",net.ReadUInt(32))
	local _date = "20"..year.."-"..month.."-"..day
	if Damagelog.Use_MySQL and Damagelog.MySQL_Connected then
		Db("SELECT UNIX_TIMESTAMP(date) AS date,map FROM damagelog_oldlogs WHERE server = ? AND date BETWEEN ? AND ? ORDER BY date ASC;", Damagelog.Server, _date, _date .. " 23:59:59", function(r)
			if (r and r[1]) then
				net.Start("M_DL_SendOldLogRounds")
				net.WriteUInt(id, 32)
				net.WriteTable(r)
				net.Send(ply)
			end
		end)
	end
end)

net.Receive("M_DL_AskOldLog", function(_,ply)
	local _time = net.ReadUInt(32)
	if Damagelog.Use_MySQL and Damagelog.MySQL_Connected then
		Db("SELECT UNCOMPRESS(damagelog) AS damagelog FROM damagelog_oldlogs WHERE server = ? AND UNIX_TIMESTAMP(date) = ? LIMIT 1;", Damagelog.Server, _time, function(r)
			if (r and r[1] and r[1].damagelog) then
				local compressed = util.Compress(r[1]["damagelog"])
				SendLogs(ply, compressed, false)
			else
				SendLogs(ply, nil, true)
			end
		end)
	end
end)
