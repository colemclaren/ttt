---- Karma system stuff
local function IsRightful(killer, victim)
    return hook.Run("TTTIsRightfulDamage", killer, victim)
end
--
--
KARMA = KARMA or {}
-- ply steamid -> karma table for disconnected players who might reconnect
KARMA.RememberedPlayers = KARMA.RememberedPlayers or {}
-- Convars, more convenient access than GetConVar bla bla
KARMA.cv = KARMA.cv or {}
KARMA.cv.enabled = CreateConVar("ttt_karma", "1", FCVAR_ARCHIVE)
KARMA.cv.strict = CreateConVar("ttt_karma_strict", "1")
KARMA.cv.starting = CreateConVar("ttt_karma_starting", "1150")
KARMA.cv.max = CreateConVar("ttt_karma_max", "2500")
KARMA.cv.ratio = CreateConVar("ttt_karma_ratio", "0.001")
KARMA.cv.killpenalty = CreateConVar("ttt_karma_kill_penalty", "15")
KARMA.cv.roundheal = CreateConVar("ttt_karma_round_increment", "5")
KARMA.cv.clean = CreateConVar("ttt_karma_clean_bonus", "30")
KARMA.cv.tbonus = CreateConVar("ttt_karma_traitorkill_bonus", "40")
KARMA.cv.tratio = CreateConVar("ttt_karma_traitordmg_ratio", "0.0003")
KARMA.cv.debug = CreateConVar("ttt_karma_debugspam", "0")
KARMA.cv.persist = CreateConVar("ttt_karma_persist", "0")
KARMA.cv.falloff = CreateConVar("ttt_karma_clean_half", "0.25")
KARMA.cv.autokick = CreateConVar("ttt_karma_low_autokick", "1")
KARMA.cv.kicklevel = CreateConVar("ttt_karma_low_amount", "450")
KARMA.cv.autoban = CreateConVar("ttt_karma_low_ban", "1")
KARMA.cv.bantime = CreateConVar("ttt_karma_low_ban_minutes", "60")
local config = KARMA.cv

local function IsDebug()
    return config.debug:GetBool()
end

local math = math

function KARMA.InitState()
    SetGlobalBool("ttt_karma", config.enabled:GetBool())
end

function KARMA.IsEnabled()
    return GetGlobal("ttt_karma")
end

function KARMA.GetMaxKarma(ply)
	if (IsValid(ply) and KARMA.RememberedPlayers[ply:SteamID64()] and KARMA.RememberedPlayers[ply:SteamID64()].Time and KARMA.RememberedPlayers[ply:SteamID64()].Time < 1572591600) then
		return 2500
	end

	return 2000
end

function KARMA.GetLevelRatio(victim)
	return IsValid(victim) and victim:IsPlayer() and (math.Clamp(victim:GetNW2Int("MOAT_STATS_LVL", 1), 0, 10) / 10) or 1
end

-- Compute penalty for hurting someone a certain amount
function KARMA.GetHurtPenalty(victim_karma, dmg, victim, attacker)
    return (dmg * math.Clamp(KARMA.GetLevelRatio(victim), 0, 1))
end

-- Compute penalty for killing someone
function KARMA.GetKillPenalty(victim_karma, victim)
    -- the kill penalty handled like dealing a bit of damage
    return KARMA.GetHurtPenalty(victim_karma, 100, victim)
end

-- Compute reward for hurting a traitor (when innocent yourself)
function KARMA.GetHurtReward(dmg, victim)
    return config.max:GetFloat() * math.Clamp(dmg * config.tratio:GetFloat(), 0, 1)
end

-- Compute reward for killing traitor
function KARMA.GetKillReward(attacker, victim)
    return KARMA.GetHurtReward(config.tbonus:GetFloat(), victim)
end

function KARMA.GivePenalty(ply, penalty, victim)
    if (not hook.Call("TTTKarmaGivePenalty", nil, ply, penalty, victim)) then
        ply:SetLiveKarma(math.max(ply:GetActiveKarma() - penalty, 1))

		if (IsDebug()) then
			PlayerMsg(ply, "-" .. penalty .. " Karma", true)
		end
    end
end

function KARMA.GiveReward(ply, reward)
    reward = KARMA.DecayedMultiplier(ply) * reward
    ply:SetLiveKarma(math.min(ply:GetActiveKarma() + reward, config.max:GetFloat()))

    return reward
end

function KARMA.ApplyKarma(ply)
    local df = 1

    -- any karma at 1000 or over guarantees a df of 1, only when it's lower do we
    -- need the penalty curve
    if (ply:GetBaseKarma() < 2000) then
		local k = ply:GetBaseKarma() - 2000
		df = 1 - ((((-0.0000002 * (k ^ 2)) * 100)/-5) / 10)
    end

    ply:SetDamageFactor(math.Clamp(df, 0.01, 1.0))

    if IsDebug() then
        print(Format("%s has karma %f and gets df %f", ply:Nick(), ply:GetBaseKarma(), df))
    end
end

-- Return true if a traitor could have easily avoided the damage/death
local function WasAvoidable(attacker, victim, dmginfo)
    local infl = dmginfo:GetInflictor()
    if attacker:IsTraitor() and victim:IsTraitor() and IsValid(infl) and infl.Avoidable then return true end

    return false
end

-- Handle karma change due to one player damaging another. Damage must not have
-- been applied to the victim yet, but must have been scaled according to the
-- damage factor of the attacker.
function KARMA.Hurt(attacker, victim, dmginfo)
    if not IsValid(attacker) or not IsValid(victim) then return end
    if attacker == victim then return end
    if not attacker:IsPlayer() or not victim:IsPlayer() then return end
    -- Ignore excess damage
    local hurt_amount = math.min(victim:Health(), dmginfo:GetDamage())

    if (not IsRightful(attacker, victim)) then
        if WasAvoidable(attacker, victim, dmginfo) then return end
        local penalty = KARMA.GetHurtPenalty(victim:GetActiveKarma(), hurt_amount, victim, attacker)
        KARMA.GivePenalty(attacker, penalty, victim)
        attacker:SetCleanRound(false)

        if IsDebug() then
            print(Format("%s (%f) attacked %s (%f) for %d and got penalised for %f", attacker:Nick(), attacker:GetActiveKarma(), victim:Nick(), victim:GetActiveKarma(), hurt_amount, penalty))
        end
    else
        local reward = KARMA.GetHurtReward(hurt_amount)
        reward = KARMA.GiveReward(attacker, reward)

        if IsDebug() then
            print(Format("%s (%f) attacked %s (%f) for %d and got REWARDED %f", attacker:Nick(), attacker:GetActiveKarma(), victim:Nick(), victim:GetActiveKarma(), hurt_amount, reward))
        end
    end
end

-- Handle karma change due to one player killing another.
function KARMA.Killed(attacker, victim, dmginfo)
    if not IsValid(attacker) or not IsValid(victim) then return end
    if attacker == victim then return end
    if not attacker:IsPlayer() or not victim:IsPlayer() then return end

    if not IsRightful(attacker, victim) then
        -- don't penalise attacker for stupid victims
        if WasAvoidable(attacker, victim, dmginfo) then return end
        local penalty = KARMA.GetHurtPenalty(victim:GetActiveKarma(), 250, victim, attacker)
        KARMA.GivePenalty(attacker, penalty, victim)
        attacker:SetCleanRound(false)

        if IsDebug() then
            print(Format("%s (%f) killed %s (%f) and gets penalised for %f", attacker:Nick(), attacker:GetActiveKarma(), victim:Nick(), victim:GetActiveKarma(), penalty))
        end
    else
        local reward = KARMA.GetKillReward(attacker, victim)
        reward = KARMA.GiveReward(attacker, reward)

        if IsDebug() then
            print(Format("%s (%f) killed %s (%f) and gets REWARDED %f", attacker:Nick(), attacker:GetActiveKarma(), victim:Nick(), victim:GetActiveKarma(), reward))
        end
    end
end

local expdecay = math.ExponentialDecay

function KARMA.DecayedMultiplier(ply)
    local max = config.max:GetFloat() or 2000
    local start = config.starting:GetFloat() or 1150
    local karma = ply:GetActiveKarma() or 1500

    if (config.falloff:GetFloat() <= 0 and karma < start) then
        return 1
    elseif (karma < max) then
        -- if falloff is enabled, then if our karma is above the starting value,
        -- our round bonus is going to start decreasing as our karma increases
        local basediff = max - start
        local plydiff = karma - start
        local half = math.Clamp(config.falloff:GetFloat(), 0.01, 0.99)

        -- exponentially decay the bonus such that when the player's excess karma
        -- is at (basediff * half) the bonus is half of the original value
        return expdecay(basediff * half, plydiff)
    end

    return 1
end

-- Handle karma regeneration upon the start of a new round
function KARMA.RegenerateKarma(ply)
    local healbonus = config.roundheal:GetFloat()
    local cleanbonus = config.clean:GetFloat()

    if ply:IsDeadTerror() and ply.death_type ~= KILL_SUICIDE or not ply:IsSpec() then
        local bonus = healbonus + (ply:GetCleanRound() and cleanbonus or 0)
        KARMA.GiveReward(ply, bonus)

        if IsDebug() then
            print(ply, "gets roundincr", incr)
        end
    end
end

-- When a new round starts, Live karma becomes Base karma
function KARMA.Rebase()
    for _, ply in ipairs(player.GetAll()) do
		KARMA.RegenerateKarma(ply)

        if IsDebug() then
            print(ply, "rebased from", ply:GetBaseKarma(), "to", ply:GetActiveKarma())
        end

        ply:SetBaseKarma(ply:GetActiveKarma())
		KARMA.CheckAutoKick(ply)
    end
end

-- Apply karma to damage factor for all players
function KARMA.ApplyKarmaAll()
    for _, ply in ipairs(player.GetAll()) do
        KARMA.ApplyKarma(ply)
    end
end

function KARMA.NotifyPlayer(ply)
    local df = ply:GetDamageFactor() or 1
    local k = math.Round(ply:GetBaseKarma())

    if df > 0.99 then
        LANG.Msg(ply, "karma_dmg_full", {
            amount = k
        })
    else
        LANG.Msg(ply, "karma_dmg_other", {
            amount = k,
            num = math.Round(math.ceil((1 - df) * 100))
        })
    end
end

-- These generic fns will be called at round end and start, so that stuff can
-- easily be moved to a different phase
function KARMA.RoundEnd(pl, target)
    if (not KARMA.IsEnabled()) then return end

	if (not IsValid(pl) and type(target) == "boolean") then
		if (target == false) then
			KARMA.Rebase()
		end

		return (target == true) and KARMA.RememberAll()
	elseif (IsValid(pl)) then
		KARMA.RegenerateKarma(pl)
		pl:SetBaseKarma(pl:GetActiveKarma())
	end
end

function KARMA.RoundBegin(pl, target)
    if (not KARMA.IsEnabled()) then return end
	if (not IsValid(pl) and type(target) == "boolean") then
		KARMA.ApplyKarmaAll()
		return (target == true) and KARMA.RememberAll()
	end

    KARMA.RegenerateKarma(pl)
	pl:SetBaseKarma(pl:GetActiveKarma())

	KARMA.CheckAutoKick(pl)
	KARMA.ApplyKarma(pl)
	KARMA.NotifyPlayer(pl)
end

function KARMA.InitPlayer(ply)
	local live = KARMA.RememberedPlayers[ply:SteamID64()] and KARMA.RememberedPlayers[ply:SteamID64()].Karma or config.starting:GetFloat()
    live = math.Clamp(live, 1, KARMA.GetMaxKarma(ply))

	ply.delay_karma_recall = (not ply:IsFullyAuthenticated())

	ply:SetBaseKarma(live)
	ply:SetLiveKarma(live)

    ply:SetCleanRound(true)
    ply:SetDamageFactor(1.0)

    -- compute the damagefactor based on actual (possibly loaded) karma
    KARMA.ApplyKarma(ply)
end

function KARMA.Remember(ply)
    if (not ply.KarmaLoaded or ply.karma_kicked or (not ply:IsFullyAuthenticated())) then return end

    -- use sql if persistence is on
	if (config.persist:GetBool()) then
		moat.mysql("UPDATE " .. moat.cfg.sql.database .. ".player SET karma = ? WHERE steam_id = ?;", ply:GetActiveKarma(), ply:SteamID64() or 0)
    end

    -- if persist is on, this is purely a backup method
	if (KARMA.RememberedPlayers[ply:SteamID64()]) then
		KARMA.RememberedPlayers[ply:SteamID64()].Karma = ply:GetActiveKarma()
	else
		KARMA.RememberedPlayers[ply:SteamID64()] = {Time = os.time(), Karma = ply:GetActiveKarma()}
	end
end

function KARMA.LateRecallAndSet(ply)
	-- if (KARMA.RememberedPlayers[ply:SteamID64()]) then
	-- 	ply.KarmaLoaded = true

	-- 	return KARMA.InitPlayer(ply)
	-- end

	moat.mysql("SELECT karma, first_join FROM " .. moat.cfg.sql.database .. ".player WHERE steam_id = ?;", ply:SteamID64() or 0, function(r)
		if (r and r[1]) then
			KARMA.RememberedPlayers[ply:SteamID64()] = {Time = r[1].first_join, Karma = r[1].karma}
		end

		ply.KarmaLoaded = true
		KARMA.InitPlayer(ply)
	end, function(r)
		ply.KarmaLoaded = true
		KARMA.InitPlayer(ply)
	end)
end

function KARMA.RememberAll()
	local str, q = "", {n = 0}

    for _, ply in ipairs(player.GetAll()) do
		if (not ply.KarmaLoaded or not ply:IsFullyAuthenticated() or ply.karma_kicked) then
			continue
		end

		if (KARMA.RememberedPlayers[ply:SteamID64()]) then
			KARMA.RememberedPlayers[ply:SteamID64()].Karma = ply:GetActiveKarma()
		else
			KARMA.RememberedPlayers[ply:SteamID64()] = {Karma = ply:GetActiveKarma(), Time = os.time()}
		end

		str = str .. "UPDATE " .. moat.cfg.sql.database .. ".player SET karma = ? WHERE steam_id = ?;"
		table.insert(q, ply:GetActiveKarma())
		table.insert(q, ply:SteamID64())
		q.n = q.n + 1
    end

	if (q.n > 0) then
		moat.mysql(str, unpack(q, 1, q.n))
	end
end

local reason = "Karma too low"
function KARMA.CheckAutoKick(ply)
    if (ply:GetBaseKarma() > config.kicklevel:GetInt() or hook.Call("TTTKarmaLow", GAMEMODE, ply) == false) then
		return
	end

	local id64 = ply:SteamID64() or 0
	players_connecting[id64][6] = (ply:GetBaseKarma() == 0 and "30 days") or tostring(string.NiceTime(3600))

	-- flag player as autokicked so we don't perform the normal player
	-- disconnect logic
    ply.karma_kicked = true

	if (config.persist:GetBool()) then
		moat.mysql("UPDATE " .. moat.cfg.sql.database .. ".player SET karma = ? WHERE steam_id = ?;", config.starting:GetFloat(), id64 or 0, function(r)
			if (config.autoban:GetBool()) then
				D3A.Player.KickID(ply:SteamID(), "karma", (KARMA and KARMA.cv) and KARMA.cv.kicklevel or 450, players_connecting[id64][6])
			else
				ply:Kick(reason)
			end
		end, function(r)
			if (config.autoban:GetBool()) then
				D3A.Player.KickID(ply:SteamID(), "karma", (KARMA and KARMA.cv) and KARMA.cv.kicklevel or 450, players_connecting[id64][6])
			else
				ply:Kick(reason)
			end
		end)
    end
end

function KARMA.PrintAll(printfn)
    for _, ply in pairs(player.GetAll()) do
        printfn(Format("%s : Live = %f -- Base = %f -- Dmg = %f\n", ply:Nick(), ply:GetActiveKarma(), ply:GetBaseKarma(), ply:GetDamageFactor() * 100))
    end
end