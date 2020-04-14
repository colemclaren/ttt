MOAT_STATS = MOAT_STATS or {}

function m_InitStatsToPlayer(ply, stats_tbl)
    local stats = stats_tbl or {}
    MOAT_STATS[ply] = {}

	MOAT_STATS[ply]["x"] = stats.x or 0
	ply:SetNW2Int("MOAT_STATS_XP", MOAT_STATS[ply]["x"])

    MOAT_STATS[ply]["l"] = stats.l or 1
    ply:SetNW2Int("MOAT_STATS_LVL", MOAT_STATS[ply]["l"])

    MOAT_STATS[ply]["o"] = stats.o or 0
    ply:SetNW2Int("MOAT_STATS_DROPS", MOAT_STATS[ply]["o"])

    MOAT_STATS[ply]["r"] = stats.r or 0
    ply:SetNW2Int("MOAT_STATS_DECONSTRUCTS", MOAT_STATS[ply]["r"])

    MOAT_STATS[ply]["k"] = stats.k or 0
    ply:SetNW2Int("MOAT_STATS_KILLS", MOAT_STATS[ply]["k"])

    MOAT_STATS[ply]["d"] = stats.d or 0
    ply:SetNW2Int("MOAT_STATS_DEATHS", MOAT_STATS[ply]["d"])

    hook.Run("PlayerStatsLoaded", ply, stats)
end

local meta = FindMetaTable("Player")

function meta:m_ModifyStatType(str, key, add)
    if (not MOAT_STATS[self]) then
        MOAT_STATS[self] = {}
    end

    if (MOAT_STATS[self][key]) then
        if (self:GetNW2Int(str)) then
            local new_value = self:GetNW2Int(str) + add
            self:SetNW2Int(str, new_value)
            MOAT_STATS[self][key] = new_value

			m_SaveStats(self)
        else
            MsgC(Color(0, 255, 0), "Unknown stat string: " .. str .. "\n")
        end
    else
        MsgC(Color(0, 255, 0), "Unknown stat key: " .. key .. "\n")
    end
end

function meta:m_SetStatType(str, key, new_value)
    if (MOAT_STATS[self][key]) then
        if (self:GetNW2Int(str)) then
            self:SetNW2Int(str, new_value)
            MOAT_STATS[self][key] = new_value

			m_SaveStats(self)
        else
            MsgC(Color(0, 255, 0), "Unknown stat string: " .. str .. "\n")
        end
    else
        MsgC(Color(0, 255, 0), "Unknown stat key: " .. key .. "\n")
    end
end

-- Modify stats under here
hook.Add("PlayerObtainedItem", "moat_ApplyDropStat", function(ply, itemtbl)
    ply:m_ModifyStatType("MOAT_STATS_DROPS", "o", 1)
end)

hook.Add("PostPlayerDeath", "moat_ApplyDeadStat", function(ply)
    ply:m_ModifyStatType("MOAT_STATS_DEATHS", "d", 1)
end)


local function m_CalculateLevel(cur_lvl, cur_exp, exp_to_add)
    local new_level, new_xp = cur_lvl, cur_exp

    if ((cur_exp + exp_to_add) < (cur_lvl * 1000)) then
        return new_level, math.max(0, new_xp + exp_to_add)
    end

    new_xp = new_xp + exp_to_add
    while new_xp >= (new_level * 1000) do
        new_xp = new_xp - (new_level * 1000)
        new_level = new_level + 1
    end

    return new_level, new_xp
end

util.AddNetworkString "Moat.Levelup"
function meta:ApplyXP(num)
    hook.Run("PlayerEarnedXP",self,num)
    local cur_exp = self:GetNW2Int("MOAT_STATS_XP")
    local cur_lvl = self:GetNW2Int("MOAT_STATS_LVL")
    local new_level, new_xp = m_CalculateLevel(cur_lvl, cur_exp, num)

    self:m_SetStatType("MOAT_STATS_XP", "x", new_xp)

    local level_upgrades = new_level - cur_lvl
    if (level_upgrades > 0) then
		net.Start "Moat.Levelup"
		net.Send(self)

        self:m_ModifyStatType("MOAT_STATS_LVL", "l", level_upgrades)

        for i = 1, level_upgrades do
            local crates = m_GetActiveCrates()
            local crate = crates[math.random(1, #crates)].Name

            self:m_DropInventoryItem(crate, "hide_chat_obtained", false, false)
        end
    end
end

MOAT_XP_SAVE = {}

hook.Add("TTTPrepareRound", "moat_ApplyLevelChanges", function()
    MOAT_XP_SAVE = {}
end)

hook.Add("TTTEndRound", "moat_ApplyLevelChanges", function()
    for k, v in pairs(player.GetAll()) do
        if (MOAT_XP_SAVE[v]) then
            local xp_num = MOAT_XP_SAVE[v]
            v:ApplyXP(xp_num)
        end
    end
end)

local XP_MULTIPLYER = 2
local TRAITOR_KILL_DETECTIVE = 100 * XP_MULTIPLYER
local TRAITOR_KILL_INNOCENT = 50 * XP_MULTIPLYER
local DETECTIVE_KILL_TRAITOR = 100 * XP_MULTIPLYER
local DETECTIVE_KILL_INNOCENT = -50 * XP_MULTIPLYER
local INNOCENT_KILL_TRAITOR = 50 * XP_MULTIPLYER
local INNOCENT_KILL_DETECTIVE = -100 * XP_MULTIPLYER

function m_ApplyXPToTable(ply, xp_add)
    if (not MOAT_XP_SAVE[ply]) then
        MOAT_XP_SAVE[ply] = 0
    end

    local cur_save = MOAT_XP_SAVE[ply]
    MOAT_XP_SAVE[ply] = cur_save + xp_add
end

hook.Add("PlayerDeath", "moat_ApplyKillLevelXPStat", function(vic, inf, att)
    if (att:IsValid() and att:IsPlayer() and att ~= vic and GetRoundState() == ROUND_ACTIVE and not GetGlobal("MOAT_MINIGAME_ACTIVE")) then
        if (att:GetTraitor()) then
            if (vic:GetDetective()) then
                m_ApplyXPToTable(att, TRAITOR_KILL_DETECTIVE)
            elseif (not vic:IsSpecial()) then
                m_ApplyXPToTable(att, TRAITOR_KILL_INNOCENT)
            end
        elseif (att:GetDetective()) then
            if (vic:GetTraitor()) then
                m_ApplyXPToTable(att, DETECTIVE_KILL_TRAITOR)
            elseif (not vic:IsSpecial()) then
                m_ApplyXPToTable(att, DETECTIVE_KILL_INNOCENT)
            end
        elseif (not att:IsSpecial()) then
            if (vic:GetDetective()) then
                m_ApplyXPToTable(att, INNOCENT_KILL_DETECTIVE)
            elseif (vic:GetTraitor()) then
                m_ApplyXPToTable(att, INNOCENT_KILL_TRAITOR)
            end
        end

        att:m_ModifyStatType("MOAT_STATS_KILLS", "k", 1)
    end
end)