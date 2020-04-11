util.AddNetworkString("MOAT_PREP_DRAGON")
util.AddNetworkString("MOAT_BEGIN_DRAGON")
util.AddNetworkString("MOAT_END_DRAGON")
MOAT_ACTIVE_BOSS = false
local MOAT_BOSS_CUR_PLY = nil
local MOAT_BOSS_DMG = {}
local MOAT_ROUND_OVER = false
local MOAT_DEATHCLAW_WPN = nil
local MOAT_APACHE_ENT = NULL
local MOAT_APACHE_INITIALIZED = false
local MOAT_BOSS_HP_MULTIPLIER = 1000
local DeafultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
    ["weapon_zm_carry"] = true
}

function m_GetActiveBoss()
    return MOAT_BOSS_CUR or MOAT_BOSS_CUR_PLY
end

local function moat_EndRoundBossHooks()
	if (MOAT_MINIGAMES.CantEnd()) then return end

    -- Remove our hooks
    hook.Remove("ttt.BeginRound", "moat_BossBeginRound")
    hook.Remove("EntityTakeDamage", "moat_BossSaveDamage")
    hook.Remove("PostPlayerDeath", "moat_BossDeath")
    hook.Remove("PlayerShouldTakeDamage", "moat_BossPreventDamage")
    hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
    hook.Remove("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss")
    hook.Remove("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout")
    MOAT_ACTIVE_BOSS = false
    MOAT_BOSS_CUR_PLY = nil
    MOAT_DEATHCLAW_WPN = nil
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_APACHE_INITIALIZED = false
    MOAT_BOSS_HP_MULTIPLIER = 1000
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "moat_BossDelayWin")
end

local function moat_EndRoundHandler()
    moat_EndRoundBossHooks()
end

function moat_InitializeDragonBoss(ply)
    if (MOAT_APACHE_INITIALIZED) then return end
    
    MOAT_APACHE_INITIALIZED = true

    local boss_hp = 3750 * #player.GetAll()

    ply:SetHealth(boss_hp)
    ply:SetMaxHealth(boss_hp)

    MOAT_APACHE_ENT = ents.Create("npc_dragon_alduin")
    MOAT_APACHE_ENT:SetController(ply)
    MOAT_APACHE_ENT:SetPos(ply:GetPos() + Vector(0, 0, 200))
    MOAT_APACHE_ENT:Spawn()

    local control = ents.Create("obj_possession_manager")
    control:SetPossessor(ply)
    control:SetTarget(MOAT_APACHE_ENT)
    control:Spawn()
    control:StartPossession()

    /*ply:Spectate(OBS_MODE_CHASE)
    ply:SpectateEntity(MOAT_APACHE_ENT)
    ply:SetNoDraw(true)*/

    for k, v in pairs(ply:GetWeapons()) do
        if (v:GetClass() ~= "weapon_ttt_unarmed") then
            ply:StripWeapon(v:GetClass())
        end
    end
    ply:SelectWeapon("weapon_ttt_unarmed")

    MOAT_APACHE_ENT:SetHealth(ply:Health())

    net.Start("MOAT_BEGIN_DRAGON")
    net.WriteEntity(MOAT_APACHE_ENT)
    net.WriteEntity(ply)
    net.Broadcast()
end

local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}

local function moat_BeginRoundBossHooks()
    hook.Add("ttt.BeginRound", "moat_BossBeginRound", function()


        if (MOAT_DEATHCLAW_WPN) then
            for k , v in pairs(ents.GetAll()) do
                if (IsValid(v) and v:GetClass():StartWith("weapon_") and not DeafultLoadout[v:GetClass()]) then
                    v:Remove()
                end
            end
        end

        local boss = MOAT_BOSS_CUR_PLY

        if (boss and IsValid(boss)) then

            boss:GodEnable() -- so fucks dont kill him before all the health

            if (boss:GetRole() ~= ROLE_TRAITOR) then
                boss:SetRole(ROLE_TRAITOR)
                boss:AddCredits(GetConVarNumber("ttt_credits_starting"))
            end

            timer.Simple(1, function()
                moat_InitializeDragonBoss(boss)
                boss:GodDisable()
            end)
        end

        local healers = {}

        for k, v in RandomPairs(player.GetAll()) do

            if (MOAT_DEATHCLAW_WPN) then
                v:Give(MOAT_DEATHCLAW_WPN)
                v:SelectWeapon(MOAT_DEATHCLAW_WPN)
            end

            v:Freeze(true)

            for k2, v2 in pairs(v:GetWeapons()) do
                if (v2.Primary.Ammo) then
                    v:GiveAmmo(9999, v2.Primary.Ammo)
                end
            end

            if (v == boss) then continue end

            if (v:GetRole() ~= ROLE_INNOCENT) then
                v:SetRole(ROLE_INNOCENT)
            end

            v:SetCollisionGroup(COLLISION_GROUP_WEAPON)

            if (#healers < math.ceil(#player.GetAll() / 4)) then
                table.insert(healers, v)
                v:Give("weapon_ttt_health_station")
               -- BroadcastLua([[chat.AddText(Material("icon16/information.png"), Color( 0, 255, 0 ),"]] .. v:Nick() .. [[ has a health station!" )]])
            end
        end

        timer.Simple(1, function()
            MuteForRestart(true)
        end)

        /*timer.Create("moat_boss_voices", 30, 0, function()
            BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. math.random(2, 10) .. "smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) timer.Simple( 20, function() song:Stop() end ) end end )") 
        end)*/

        timer.Simple(5, function()
            MuteForRestart(false)
        end)

        SetRoundEnd(CurTime() + 99999)

        MOAT_BOSS_CUR_PLY:SetCredits(0)

        timer.Simple(5, function() 
            hook.Remove("PlayerSpawn", "moat_PlayerRespawn")

            for k, v in pairs(player.GetAll()) do
                v:Freeze(false)
                v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            end

            MOAT_BOSS_CUR_PLY:AddEquipmentItem(EQUIP_RADAR)
            MOAT_BOSS_CUR_PLY:ConCommand("ttt_radar_scan")
        end)
    end)

    hook.Add("PlayerSpawn", "moat_PlayerRespawn", function(ply)
        if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR) and ply == MOAT_BOSS_CUR) then
            MOAT_BOSS_CUR:GodEnable()
        end
        
        ply:Freeze(true)

        timer.Simple(2, function()

            local boss = MOAT_BOSS_CUR_PLY

            if (boss and IsValid(boss) and ply == boss) then
                if (boss:GetRole() ~= ROLE_TRAITOR) then
                    boss:SetRole(ROLE_TRAITOR)
                    boss:AddCredits(GetConVarNumber("ttt_credits_starting"))
                end

                timer.Simple(1, function()
                    moat_InitializeDragonBoss(boss)
                    boss:GodDisable()
                end)
            else
                if (ply:GetRole() ~= ROLE_INNOCENT) then
                    ply:SetRole(ROLE_INNOCENT)
                end
            end

            if (MOAT_DEATHCLAW_WPN) then
                ply:Give(MOAT_DEATHCLAW_WPN)
                ply:SelectWeapon(MOAT_DEATHCLAW_WPN)
            end

            for k, v in pairs(ply:GetWeapons()) do
                if (v.Primary.Ammo) then
                    ply:GiveAmmo(9999, v.Primary.Ammo)
                end
            end
        end)
    end)

    hook.Add("TTTCheckForWin", "moat_BossDelayWin", function() return WIN_NONE end)

    hook.Add("EntityTakeDamage", "moat_BossSaveDamage", function(ply, dmginfo)
        if (ply == MOAT_APACHE_ENT and dmginfo:GetDamage() >= 1 and dmginfo:GetAttacker():IsPlayer() and GetRoundState() == ROUND_ACTIVE) then
            local att = dmginfo:GetAttacker()
            if (not att.BossDamage) then
                att.BossDamage = 0
            end

            net.Start("moat.damage")
            net.WriteUInt(math.Round(dmginfo:GetDamage()), 16)
            net.Send(att)

            net.Start("moat_hitmarker")
            net.Send(att)

            att.BossDamage = att.BossDamage + dmginfo:GetDamage()
        end
    end)

    hook.Add("PlayerShouldTakeDamage", "moat_BossPreventDamage", function(ply, ent)
        if (ent:IsPlayer() and ply:GetRole() == ROLE_INNOCENT and ent:GetRole() == ROLE_INNOCENT) then
            return false
        elseif (IsValid(ent) and ent:GetOwner() and IsValid(ent:GetOwner())) then
            if (ent:GetOwner():IsPlayer() and ply:GetRole() == ROLE_INNOCENT and ent:GetOwner():GetRole() == ROLE_INNOCENT) then
                return false
            end
        end
    end)

    hook.Add("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss", function(ply, penalty, vic)
        if (vic:IsPlayer() and ply:GetRole() == ROLE_INNOCENT and vic:GetRole() == ROLE_INNOCENT) then
            return true
        end
    end)

    hook.Add("PostPlayerDeath", "moat_BossDeath", function(ply)
        if (GetRoundState() ~= ROUND_ACTIVE) then return end
        
        local IS_BOSS = false
        if (ply == MOAT_BOSS_CUR_PLY) then
            IS_BOSS = true
        end

        MOAT_BOSS_CUR_PLY:SetCredits(0)
        
        timer.Simple(1, function()
            if (IsValid(ply.server_ragdoll)) then
                local pl = player.GetByUniqueID(ply.server_ragdoll.uqid)
                if not IsValid(pl) then return end
                pl:SetCleanRound(false)
                pl:SetNW2Bool("body_found", true)
                CORPSE.SetFound(ply.server_ragdoll, true)
                ply.server_ragdoll:Remove()
            end
        end)

        if (GetRoundState() == ROUND_ACTIVE and not IS_BOSS) then
            --BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "_death" .. math.random(1, 11) .. "smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) end end )") 
        end

        local numalive = 0

        for k, v in pairs(player.GetAll()) do
            if (v:Alive() and not v:IsSpec()) then
                numalive = numalive + 1
            end
        end

        if (GetRoundState() ~= ROUND_ACTIVE or (numalive > 1 and not IS_BOSS) or MOAT_ROUND_OVER) then return end

        MOAT_ROUND_OVER = true

        net.Start("moat.damage.reset")
        net.Broadcast()

        for k, v in pairs(player.GetAll()) do
            if (IsValid(v) and v.BossDamage and v.BossDamage > 1) then
                table.insert(MOAT_BOSS_DMG, {v:Nick(), v.BossDamage, v:EntIndex()})
            end
        end

        net.Start("MOAT_END_DRAGON")
        net.WriteBool(IS_BOSS)
        net.WriteTable(MOAT_BOSS_DMG)
        net.Broadcast()

        timer.Remove("moat_boss_voices")

        MOAT_BOSS_CUR_PLY:SpectateEntity(nil)
        MOAT_BOSS_CUR_PLY:Spectate(OBS_MODE_NONE)


        timer.Simple(20, function()
            moat_EndRoundHandler()
        end)

        if (not IS_BOSS) then
            --BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "_loss_smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) end end )") 
            if (IsValid(MOAT_BOSS_CUR_PLY)) then
                MOAT_BOSS_CUR_PLY:m_DropInventoryItem(math.random(5,6))
            end
            return
        else
            --BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "_won_smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) end end )") 
        end

        local ply_tbl = {}

        for k, v in pairs(player.GetAll()) do
            if (IsValid(v) and v.BossDamage and v.BossDamage > 1) then
                table.insert(ply_tbl, {v, v.BossDamage})
            end
        end

        table.sort(ply_tbl, function(a, b) return a[2] > b[2] end)

        for k, v in ipairs(ply_tbl) do
            if (k == 1) then
                local es = math.random(1, 4)

                if (es == 4) then
                    v[1]:m_DropInventoryItem(6)
                else
                    v[1]:m_DropInventoryItem(5)
                end

                continue 
            end
            if (rarity_to_placing[k]) then
                v[1]:m_DropInventoryItem(rarity_to_placing[k])
            else
                v[1]:m_DropInventoryItem(3)
            end
        end
    end)
end

concommand.Add("moat_start_dragon", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    --if (GetRoundState() ~= ROUND_PREP) then return end
    local chosen = args[1]
    MOAT_DEATHCLAW_WPN = args[2]

    if (MOAT_DEATHCLAW_WPN) then
        MOAT_BOSS_HP_MULTIPLIER = 500

        for k , v in pairs(ents.GetAll()) do
            if (IsValid(v) and v:GetClass():StartWith("weapon_") and not DeafultLoadout[v:GetClass()]) then
                v:Remove()
            end
        end

        hook.Add("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout", function(ply) return true end)
    end

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
        ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "No player provided." )]])

        return
    end

    if (type(chosen) == "string" or chosen == NULL or not IsValid(chosen)) then
        ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "No player found with steamid provided." )]])

        return
    end

    for i = 1, 5 do
        chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU WILL BE THE BOSS!!!" )]])
    end

    for k, v in pairs(player.GetAll()) do
        if (v == chosen) then continue end
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
    end

    net.Start("MOAT_PREP_DRAGON")
    net.Broadcast()

    MuteForRestart(true)

    ttt.ExtendPrep()

    MOAT_APACHE_INITIALIZED = false
    MOAT_APACHE_ENT = NULL
    MOAT_ACTIVE_BOSS = true
    MOAT_BOSS_CUR_PLY = chosen
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Dragon Boss")
    for k, v in pairs(player.GetAll()) do
        v.BossDamage = 0
    end
    moat_BeginRoundBossHooks()
end)