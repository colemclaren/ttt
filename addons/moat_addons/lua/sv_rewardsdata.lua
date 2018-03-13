--REWARDS Data Server Dist (Converted to use MYSQL with mysqloo module)
require('mysqloo')

--
-- STEAM Rewards - MySQL Database Settings
--
REWARDS.Database = {}
REWARDS.Database.Host = 'gamedb.moat.gg' -- MySQL host/server IP
REWARDS.Database.Username = 'footsies' -- MySQL username
REWARDS.Database.Password = 'clkmTQF6bF@3V0NYjtUMoC6sF&17B$' -- MySQL password
REWARDS.Database.DatabaseName = 'old_moat_stats' -- MySQL database
REWARDS.Database.Port = 3306 -- MySQL port number (Usually 3306)
/*
function REWARDS.Database.Setup()


	REWARDS.Database.DB = mysqloo.connect(REWARDS.Database.Host, REWARDS.Database.Username, REWARDS.Database.Password, REWARDS.Database.DatabaseName, REWARDS.Database.Port)
	
	function REWARDS.Database.DB:onConnected()
		print("SteamGroup Rewards: MySQL connection successful.")
		
		//Create table if it doesn't exist
		REWARDS.MySQLQuery("CREATE TABLE IF NOT EXISTS steam_rewards(steam char(20) NOT NULL, value INTEGER NOT NULL, PRIMARY KEY(steam));")
		
	end
	function REWARDS.Database.DB:onConnectionFailed(error)
		print("SteamGroup Rewards: MySQL CONNECTION FAILED. Please check your MySQL settings: " .. error)
	end
	REWARDS.Database.DB:connect()
	
	
	
end
hook.Add("InitPostEntity","REWARDS_InitSetupDatabase",REWARDS.Database.Setup)*/


hook.Add("SQLConnected", "REWARDS_SQL", function(db)
    REWARDS.Database.DB = db
    print("SteamGroup Rewards: MySQL connection successful.")
    REWARDS.MySQLQuery("CREATE TABLE IF NOT EXISTS steam_rewards(steam char(20) NOT NULL, value INTEGER NOT NULL, PRIMARY KEY(steam));")
end)

hook.Add("SQLConnectionFailed", "REWARDS_SQL", function(db, err)
    print("SteamGroup Rewards: MySQL CONNECTION FAILED. Please check your MySQL settings: " .. err)
end)

function REWARDS.Database.GroupJoin(ply)
	if not IsValid(ply) then return end
	REWARDS.MySQLQuery("INSERT INTO steam_rewards VALUES(" .. sql.SQLStr(ply:SteamID64()) .. ", " .. 1 .. ");")
end

function REWARDS.Database.GroupLeave(steamid)
    REWARDS.MySQLQuery("DELETE FROM steam_rewards WHERE steam = " .. sql.SQLStr(steamid) .. ";")
end

function REWARDS.Database.IsInGroup(ply, callback)
	if not IsValid(ply) then return end
    REWARDS.MySQLQuery("SELECT * FROM steam_rewards WHERE steam = " .. sql.SQLStr(ply:SteamID64()) .. ";",
	function(r)
	if r and r.value and (tonumber(r.value) == 1) then callback(ply, true)
	else callback(ply, false) end
	end)
end

function REWARDS.Database.ClearAllRecords()
    REWARDS.MySQLQuery("DELETE FROM steam_rewards ;")
end

function REWARDS.MySQLQuery(query, callback)
	local result = REWARDS.Database.DB:query(query)
	function result:onSuccess(data)
		if #data >= 1 then
			local row = data[1]
			callback(row)
		else
			if callback then callback() end
		end
	end
	function result:OnError(error, query)
		if REWARDS.Database.DB and REWARDS.Database.DB:status() == mysqloo.DATABASE_NOT_CONNECTED then
			REWARDS.Database.DB:connect()
			timer.Simple(1, function() result:start() end)

			result:start()
		end
		print("SteamGroup Rewards: MySQL Query Failed. Please check your MySQL settings: " .. error .. " when running: " .. query)
	end
	result:start()
end