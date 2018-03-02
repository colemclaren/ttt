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

function D3A.StartVote(pl, question, answers, callback)
	if (D3A.VoteActive) then return end
	
	D3A.Vote.Current = {}
	D3A.VoteActive = true

	net.Start("D3A.StartVote")
	net.WriteString(question)
	net.WriteTable(answers)
	net.Broadcast()

	timer.Create("D3A.Vote", 10, 1, function() D3A.EndVote(callback, answers) end)
end


util.AddNetworkString("MGA.SendMaps")

local sentmaps = {}
local all_maps = nil

net.Receive("MGA.SendMaps", function(_, pl)
	if (sentmaps[pl]) then return end
	
	if (all_maps == nil) then
		all_maps = {}
		local maps = file.Find("maps/*.bsp", "GAME")
		local num = 1

		for k, v in pairs(maps) do
			local mapstr = v:sub(1, -5):lower()

			all_maps[num] = mapstr
			num = num + 1
		end
	end

	net.Start("MGA.SendMaps")
	net.WriteUInt(#all_maps, 9)
	for i = 1, #all_maps do
		net.WriteString(all_maps[i])
	end
	net.Send(pl)

	sentmaps[pl] = true
end)