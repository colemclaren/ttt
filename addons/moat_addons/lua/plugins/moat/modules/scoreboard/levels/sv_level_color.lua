MOAT_LEVELS = MOAT_LEVELS or {}
MOAT_LEVELS.Effects = {"Normal", "Glow", "Fire", "Bounce", "Enchanted", "Electric", "Frost", "Rainbow"}

util.AddNetworkString("Moat.LevelChange")

function MOAT_LEVELS.LoadLevel(ply, color_r, color_g, color_b, color_effect)
	ply:SetNW2Int("Moat.Level.Effect", color_effect)
	ply:SetNW2Int("Moat.Level.R", color_r)
	ply:SetNW2Int("Moat.Level.G", color_g)
	ply:SetNW2Int("Moat.Level.B", color_b)
end

function MOAT_LEVELS.UpdateLevel(ply, col, effect)
   	moat.mysql("UPDATE moat_levels SET color_r = ?, color_g = ?, color_b = ?, color_effect = ? WHERE steam_id = ?", 
		col.r,
		col.g,
		col.b,
		effect,
	ply:SteamID64())

	MOAT_LEVELS.LoadLevel(ply, col.r, col.g, col.b, effect)
end

net.Receive("Moat.LevelChange", function(_, pl)
	local color = net.ReadColor()
	local effect = net.ReadUInt(8)

	if (not effect or not MOAT_LEVELS.Effects[effect]) then
		return
	end

	if (pl:GetNW2Int("MOAT_STATS_LVL", 1) < 100) then
		return
	end

	color.r = math.Clamp(math.Round(color.r, 0), 0, 255)
	color.g = math.Clamp(math.Round(color.g, 0), 0, 255)
	color.b = math.Clamp(math.Round(color.b, 0), 0, 255)

	MOAT_LEVELS.UpdateLevel(pl, color, effect)
end)

hook("PlayerStatsLoaded", function(ply, stats)
	if (not ply:SteamID64()) then
		return
	end

	if (ply:GetNW2Int("MOAT_STATS_LVL", 1) < 100) then
		return
	end

	moat.mysql("SELECT color_r, color_g, color_b, color_effect FROM moat_levels WHERE steam_id = ?", ply:SteamID64(), function(d)
		if (not IsValid(ply)) then
			return
		end

		if (not d or not d[1]) then
			moat.mysql("INSERT INTO moat_levels (steam_id, color_r, color_g, color_b, color_effect) VALUES (?, 255, 255, 255, 1)", ply:SteamID64())
			MOAT_LEVELS.LoadLevel(ply, 255, 255, 255, 1)
			return
		end

		MOAT_LEVELS.LoadLevel(ply, d[1].color_r, d[1].color_g, d[1].color_b, d[1].color_effect)
	end)
end)