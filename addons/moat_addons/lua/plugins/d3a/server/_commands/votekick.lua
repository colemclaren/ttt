COMMAND.Name = "Votekick"
COMMAND.Flag = "+"
COMMAND.CheckRankWeight = true
COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Reason"}}
local reasons = {
	"Map Exploiting",
	"Attempted Mass RDM",
	"Mass RDM",
	"Meta Gaming",
	"Harassment",
	"Crashing The Server",
} -- not sent to client, found in addons\moat_addons\lua\plugins\d3a\client\cl_menu.lua:100
COMMAND.Run = function(pl, args, supp)
	if (D3A.VoteActive) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There's already a vote active! Please try later!")

		return
	end
	local reason = supp[2] or args[2]
	local staff_found = false

	if (not table.HasValue(reasons, reason)) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Please choose a valid reason for votekicking this person! (!menu)")

		return
	end

	for k, v in ipairs(player.GetAll()) do
		local rank = v:GetUserGroup()

		if (rank ~= "user" and rank ~= "vip" and rank ~= "mvp" and rank ~= "hoodninja") then
			staff_found = true
			break
		end
	end

	if (staff_found) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There is one or more staff members currently on the server! Please ask them for help rather than taking the situation into your own hands!")

		return
	end

	if (#player.GetAll() < 4) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There are not enough people on to start a vote kick!")

		return
	end

	local plynum = #player.GetAll()
	local targ, targid, plid = supp[1]:SteamID(), IsValid(supp[1]) and supp[1]:NameID(), D3A.Commands.NameID(pl)
	local plname = D3A.Commands.Name(pl)

	D3A.StartVote(pl, "Votekick " .. supp[1]:Name() .. "? (" .. reason .. ")", {"Yes", "No"}, supp[1], function(res, votes)
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
			game.ConsoleCommand('mga ban "' .. targ .. '" "30" "minutes" "Votekicked by ' .. D3A.Commands.NameID(pl):gsub('"',"") .. ' (' .. reason:gsub('"',"") .. ')"\n')
			D3A.Commands.Discord("votekick_pass", targid, plid)
		else
			D3A.Chat.Broadcast2(moat_red, "Votekick Failed. (Not Enough Votes)")
		end
	end)

	D3A.Commands.Discord("votekick", D3A.Commands.NameID(pl), IsValid(supp[1]) and supp[1]:NameID())
end