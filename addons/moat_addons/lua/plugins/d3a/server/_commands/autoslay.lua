COMMAND.Name = "Aslay"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}, {"number", "Rounds/0 to Cancel"}, {"string", "Reason"}}

COMMAND.CheckArgs = function(pl, cmd, args)
	local margs = cmd.Args
	local err
	local supp = false
	
	if ((pl and not pl.rcon) and pl:IsPlayer() and !pl:HasAccess(cmd.Flag)) then
		err = "'" .. cmd.Flag .. "' access required!"
	end
	
	if (!err) then
		for k, v in pairs(args) do
			if (!args[k]) then
				err = "_"
				break
			end
			
			local targ = D3A.FindPlayer(v)
			if (targ) then
				if (cmd.CheckRankWeight) then
					if (!D3A.Ranks.CheckWeight(pl, targ)) then
						D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!")
						D3A.Chat.SendToPlayer2(targ, moat_red, pl:Name() .. " (" .. pl:SteamID() .. ") attempted to use " .. cmd.Name .. " on you.")
						continue
					end
				end
				supp = supp or {}
				table.insert(supp, targ)
			end
		end
	end
	
	if (!err and (!supp or #supp == 0)) then
		err = "_"
	end
	
	if (err) then
		if (err == "_") then
			err = "Usage: " .. cmd.Name .. " "
			for k, v in pairs(margs) do
				err = err .. "[" .. v[1] .. ":" .. v[2] .. "] "
			end
		end
		D3A.Chat.SendToPlayer2(pl, moat_red, err)
		return false
	end
	
	return supp
end

COMMAND.Run = function(pl, args, supplement)
	local plname = (((pl and pl.rcon) or pl:IsValid()) and pl:Name()) or "Console"
	
	local targ = supplement[1]
	local rounds = tonumber(args[2]) or 1
	local reason = table.concat(args, " ", 3)

	if ( #reason == 0 ) then reason = "Rule breaking :(" end

	Damagelog:SetSlays(pl, targ:SteamID(), rounds, reason, targ)
	
	if (rounds >= 1) then
		D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has added ", moat_green, tostring(rounds), moat_white, " autoslays to ", moat_green, targ:Name(), moat_white, " with the reason: ", moat_green, reason, moat_white, ".")
	else
		D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has removed the autoslays of ", moat_green, targ:Name(), moat_white, ".")
	end
end