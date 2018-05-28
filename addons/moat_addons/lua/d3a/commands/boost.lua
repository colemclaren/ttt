COMMAND.Name = "Boost"
COMMAND.Flag = "C"
COMMAND.CheckRankWeight = true
COMMAND.Args = {{"string", "Map"}}

D3A.MapBoosts = {}
D3A.MapBoostsPls = {}

COMMAND.Run = function(pl, args, supp)
	if (#D3A.MapBoosts >= 10) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "There's already 10 map boosts! Please try again next map!")
		return
	end

	if (D3A.MapBoostsPls[pl:SteamID()]) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You've alrady boosted a map this map! Please try again next map!")
		return
	end

	local map_req = table.concat(args, " ", 1):lower()

	if (D3A.MapBoosts[map_req]) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "The request map has already been boosted!")
		return
	end

	if (not map_req:StartWith("ttt_")) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You can only request ttt_ maps to be boosted!")
		return
	end

	local map_found = false
	local maps = file.Find("maps/*.bsp", "GAME")

	for k, v in pairs(maps) do
		local mapstr = v:sub(1, -5):lower()

		if (map_req == mapstr) then
			map_found = true
			break
		end
	end

	if (not map_found) then D3A.Chat.SendToPlayer2(pl, moat_red, "The map name " .. map_req .. " doesn't exist!") return end

	if (table.HasValue(recentmaps, map_req .. ".bsp") or game.GetMap():lower() == map_req) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Unable to nominate a map in the map cooldown!")
		return
	end

	D3A.MapBoosts[map_req] = true
	D3A.MapBoostsPls[pl:SteamID()] = true

	D3A.Chat.Broadcast2(moat_cyan, pl:Name(), moat_white, " has boosted ", moat_green, map_req, moat_white, " for the next map vote.")
end