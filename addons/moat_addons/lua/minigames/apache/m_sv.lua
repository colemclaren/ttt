util.AddNetworkString("MOAT_PREP_APACHE")
util.AddNetworkString("MOAT_BEGIN_APACHE")
util.AddNetworkString("MOAT_END_APACHE")
MOAT_ACTIVE_BOSS = false
local MOAT_BOSS_CUR_PLY = nil
local MOAT_BOSS_DMG = {}
local MOAT_ROUND_OVER = false
local deathclaw_voice_url = "https://i.moat.gg/servers/tttsounds/apache/apache"
local MOAT_DEATHCLAW_WPN = nil
local MOAT_APACHE_ENT = NULL
local MOAT_APACHE_INITIALIZED = false
local MOAT_BOSS_HP_MULTIPLIER = 1000
local DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
    ["weapon_zm_carry"] = true
}

function m_GetActiveBoss()
    return MOAT_BOSS_CUR or MOAT_BOSS_CUR_PLY
end

local function moat_EndRoundBossHooks()
    -- Remove our hooks
    hook.Remove("TTTBeginRound", "moat_BossBeginRound")
    hook.Remove("EntityTakeDamage", "moat_BossSaveDamage")
    hook.Remove("PostPlayerDeath", "moat_BossDeath")
    hook.Remove("EntityTakeDamage", "moat_BossPreventDamage")
    hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
    hook.Remove("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss")
    hook.Remove("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout")
    hook.Remove("PlayerDisconnected", "moat_BossDisconnect")

    MOAT_ACTIVE_BOSS = false
    MOAT_BOSS_CUR_PLY = nil
    MOAT_DEATHCLAW_WPN = nil
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_APACHE_INITIALIZED = false
    MOAT_BOSS_HP_MULTIPLIER = 1000
    MOAT_MINIGAME_OCCURING = false
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "moat_BossDelayWin")
end

local function moat_EndRoundHandler()
    moat_EndRoundBossHooks()
end

function moat_InitializeApacheBoss(ply)
    if (MOAT_APACHE_INITIALIZED) then return end
    
    MOAT_APACHE_INITIALIZED = true

    local boss_hp = 4166 * #player.GetAll()

    ply:SetHealth(boss_hp)
    ply:SetMaxHealth(boss_hp)

    MOAT_APACHE_ENT = ents.Create("npc_apache")
    MOAT_APACHE_ENT.Controller = ply
    MOAT_APACHE_ENT:Spawn()
    MOAT_APACHE_ENT:SetPos(ply:GetPos() + Vector(0, 0, 256))

    ply:Spectate(OBS_MODE_CHASE)
    ply:SpectateEntity(MOAT_APACHE_ENT)
    ply:SetNoDraw(true)

    for k, v in pairs(ply:GetWeapons()) do
        if (v:GetClass() ~= "weapon_ttt_unarmed") then
            ply:StripWeapon(v:GetClass())
        end
    end
    ply:SelectWeapon("weapon_ttt_unarmed")

    MOAT_APACHE_ENT:SetHealth(ply:Health())

    net.Start("MOAT_BEGIN_APACHE")
    net.WriteEntity(MOAT_APACHE_ENT)
    net.WriteEntity(ply)
    net.Broadcast()
end

local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}

local function moat_BossPlayerDeath(ply)
	if (MOAT_ROUND_OVER or GetRoundState() ~= ROUND_ACTIVE) then return end
	local IS_BOSS, ALIVE = false, GetAlivePlayers()
	if (type(ply) == "string" and ply == "boss") then
		IS_BOSS = true
	else
		IS_BOSS = IsValid(MOAT_BOSS_CUR_PLY) and MOAT_BOSS_CUR_PLY == ply
	end

	if (IS_BOSS or ALIVE <= 1) then
		MOAT_ROUND_OVER = true
	end

	if (IsValid(MOAT_BOSS_CUR_PLY)) then
		MOAT_BOSS_CUR_PLY:SetCredits(0)
	end

	if (not MOAT_ROUND_OVER) then
		timer.Simple(1, function()
			if (not IsValid(ply) or not IsValid(ply.server_ragdoll)) then return end

            local pl = player.GetBySteamID(ply.server_ragdoll.sid)
            if (not IsValid(pl)) then return end
            pl:SetCleanRound(false)
            pl:SetNWBool("body_found", true)
            CORPSE.SetFound(ply.server_ragdoll, true)
            ply.server_ragdoll:Remove()
    	end)

		BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "_death" .. math.random(1, 11) .. "smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) end end )")
		return
	end

    net.Start("moat.damage.reset")
    net.Broadcast()

    for k, v in pairs(player.GetAll()) do
        if (v:IsValid() and v.BossDamage and v.BossDamage > 1) then
            table.insert(MOAT_BOSS_DMG, {v:Nick(), v.BossDamage, v:EntIndex()})
        end
    end

    net.Start("MOAT_END_APACHE")
    net.WriteBool(IS_BOSS)
    net.WriteTable(MOAT_BOSS_DMG)
    net.Broadcast()

    timer.Remove("moat_boss_voices")

	if (IsValid(MOAT_BOSS_CUR_PLY)) then
		MOAT_BOSS_CUR_PLY:SpectateEntity(nil)
    	MOAT_BOSS_CUR_PLY:Spectate(OBS_MODE_NONE)
	end

    timer.Simple(20, function()
        moat_EndRoundHandler()
    end)

    if (not IS_BOSS) then
        BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "_loss_smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) end end )") 
        if (IsValid(MOAT_BOSS_CUR_PLY)) then
            MOAT_BOSS_CUR_PLY:m_DropInventoryItem(math.random(5,6))
        end
        return
    else
        BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "_won_smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) end end )") 
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
end

local function moat_BeginRoundBossHooks()
    hook.Add("PlayerDisconnected", "moat_BossDisconnect", function(pl)
        hook.Run("PostPlayerDeath", pl)
    end)

    hook.Add("TTTBeginRound", "moat_BossBeginRound", function()
		local pls = player.GetAll()
		if (not IsValid(MOAT_BOSS_CUR_PLY)) then
			local chosen
        	for k, v in RandomPairs(pls) do
            	if (v:Team() ~= TEAM_SPEC) then
                	chosen = v

                	break
            	end
        	end

			for i = 1, 5 do
        		chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU ARE THE BOSS!!!" )]])
    		end

			MOAT_BOSS_CUR_PLY = chosen
		end

        if (MOAT_DEATHCLAW_WPN) then
            for k , v in pairs(ents.GetAll()) do
                if (IsValid(v) and v:IsValid() and v ~= NULL and v:GetClass():StartWith("weapon_") and not DefaultLoadout[v:GetClass()]) then
                    v:Remove()
                end
            end
        end

        local boss = MOAT_BOSS_CUR_PLY
        boss:GodEnable()
        if (boss:GetRole() ~= ROLE_TRAITOR) then
            boss:SetRole(ROLE_TRAITOR)
        end
		boss:SetCredits(0)

        timer.Simple(boss.JustSpawned and 2 or 0, function()
			moat_InitializeApacheBoss(boss)
        	boss:GodDisable()
        end)

        local healers = {}
        for k, v in RandomPairs(pls) do
			v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			v:Freeze(true)
			if (v == boss) then continue end

			if (v:GetRole() ~= ROLE_INNOCENT) then
                v:SetRole(ROLE_INNOCENT)
            end

			local healer = false
            if (#healers < math.ceil(#pls / 4)) then
				healer = true
                table.insert(healers, v)
				D3A.Chat.SendToPlayer2(v, Color(255, 255, 0), v:Nick(), Color(255, 255, 255), " has a ", Color(0, 255, 0), "health station", Color(255, 255, 255), "!")
            end

			timer.Simple(v.JustSpawned and 2 or 0, function()
				if (MOAT_DEATHCLAW_WPN) then
                	v:Give(MOAT_DEATHCLAW_WPN)
                	v:SelectWeapon(MOAT_DEATHCLAW_WPN)
            	end

            	for k2, v2 in pairs(v:GetWeapons()) do
                	if (v2.Primary.Ammo) then
                    	v:GiveAmmo(9999, v2.Primary.Ammo)
                	end
            	end

				if (healer) then
					v:Give("weapon_ttt_health_station")
				end
			end)
        end

        timer.Simple(1, function()
            MuteForRestart(true)
            BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. "_america" .. math.random(1, 2) .. "smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) timer.Simple( 20, function() song:Stop() end ) end end )")
        end)

        timer.Create("moat_boss_voices", 30, 0, function()
            BroadcastLua("sound.PlayURL('" .. tostring(deathclaw_voice_url .. math.random(2, 10) .. "smith.mp3") .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume(2) timer.Simple( 20, function() song:Stop() end ) end end )") 
        end)

        timer.Simple(5, function()
            MuteForRestart(false)
        end)

        SetRoundEnd(CurTime() + 99999)

        timer.Simple(5, function() 
            for k, v in ipairs(player.GetAll()) do
                v:Freeze(false)
                v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            end
			if (not IsValid(MOAT_BOSS_CUR_PLY)) then return end

            MOAT_BOSS_CUR_PLY:GiveEquipmentItem(EQUIP_RADAR)
            MOAT_BOSS_CUR_PLY:ConCommand("ttt_radar_scan")
        end)
		
		local tmr = MOAT_BOSS_CUR_PLY:EntIndex()
		timer.Create("moat_check_boss" .. tmr, 0.1, 0, function()
			if (not IsValid(MOAT_BOSS_CUR_PLY)) then
				moat_BossPlayerDeath("boss")
				timer.Remove("moat_check_boss" .. tmr)
				return
			end
		end)
    end)

    hook.Add("TTTCheckForWin", "moat_BossDelayWin", function() return WIN_NONE end)

    hook.Add("EntityTakeDamage", "moat_BossSaveDamage", function(ply, dmginfo)
		local att = dmginfo:GetAttacker()
        if (IsValid(ply) and IsValid(att) and ply == MOAT_APACHE_ENT and dmginfo:GetDamage() >= 1 and att:IsPlayer() and GetRoundState() == ROUND_ACTIVE) then
			if (MOAT_BOSS_CUR_PLY and IsValid(MOAT_BOSS_CUR_PLY) and MOAT_BOSS_CUR_PLY == att) then return end

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

    hook.Add("EntityTakeDamage", "moat_BossPreventDamage", function(ent, dmg)
		if (not IsValid(ent) or not ent:IsPlayer()) then return end
		if (not IsValid(MOAT_BOSS_CUR_PLY) or not IsValid(MOAT_APACHE_ENT) or ent == MOAT_APACHE_ENT) then return end
		if (dmg:IsBulletDamage() or dmg:IsExplosionDamage()) then
			local att = dmg:GetAttacker()
			if (not IsValid(att)) then return end

			if (dmg:IsExplosionDamage() and att:GetClass() ~= "proj_dan_heli_shot") then dmg:SetDamage(0) return true end
			att = (not att:IsPlayer() and att:GetOwner() and IsValid(att:GetOwner())) and att:GetOwner() or att

			if (IsValid(att) and att:IsPlayer() and att:GetRole() == ent:GetRole()) then
				dmg:SetDamage(0)
				return true
			end
		end
    end)

    hook.Add("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss", function(ply, penalty, vic)
        return true
    end)

    hook.Add("PostPlayerDeath", "moat_BossDeath", moat_BossPlayerDeath)
end

local allowed_ids = {
    ["STEAM_0:0:46558052"] = true,
    ["STEAM_0:1:24643024"] = true,
    ["STEAM_0:1:46918472"] = true,
    ["STEAM_0:1:39556387"] = true
}

concommand.Add("moat_start_apache", function(ply, cmd, args)
    if ((ply ~= NULL and not allowed_ids[ply:SteamID()]) or GetRoundState() ~= ROUND_PREP) then

        return
    end
	if (not IsValid(ply) and MSE.Player) then ply = MSE.Player end


    local chosen = args[1]
    MOAT_DEATHCLAW_WPN = args[2]

    if (MOAT_DEATHCLAW_WPN) then
        MOAT_BOSS_HP_MULTIPLIER = 350

        for k , v in pairs(ents.GetAll()) do
            if (IsValid(v) and v:IsValid() and v ~= NULL and v:GetClass():StartWith("weapon_") and not DefaultLoadout[v:GetClass()]) then
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

    net.Start("MOAT_PREP_APACHE")
    net.Broadcast()

    MuteForRestart(true)

    SetRoundEnd(CurTime() + 30)
    timer.Adjust("prep2begin", 30, 1, BeginRound)
    timer.Adjust("selectmute", 29, 1, function() MuteForRestart(true) end)

    MOAT_APACHE_INITIALIZED = false
    MOAT_APACHE_ENT = NULL
    MOAT_ACTIVE_BOSS = true
    MOAT_BOSS_CUR_PLY = chosen
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_MINIGAME_OCCURING = true
    for k, v in pairs(player.GetAll()) do
        v.BossDamage = 0
    end
    moat_BeginRoundBossHooks()
end)