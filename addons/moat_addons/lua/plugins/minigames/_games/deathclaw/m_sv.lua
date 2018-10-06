util.AddNetworkString("MOAT_PREP_BOSS")
util.AddNetworkString("MOAT_BEGIN_BOSS")
util.AddNetworkString("MOAT_END_BOSS")
MOAT_ACTIVE_BOSS = false
local MOAT_BOSS_CUR = nil
local MOAT_BOSS_DMG = {}
local MOAT_ROUND_OVER = false
local MOAT_BOSS_MODEL = "models/deathclaw_player/deathclaw_player_glowing.mdl"
local MOAT_DEATHCLAW_WPN = nil
local MOAT_BOSS_HP_MULTIPLIER = 500
local DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
    ["weapon_zm_carry"] = true
}

local function moat_EndRoundBossHooks()
	if (MOAT_MINIGAMES.CantEnd()) then return end

    -- Remove our hooks
    hook.Remove("tt.BeginRound", "moat_BossBeginRound")
    hook.Remove("EntityTakeDamage", "moat_BossSaveDamage")
    hook.Remove("PostPlayerDeath", "moat_BossDeath")
    hook.Remove("EntityTakeDamage", "moat_BossPreventDamage")
    hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
    hook.Remove("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss")
    hook.Remove("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout")
    hook.Remove("PlayerDisconnected", "moat_BossDisconnect")
	hook.Remove("PlayerFootstep", "moat_ScreenShake")
	hook.Remove("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents")

    MOAT_ACTIVE_BOSS = false
    MOAT_BOSS_CUR = nil
    MOAT_DEATHCLAW_WPN = nil
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_BOSS_HP_MULTIPLIER = 650
    MOAT_MINIGAME_OCCURING = false
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "moat_BossDelayWin")
end

function GetAlivePlayers()
    local num = 0

    for k, v in ipairs(player.GetAll()) do
        if (not IsValid(v) or v:Team() == TEAM_SPEC) then continue end
        num = num + 1
    end

    return num
end

local function moat_EndRoundHandler()
    if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR)) then
        MOAT_BOSS_CUR:SetModelScale(1, 0)
    end

    moat_EndRoundBossHooks()
end

local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}

local function moat_BossPlayerDeath(ply)
	if (not MOAT_ACTIVE_BOSS) then return end
	if (MOAT_ROUND_OVER or GetRoundState() ~= ROUND_ACTIVE) then return end
	local IS_BOSS, ALIVE = false, GetAlivePlayers()
	if (type(ply) == "string" and ply == "boss") then
		IS_BOSS = true
	else
		IS_BOSS = IsValid(MOAT_BOSS_CUR) and MOAT_BOSS_CUR == ply
	end

	if (IS_BOSS or ALIVE <= 1) then
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
            pl:SetNWBool("body_found", true)
            CORPSE.SetFound(ply.server_ragdoll, true)
            ply.server_ragdoll:Remove()
    	end)

		return
	end

    net.Start("moat.damage.reset")
    net.Broadcast()

    for k, v in pairs(player.GetAll()) do
        if (IsValid(v) and v.BossDamage and v.BossDamage > 1) then
            table.insert(MOAT_BOSS_DMG, {v:Nick(), v.BossDamage, v:EntIndex()})
        end
    end

    net.Start("MOAT_END_BOSS")
    net.WriteBool(IS_BOSS)
    net.WriteTable(MOAT_BOSS_DMG)
    net.Broadcast()

    timer.Remove("moat_boss_voices")

    timer.Simple(20, function()
        moat_EndRoundHandler()
    end)

    if (not IS_BOSS) then
        if (IsValid(MOAT_BOSS_CUR)) then
            MOAT_BOSS_CUR:m_DropInventoryItem(math.random(5,6))
        end
        return
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
end

local function moat_BeginRoundBossHooks()
    hook.Add("PlayerDisconnected", "moat_BossDisconnect", function(pl)
        hook.Run("PostPlayerDeath", pl)
    end)

    hook.Add("tt.BeginRound", "moat_BossBeginRound", function()
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
        		chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU ARE THE BOSS!!!" )]])
    		end

			MOAT_BOSS_CUR = chosen
		end

		net.Start("MOAT_BEGIN_BOSS")
        net.WriteEntity(MOAT_BOSS_CUR)
        net.Broadcast()

        if (MOAT_DEATHCLAW_WPN) then
            for k , v in pairs(ents.GetAll()) do
                if (IsValid(v) and v:GetClass():StartWith("weapon_") and not DefaultLoadout[v:GetClass()]) then
                    v:Remove()
                end
            end
        end

        local boss = MOAT_BOSS_CUR
        boss:GodEnable()
        if (boss:GetRole() ~= ROLE_TRAITOR) then
            boss:SetRole(ROLE_TRAITOR)
        end
		boss:SetCredits(0)

        timer.Simple(3, function()
            local hp = (#pls) * MOAT_BOSS_HP_MULTIPLIER
            boss:SetModel(MOAT_BOSS_MODEL)
            boss:SetModelScale(2, 1)
            boss:SetHealth(hp)
            boss:SetMaxHealth(hp)
            boss:GodDisable()
        end)

        local healers = {}
        for k, v in RandomPairs(pls) do
			v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			v:Freeze(true)

			if (v ~= boss and v:GetRole() ~= ROLE_INNOCENT) then
                v:SetRole(ROLE_INNOCENT)
            end

			local healer = false
            if (v ~= boss and #healers < math.ceil(#pls / 4)) then
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
                    	v:GiveAmmo(999, v2.Primary.Ammo)
                	end
            	end

				if (healer) then
					v:Give("weapon_ttt_health_station")
				end
			end)
        end

        timer.Simple(1, function()
            MuteForRestart(true)
			cdn.PlayURL(table.Random({
				"https://cdn.moat.gg/f/9ZVqpi9q4sbDs97keRh58zMHU4Fx.mp3",
				"https://cdn.moat.gg/f/d9HxwkUgQwLjlHh0Bf7IuUFHqKP9.mp3",
				"https://cdn.moat.gg/f/DDMkTBCubdG8eRJi6xJqIM6oxw39.mp3",
				"https://cdn.moat.gg/f/tz7cKLTDZaGa4mOXOydTBXAs0Yrq.mp3"
			}), 2)
		end)

        timer.Create("moat_boss_voices", 30, 0, function()
			cdn.PlayURL(table.Random({
				"https://cdn.moat.gg/f/6XnW831bWenJx68WhjmVxZQzJZyM.mp3",
				"https://cdn.moat.gg/f/pEbmUc61njR1ln1jAKW4OeAGmLtX.mp3",
				"https://cdn.moat.gg/f/7nDZ4fmH30oKz7jyIkjAXhoy3txB.mp3",
				"https://cdn.moat.gg/f/4K08jYuzVsx61jf9VB5HvCy1bizP.mp3",
				"https://cdn.moat.gg/f/zEVBhbDi0gbQCjSPnd9o1eTrngFr.mp3",
				"https://cdn.moat.gg/f/MyW0YV0HMlOPWx9pae4BkZEyZBNK.mp3",
				"https://cdn.moat.gg/f/ldN1LMM19arhjB21FjI4VeH9b47m.mp3",
				"https://cdn.moat.gg/f/jYQN7fWiON4Aa7fznNRYWDjqtJo6.mp3",
				"https://cdn.moat.gg/f/MEPGEZIb9UZ3fJcre8TOzHMEcYFV.mp3",
				"https://cdn.moat.gg/f/oaUnqPMAyov1o3qInOtDbrClqQ74.mp3",
				"https://cdn.moat.gg/f/rAdgJmmZzmCFxRtqCSZvR3REf2ux.mp3"
			}), 2)
        end)

        timer.Simple(5, function()
            MuteForRestart(false)
        end)

        hook.Add("PlayerFootstep", "moat_ScreenShake", function(ply, pos, foot, sound, vol, rf)
            if (IsValid(MOAT_BOSS_CUR) and ply == MOAT_BOSS_CUR) then
                util.ScreenShake(pos, 5, 5, 0.5, 1500)
            end
            if (GetRoundState() ~= ROUND_ACTIVE) then
                hook.Remove("PlayerFootstep", "moat_ScreenShake")
            end
        end)

        hook.Add("PlayerSwitchWeapon", "moat_HolsteredHide", function(ply, old, new)
            if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR) and ply == MOAT_BOSS_CUR) then
                if (new.Kind == WEAPON_UNARMED) then
                    ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                    ply:SetRenderMode(RENDERMODE_TRANSALPHA)
                    ply:SetColor(Color(255, 255, 255, 0))
                    ply:GodEnable()
                    ply:SetNWBool("disguised", true)

					net.Start("MOAT_PLAYER_CLOAKED")
                    net.WriteEntity(ply)
                    net.WriteBool(true)
                    net.Broadcast()

                    timer.Create("moat_BossInvisDmg".. ply:EntIndex(), 1, 0, function()
                        if (not MOAT_ACTIVE_BOSS) then
                            timer.Remove("moat_BossInvisDmg".. ply:EntIndex())
                            return
                        end
                        if (IsValid(ply)) then
                            if ((ply:Health() - #pls) <= 0) then
                                ply:Kill()
                                timer.Remove("moat_BossInvisDmg".. ply:EntIndex())
                            else
                                ply:SetHealth(ply:Health() - #pls)
                            end
                        end
                    end)
                elseif(IsValid(old) and old.Kind == WEAPON_UNARMED) then
					net.Start("MOAT_PLAYER_CLOAKED")
                    net.WriteEntity(ply)
                    net.WriteBool(false)
                    net.Broadcast()

                    ply:SetColor(Color(255, 255, 255, 255))
                    ply:GodDisable()
                    ply:SetNWBool("disguised", false)
                    ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                    timer.Remove("moat_BossInvisDmg".. ply:EntIndex())
                end
            end
            if (GetRoundState() ~= ROUND_ACTIVE) then
                hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
            end
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

    hook.Add("TTTCheckForWin", "moat_BossDelayWin", function() return WIN_NONE end)

    hook.Add("EntityTakeDamage", "moat_BossSaveDamage", function(ply, dmginfo)
		local att = dmginfo:GetAttacker()
        if (IsValid(ply) and IsValid(att) and ply:IsPlayer() and dmginfo:GetDamage() >= 1 and att:IsPlayer() and GetRoundState() == ROUND_ACTIVE and MOAT_BOSS_CUR and ply == MOAT_BOSS_CUR and not MOAT_BOSS_CUR:HasGodMode()) then
			if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR) and MOAT_BOSS_CUR == att) then return end

            if (not att.BossDamage) then
                att.BossDamage = 0
            end

            net.Start("moat.damage")
            net.WriteUInt(math.Round(dmginfo:GetDamage()), 16)
            net.Send(att)

            att.BossDamage = att.BossDamage + dmginfo:GetDamage()
        end
    end)

    hook.Add("EntityTakeDamage", "moat_BossPreventDamage", function(ent, dmg)
		if (not IsValid(ent) or not ent:IsPlayer()) then return end
		if (not IsValid(MOAT_BOSS_CUR) or ent == MOAT_BOSS_CUR) then return end
		if (dmg:IsBulletDamage() or dmg:IsExplosionDamage()) then
			if (dmg:IsExplosionDamage()) then dmg:SetDamage(0) return true end

			local att = dmg:GetAttacker()
			if (not IsValid(att)) then return end
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

	hook.Add("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents", function(att, vic)
		return att:GetRole() == vic:GetRole()
	end)

    hook.Add("PostPlayerDeath", "moat_BossDeath", moat_BossPlayerDeath)
end

local allowed_ids = {
    ["STEAM_0:0:46558052"] = true,
    ["STEAM_0:1:24643024"] = true,
    ["STEAM_0:1:46918472"] = true,
    ["STEAM_0:1:39556387"] = true,
    ["STEAM_0:0:96933728"] = true
}

concommand.Add("moat_start_boss", function(ply, cmd, args)
    if ((ply ~= NULL and not allowed_ids[ply:SteamID()]) or GetRoundState() ~= ROUND_PREP) then
        return
    end
	if (not IsValid(ply) and MSE.Player) then ply = MSE.Player end


    local chosen = args[1]
    MOAT_DEATHCLAW_WPN = args[2]

    if (MOAT_DEATHCLAW_WPN) then
        MOAT_BOSS_HP_MULTIPLIER = 350

        for k , v in pairs(ents.GetAll()) do
            if (IsValid(v) and v ~= NULL and v:GetClass():StartWith("weapon_") and not DefaultLoadout[v:GetClass()]) then
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

    net.Start("MOAT_PREP_BOSS")
    net.Broadcast()

    tt.ExtendPrep()

    MOAT_ACTIVE_BOSS = true
    MOAT_BOSS_CUR = chosen
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_MINIGAME_OCCURING = true
    for k, v in pairs(player.GetAll()) do
        v.BossDamage = 0
    end

    moat_BeginRoundBossHooks()
end)