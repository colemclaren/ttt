util.AddNetworkString("MOAT_PREP_STALKER")
util.AddNetworkString("MOAT_BEGIN_STALKER")
util.AddNetworkString("MOAT_END_STALKER")
MOAT_ACTIVE_BOSS = false
MOAT_BOSS_CUR = nil
local MOAT_BOSS_DMG = {}
local MOAT_ROUND_OVER = false
local MOAT_BOSS_MODEL = "models/player/zombie_fast.mdl"
local MOAT_DEATHCLAW_WPN = nil
local MOAT_BOSS_HP_MULTIPLIER = 90
local MOAT_BOSS_KNIFE = 45
local DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
    ["weapon_zm_carry"] = true,
    ["weapon_ttt_knifestalker"] = true
}

local function moat_EndRoundBossHooks()
	if (MOAT_MINIGAMES.CantEnd()) then return end

    if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR)) then
		net.Start("MOAT_PLAYER_CLOAKED")
		net.WriteEntity(MOAT_BOSS_CUR)
		net.WriteBool(false)
		net.Broadcast()

		MOAT_BOSS_CUR:SetColor(Color(255, 255, 255, 255))
		MOAT_BOSS_CUR:GodDisable()
		MOAT_BOSS_CUR:SetNW2Bool("disguised", false)
		MOAT_BOSS_CUR:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		MOAT_BOSS_CUR.SpeedMod = 1
    end

    -- Remove our hooks
    hook.Remove("ttt.BeginRound", "moat_BossBeginRound")
    hook.Remove("EntityTakeDamage", "moat_BossSaveDamage")
    hook.Remove("PostPlayerDeath", "moat_BossDeath")
    hook.Remove("EntityTakeDamage", "moat_BossPreventDamage")
    hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
    hook.Remove("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss")
    hook.Remove("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout")
    hook.Remove("EntityTakeDamage", "moat_StopFallDamage")
    hook.Remove("PlayerDeath", "moat_BossKnife")
    hook.Remove("PlayerCanPickupWeapon", "moat_RestrictWeaponPickup")
    hook.Remove("PlayerSwitchWeapon", "moat_RestrictWeaponSwitch")
    hook.Remove("Think", "moat_JetpackVelocity")
    hook.Remove("PlayerDisconnected", "moat_BossDisconnect")
	hook.Remove("SetupPlayerVisibility", "moat_BossVisibility")
	hook.Remove("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents")
	hook.Remove("PlayerShouldTakeDamage", "moat_BossPreventDamage")
    hook.Remove("ShouldCollide", "moat_BossCollide")

    MOAT_ACTIVE_BOSS = false
    MOAT_BOSS_CUR = nil
    MOAT_DEATHCLAW_WPN = nil
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    MOAT_BOSS_HP_MULTIPLIER = 90
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "moat_BossDelayWin")
end

local function moat_EndRoundHandler()
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
            pl:SetNW2Bool("body_found", true)
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

    net.Start("MOAT_END_STALKER")
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

    hook.Add("ttt.BeginRound", "moat_BossBeginRound", function()
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

        net.Start("MOAT_BEGIN_STALKER")
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

		hook.Add("SetupPlayerVisibility", "moat_BossVisibility", function()
            AddOriginToPVS(MOAT_BOSS_CUR:GetPos())
        end)

        timer.Simple(3, function()
            local hp = (#pls) * MOAT_BOSS_HP_MULTIPLIER
            boss:SetModel(MOAT_BOSS_MODEL)
            boss:SetHealth(hp)
            boss:SetMaxHealth(hp)
            boss:GodDisable()
            boss.SpeedMod = 1.5
            boss:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			boss:SetRenderMode(RENDERMODE_TRANSALPHA)
			boss:SetColor(Color(255, 255, 255, 0))
			boss:SetNW2Bool("disguised", true)

			net.Start("MOAT_PLAYER_CLOAKED")
			net.WriteEntity(boss)
			net.WriteBool(true)
			net.Broadcast()

            boss:Give("weapon_ttt_knifestalker")
            boss:SelectWeapon("weapon_ttt_knifestalker")

			for k, v in pairs(boss:GetWeapons()) do
                if (not DefaultLoadout[v:GetClass()]) then boss:StripWeapon(v:GetClass()) end
            end

			boss:SelectWeapon("weapon_ttt_knifestalker")
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

			local function HandleWeaponsAndAmmo()
				if (not IsValid(v)) then return end

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
			end

			timer.Simple(0, HandleWeaponsAndAmmo)
			timer.Simple(2, HandleWeaponsAndAmmo)
        end

        timer.Simple(1, function()
            MuteForRestart(true)
            cdn.PlayURL("https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt10.mp3")
		end)

        timer.Simple(10, function()
			if (not MOAT_EASTER.SpawnPositions) then return end
            local pos = MOAT_EASTER.SpawnPositions[math.random(1, #MOAT_EASTER.SpawnPositions)]
			if (not pos or not isvector(pos)) then return end

            local ent = ents.Create("sent_egg")
            ent:SetPos(pos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
            ent:Spawn()

            BroadcastLua([[chat.AddText(Material("icon16/information.png"), Color(255, 255, 0),"AN EASTER EGG HAS SPAWNED ON THE MAP!!!" )]])
			cdn.PlayURL("https://static.moat.gg/servers/tttsounds/stalker/stalker_easteregg.mp3")
        end)

		timer.Create("moat_boss_voices", 30, 0, function()
			cdn.PlayURL(table.Random({
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt1.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt2.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt3.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt4.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt5.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt6.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt7.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt8.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt9.mp3",
				"https://static.moat.gg/servers/tttsounds/stalker/stalker_taunt10.mp3",
			}), 2)
        end)

        timer.Simple(5, function()
            MuteForRestart(false)
        end)

        hook.Add("EntityTakeDamage", "moat_StopFallDamage", function(ent, dmginfo)
            if (MOAT_BOSS_CUR and ent == MOAT_BOSS_CUR and dmginfo:IsFallDamage()) then
                return true
            end
        end)

        hook.Add("Think", "moat_JetpackVelocity", function()
            if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR) and MOAT_BOSS_CUR:Team() ~= TEAM_SPEC and MOAT_BOSS_CUR:KeyDown(IN_JUMP)) then
                MOAT_BOSS_CUR:SetVelocity(MOAT_BOSS_CUR:GetUp() * 25)
            end
        end)

        SetRoundEnd(CurTime() + 99999)

        timer.Simple(5, function() 
            for k, v in ipairs(player.GetAll()) do
                v:Freeze(false)
                v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            end
			if (not IsValid(MOAT_BOSS_CUR)) then return end

			net.Start("MOAT_PLAYER_CLOAKED")
            net.WriteEntity(MOAT_BOSS_CUR)
            net.WriteBool(true)
            net.Broadcast()

            MOAT_BOSS_CUR:GiveEquipmentItem(EQUIP_RADAR)
            MOAT_BOSS_CUR:ConCommand("ttt_radar_scan")
        end)

		local tmr = MOAT_BOSS_CUR:EntIndex()
		timer.Create("moat_check_boss" .. tmr, 0.1, 0, function()
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
        if (IsValid(ply) and IsValid(att) and ply:IsPlayer() and dmginfo:GetDamage() >= 0 and att:IsPlayer() and GetRoundState() == ROUND_ACTIVE and MOAT_BOSS_CUR and ply == MOAT_BOSS_CUR and not MOAT_BOSS_CUR:HasGodMode()) then
			if (MOAT_BOSS_CUR and IsValid(MOAT_BOSS_CUR) and MOAT_BOSS_CUR == att) then return end

            if (not att.BossDamage) then
                att.BossDamage = 0
            end

            att.BossDamage = att.BossDamage + dmginfo:GetDamage()

			SHR:SendHitEffects(att, dmginfo:GetDamage(), dmginfo:GetDamagePosition())

			net.Start("moat.damage")
            net.WriteUInt(dmginfo:GetDamage(), 16)
            net.Send(att)
        end
    end)

	hook.Add("EntityTakeDamage", "moat_BossPreventDamage", function(ent, dmg)
		if (not IsValid(ent) or not ent:IsPlayer()) then return end
		if (not IsValid(MOAT_BOSS_CUR) or ent == MOAT_BOSS_CUR) then return end
		-- if (dmg:IsBulletDamage() or dmg:IsExplosionDamage()) then
			if (dmg:IsExplosionDamage()) then dmg:SetDamage(0) return true end

			local att = dmg:GetAttacker()
			if (not IsValid(att)) then return end
			att = (not att:IsPlayer() and att:GetOwner() and IsValid(att:GetOwner())) and att:GetOwner() or att

			if (IsValid(att) and att:IsPlayer() and att:GetRole() == ent:GetRole()) then
				dmg:SetDamage(0)
				return true
			end
		-- end
    end)

	hook.Add("PlayerShouldTakeDamage", "moat_BossPreventDamage", function(pl1, pl2)
        if (pl1:IsPlayer() and pl2:IsPlayer() and pl1:GetRole() == pl2:GetRole()) then
            return false
        end
    end)

    hook.Add("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss", function(ply, penalty, vic)
        return true
    end)

    hook.Add("PlayerDeath", "moat_BossKnife", function(ply, inf, att)
        if(att == MOAT_BOSS_CUR and not MOAT_ROUND_OVER) then
			if (not MOAT_EASTER.SpawnPositions) then return end
            local pos = MOAT_EASTER.SpawnPositions[math.random(1, #MOAT_EASTER.SpawnPositions)]
            if (not pos or not isvector(pos)) then return end

            local ent = ents.Create("sent_egg")
            ent:SetPos(pos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
            ent:Spawn()

            BroadcastLua([[chat.AddText(Material("icon16/information.png"), Color(255, 255, 0),"AN EASTER EGG HAS SPAWNED ON THE MAP!!!" )]])
           	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/stalker/stalker_easteregg.mp3")
        end
    end)

    hook.Add("PlayerCanPickupWeapon", "moat_RestrictWeaponPickup", function(ply, wep)
        if (ply == MOAT_BOSS_CUR and not DefaultLoadout[wep:GetClass()]) then
            return false
        end
    end)

    hook.Add("PlayerSwitchWeapon", "moat_RestrictWeaponSwitch", function(ply, owep, neww)
        if (ply == MOAT_BOSS_CUR and not DefaultLoadout[neww:GetClass()]) then
            return true
        end
    end)

	hook.Add("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents", function(att, vic)
		return att:GetRole() == vic:GetRole()
	end)

	hook.Add("ShouldCollide", "moat_BossCollide", function(e1, e2)
		if (IsValid(MOAT_BOSS_CUR) and ((e1 == MOAT_BOSS_CUR and e2.Collided) or (e2 == MOAT_BOSS_CUR and e1.Collided))) then return false end
	end)

	hook.Add("PostPlayerDeath", "moat_BossDeath", moat_BossPlayerDeath)
end

function moat_start_stalker_round(ply, args)
	if (not IsValid(ply) and MSE.Player) then ply = MSE.Player end

    local chosen = args[1]
    MOAT_DEATHCLAW_WPN = args[2]

    if (MOAT_DEATHCLAW_WPN) then
        MOAT_BOSS_HP_MULTIPLIER = 350

        for k , v in pairs(ents.GetAll()) do
            if (IsValid(v) and v:GetClass():StartWith("weapon_") and not DefaultLoadout[v:GetClass()]) then
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

    net.Start("MOAT_PREP_STALKER")
    net.Broadcast()

    ttt.ExtendPrep()

    MOAT_ACTIVE_BOSS = true
    MOAT_BOSS_CUR = chosen
    MOAT_BOSS_DMG = {}
    MOAT_ROUND_OVER = false
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Stalker Boss")
    for k, v in pairs(player.GetAll()) do
        v.BossDamage = 0
    end

    moat_BeginRoundBossHooks()
end

concommand.Add("moat_start_stalker", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    moat_start_stalker_round(ply, args)
end)


-- hook.Add("TTTPrepareRound", "moat_StartHunterGame", function()
--     local random_chance = math.random(1, 20)

--     if (#player.GetAll() > 7 and random_chance == 10 and GetGlobalInt("ttt_rounds_left") < 8) then
--         timer.Simple(5, function() moat_start_stalker_round("na", {"random"}) end)
--     end
-- end)