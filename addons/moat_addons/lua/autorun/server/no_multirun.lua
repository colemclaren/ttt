nomr = nomr or {
	serverid = util.CRC(GetConVarString('ip') .. ':' .. GetConVarString('hostport'))
}

include 'dash_mysql_wrapper.lua'


nomr.db = nomr.db or nomr.mysql('gamedb.moat.gg', 'footsies', 'clkmTQF6bF@3V0NYjtUMoC6sF&17B$', 'old_moat_stats', 3306)

nomr.db:Query [[
	CREATE TABLE IF NOT EXISTS `sessions`(  
		`steamid64` BIGINT(20) NOT NULL,
		`time` INT NOT NULL,
		`server` BIGINT(20) NOT NULL,
		PRIMARY KEY (`steamid64`)
	);
]]

nomr.db:Query('DELETE FROM sessions WHERE server = ' .. nomr.serverid .. ';')

local checksession 	= nomr.db:Prepare('SELECT steamid64, server FROM sessions WHERE steamid64=? AND time >= (UNIX_TIMESTAMP() - 0.5) AND server != ' .. nomr.serverid .. ';')
local updatesession = nomr.db:Prepare('REPLACE INTO sessions(steamid64, time, server) VALUES(?, UNIX_TIMESTAMP(), ' .. nomr.serverid .. ');')
hook.Add('CheckPassword', 'nomr.CheckPassword', function(steamid64)
	checksession:Run(steamid64, function(data)
		if (#data > 0) then
			game.KickID(util.SteamIDFrom64(steamid64), 'Active session on another server detected') -- if we create your session here you wont be able to join other servers if you lose connection before you're authed
		end
	end)
end)

hook.Add('PlayerAuthed', 'nomr.PlayerAuthed', function(pl)
	checksession:Run(pl:SteamID64(), function(data)
		if IsValid(pl) then
			if (#data > 0) then
				game.KickID(pl:SteamID(), 'Active session on another server detected') -- You tried to join before your session was made
			else
				updatesession:Run(pl:SteamID64())
			end
		end
	end)
end)

local deletesession = nomr.db:Prepare('DELETE FROM sessions WHERE steamid64=? AND server = ' .. nomr.serverid .. ';')
hook.Add('PlayerDisconnected', 'nomr.PlayerDisconnected', function(pl)
	deletesession:Run(pl:SteamID64())
end)

local updatesessions = nomr.db:Prepare('UPDATE sessions SET time = UNIX_TIMESTAMP() WHERE server = ' .. nomr.serverid .. ';')
timer.Create('nomr.UpdateSessions', 0.25, 0, function()
	updatesessions:Run()
end)

timer.Create("no_multirun_no_disconnect", 180, 0, function()
	nomr.db:Query("SELECT * FROM sessions")
end)