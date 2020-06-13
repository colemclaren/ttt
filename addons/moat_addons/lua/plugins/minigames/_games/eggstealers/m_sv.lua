util.AddNetworkString("MOAT_PREP_BUNNY")
util.AddNetworkString("MOAT_BEGIN_BUNNY")
util.AddNetworkString("MOAT_END_BUNNY")
util.AddNetworkString("MOAT_BUNNY_SPAWNS")
util.AddNetworkString("MOAT_BUNNY_LIVES")
MOAT_ACTIVE_BOSS = false
local MOAT_BOSS_CUR = nil
local MOAT_ROUND_OVER = false
local MOAT_BOSS_MODEL = "models/player/bugsb/bugsb.mdl"
local MOAT_RESPAWN_TIME = 25
local MOAT_LIVES = 2
local EGG_COUNT, START_PLAYERS = 0, 0

local function line(n)
    return "https://static.moat.gg/ttt/easter/bugs"..n.."_pn.mp3"
end

local ShitTalk = {
    line "40",
    line "55",
    line "89",
    line "68",
    line "152",
    line "32",
}

local Winner = {
    line "125",
    line "124",
}

local Start = {
    line "118",
    line "02",
    line "119",
}

local Kill = {
    line "01",
    line "51",
    line "94",
    line "101",
    line "132",
}

local Stolen = {
    line "11",
    line "155",
    line "28",
}

local function moat_EndRoundBossHooks(force)
	if (MOAT_MINIGAMES.CantEnd() and not force) then return end

    -- Remove our hooks
    hook.Remove("ttt.BeginRound", "moat_BossBeginRound")
    hook.Remove("EntityTakeDamage", "moat_BossSaveDamage")
    hook.Remove("PostPlayerDeath", "moat_BossDeath")
    hook.Remove("EntityTakeDamage", "moat_BossPreventDamage")
    hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
    hook.Remove("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss")
    hook.Remove("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout")
    hook.Remove("PlayerDisconnected", "moat_BossDisconnect")
    hook.Remove("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents")
    hook.Remove("SetupPlayerVisibility", "moat_BossVisibility")
    hook.Remove("PlayerShouldTakeDamage", "moat_BossPreventDamage")
    hook.Remove("TTTPrepareRound", "moat_BossRestartFix")
    hook.Remove("PlayerSetModel", "moat_BunnyModel")
    hook.Remove("PlayerLoadout", "moat_DeleteLoadout")
    hook.Remove("moat_Easter2019_Taken", "moat_EggTaken")
    hook.Remove("ScalePlayerDamage", "moat_ScaleBossDamage")
    timer.Remove("moat_RespawnBunnyStealers")

    MOAT_ACTIVE_BOSS = false
    MOAT_BOSS_CUR = nil
    MOAT_ROUND_OVER = false
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "moat_BossDelayWin")
end

local function GetAlivePlayers(collect)
    local num = 0
    local plys = {}

    for k, v in ipairs(player.GetAll()) do
        if (not IsValid(v) or not v.BunnyLives or v.BunnyLives <= 0) then continue end
        num = num + 1
        plys[#plys + 1] = v
    end

    return num, collect and plys or nil
end

local function moat_EndRoundHandler(force)
    if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR)) then
        MOAT_BOSS_CUR:SetModelScale(1, 0)
    end

    moat_EndRoundBossHooks(force)
end

local function NotifyNextSpawn()
    net.Start "MOAT_BUNNY_SPAWNS"
        net.WriteFloat(CurTime() + MOAT_RESPAWN_TIME)
    net.Broadcast()
    for _, ply in pairs(player.GetAll()) do
        if (not ply.BunnyLives) then
            continue
        end
        net.Start "MOAT_BUNNY_LIVES"
            net.WriteUInt(ply.BunnyLives, 8)
        net.Send(ply)
    end
end

local function moat_RespawnPlayers(plys)
    local num, Alive
    if (not plys) then
        num, Alive = GetAlivePlayers(true)
    else
        num, Alive = #plys, plys
    end

    for i = #Alive, 1, -1 do
        local ply = Alive[i]
        if (ply:Alive()) then
            table.remove(Alive, i)
        end
    end


    if (#Alive > 0) then
        local pos = EASTER.EggSpawns[1]
        local clause = {
            NotNear = {
                Position = pos,
                Distance = 1000
            },
            Near = {
                Position = pos,
                Distance = 2000
            },
            Amount = #Alive
        }
        local points = spawns.Find(clause)
        clause.Amount = 1

        for i, ply in pairs(Alive) do
            ply:SpawnForRound(true)
			ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            ply:StripWeapons()
            ply:SetModel "models/player/robber.mdl"
            ply:Give "weapon_ttt_unarmed"
            if (points) then
                ply:SetPos(points[i])
            else
                -- fallback if no group spawns
                local point = spawns.Find(clause)
                if (point) then
                    ply:SetPos(point[1])
                end
            end
        end
    end

    NotifyNextSpawn()
end

local IGNORE_DEATH = false
local WAS_STOLEN = false

local function moat_BossPlayerDeath(ply)
    if (IGNORE_DEATH) then
        IGNORE_DEATH = false
        return
    end

    if (not MOAT_ACTIVE_BOSS) then return end

    local IS_BOSS
    
	if (type(ply) == "string" and ply == "boss") then
		IS_BOSS = true
	else
		IS_BOSS = IsValid(MOAT_BOSS_CUR) and MOAT_BOSS_CUR == ply
    end
    
    if (not IS_BOSS) then
        ply.BunnyLives = ply.BunnyLives - 1
        if (not WAS_STOLEN and math.random(6) == 1) then
            cdn.PlayURL(table.Random(Kill), 2)
        end
    end

	if (MOAT_ROUND_OVER or GetRoundState() ~= ROUND_ACTIVE) then return end
	local ALIVE = GetAlivePlayers()

	if (IS_BOSS or ALIVE == 0) then
		MOAT_ROUND_OVER = true
	end

	if (IsValid(MOAT_BOSS_CUR)) then
		MOAT_BOSS_CUR:SetCredits(0)
    end

	if (not MOAT_ROUND_OVER) then
		timer.Simple(1, function()
			if (not IsValid(ply) or not IsValid(ply.server_ragdoll)) then return end

            local pl = player.GetBySteamID(ply.server_ragdoll.sid)
            if (not IsValid(pl)) then return end
            pl:SetCleanRound(false)
            pl:SetNW2Bool("body_found", true)
            CORPSE.SetFound(ply.server_ragdoll, true)
            ply.server_ragdoll:Remove()
    	end)

		return
    end

    if (not IS_BOSS) then
        for i = 1, #ents.FindByClass "sent_egg_basket_adv" do
            MOAT_BOSS_CUR:m_DropInventoryItem("Easter Basket 2019", nil, nil, true)
        end
        m_SaveInventory(MOAT_BOSS_CUR)
        if (math.random(1) == 1) then
            cdn.PlayURL(table.Random(Winner), 2)
        end
    end

    net.Start("MOAT_END_BUNNY")
        net.WriteBool(IS_BOSS)
    net.Broadcast()

    cdn.PlayURL("https://static.moat.gg/ttt/easter/looney_tunes_end2.mp3", 2)

    timer.Remove("moat_boss_voices")

    timer.Simple(10, function()
        moat_EndRoundHandler()
    end)
end

local Doors = {
    "func_door", "func_door_rotating", "prop_door_rotating", "func_breakable"
}

for _, v in ipairs(Doors) do
    Doors[v] = true
end

local function moat_BeginRoundBossHooks()
    hook.Add("PlayerDisconnected", "moat_BossDisconnect", function(pl)
        hook.Run("PostPlayerDeath", pl)
    end)

    hook.Add("PlayerSetModel", "moat_BunnyModel", function(pl)
        pl:SetModel "models/player/robber.mdl"
        return true
    end)

    -- force end round if prepare round
    hook.Add("TTTPrepareRound", "moat_BossRestartFix", function()
        moat_EndRoundHandler(true)
    end)

    hook.Add("PlayerLoadout", "moat_DeleteLoadout", function(ply)
        ply:StripWeapons()
        ply:Give "weapon_ttt_unarmed"
        return true
    end)

    hook.Add("ScalePlayerDamage", "moat_ScaleBossDamage", function(_, _, dmg)
        local pct = 1 - EGG_COUNT / #EASTER.EggSpawns
        dmg:ScaleDamage(pct * 1.2 + 1.2)
    end)

    hook.Add("moat_Easter2019_Taken", "moat_EggTaken", function(ply)
        ply.BunnyLives = ply.BunnyLives + 1
        WAS_STOLEN = true
        ply:KillSilent()
        WAS_STOLEN = false
        EGG_COUNT = EGG_COUNT - 1
        if (EGG_COUNT == 0) then
            moat_BossPlayerDeath("boss")
        end

        if (math.random(6) == 1) then
            cdn.PlayURL(table.Random(Stolen), 2)
        end
        BroadcastLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "]] .. EGG_COUNT .. [[ eggs are left!" )]])
    end)

    for _, ent in pairs(ents.GetAll()) do
        if (Doors[ent:GetClass()]) then
            ent:Remove()
        end
    end

    timer.Create("moat_RespawnBunnyStealers", MOAT_RESPAWN_TIME, 0, moat_RespawnPlayers)
    timer.Simple(1, function()
        MuteForRestart(true)
        cdn.PlayURL("https://static.moat.gg/ttt/easter/looney_tunes_opening2.mp3", 2)
    end)

    hook.Add("ttt.BeginRound", "moat_BossBeginRound", function()
        for _, pos in ipairs(EASTER.EggSpawns) do
            local egg = ents.Create "sent_egg_basket_adv"
            egg:SetShinesThrough(true)
            egg:SetPos(pos + Vector(0,0,22))
            egg.IgnoreEntity = MOAT_BOSS_CUR
            egg:Spawn()
        end
        EGG_COUNT = #EASTER.EggSpawns
        START_PLAYERS = GetAlivePlayers()

		local pls = player.GetAll()
		if (not IsValid(MOAT_BOSS_CUR)) then
			local chosen
        	for k, v in RandomPairs(pls) do
            	if (v:Team() ~= TEAM_SPEC) then
                	chosen = v

                	break
            	end
        	end

			for i = 1, 5 do
        		chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU ARE THE BUNNY!!!" )]])
    		end

			MOAT_BOSS_CUR = chosen
        end
        
        moat_RespawnPlayers(select(2, GetAlivePlayers(true)))

		net.Start("MOAT_BEGIN_BUNNY")
        net.WriteEntity(MOAT_BOSS_CUR)
        net.Broadcast()

        local boss = MOAT_BOSS_CUR


        for _, v in pairs(ents.GetAll()) do
            if (IsValid(v) and v:IsWeapon() and (not IsValid(v:GetOwner()) or v:GetOwner() ~= boss)) then
                v:Remove()
            end	
        end

        boss.IgnoreDeath = true
        IGNORE_DEATH = true
        boss:KillSilent()
        boss:SpawnForRound(true)

        for _, ply in pairs(pls) do
            if (ply ~= boss) then
                ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                ply:SetRole(ROLE_INNOCENT)
                if (ply:Alive() and not ply:GetForceSpec()) then
                    ply.BunnyLives = MOAT_LIVES
                    IGNORE_DEATH = true
                    ply:KillSilent()
                end
            end
        end
        moat_RespawnPlayers()
        NotifyNextSpawn()

        for _, ply in pairs(pls) do
            ply:Freeze(true)
        end

        boss:GodEnable()
        if (boss:GetRole() ~= ROLE_TRAITOR) then
            boss:SetRole(ROLE_TRAITOR)
        end
        boss:SetCredits(0)
        boss:SetPos(EASTER.EggSpawns[1])

        timer.Simple(3, function()
            boss:SetModel(MOAT_BOSS_MODEL)
            boss:SetModelScale(1.5, 1)
            boss:SetHealth(20190421)
            boss:SetMaxHealth(20190421)
            boss:GodDisable()
            timer.Simple(1, function()
                cdn.PlayURL(table.Random(Start), 2)
            end)
        end)


        timer.Create("moat_boss_voices", 30, 0, function()
			cdn.PlayURL(table.Random(ShitTalk), 2)
        end)

        timer.Simple(5, function()
            MuteForRestart(false)
        end)

        hook.Add("SetupPlayerVisibility", "moat_BossVisibility", function()
            AddOriginToPVS(MOAT_BOSS_CUR:GetPos())
        end)

        SetRoundEnd(CurTime() + 99999)

        timer.Simple(5, function() 
            for k, v in ipairs(player.GetAll()) do
                v:Freeze(false)
                v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            end
			if (not IsValid(MOAT_BOSS_CUR)) then return end

            MOAT_BOSS_CUR:GiveEquipmentItem(EQUIP_RADAR)
            MOAT_BOSS_CUR:ConCommand("ttt_radar_scan")
        end)
		
		local tmr = MOAT_BOSS_CUR:EntIndex()
		timer.Create("moat_check_boss" .. tmr, 0.1, 0, function()
			if (MOAT_ROUND_OVER) then timer.Remove("moat_check_boss" .. tmr) return end

			if (not IsValid(MOAT_BOSS_CUR)) then
				moat_BossPlayerDeath("boss")
				timer.Remove("moat_check_boss" .. tmr)
				return
			end
		end)
    end)

    hook.Add("TTTCheckForWin", "moat_BossDelayWin", function()
        return WIN_NONE
    end)

    hook.Add("PlayerShouldTakeDamage", "moat_BossPreventDamage", function(pl1, pl2)
        if (pl1:IsPlayer() and pl2:IsPlayer() and pl1:GetRole() == pl2:GetRole()) then
            return false
        end
    end)

    hook.Add("EntityTakeDamage", "moat_BossPreventDamage", function(ent, dmg)
		if (not IsValid(ent) or not ent:IsPlayer()) then return end
		if (not IsValid(MOAT_BOSS_CUR) or ent == MOAT_BOSS_CUR) then return end
        if (dmg:IsExplosionDamage()) then dmg:SetDamage(0) return true end

        local att = dmg:GetAttacker()
        if (not IsValid(att)) then return end
        att = (not att:IsPlayer() and IsValid(att:GetOwner())) and att:GetOwner() or att

        if (IsValid(att) and att:IsPlayer() and att:GetRole() == ent:GetRole()) then
            dmg:SetDamage(0)
            return true
        end
    end)

    hook.Add("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss", function(ply, penalty, vic)
        return true
    end)

	hook.Add("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents", function(att, vic)
		return att:GetRole() == vic:GetRole()
	end)

    hook.Add("PostPlayerDeath", "moat_BossDeath", moat_BossPlayerDeath)
end

EASTER = EASTER or {}

function EASTER.StartEggStealer(chosen)
    hook.Add("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout", function(ply)
        timer.Simple(0, function()
            for _, wep in pairs(ply:GetWeapons()) do
                if (wep.Primary.Ammo) then
                    ply:GiveAmmo(9999, wep.Primary.Ammo)
                end
            end
        end)
        return ply ~= chosen
    end)

    for i = 1, 5 do
        chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU ARE THE BUNNY!!!" )]])
    end

    for k, v in pairs(player.GetAll()) do
        if (v == chosen) then
            continue
        end
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
    end

    for _, v in pairs(ents.GetAll()) do
        if (IsValid(v) and v:IsWeapon() and (not IsValid(v:GetOwner()) or v:GetOwner() ~= chosen)) then
            v:Remove()
        end	
    end

    net.Start("MOAT_PREP_BUNNY")
    net.Broadcast()

    ttt.ExtendPrep(21)

    chosen:StripWeapons()
    MOAT_LOADOUT.GiveLoadout(chosen)

    MOAT_ACTIVE_BOSS = true
    MOAT_BOSS_CUR = chosen
    MOAT_ROUND_OVER = false
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Egg Stealers")

    moat_BeginRoundBossHooks()
end

concommand.Add("moat_start_egg_stealers", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then
        return
    end
    if (not IsValid(ply) and MSE.Player) then
        ply = MSE.Player
    end

    if (IsValid(ply) and not moat.isdev(ply)) then
        ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You cannot start this minigame." )]])
        return
    end

    local chosen = args[1]

    if (chosen == "self") then
        chosen = ply
    elseif (chosen == "random") then
        for k, v in RandomPairs(player.GetAll()) do
            if (v:Team() ~= TEAM_SPEC) then
                chosen = v

                break
            end
        end
    elseif (chosen) then
        chosen = player.GetBySteamID(chosen)
    else
		if (IsValid(ply)) then
        	ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "No player provided." )]])
		end

        return
    end

    if (type(chosen) == "string" or not IsValid(chosen)) then
		if (IsValid(ply)) then
        	ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "Couldn't find a player." )]])
		end

        return
    end

    EASTER.StartEggStealer(chosen)
end)