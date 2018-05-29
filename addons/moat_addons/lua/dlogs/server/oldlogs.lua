
util.AddNetworkString("dlogs.AskLogsList")
util.AddNetworkString("dlogs.AskOldLog")
util.AddNetworkString("dlogs.SendOldLog")
util.AddNetworkString("dlogs.SendLogsList")
util.AddNetworkString("dlogs.AskOldLogRounds")
util.AddNetworkString("dlogs.SendOldLogRounds")

dlogs.previous_reports = {}

local limit = os.time() - dlogs.Config.LogDays*24*60*60

local function GetLogsCount_SQLite()
	return sql.QueryValue("SELECT COUNT(id) FROM damagelog_oldlogs_v3;")
end

if dlogs.Config.Use_MySQL then
	require("mysqloo")
	dlogs.MySQL_Error = nil
	file.Delete("damagelog/mysql_error.txt")
	local info = dlogs.MySQL_Informations
	dlogs.database = mysqloo.connect(info.ip, info.username, info.password, info.database, info.port)
	dlogs.database.onConnected = function(self)
		dlogs.MySQL_Connected = true
		local create_table1 = self:query([[CREATE TABLE IF NOT EXISTS damagelog_oldlogs_v3 (
			id INT UNSIGNED NOT NULL AUTO_INCREMENT,
			year INTEGER NOT NULL,
			month INTEGER NOT NULL,
			day INTEGER NOT NULL,
			date INTEGER NOT NULL,
			map TINYTEXT NOT NULL,
			round TINYINT NOT NULL,
			damagelog BLOB NOT NULL,
			PRIMARY KEY (id));
		]])
		create_table1:start()
		local create_table2 = self:query([[CREATE TABLE IF NOT EXISTS damagelog_weapons (
			class varchar(255) NOT NULL,
			name varchar(255) NOT NULL,
			PRIMARY KEY (class));
		]])
		create_table2:start()
		local list = self:query("SELECT MIN(date), MAX(date) FROM damagelog_oldlogs_v3;")
		list.onSuccess = function(query)
			local data = query:getData()
			if not data[1] then return end
			dlogs.OlderDate = data[1]["MIN(date)"]
			dlogs.LatestDate = data[1]["MAX(date)"]
		end
		list:start()
		local delete_old = self:query("DELETE FROM damagelog_oldlogs_v3 WHERE date <= "..limit..";")
		delete_old:start()
		dlogs.OldLogsDays = {}
		local yearsQuery = self:query("SELECT DISTINCT year FROM damagelog_oldlogs_v3;")
		yearsQuery.onSuccess = function(yearsQuery)
			local years = yearsQuery:getData()
			for k1, year in pairs(years) do
				local y = tonumber(year.year)
				if not y then continue end
				dlogs.OldLogsDays[y] = {}
				local monthQuery =  self:query("SELECT DISTINCT month FROM damagelog_oldlogs_v3;")
				monthQuery.onSuccess = function(monthQuery)
					local months = monthQuery:getData()
					for k2, month in pairs(months) do
						local m = tonumber(month.month)
						if not m then continue end
						dlogs.OldLogsDays[y][m] = {}
						local dayQuery = self:query("SELECT DISTINCT day FROM damagelog_oldlogs_v3;")
						dayQuery.onSuccess = function(dayQuery)
							local days = dayQuery:getData()
							for k, day in pairs(days) do
								local d = tonumber(day.day)
								if not d then continue end
								dlogs.OldLogsDays[y][m][d] = true
							end
						end
						dayQuery:start()
					end
				end
				monthQuery:start()
			end
		end
		yearsQuery:start()
	end
	dlogs.database.onConnectionFailed = function(self, err)
		file.Write("damagelog/mysql_error.txt", err)
		dlogs.MySQL_Error = err
	end
	dlogs.database:connect()
else
	if not sql.TableExists("damagelog_oldlogs_v3") then
		-- year/month/day are only here to send the list of days to the client
		-- date is the UNIX TIME
		sql.Query([[CREATE TABLE IF NOT EXISTS damagelog_oldlogs_v3 (
			id INT UNSIGNED NOT NULL PRIMARY KEY,
			year INTEGER NOT NULL,
			month INTEGER NOT NULL,
			day INTEGER NOT NULL,
			date INTEGER NOT NULL,
			map TINYTEXT NOT NULL,
			round TINYINT NOT NULL,
			damagelog TEXT);
		]])
	end
	if not sql.TableExists("damagelog_weapons") then
		sql.Query([[CREATE TABLE IF NOT EXISTS damagelog_weapons (
			class varchar(255) NOT NULL,
			name varchar(255) NOT NULL,
			PRIMARY KEY (class));
		]])
	end
	dlogs.OlderDate = tonumber(sql.QueryValue("SELECT MIN(date) FROM damagelog_oldlogs_v3 WHERE damagelog IS NOT NULL;"))
	dlogs.LatestDate = tonumber(sql.QueryValue("SELECT MAX(date) FROM damagelog_oldlogs_v3 WHERE damagelog IS NOT NULL;"))
	sql.Query("DELETE FROM damagelog_oldlogs_v3 WHERE date <= "..limit..";")
	-- Get the list of days and send it to the client
	dlogs.OldLogsDays = {}
	local years = sql.Query("SELECT DISTINCT year FROM damagelog_oldlogs_v3;") or {}
	for k1, year in pairs(years) do
		local y = tonumber(year.year)
		if not y then continue end
		dlogs.OldLogsDays[y] = {}
		local months = sql.Query("SELECT DISTINCT month FROM damagelog_oldlogs_v3 WHERE year = " .. y .. ";") or {}
		for k2, month in pairs(months) do
			local m = tonumber(month.month)
			if not m then continue end
			dlogs.OldLogsDays[y][m] = {}
			local days = sql.Query("SELECT DISTINCT day FROM damagelog_oldlogs_v3 WHERE year = " .. y .. " AND month = " ..m.. ";") or {}
			for k3, day in pairs(days) do
				local d = tonumber(day.day)
				if not d then continue end
				dlogs.OldLogsDays[y][m][d] = true
			end
		end
	end
end

if file.Exists("damagelog/damagelog_lastroundmap.txt", "DATA") then
	dlogs.last_round_map = tonumber(file.Read("damagelog/damagelog_lastroundmap.txt", "DATA"))
	file.Delete("damagelog/damagelog_lastroundmap.txt")
end

hook.Add("TTTEndRound", "dlogs_EndRound", function()
	if dlogs.DamageTable and (dlogs.ShootTables and dlogs.ShootTables[dlogs.CurrentRound]) then
		local logs = {
			DamageTable = dlogs.DamageTable,
			ShootTable = dlogs.ShootTables[dlogs.CurrentRound],
			Roles = dlogs.Roles[dlogs.CurrentRound]
		}
		logs = util.TableToJSON(logs)
		local t = os.time()
		local year = tonumber(os.date("%y"))
		local month = tonumber(os.date("%m"))
		local day = tonumber(os.date("%d"))
		if dlogs.Config.Use_MySQL and dlogs.MySQL_Connected then
			local insert = string.format("INSERT INTO damagelog_oldlogs_v3(`year`, `month`, `day`, `date`, `round`, `map`, `damagelog`) VALUES(%i, %i, %i, %i, %i, \"%s\", COMPRESS(%s));",
				year, month, day, t, dlogs.CurrentRound, game.GetMap(), sql.SQLStr(logs))
			local query = dlogs.database:query(insert)
			query:start()
		elseif not dlogs.Config.Use_MySQL then
			local insert = string.format("INSERT INTO damagelog_oldlogs_v3(`id`, `year`, `month`, `day`, `date`, `round`, `map`, `damagelog`) VALUES(%i, %i, %i, %i, %i, %i, \"%s\", %s);",
				GetLogsCount_SQLite() + 1, year, month, day, t, dlogs.CurrentRound, game.GetMap(), sql.SQLStr(logs))
			sql.Query(insert)
		end
		file.Write("damagelog/damagelog_lastroundmap.txt", tostring(t))
	end
end)

net.Receive("dlogs.AskLogsList", function(_,ply)
	net.Start("dlogs.SendLogsList")
	if dlogs.OlderDate and dlogs.LatestDate then
		net.WriteUInt(1, 1)
		net.WriteTable(dlogs.OldLogsDays)
		net.WriteUInt(dlogs.OlderDate, 32)
		net.WriteUInt(dlogs.LatestDate, 32)
	else
		net.WriteUInt(0, 1)
	end
	net.Send(ply)
end)

local function SendLogs(ply, compressed, cancel)
	net.Start("dlogs.SendOldLog")
	if cancel then
		net.WriteUInt(0,1)
	else
		net.WriteUInt(1,1)
		net.WriteUInt(#compressed, 32)
		net.WriteData(compressed, #compressed)
	end
	net.Send(ply)
end

net.Receive("dlogs.AskOldLogRounds", function(_, ply)
	local id = net.ReadUInt(32)
	local year = net.ReadUInt(32)
	local month = string.format("%02d",net.ReadUInt(32))
	local day = string.format("%02d",net.ReadUInt(32))
	local isnewlog = net.ReadBool()
	local _date = "20"..year.."-"..month.."-"..day
	if dlogs.Config.Use_MySQL and dlogs.MySQL_Connected then
		local query_str = "SELECT date,map,round FROM damagelog_oldlogs_v3 WHERE date BETWEEN UNIX_TIMESTAMP(\"".._date.." 00:00:00\") AND UNIX_TIMESTAMP(\"".._date.." 23:59:59\") ORDER BY date ASC;"
		local query = dlogs.database:query(query_str)
		query.onSuccess = function(self)
			if not IsValid(ply) then return end
			local data = self:getData()
			net.Start("dlogs.SendOldLogRounds")
			net.WriteUInt(id, 32)
			net.WriteTable(data)
			net.WriteBool(isnewlog)
			net.Send(ply)
		end
		query:start()
	else
		local query_str = "SELECT date,map,round FROM damagelog_oldlogs_v3 WHERE date BETWEEN strftime(\"%s\", \"".._date.." 00:00:00\") AND strftime(\"%s\", \"".._date.." 23:59:59\") ORDER BY date ASC;"
		local result = sql.Query(query_str)
		if not result then result = {} end
		net.Start("dlogs.SendOldLogRounds")
		net.WriteUInt(id, 32)
		net.WriteTable(result)
		net.WriteBool(isnewlog)
		net.Send(ply)
	end
end)

net.Receive("dlogs.AskOldLog", function(_,ply)
	if IsValid(ply) and ply:IsPlayer() and (ply.lastLogs == nil or (CurTime() - ply.lastLogs) > 2) then
		local _time = net.ReadUInt(32)
		if dlogs.Config.Use_MySQL and dlogs.MySQL_Connected then
			local query = dlogs.database:query("SELECT UNCOMPRESS(damagelog) FROM damagelog_oldlogs_v3 WHERE date = ".._time..";")
			query.onSuccess = function(self)
				local data = self:getData()
				net.Start("dlogs.SendOldLog")
				if data[1] and data[1]["UNCOMPRESS(damagelog)"] then
					local compressed = util.Compress(data[1]["UNCOMPRESS(damagelog)"])
					SendLogs(ply, compressed, false)
				else
					SendLogs(ply, nil, true)
				end
				net.Send(ply)
			end
			query:start()
		elseif not dlogs.Config.Use_MySQL then
			local query = sql.QueryValue("SELECT damagelog FROM damagelog_oldlogs_v3 WHERE date = ".._time..";")
			net.Start("dlogs.SendOldLog")
			if query then
				SendLogs(ply, util.Compress(query), false)
			else
				SendLogs(ply, nil, true)
			end
		end
	end
	ply.lastLogs = CurTime()
end)
