-- automatically handle unjoinable maps
local default_map = "ttt_minecraftcity_v4"
local default_regmap = "ttt_clue_se"
local default_mcmap = "ttt_minecraft_b5"
local map_disconnect_reasons = {
	["Client's map differs from the server's"] = true,
	["Map is missing"] = true
}

local map_disconnect_limit, map_disconnects = 15, 0
function D3A.CheckMissingMap(forced)
	local c = player.GetCount()
	if (c >= 3 and not forced) then return end
	map_disconnects = map_disconnects + 1

	if (forced or map_disconnects >= map_disconnect_limit) then
		if (not file.Exists("maps/" .. default_map .. ".bsp", "GAME")) then
			if (GetHostName():lower():find("minecraft")) then
				default_map = default_mcmap
			else
				default_map = default_regmap
			end
		end

		local rs = "too many missing map disconnections"
		if (forced) then rs = "map name not in download list (name was updated on workshop?)" end
		local msg = (GetHostName() or "") .. " had to changelevel due to " .. rs .. " for `" .. game.GetMap() .. "` <@207612500450082816>"

		discord.Send("Bad Map", msg)
		
		RunConsoleCommand("mga", "map", default_map)
	end
end

function D3A.HandleMapDisconnects(str)
	if (str and map_disconnect_reasons[str]) then
		D3A.CheckMissingMap()
	end
end