local max_kills = 5
local pl_kills = {}

hook.Add("PlayerDeath", "AutoBanRDM", function(vic, inf, att)
    if (GetGlobal("MOAT_MINIGAME_ACTIVE") or (Server and Server.IsDev)) then return end
    if (inf.Avoidable or not IsValid(att) or not att:IsPlayer() or att == vic) then return end
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
	local roles = {[ROLE_DETECTIVE] = 1, [ROLE_INNOCENT] = 1, [ROLE_TRAITOR] = 2}
	local attr = roles[att:GetRole()]
	local vicr = roles[vic:GetRole()]

    if ((attr and vicr and attr == vicr) or (att:GetRole() == vic:GetRole())) then
        if (not pl_kills[att:SteamID()]) then
			if (att:GetNW2Int("MOAT_STATS_LVL", 1) >= 10) then
				pl_kills[att:SteamID()] = 15
			else
				pl_kills[att:SteamID()] = 5
			end
		end

        pl_kills[att:SteamID()] = pl_kills[att:SteamID()] - 1
        if (pl_kills[att:SteamID()] == 3) then
            att:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color(255, 100, 100), "WARNING: You will be banned from the server if you kill 3 more teammates!")]])
        elseif (pl_kills[att:SteamID()] == 2) then
            att:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color(255, 100, 100), "WARNING: You will be banned from the server if you kill 2 more teammates!")]])
        elseif (pl_kills[att:SteamID()] == 1) then
            att:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color(255, 100, 100), "WARNING: You will be banned from the server if you kill 1 more teammates!")]])
        elseif (pl_kills[att:SteamID()] <= 0) then
            RunConsoleCommand("mga", "ban", att:SteamID(), "240", "minutes", "[Automated] Too Many Teammate Kills!")
        end
    end
end)