local sv = {ID = 0}
sv.Loaded = false
sv.Def = "h-hewwo?? uwu"
sv.IP = GetConVarString "ip"
sv.Port = GetConVarString "hostport"
sv.FullIP = sv.IP .. ":" .. sv.Port
sv.Count = {Players = 0, Staff = 0, Innocents = 0, Traitors = 0, Others = 0, Spectators = 0}
sv.LastCount = 0
sv.Wins = {Innocents = 0, Traitors = 0}
sv.TopPlayer = {}
sv.States = {
	[1] = "Waiting for Players",
	[2] = "Preparing Round",
	[3] = "Active Round",
	[4] = "Round Ending"
}

hook("TTTEndRound", function(res)
	if (res == 3) then
		sv.Wins.Innocents = sv.Wins.Innocents + 1
	elseif (res == 2) then
		sv.Wins.Traitors = sv.Wins.Traitors + 1
	end
end)

function sv.RefreshCounts()
	local p, ps, i, t, o, s, n, a = 0, 0, 0, 0, 0, 0, 0
	for k, v in ipairs(player.GetAll()) do
		if (not IsValid(v)) then
			continue
		end

		p = p + 1

		if (v.IsStaff) then
			ps = ps + 1
		end

		if (v:Team() == TEAM_SPEC) then
			s = s + 1
		elseif (v:IsTraitor()) then
			t = t + 1
		elseif (v:IsSpecial() and not v:IsDetective()) then
			o = o + 1
		else
			i = i + 1
		end

		if (v:Frags() > n) then
			n = v:Frags()
			a = v
		end
	end

	sv.Count = {Players = p, Staff = ps, Innocents = i, Traitors = t, Others = o, Spectators = s}
	sv.LastCount = CurTime()

	if (not IsValid(a)) then
		return
	end

	sv.TopPlayer = {SteamID64 = a:SteamID64(), Name = a:Nick(), Score = n}
end

function sv.Name() if (GetServerName) then return GetServerName() end return GetHostName() end
function sv.Map() return game.GetMap() or sv.Def end
function sv.PlayerCount() return sv.Count.Players end
function sv.StaffCount() return sv.Count.Staff end
function sv.MaxPlayers() return GetConVarNumber "maxplayers" end
function sv.JoinURL() return "steam://connect/" .. sv.IP .. (sv.Port == "27015" and "" or (":" .. sv.Port)) end
function sv.RoundsLeft() return math.max(0, GetGlobal("ttt_rounds_left", 6)) end
function sv.RoundState() return sv.States[Either(GetRoundState, GetRoundState(), 1)] or sv.States[1] end
function sv.RoundTimeLeft() return math.max(0, GetGlobal("ttt_round_end") - CurTime()) end
function sv.MapTimeLeft() return math.max(0, (GetConVar("ttt_time_limit_minutes"):GetInt() * 60) - CurTime()) end
function sv.TraitorsAlive() return sv.Count.Traitors end
function sv.InnocentsAlive() return sv.Count.Innocents end
function sv.OthersAlive() return sv.Count.Others end
function sv.SpectatorCount() return sv.Count.Spectators end
function sv.TraitorWins() return sv.Wins.Traitors end
function sv.InnocentWins() return sv.Wins.Innocents end
function sv.TopPlayerSteamID() return sv.TopPlayer.SteamID64 or "0" end
function sv.TopPlayerName() return sv.TopPlayer.Name or "None" end
function sv.TopPlayerScore() return sv.TopPlayer.Score or 0 end
function sv.MapEvent() if (MG_cur_event) then return MG_cur_event .. " Event" end return "" end
function sv.SpecialRound()
	if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return GetGlobal("MOAT_MINIGAME_ACTIVE") .. " Round" end
	if (cur_random_round) then return cur_random_round .. " Round" end
	return ""
end

function sv.CreateRow()
	print "Attempting INSERT INTO player_servers ..."

	moat.mysql([[INSERT INTO player_servers (name, full_ip, map, players, staff, ip, port, custom_ip, join_url, hostname, 
	max_players, rounds_left, round_state, time_left, map_time_left, traitors_alive, innocents_alive, others_alive, spectators, 
	traitor_wins, innocent_wins, top_player_steamid, top_player_name, top_player_score, special_round, map_event, map_changed) 
	VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)]], 
	sv.Name(), sv.FullIP, sv.Map(), sv.PlayerCount(), sv.StaffCount(), sv.IP, sv.Port, sv.IP, sv.JoinURL(), GetHostName(), sv.MaxPlayers(), 
	sv.RoundsLeft(), sv.RoundState(), sv.RoundTimeLeft(), sv.MapTimeLeft(),
	sv.TraitorsAlive(), sv.InnocentsAlive(), sv.OthersAlive(), sv.SpectatorCount(), sv.TraitorWins(), sv.InnocentWins(),
	sv.TopPlayerSteamID(), sv.TopPlayerName(), sv.TopPlayerScore(), sv.SpecialRound(), sv.MapEvent(), CurTime(),
	function(r)
		print "INSERT INTO player_servers successful!"
		sv.Initialize()
	end)
end

function sv.UpdateRows()
	sv.RefreshCounts()

	moat.mysql([[UPDATE player_servers SET map = ?, staff = ?, hostname = ?, max_players = ?, 
	rounds_left = ?, round_state = ?, time_left = ?, map_time_left = ?, 
	traitors_alive = ?, innocents_alive = ?, others_alive = ?, spectators = ?, traitor_wins = ?, innocent_wins = ?, 
	top_player_steamid = ?, top_player_name = ?, top_player_score = ?, special_round = ?, map_event = ?, map_changed = ? WHERE id = ?]], 
	sv.Map(), sv.StaffCount(), GetHostName(), sv.MaxPlayers(), 
	sv.RoundsLeft(), sv.RoundState(), sv.RoundTimeLeft(), sv.MapTimeLeft(),
	sv.TraitorsAlive(), sv.InnocentsAlive(), sv.OthersAlive(), sv.SpectatorCount(), sv.TraitorWins(), sv.InnocentWins(),
	sv.TopPlayerSteamID(), sv.TopPlayerName(), sv.TopPlayerScore(), sv.SpecialRound(), sv.MapEvent(), CurTime(), sv.ID)
end

function sv.Initialize()
	sv.Loaded = false

	print("Loading player_servers for " .. sv.FullIP)
	moat.mysql("SELECT id FROM player_servers WHERE full_ip LIKE ?;", sv.FullIP, function(r)
		if (not r or not r[1] or not r[1].id) then
			print("No player_servers row for IP: " .. sv.FullIP)
			return sv.CreateRow()
		end

		sv.ID = r[1].id
		sv.Loaded = true

		print("Loaded player_servers ID: " .. sv.ID)

		timer.Create("player_servers", 5, 0, function()
			if (not sv.Loaded) then
				timer.Remove "player_servers"
				return
			end

			sv.UpdateRows()
		end)
	end)

end

hook.Add("SQLConnected", "Servers.SQL", sv.Initialize)