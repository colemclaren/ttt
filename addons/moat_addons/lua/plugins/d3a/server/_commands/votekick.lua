COMMAND.Name = "Votekick"
COMMAND.Flag = "C"
COMMAND.CheckRankWeight = true
COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	if (D3A.VoteActive) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There's already a vote active! Please try later!")

		--return
	end

	local staff_found = false

	for k, v in ipairs(player.GetAll()) do
		local rank = v:GetUserGroup()

		if (rank ~= "user" and rank ~= "vip" and rank ~= "credibleclub") then
			staff_found = true
			break
		end
	end

	if (staff_found) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There is one or more staff members currently on the server! Please ask them for help rather than taking the situation into your own hands!")

		--return
	end

	if (#player.GetAll() < 4) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There are not enough people on to start a vote kick!")

		--return
	end

	local plynum = #player.GetAll()
	local targ = supp[1]:SteamID()
	local plname = pl:Name()

	D3A.StartVote(pl, "Votekick " .. supp[1]:Name() .. "?", {"Yes", "No"}, supp[1], function(res, votes)
		local msgtbl = {}
		table.sort(res, function(a, b) return a[2] > b[2] end)

		table.insert(msgtbl, moat_white)
		table.insert(msgtbl, "Vote Results: ")
		for i = 1, #res do
			table.insert(msgtbl, moat_white)
			table.insert(msgtbl, tostring(res[i][1] .. "("))
			table.insert(msgtbl, moat_green)
			table.insert(msgtbl, tostring(res[i][2]))
			table.insert(msgtbl, moat_white)

			if (i ~= #res) then
				table.insert(msgtbl, "), ")
			else
				table.insert(msgtbl, "). Total Votes: ")
				table.insert(msgtbl, moat_cyan)
				table.insert(msgtbl, tostring(votes))
				table.insert(msgtbl, moat_white)
				table.insert(msgtbl, ".")
			end
		end

		D3A.Chat.Broadcast2(unpack(msgtbl))

		if (res[1][1] == "Yes" and (plynum/2) <= res[1][2]) then
			game.ConsoleCommand('mga ban "' .. targ .. '" "30" "minutes" "Votekicked by ' .. pl:NameID() .. '"\n')
		else
			D3A.Chat.Broadcast2(moat_red, "Votekick Failed. (Not Enough Votes)")
		end
	end)
end