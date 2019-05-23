D3A.Vote = {}
D3A.VoteActive = false
D3A.Vote.Current = {}

util.AddNetworkString("D3A.StartVote")
util.AddNetworkString("D3A.EndVote")
util.AddNetworkString("D3A.CountVote")

function D3A.EndVote(callback, answers)
	local res = {}
	local votes = 0

	for i = 1, #answers do
		res[i] = {answers[i], 0}
	end

	for k, v in pairs(D3A.Vote.Current) do
		if (k:IsValid()) then
			if (not res[v]) then continue end
			
			res[v][2] = res[v][2] + 1
			votes = votes + 1
		end
	end

	if (callback) then
		callback(res, votes)
	end

	net.Start("D3A.EndVote")
	net.Broadcast()

	D3A.Vote.Current = {}
	D3A.VoteActive = false
end

function D3A.CountVote(l, pl)
	if (not D3A.VoteActive or D3A.Vote.Current[pl]) then return end

	D3A.Vote.Current[pl] = net.ReadUInt(8)
end

net.Receive("D3A.CountVote", D3A.CountVote)

function D3A.InitializeVote(pl, question, answers, callback)
	if (D3A.VoteActive) then return end

	D3A.Vote.Current = {}
	D3A.VoteActive = true

	net.Start("D3A.StartVote")
	net.WriteString(question)
	net.WriteTable(answers)
	net.Broadcast()

	timer.Create("D3A.Vote", 10, 1, function() D3A.EndVote(callback, answers) end)
end

function D3A.StartVote(pl, question, answers, other, callback)
	if (D3A.VoteActive) then return end

	D3A.MySQL.FormatQuery("SELECT staff_steam_id, reason, date FROM player_bans_votekick WHERE steam_id = #;", pl:SteamID64(), function(r)
		if (not r or not r[1]) then
			D3A.InitializeVote(pl, question, answers, callback)

			if (other) then
				D3A.Chat.Broadcast2(moat_cyan, pl:Name(), moat_white, " has started a vote to kick: ", moat_green, other:Name(), moat_white, ".")
			end

			return
		end

		D3A.Chat.SendToPlayer2(pl, moat_pink, "You're currently banned from votekick access for the reason: ", moat_red, r[1].reason, moat_pink, ".")
	end)
end


util.AddNetworkString("MGA.SendMaps")

local sentmaps = {}
net.Receive("MGA.SendMaps", function(_, pl)
	if (sentmaps[pl]) then return end
	sentmaps[pl] = true

	local maps, count = MapVote.GetAvailableMaps()
	net.Start("MGA.SendMaps")
	net.WriteUInt(count, 16)
	for i = 1, count do
		net.WriteString(maps[i])
	end
	net.Send(pl)
end)