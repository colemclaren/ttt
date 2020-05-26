-- automatically handle unjoinable maps
local default_regmap = "ttt_rooftops_a2_f1"
local default_mcmap = "ttt_minecraft_b5"
local map_disconnect_reasons = {
	["Client's map differs from the server's"] = true,
	["Map is missing"] = true
}

local map_disconnect_limit, map_disconnects = 3, 0
function D3A.CheckMissingMap(forced)
	local c = player.GetCount()
	if (c >= 3 and not forced or Server.IsDev) then
		return
	end

	map_disconnects = map_disconnects + 1

	if (forced or map_disconnects >= map_disconnect_limit) then
		local default_map = default_regmap

		if (GetHostName():lower():find("minecraft")) then
			default_map = default_mcmap
		end

		local rs = "too many missing map disconnections"
		if (forced) then rs = "map name not in download list (name was updated on workshop?)" end
		local msg = (GetHostName() or "") .. " had to changelevel due to " .. rs .. " for `" .. game.GetMap() .. "` <@677077640619884544>"

		discord.Send("Bad Map", msg)

		RunConsoleCommand("mga", "map", default_map)
	end
end

function D3A.HandleMapDisconnects(str)
	if (str and map_disconnect_reasons[str]) then
		D3A.CheckMissingMap()
	end
end