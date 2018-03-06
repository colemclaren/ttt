util.AddNetworkString("MOAT_PREP_STALKER")
util.AddNetworkString("MOAT_BEGIN_STALKER")
util.AddNetworkString("MOAT_END_STALKER")
MOAT_ACTIVE_BOSS = false
MOAT_BOSS_CUR = nil
local MOAT_BOSS_DMG = {}
local MOAT_ROUND_OVER = false
local MOAT_BOSS_MODEL = "models/player/zombie_fast.mdl"
local deathclaw_voice_url = "http://server.moatgaming.org/tttsounds/stalker/stalker_"
local MOAT_DEATHCLAW_WPN = nil
local MOAT_BOSS_HP_MULTIPLIER = 90
local MOAT_BOSS_KNIFE = 45
local DeafultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
    ["weapon_zm_carry"] = true,
    ["weapon_ttt_knife"] = true
}

local function moat_EndRoundBossHooks()

    if (MOAT_BOSS_CUR and MOAT_BOSS_CUR:IsValid()) then
        MOAT_BOSS_CUR:SetColor(Color(255, 255, 255, 255))
        MOAT_BOSS_CUR:DrawShadow(true)
        MOAT_BOSS_CUR:SetNWBool("disguised", false)
        MOAT_BOSS_CUR:SetNWFloat("SpeedModAddend", 0)
    end

    -- Remove our hooks
    hook.Remove("TTTBeginRound", "moat_BossBeginRound")
    hook.Remove("EntityTakeDamage", "moat_BossSaveDamage")
    hook.Remove("PostPlayerDeath", "moat_BossDeath")
    hook.Remove("PlayerShouldTakeDamage", "moat_BossPreventDamage")
    hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
    hook.Remove("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss")
    hook.Remove("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout")
    hook.Remove("EntityTakeDamage", "moat_StopFallDamage")
    hook.Remove("PlayerDeath", "moat_BossKnife")
    hook.Remove("PlayerCanPickupWeapon", "moat_RestrictWeaponPickup")
    hook.Remove("PlayerSwitchWeapon", "moat_RestrictWeaponSwitch")
    hook.Remove("Think", "moat_JetpackVelocity")
    hook.Remove("PlayerDisconnected", "moat_BossDisconnect")
    
    MOAT_ACTIVE_BOSS = false
    MOAT_BOSS_CUR = nil
    MOAT_DEATHCLAW_WPN = nil
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_BOSS_HP_MULTIPLIER = 90
    MOAT_MINIGAME_OCCURING = false
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "moat_BossDelayWin")
end

function GetAlivePlayers()
    local num = 0

    for k, v in pairs(player.GetAll()) do
        if (v:Alive() and not v:IsSpec()) then
            num = num + 1
        end
    end

    return num
end

local function moat_EndRoundHandler()
    moat_EndRoundBossHooks()
end

local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}

local function moat_BeginRoundBossHooks()
    hook.Add("PlayerDisconnected", "moat_BossDisconnect", function(pl)
        hook.Run("PostPlayerDeath", pl)
    end)

    hook.Add("TTTBeginRound", "moat_BossBeginRound", function()

        if (MOAT_DEATHCLAW_WPN) then
            for k , v in pairs(ents.GetAll()) do
                if (IsValid(v) and v:IsValid() and v ~= NULL and v:GetClass():StartWith("weapon_") and not DeafultLoadout[v:GetClass()]) then
                    v:Remove()
                end
            end
        end

        local boss = MOAT_BOSS_CUR

        if (boss and boss:IsValid()) then

            boss:GodEnable() -- so fucks dont kill him before all the health

            if (boss:GetRole() ~= ROLE_TRAITOR) then
                boss:SetRole(ROLE_TRAITOR)
                boss:AddCredits(GetConVarNumber("ttt_credits_starting"))
            end

            timer.Simple(1, function()
                local hp = #player.GetAll() * MOAT_BOSS_HP_MULTIPLIER
                boss:SetModel(MOAT_BOSS_MODEL)
                boss:SetHealth(hp)
                boss:SetMaxHealth(hp)
                boss:GodDisable()
                boss:SetNWFloat("SpeedModAddend", 0.5)
                boss:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                boss:SetRenderMode(RENDERMODE_TRANSALPHA)
                boss:SetColor(Color(255, 255, 255, 0))
                boss:DrawShadow(false)
                boss:SetNWBool("disguised", true)
                boss:Give("weapon_ttt_knife")
                boss:SelectWeapon("weapon_ttt_knife")
                net.Start("MOAT_PLAYER_CLOAKED")
                net.WriteEntity(boss)
                net.WriteBool(true)
                net.Broadcast()

                for k, v in pairs(boss:GetWeapons()) do
                    if (not DeafultLoadout[v:GetClass()]) then boss:StripWeapon(v:GetClass()) end

                    if (v.ClassName and v.ClassName == "weapon_ttt_knife") then
                        v.Primary.Damage = MOAT_BOSS_KNIFE
                    end
                end
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
                BroadcastLua([[chat.AddText(Material("icon16/information.png"), Color( 0, 255, 0 ),"]] .. v:Nick() .. [[ has a health station!" )]])
            end
        end

        net.Start("MOAT_BEGIN_STALKER")
        net.WriteEntity(boss)
        net.Broadcast()

        timer.Simple(1, function()
            MuteForRestart(true)
            BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "taunt1" .. ".mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) timer.Simple( 20, function() song:Stop() end ) end end )")
        end)

        timer.Simple(10, function()
            local pos = MOAT_EASTER.SpawnPositions[math.random(1, #MOAT_EASTER.SpawnPositions)]

            local ent = ents.Create("sent_egg")
            ent:SetPos(pos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
            ent:Spawn()

            BroadcastLua([[chat.AddText(Material("icon16/information.png"), Color(255, 255, 0),"AN EASTER EGG HAS SPAWNED ON THE MAP!!!" )]])
            BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "easteregg" .. ".mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) timer.Simple( 20, function() song:Stop() end ) end end )")
        end)

        timer.Simple(5, function()
            MuteForRestart(false)
        end)

        hook.Add("PlayerFootstep", "moat_ScreenShake", function(ply, pos, foot, sound, vol, rf)
            if (MOAT_BOSS_CUR and ply == MOAT_BOSS_CUR) then
                util.ScreenShake(pos, 5, 5, 0.5, 1500)
            end
            if (GetRoundState() ~= ROUND_ACTIVE) then
                hook.Remove("PlayerFootstep", "moat_ScreenShake")
            end
        end)

        hook.Add("EntityTakeDamage", "moat_StopFallDamage", function(ent, dmginfo)
            if (MOAT_BOSS_CUR and ent == MOAT_BOSS_CUR and dmginfo:IsFallDamage()) then
                return true
            end
        end)

        hook.Add("Think", "moat_JetpackVelocity", function()
            if (MOAT_BOSS_CUR and MOAT_BOSS_CUR:IsValid() and MOAT_BOSS_CUR:Team() ~= TEAM_SPEC and MOAT_BOSS_CUR:KeyDown(IN_JUMP)) then
                MOAT_BOSS_CUR:SetVelocity(MOAT_BOSS_CUR:GetUp() * 25)
            end
        end)

        SetRoundEnd(CurTime() + 99999)

        MOAT_BOSS_CUR:SetCredits(0)

        timer.Simple(5, function() 
            hook.Remove("PlayerSpawn", "moat_PlayerRespawn")

            for k, v in pairs(player.GetAll()) do
                v:Freeze(false)
                v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            end

            MOAT_BOSS_CUR:GiveEquipmentItem(EQUIP_RADAR)
            MOAT_BOSS_CUR:ConCommand("ttt_radar_scan")
        end)
    end)

    hook.Add("PlayerSpawn", "moat_PlayerRespawn", function(ply)

        if (MOAT_BOSS_CUR and MOAT_BOSS_CUR:IsValid() and ply == MOAT_BOSS_CUR) then
            MOAT_BOSS_CUR:GodEnable()
        end
        
        ply:Freeze(true)

        timer.Simple(2, function()

            local boss = MOAT_BOSS_CUR

            if (boss and boss:IsValid() and ply == boss) then
                if (boss:GetRole() ~= ROLE_TRAITOR) then
                    boss:SetRole(ROLE_TRAITOR)
                    boss:AddCredits(GetConVarNumber("ttt_credits_starting"))
                end

                timer.Simple(1, function()
                    local hp = #player.GetAll() * MOAT_BOSS_HP_MULTIPLIER
                    boss:SetModel(MOAT_BOSS_MODEL)
                    boss:SetHealth(hp)
                    boss:SetMaxHealth(hp)
                    boss:GodDisable()
                    boss:SetNWFloat("SpeedModAddend", 0.5)
                    boss:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                    boss:SetRenderMode(RENDERMODE_TRANSALPHA)
                    boss:SetColor(Color(255, 255, 255, 0))
                    boss:DrawShadow(false)
                    boss:SetNWBool("disguised", true)
                    boss:Give("weapon_ttt_knife")
                    boss:SelectWeapon("weapon_ttt_knife")
                    net.Start("MOAT_PLAYER_CLOAKED")
                    net.WriteEntity(boss)
                    net.WriteBool(true)
                    net.Broadcast()

                    for k, v in pairs(boss:GetWeapons()) do
                        if (not DeafultLoadout[v:GetClass()]) then boss:StripWeapon(v:GetClass()) end

                        if (v.ClassName and v.ClassName == "weapon_ttt_knife") then
                            v.Primary.Damage = MOAT_BOSS_KNIFE
                        end
                    end
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
        if (IsValid(ply) and ply:IsPlayer() and dmginfo:GetDamage() >= 1 and dmginfo:GetAttacker():IsPlayer() and GetRoundState() == ROUND_ACTIVE and MOAT_BOSS_CUR and ply == MOAT_BOSS_CUR and not MOAT_BOSS_CUR:HasGodMode()) then
            local att = dmginfo:GetAttacker()
            if (not att.BossDamage) then
                att.BossDamage = 0
            end

            net.Start("moat.damage")
            net.WriteUInt(math.Round(dmginfo:GetDamage()), 16)
            net.Send(att)

            att.BossDamage = att.BossDamage + dmginfo:GetDamage()
        end
    end)

    hook.Add("PlayerShouldTakeDamage", "moat_BossPreventDamage", function(ply, ent)
        if (ent:IsPlayer() and ply:GetRole() == ROLE_INNOCENT and ent:GetRole() == ROLE_INNOCENT) then
            return false
        elseif (ent:GetOwner() and ent:GetOwner():IsValid()) then
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

    hook.Add("PlayerDeath", "moat_BossKnife", function(ply, inf, att)
        if(att == MOAT_BOSS_CUR and GetRoundState() == ROUND_ACTIVE) then
            timer.Simple(0.5, function()
                MOAT_BOSS_CUR:Give("weapon_ttt_knife")

                for k, v in pairs(MOAT_BOSS_CUR:GetWeapons()) do
                    if (not DeafultLoadout[v:GetClass()]) then MOAT_BOSS_CUR:StripWeapon(v:GetClass()) end

                    if (v.ClassName and v.ClassName == "weapon_ttt_knife") then
                        v.Primary.Damage = 50
                    end
                end

                MOAT_BOSS_CUR:SelectWeapon("weapon_ttt_knife")
            end)

            local pos = MOAT_EASTER.SpawnPositions[math.random(1, #MOAT_EASTER.SpawnPositions)]

            local ent = ents.Create("sent_egg")
            ent:SetPos(pos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
            ent:Spawn()

            BroadcastLua([[chat.AddText(Material("icon16/information.png"), Color(255, 255, 0),"AN EASTER EGG HAS SPAWNED ON THE MAP!!!" )]])
             BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "easteregg" .. ".mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) timer.Simple( 20, function() song:Stop() end ) end end )")
        end
    end)

    hook.Add("PlayerCanPickupWeapon", "moat_RestrictWeaponPickup", function(ply, wep)
        if (ply == MOAT_BOSS_CUR and not DeafultLoadout[wep:GetClass()]) then
            return false
        end
    end)

    hook.Add("PlayerSwitchWeapon", "moat_RestrictWeaponSwitch", function(ply, owep, neww)
        if (ply == MOAT_BOSS_CUR and not DeafultLoadout[neww:GetClass()]) then
            return true
        end
    end)

    hook.Add("PostPlayerDeath", "moat_BossDeath", function(ply)
        if (GetRoundState() ~= ROUND_ACTIVE) then return end
        
        local IS_BOSS = MOAT_BOSS_CUR and MOAT_BOSS_CUR == ply

        MOAT_BOSS_CUR:SetCredits(0)

        timer.Simple(1, function()
            if (IsValid(ply.server_ragdoll)) then
                local pl = player.GetByUniqueID(ply.server_ragdoll.uqid)
                if not IsValid(pl) then return end
                pl:SetCleanRound(false)
                pl:SetNWBool("body_found", true)
                CORPSE.SetFound(ply.server_ragdoll, true)
                ply.server_ragdoll:Remove()
            end
        end)

        if (GetRoundState() == ROUND_PREP or (GetAlivePlayers() > 1 and not IS_BOSS) or MOAT_ROUND_OVER) then return end
        MOAT_ROUND_OVER = true
        
        net.Start("moat.damage.reset")
        net.Broadcast()

        for k, v in pairs(player.GetAll()) do
            if (v:IsValid() and v.BossDamage and v.BossDamage > 1) then
                table.insert(MOAT_BOSS_DMG, {v:Nick(), v.BossDamage, v:EntIndex()})
            end
        end

        net.Start("MOAT_END_STALKER")
        net.WriteBool(IS_BOSS)
        net.WriteTable(MOAT_BOSS_DMG)
        net.Broadcast()

        timer.Remove("moat_boss_voices")

        timer.Simple(20, function()
            moat_EndRoundHandler()
        end)

        if (not IS_BOSS) then
            if (MOAT_BOSS_CUR:IsValid()) then
                MOAT_BOSS_CUR:m_DropInventoryItem(math.random(5,6))
            end
            return
        end

        local ply_tbl = {}

        for k, v in pairs(player.GetAll()) do
            if (v:IsValid() and v.BossDamage and v.BossDamage > 1) then
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

local allowed_ids = {
    ["STEAM_0:0:46558052"] = true,
    ["STEAM_0:1:24643024"] = true,
    ["STEAM_0:1:46918472"] = true,
    ["STEAM_0:1:39556387"] = true
}

function moat_start_stalker_round(ply, args)
    local chosen = args[1]
    MOAT_DEATHCLAW_WPN = args[2]

    if (MOAT_DEATHCLAW_WPN) then
        MOAT_BOSS_HP_MULTIPLIER = 90

        for k , v in pairs(ents.GetAll()) do
            if (IsValid(v) and v:IsValid() and v ~= NULL and v:GetClass():StartWith("weapon_") and not DeafultLoadout[v:GetClass()]) then
                v:Remove()
            end
        end

        hook.Add("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout", function(ply) return true end)
    end

    if (chosen == "random") then
        for k, v in RandomPairs(player.GetAll()) do
            if (v:Team() ~= TEAM_SPEC) then
                chosen = v
                break
            end
        end
    elseif (chosen == "self") then
        chosen = ply
    elseif (chosen) then
        chosen = player.GetBySteamID(chosen)
    else
        --ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "No player provided." )]])

        return
    end

    if (type(chosen) == "string" or chosen == NULL or not chosen:IsValid()) then
        --ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "No player found with steamid provided." )]])

        return
    end

    for i = 1, 5 do
        chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU WILL BE THE STALKER!!!" )]])
    end

    for k, v in pairs(player.GetAll()) do
        if (v == chosen) then continue end
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "I'M COMING FOR YOU..." )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 128, 0 ), "I'M COMING FOR YOU..." )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "I'M COMING FOR YOU..." )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 128, 0 ), "I'M COMING FOR YOU..." )]])
        v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "I'M COMING FOR YOU..." )]])
    end

    net.Start("MOAT_PREP_STALKER")
    net.Broadcast()

    SetRoundEnd(CurTime() + 30)
    timer.Adjust("prep2begin", 30, 1, BeginRound)
    timer.Adjust("selectmute", 29, 1, function() MuteForRestart(true) end)

    MOAT_ACTIVE_BOSS = true
    MOAT_BOSS_CUR = chosen
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_MINIGAME_OCCURING = true
    for k, v in pairs(player.GetAll()) do
        v.BossDamage = 0
    end
    moat_BeginRoundBossHooks()
end

concommand.Add("moat_start_stalker", function(ply, cmd, args)
    if ((ply ~= NULL and not allowed_ids[ply:SteamID()]) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    moat_start_stalker_round(ply, args)
end)
/*
hook.Add("TTTPrepareRound", "moat_StartHunterGame", function()
    local random_chance = math.random(1, 20)

    if (#player.GetAll() > 7 and random_chance == 10 and GetGlobalInt("ttt_rounds_left") < 8) then
        timer.Simple(5, function() moat_start_stalker_round("na", {"random"}) end)
    end
end)*/