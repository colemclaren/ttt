COMMAND.Name = "SetGroup"

COMMAND.AdminMode = true
COMMAND.Flag = D3A.Config.Commands.SetGroup

COMMAND.Args = {{"string", "Name/SteamID"}, {"string", "Rank"}}

COMMAND.Run = function(pl, args, supp)
	local plname = D3A.Commands.Name(pl)
	local tmname = args[2]:lower()

	if (not moat.Ranks.Get(tmname)) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Unknown rank name: " .. tmname .. ".")
		return
	end

	if (not moat.isdev(pl) and (tmname == "communitylead" or tmname == "owner" or tmname == "headadmin")) then
		if (not moat.isdev(pl)) then
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
		if (not moat.Ranks.CheckWeight(pl, d.rank)) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!")
			return
		end

		D3A.Ranks.ChangeRank(sid, tmname)

		D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has set the rank of ", moat_green, d.name, 
		moat_white, " (", moat_green, util.SteamIDFrom64(sid), moat_white, ") to ", moat_green, tmname, moat_white, ".")

		D3A.Commands.Discord("setgroup", D3A.Commands.NameID(pl), (IsValid(targ) and targ:NameID()) or (d.name .. " (" .. util.SteamIDFrom64(d.steam_id) .. ")"), tmname)
	end,
	function()
		D3A.Chat.SendToPlayer2(pl, moat_red, "Could not find player by SteamID: " .. sid .. ".")
	end)
end