COMMAND.Name = "SetGroup"

COMMAND.AdminMode = true
COMMAND.Flag = D3A.Config.Commands.SetGroup

COMMAND.Args = {{"string", "Name/SteamID"}, {"string", "Rank"}}

COMMAND.Run = function(pl, args, supp)
	local plname = (((pl and pl.rcon) or pl:IsValid()) and pl:Name()) or "Console"
	local plstid = (((pl and pl.rcon) or pl:IsValid()) and pl:SteamID()) or "CONSOLE"
	local tmname = args[2]:lower()
	local exptime = 0
	local newrank
	
	if (exptime != 0) then
		if (!args[4]) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "When setting a duration other than permanent, please input a rank to set this user to after expiration.")
			return
		end
		newrank = args[4]
	end

	if (tmname == "trialstaff") then
		exptime = 43200 * 60
		newrank = "moderator"
	end
	
	local targ = D3A.FindPlayer(args[1]);
	
	if (targ) then
		if (!D3A.Ranks.CheckWeight(pl, targ)) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!");
			D3A.Chat.SendToPlayer2(targ, moat_red, pl:Name() .. " (" .. pl:SteamID() .. ") attempted to use SetGroup on you.")
			
			return
		end
		
		local succ, err = D3A.Ranks.SetPlayerRank(targ, tmname, exptime, newrank)
		
		if (!succ) then
			D3A.Chat.SendToPlayer2(pl, moat_red, err)
		else
			local len = (exptime != 0 and exptime/60 .. " minute" .. ((exptime/60 != 1 and "s") or "")) or "permanent"
			
			tmname = D3A.Ranks.Stored[tmname].Name
			newrank = (newrank and D3A.Ranks.Stored[newrank].Name) or nil
			
			D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has set the rank of ", moat_green, targ:Name(), moat_white, " (", moat_green, targ:SteamID(), moat_white, ") to ", moat_green, tmname, moat_white, ".")
		end
	else
		local steamID = D3A.MySQL.Escape(args[1]);
		local steamID64 = D3A.MySQL.Escape(util.SteamIDTo64(args[1]));
		
		D3A.MySQL.Query(D3A_selectUserInfo(steamID, steamID64), function(data)
			if (data and data[1]) then
				data = data[1];
				data.extra = data.extra or "[]";
				data.Vars = util.JSONToTable(data.extra);
				
				local rankToCheck = data.rank or "user";
				
				if (!D3A.Ranks.CheckWeight(pl, rankToCheck)) then
					D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!");

					return;
				end
				
				local succ, err = D3A.Ranks.SetSteamIDRank(steamID, tmname, exptime, newrank, data);
				
				if (!succ) then
					D3A.Chat.SendToPlayer2(pl, moat_red, err);
				else
					local len = (exptime != 0 and exptime/60 .. " minute" .. ((exptime/60 != 1 and "s") or "")) or "permanent"
			
					tmname = D3A.Ranks.Stored[tmname].Name
					newrank = (newrank and D3A.Ranks.Stored[newrank].Name) or nil
					
					D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has set the rank of ", moat_green, data.name, moat_white, " (", moat_green, steamID, moat_white, ") to ", moat_green, tmname, moat_white, ".")
					
					D3A.Chat.SendToPlayer2(pl, moat_red, "WARNING: If this player is online on another MG TTT server right now, this will not work.")
				end
			else
				D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player by SteamID: " .. steamID .. ".")
			end
		end);
	end
end