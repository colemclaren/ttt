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

	hook.Add('PlayerStatsLoaded', 'nomr.PlayerStatsLoaded', function(pl, stats)
		nomr:Query('SELECT steamid64, server FROM player_sessions WHERE steamid64=' .. pl:SteamID64() .. ' AND time >= (UNIX_TIMESTAMP() - 2) AND server != ' .. self.serverid .. ';', function(d)
			if IsValid(pl) then
				if (d and #d > 0) then
					game.KickID(pl:SteamID(), 'Active session on another server detected') -- You tried to join before your session was made
				else
					local usergroup = pl:GetUserGroup() or "user"
					local level = tostring(stats and stats.l or 1)
					nomr:Query('REPLACE INTO player_sessions(steamid64, time, server, name, rank, level, team_kills, slays) VALUES(' .. pl:SteamID64() .. ', UNIX_TIMESTAMP(), ' .. nomr.serverid .. ', ' .. "'" .. nomr.db:escape(utf8.force(pl:Nick())) .. "'" .. ', ' .. "'" .. nomr.db:escape(usergroup) .. "'" .. ', ' .. nomr.db:escape(level) .. ', 0, 0);')
				end
			end
		end)
	end)

	-- apparently the regular PlayerDisconnected hook is unreliable? idk
	local session_antispam = {}
	local session_queue = {}
	local function delete_session(player_id)
		if (session_antispam[player_id] and session_antispam[player_id] > CurTime()) then 
			if (not session_queue[player_id]) then
				session_queue[player_id] = true
				timer.Simple(2, function()
					session_queue[player_id] = nil
					delete_session(player_id)
				end)
			end

			return 
		end

		nomr:Query('DELETE FROM player_sessions WHERE steamid64=' .. player_id .. ' AND server = ' .. nomr.serverid .. ';')
		session_antispam[player_id] = CurTime() + 1
	end

	gameevent.Listen("player_disconnect")
	hook.Add("player_disconnect", "nomr.PlayerDisconnected", function(info)
		local steamid64 = util.SteamIDTo64(info.networkid)
		if (not steamid64) then return end
		
		delete_session(steamid64)
	end)

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
	nomr:Query("SELECT * FROM player_sessions")
end)