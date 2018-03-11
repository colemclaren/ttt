nomr = nomor or {
	serverid = GetConVarString('ip') .. ':' .. GetConVarString('hostport')
}

function nomr:Query(str)
	if (not self.db) then return end
	
	local q = self.db:query(str)
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
	local checksession 	= self.db:prepare('SELECT steamid64, server FROM player_sessions WHERE steamid64=? AND time >= (UNIX_TIMESTAMP() - 0.5) AND server != ' .. self.serverid .. ';')
	local updatesession = self.db:prepare('REPLACE INTO player_sessions(steamid64, time, server, name, rank, level, team_kills, slays) VALUES(?, UNIX_TIMESTAMP(), ' .. self.serverid .. ', ?, ?, ?, 0, 0);')
	local deletesession = self.db:prepare('DELETE FROM player_sessions WHERE steamid64=? AND server = ' .. self.serverid .. ';')
	local updatesessions = self.db:prepare('UPDATE player_sessions SET time = UNIX_TIMESTAMP() WHERE server = ' .. self.serverid .. ';')

	hook.Add('CheckPassword', 'nomr.CheckPassword', function(steamid64)
		checksession:setString(1, steamid64)

		self:Run(checksession, function(d)
			if (d and #d > 0) then
				game.KickID(util.SteamIDFrom64(steamid64), 'Active session on another server detected') -- if we create your session here you wont be able to join other servers if you lose connection before you're authed
			end
		end)
	end)

	hook.Add('PlayerStatsLoaded', 'nomr.PlayerStatsLoaded', function(pl, stats)
		checksession:setString(1, pl:SteamID64())

		self:Run(checksession, function(d)
			if IsValid(pl) then
				if (d and #d > 0) then
					game.KickID(pl:SteamID(), 'Active session on another server detected') -- You tried to join before your session was made
				else
					updatesession:setString(1, pl:SteamID64())
					updatesession:setString(2, pl:Nick())
					updatesession:setString(3, pl:GetUserGroup() or "user")
					updatesession:setNumber(4, stats and stats.l or 1)
					self:Run(updatesession)
				end
			end
		end)
	end)

	hook.Add('PlayerDisconnected', 'nomr.PlayerDisconnected', function(pl)
		deletesession:setString(1, pl:SteamID64())
		self:Run(deletesession)
	end)

	timer.Create('nomr.UpdateSessions', 0.25, 0, function()
		self:Run(updatesessions)
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
	nomr:Query('DELETE FROM sessions WHERE server = ' .. nomr.serverid .. ';')

	nomr:onConnected()
end)

timer.Create("no_multirun_no_disconnect", 180, 0, function()
	nomr.db:Query("SELECT * FROM sessions")
end)