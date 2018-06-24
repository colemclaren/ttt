COMMAND.Name = "Vote"

COMMAND.Flag = "s"

COMMAND.Args = {{"string","Question"}, {"string", "Answer1"}, {"string", "Answer2"}}

COMMAND.Run = function(pl, args, supp)
	if (D3A.VoteActive) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There's already a vote active! Please try later!")

		return
	end

	local ans = {}

	for i = 2, #args do
		table.insert(ans, args[i])
	end

	if (#ans < 2) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You must specify at least two answers! Surround your question and answers in their own quotes!")

		return
	end

	D3A.StartVote(pl, args[1], ans, nil, function(res, votes)
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
	end)
end