require "mysqloo"

nomr = nomor or {
	serverid = GetConVarString('ip') .. ':' .. GetConVarString('hostport')
}

function nomr:Query(str, func)
	if (not self.db) then return end

	local q = self.db:query(str)
	function q:onSuccess(data)
		if (func) then func(data) end
	end
	function q:onError(err)
		print("-- " .. err)
	end
	q:start()
end

function nomr:Run(str, func)
	local p = str

	function p:onSuccess(data)
		if (func) then func(data) end
	end

	p:start()
end

function nomr:onConnected()
	self.serverid = "'" .. self.db:escape(self.serverid) .. "'"

	/*local checksession 	= self.db:prepare('SELECT steamid64, server FROM player_sessions WHERE steamid64=? AND time >= (UNIX_TIMESTAMP() - 0.5) AND server != ' .. self.serverid .. ';')
	local updatesession = self.db:prepare('REPLACE INTO player_sessions(steamid64, time, server, name, rank, level, team_kills, slays) VALUES(?, UNIX_TIMESTAMP(), ' .. self.serverid .. ', ?, ?, ?, 0, 0);')
	local deletesession = self.db:prepare('DELETE FROM player_sessions WHERE steamid64=? AND server = ' .. self.serverid .. ';')*/

	/*hook.Add('CheckPassword', 'nomr.CheckPassword', function(steamid64)
		nomr:Query('SELECT steamid64, server FROM player_sessions WHERE steamid64=' .. steamid64 .. ' AND time >= (UNIX_TIMESTAMP() - 2) AND server != ' .. self.serverid .. ';', function(d)
			if (d and #d > 0) then
				game.KickID(util.SteamIDFrom64(steamid64), 'Active session on another server detected') -- if we create your session here you wont be able to join other servers if you lose connection before you're authed
			end
		end)
	end)*/

	hook.Add('PlayerStatsLoaded', 'nomr.PlayerStatsLoaded', function(pl, stats)
		nomr:Query('SELECT steamid64, server FROM player_sessions WHERE steamid64=' .. pl:SteamID64() .. ' AND time >= (UNIX_TIMESTAMP() - 2) AND server != ' .. self.serverid .. ';', function(d)
			if IsValid(pl) then
				if (d and #d > 0) then
					game.KickID(pl:SteamID(), 'Active session on another server detected') -- You tried to join before your session was made
				else
					local usergroup = pl:GetUserGroup() or "user"
					local level = tostring(stats and stats.l or 1)
					nomr:Query('REPLACE INTO player_sessions(steamid64, time, server, name, rank, level, team_kills, slays) VALUES(' .. pl:SteamID64() .. ', UNIX_TIMESTAMP(), ' .. nomr.serverid .. ', ' .. "'" .. nomr.db:escape(pl:Nick()) .. "'" .. ', ' .. "'" .. nomr.db:escape(usergroup) .. "'" .. ', ' .. nomr.db:escape(level) .. ', 0, 0);')
				end
			end
		end)
	end)

	hook.Add('PlayerDisconnected', 'nomr.PlayerDisconnected', function(pl)
		nomr:Query('DELETE FROM player_sessions WHERE steamid64=' .. pl:SteamID64() .. ' AND server = ' .. self.serverid .. ';')
	end)

	--local updatesessions = self.db:prepare('UPDATE player_sessions SET time = UNIX_TIMESTAMP() WHERE server = ' .. self.serverid .. ';')
	timer.Create('nomr.UpdateSessions', 1, 0, function()
		nomr:Query('UPDATE player_sessions SET time = UNIX_TIMESTAMP() WHERE server = ' .. self.serverid .. ';')
	end)
end

hook.Add("SQLConnected", "nomr_sql", function(data)
	nomr.db = data

	nomr:Query [[
		CREATE TABLE IF NOT EXISTS `player_sessions`(  
			`steamid64` BIGINT(20) NOT NULL,
			`time` INT NOT NULL,
			`server` VARCHAR(22) NOT NULL,
			`name` TEXT NOT NULL,
			`rank` TEXT NOT NULL,
			`level` INT NOT NULL,
			`team_kills` INT NOT NULL,
			`slays` INT NOT NULL,
			PRIMARY KEY (`steamid64`)
		);
	]]

	nomr:Query('DELETE FROM player_sessions WHERE server = ' .. "'" .. nomr.db:escape(nomr.serverid) .. "'" .. ';')
	nomr:onConnected()
end)

timer.Create("no_multirun_no_disconnect", 180, 0, function()
	nomr:Query("SELECT * FROM sessions")
end)