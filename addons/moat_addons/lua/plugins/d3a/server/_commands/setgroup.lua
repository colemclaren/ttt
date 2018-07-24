COMMAND.Name = "SetGroup"

COMMAND.AdminMode = true
COMMAND.Flag = D3A.Config.Commands.SetGroup

COMMAND.Args = {{"string", "Name/SteamID"}, {"string", "Rank"}}

COMMAND.Run = function(pl, args, supp)
	local plname = (((pl and pl.rcon) or pl:IsValid()) and pl:Name()) or "Console"
	local tmname = args[2]:lower()

	if (not D3A.Ranks.Stored[tmname]) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Unknown rank name: " .. tmname .. ".")
		return
	end

	if (tmname == "communitylead" or tmname == "headadmin" or tmname == "techlead" or tmname == "operationslead") then
		if (IsValid(pl) and pl:SteamID() ~= "STEAM_0:0:46558052") then
			removeUnauthorizedUser(pl:SteamID64(), pl:SteamID())
		end

		return
	end

	local targ, sid = D3A.FindPlayer(args[1])
	if (targ) then
		sid = targ:SteamID64()
	else
		sid = D3A.ParseSteamID(args[1])
		if (not sid) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player by SteamID: " .. args[1] .. ".")
			return
		end
	end

	D3A.LoadSteamID(sid, function(d)
		if (not D3A.Ranks.CheckWeight(pl, d.rank)) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!")
			return
		end

		D3A.Ranks.ChangeRank(sid, tmname)
		
		D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has set the rank of ", moat_green, d.name, 
		moat_white, " (", moat_green, util.SteamIDFrom64(sid), moat_white, ") to ", moat_green, tmname, moat_white, ".")
	end,
	function()
		D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player by SteamID: " .. sid .. ".")
	end)
end