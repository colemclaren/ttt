

util.AddNetworkString("FFA_I_Just_Joined")
util.AddNetworkString("FFA_Begin")
util.AddNetworkString("FFA_End")
util.AddNetworkString("FFA_NewKills")
util.AddNetworkString("FFA_Prep")
util.AddNetworkString("FFA_Kill")
util.AddNetworkString("FFA_KStreak")


MG_FFA = MG_FFA or {}
MG_FFA.Hooks = MG_FFA.Hooks or {}
MG_FFA.Players = MG_FFA.Players or {}
MG_FFA.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_FFA.DefaultLoadout = {
}
MG_FFA.Loadout = {}
MG_FFA.FFAOver = false
MG_FFA.KillsMax = 50
MG_FFA.InProgress = MG_FFA.InProgress or false
MG_FFA.TimeEnd = MG_FFA.TimeEnd or 0

function MG_FFA.HookAdd(event, func)
    hook.Add(event, "MG_FFA_" .. event, func)
    table.insert(MG_FFA.Hooks, {event, "MG_FFA_" .. event})
end

function MG_FFA.RemoveHooks()
	for k, v in pairs(MG_FFA.Hooks) do
		hook.Remove(v[1], v[2])
	end
end

function MG_FFA:DoEnding(force)
	if (MOAT_MINIGAMES.CantEnd()) then return end

    MG_FFA.RemoveHooks()
    MG_FFA.ResetVars()
    MG_FFA.HandleDamageLogStuff(true)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "MG_FFA_DELAYWIN")
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    MG_FFA.InProgress = false
    timer.Remove("FFA.SpawnPoints")
end

function MG_FFA.ResetVars()
    MG_FFA.Hooks = {}
    MG_FFA.Players = {}
	MG_FFA.Loadout = {
	}
end

function MG_FFA.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_FFA.DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
            if (v.SetZoom) then
                v:SetZoom(false)
            end
            if (v.SetIronSights) then
                v:SetIronsights(false)
            end

            if (IsValid(ply)) then
				ply:StripWeapon(v:GetClass())
			end
        end
    end
end

function MG_FFA.GiveAmmo(ply)
    for k, v in pairs(MG_FFA.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end


function MG_FFA.PreventLoadouts()
    return true
end

function MG_FFA.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_FFA.DoKill(ply)
    local mk = MG_FFA.Kills()
    ply.FFAKills = ply.FFAKills + 1
    if ply.FFAKills > mk then
        net.Start("FFA_NewKills")
        net.WriteInt(MG_FFA.Kills(),8)
        net.Broadcast()
    end
end

function MG_FFA.PlayerDeath(vic, inf, att)
	timer.Simple(5, function()
        if not IsValid(vic) then return end
		MG_FFA.RespawnPlayer(vic)
	end)
    print("Death",vic,att)
	if (att == vic) then return end
	if (att ~= vic and att:IsPlayer()) then
        MG_FFA.DoKill(att)
        vic:SetCredits(0)
        timer.Simple(1,function()
            if not IsValid(att) then return end
            att:SetCredits(0)
        end)

        net.Start("FFA_Kill")
        net.WriteEntity(att)
        net.WriteBool(att:GetRole() == ROLE_DETECTIVE)
        net.WriteEntity(vic)
        net.WriteBool(vic:GetRole() == ROLE_DETECTIVE)
        net.Broadcast()
	end
end

function MG_FFA.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_FFA.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end

function MG_FFA.Move(ply,mv)
    if mv:GetButtons() ~= 0 then
        ply.T_Moved = CurTime() + 7.5
    end
end

function MG_FFA.RespawnPlayer(ply)
    if (not IsValid(ply)) then return end

	local indx = ply:EntIndex()
    timer.Create("respawn_player"..indx, 0.1, 0, function()
        if (not IsValid(ply)) then timer.Remove("respawn_player"..indx) return end
		if (not MG_FFA.InProgress) then timer.Remove("respawn_player"..indx) return end

        local corpse = MG_FFA.FindCorpse(ply)
        if (corpse) then 
            MG_FFA.RemoveCorpse(corpse)
        end
        if (ply.T_Moved or 0) > CurTime() then
            ply:SpawnForRound(true)
            ply:SetRole(ROLE_INNOCENT)
        end

        if (ply:IsActive()) then timer.Remove("respawn_player"..indx) return end
    end)
end
local item_kind_codes = {
    ["tier"] = "1"
}
function MG_FFA.GiveWeapon(ply,v)
    if not istable(v) then ply:Give(v) return end
	local weapon_table = {}

    if (v.w) then
        weapon_table = weapons.Get(v.w)
    end

    for k2, v2 in pairs(ply:GetWeapons()) do
        if (v2.Kind == weapon_table.Kind) then
            ply:StripWeapon(v2.ClassName)
        end
    end

    local v3 = ply:Give(v.w)
    local wpn_tbl = v3:GetTable()
	local item_old = table.Copy(v.item)

    m_ApplyWeaponMods(v3, v, v.item)
    v3:SetClip1(wpn_tbl.Primary.DefaultClip)
    wpn_tbl.UniqueItemID = v.c
    wpn_tbl.PrimaryOwner = ply
    net.Start("MOAT_UPDATE_WEP")
    net.WriteString(v.w)
    if not ply.TDM_Cache then ply.TDM_Cache = {} end
    net.WriteUInt(v3:EntIndex(), 16)
    if not ply.TDM_Cache[v.w] then
        net.WriteBool(true)
        
        if (v.t) then
            v.Talents = GetItemTalents(v)
        end
		table.removeFunctions(v)

		ply.TDM_Cache[v.w] = table.Copy(v or {}) or {}
        net.WriteTable(v or {})

		v.item = item_old
    else
		net.WriteBool(false)
	end
    net.Send(ply)

    if (wpn_tbl.Primary.Ammo and wpn_tbl.Primary.ClipSize and ply:GetAmmoCount(wpn_tbl.Primary.Ammo) < wpn_tbl.Primary.ClipSize) then
        ply:GiveAmmo(wpn_tbl.Primary.ClipSize, wpn_tbl.Primary.Ammo, true)
    end
end

function MG_FFA.GiveWeapons(ply)
    MG_FFA.StripWeapons(ply)
	MG_FFA.GiveWeapon(ply,MG_FFA.Loadout.prim)
    MG_FFA.GiveWeapon(ply,MG_FFA.Loadout.sec)

    timer.Simple(0,function()
        for k,v in pairs(ply:GetWeapons()) do
            function v:PreDrop()
                self:Remove()
            end
            v.AllowDrop = false
        end
        if not istable(MG_FFA.Loadout.prim) then
            ply:SelectWeapon(MG_FFA.Loadout.prim)
        else
            ply:SelectWeapon(MG_FFA.Loadout.prim.w or "")
        end
    end)
end

local sp_time = 5

function MG_FFA.StartCommand(ply,cmd)
    if not ply:Alive() then return end
    if ply.SpawnProtection then
        if cmd:KeyDown(IN_ATTACK) then
            ply.SpawnProtection = false
            ply:SetRenderMode(RENDERMODE_NORMAL)
            ply:SetColor(Color(255,255,255,255))
            timer.Simple(1,function()
                ply:SetColor(Color(255,255,255,255))
            end)
            ply:SetNW2Int("MG_FFA_SPAWNPROTECTION",0)
        end
    end
end

function MG_FFA.PlayerSpawn(ply)
    ply:ResetEquipment()
    ply:SetCredits(0)
    timer.Simple(0,function() MG_FFA.GiveWeapons(ply) end)
    MG_FFA.GiveAmmo(ply)
    ply:ShouldDropWeapon(false)
    ply.KillStreak = 0
    ply.SpawnProtection = true
    ply:SetNW2Int("MG_FFA_SPAWNPROTECTION",CurTime() + sp_time)
    ply:SetRenderMode(RENDERMODE_TRANSALPHA)
    timer.Simple(0.1,function()
        ply:ResetEquipment()
        ply:SetColor(Color(255,255,255,100))
    end)
    timer.Simple(1,function()
        if not IsValid(ply) then return end
        ply:SetColor(Color(255,255,255,100))
    end)
    timer.Simple(sp_time,function()
        if not IsValid(ply) then return end
        if not ply.SpawnProtection then return end
        ply.SpawnProtection = false
        ply:SetRenderMode(RENDERMODE_NORMAL)
        ply:SetColor(Color(255,255,255,255))
    end)
end
local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
function MG_FFA.Win()
    timer.Simple(25, function() MG_FFA:DoEnding() end)
    --print("WIN:",team)
    net.Start("FFA_End")
    local t = {}
    for k,v in pairs(MG_FFA.Players) do
        if not IsValid(v) then continue end
        table.insert(t,{v,math.Round(v.FFAKills)})
    end
    table.sort(t,function(a,b) return a[2] > b[2] end)
    net.WriteTable(t)
    net.Broadcast()

    timer.Simple((0.2 * ((#t - 3) + 0.5 ) + (4.5)),function()
        for k, v in ipairs(t) do
            if not IsValid(v[1]) then continue end
            if v[1]:IsBot() then continue end
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

function MG_FFA.Kills()
    local t = {}
    for k,v in pairs(MG_FFA.Players) do
        if not IsValid(v) then continue end
        table.insert(t,{v,math.Round(v.FFAKills)})
    end
    table.sort(t,function(a,b) return a[2] > b[2] end)
    return t[1][2],t[1][1]
end


function MG_FFA.Think()
    if not MG_FFA.InProgress then return end

    if (MG_FFA.Kills() >= MG_FFA.KillsMax) then
        MG_FFA.InProgress = false
        MG_FFA.Win(e)
	end

    if MG_FFA.TimeEnd < CurTime() then
        MG_FFA.InProgress = false
        MG_FFA.Win()
    end
end

function MG_FFA.TakeDamage(ply, dmginfo)
    if (IsValid(ply) and ply:IsPlayer() and dmginfo:GetDamage() >= 1 and dmginfo:GetAttacker():IsPlayer() and GetRoundState() == ROUND_ACTIVE ) then
        local att = dmginfo:GetAttacker()
        if (not att.FFADamage) then
            att.FFADamage = 0
        end
        if (ply.SpawnProtection and att:IsPlayer() and (ply ~= att)) or (att.SpawnProtection and ply:IsPlayer() and (ply ~= att)) then return end
        --print(ply:Health(),"Add: ",(math.min(dmginfo:GetDamage(),ply:Health())))
        att.FFADamage = att.FFADamage + (math.min(dmginfo:GetDamage(),ply:Health()))
    end
end

function MG_FFA.PlayerShouldTakeDamage(ply,ent)
    if ply.SpawnProtection or ent.SpawnProtection then
        return false
    end
    if (((not ent:IsPlayer()) and (not ent:IsWorld())) or GetRoundState() == ROUND_PREP) then return false end
end

function MG_FFA.KarmaStuff()
    return true
end

function MG_FFA.PlayerDisconnected(ply)

end

function MG_FFA.PrepRound(mk, pri, sec, creds)
	MG_FFA.FFAOver = false
	MG_FFA.HandleDamageLogStuff(false)

    for k, v in pairs(player.GetAll()) do
        MG_FFA.StripWeapons(v)
        v:StripAmmo()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_FFA.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end

	MG_FFA.HookAdd("MoatInventoryShouldGiveLoadout", MG_FFA.PreventLoadouts)
	MG_FFA.HookAdd("ttt.BeginRound", MG_FFA.BeginRound)
	MG_FFA.HookAdd("CanPlayerSuicide", function(ply) return true end)
    MG_FFA.HookAdd("PlayerDeath",MG_FFA.PlayerDeath)
    MG_FFA.HookAdd("PlayerSpawn",MG_FFA.PlayerSpawn)
    MG_FFA.HookAdd("Think",MG_FFA.Think)
    MG_FFA.HookAdd("EntityTakeDamage",MG_FFA.TakeDamage)
    MG_FFA.HookAdd("PlayerShouldTakeDamage",MG_FFA.PlayerShouldTakeDamage)
    MG_FFA.HookAdd("Move",MG_FFA.Move)
    MG_FFA.HookAdd("TTTKarmaGivePenalty", MG_FFA.KarmaStuff)
    MG_FFA.HookAdd("PlayerDisconnected", MG_FFA.PlayerDisconnected)
    MG_FFA.HookAdd("StartCommand", MG_FFA.StartCommand)
    MG_FFA.HookAdd("TTTCanUseTraitorButton",function() return false end)
    MG_FFA.SpawnPoints = {}
    timer.Create("FFA.SpawnPoints",5,0,MG_FFA.TrackSpawnPoints)

    hook.Add("TTTCheckForWin", "MG_FFA_DELAYWIN", function() return WIN_NONE end)

    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_FFA.StripWeapons(v)
        v:StripAmmo()
        v.TDM_Cache = {}
        v.FFAKills = 0
    end

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Free For All")
end

function MG_FFA.DecideTeams(pls)
    MG_FFA.Players = {}

	for i,v in RandomPairs(player.GetAll()) do
		table.insert(MG_FFA.Players, v)

		v:SetRole(ROLE_INNOCENT)
	end
end

function MG_FFA.BeginRound()
    SetRoundEnd(CurTime() + 900)
    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_FFA.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    for k,v in pairs(player.GetAll()) do
        v.FFAKills = 0
    end
    MG_FFA.InProgress = true
    MG_FFA.TimeEnd = CurTime() + (60 * 10)
    net.Start("FFA_Begin")
    net.WriteInt(MG_FFA.KillsMax,8)
    net.Broadcast()

    local pls = player.GetAll()

    for k, v in pairs(pls) do
        MG_FFA.StripWeapons(v)
        v:StripAmmo()
        MG_FFA.GiveWeapons(v)
        MG_FFA.GiveAmmo(v)
        v.KillStreak = 0
        v.FFADamage = 0
    end

    MG_FFA.DecideTeams(pls)
    print("Begin round")
end

concommand.Add("moat_start_FFA", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end


    local max_kills = tonumber(args[1]) or 25
    max_kills = math.max(0,math.min(max_kills,30)) -- max kills
    MG_FFA.KillsMax = max_kills
    print("mk:" .. max_kills)

    local prim_wep = args[2] or "weapon_ttt_m16"
    if prim_wep == "self" then
        prim_wep = ply:EntIndex()
    elseif prim_wep == "randomply" then
        for k, v in RandomPairs(player.GetAll()) do
            if (v:Team() ~= TEAM_SPEC) then
                 prim_wep = v:EntIndex()
                 break
            end
        end
    elseif player.GetBySteamID(prim_wep) then
        prim_wep = player.GetBySteamID(prim_wep):EntIndex()
    end
    local opp = prim_wep
    if isnumber(tonumber(prim_wep)) then
        if IsPlayer(Entity(prim_wep)) then
            local pri_wep, _, _, _, _ = m_GetLoadout(Entity(prim_wep))
            if istable(pri_wep) and pri_wep.w then
                prim_wep = pri_wep
            else
                prim_wep = "weapon_ttt_m16"
            end
        else
            prim_wep = "weapon_ttt_m16"
        end
    end

    MG_FFA.Loadout.prim = prim_wep

    local sec_wep = args[3] or "weapon_zm_revolver"
    if sec_wep == "self" then
        sec_wep = ply:EntIndex()
    elseif sec_wep == "randomply" then
        for k, v in RandomPairs(player.GetAll()) do
            if (v:Team() ~= TEAM_SPEC) then
                 sec_wep = v:EntIndex()
                 break
            end
        end
    elseif player.GetBySteamID(sec_wep) then
        sec_wep = player.GetBySteamID(sec_wep):EntIndex()
    end
    local osp = sec_wep
    if isnumber(tonumber(sec_wep)) then
        if IsPlayer(Entity(sec_wep)) then
            local _, seco_wep, _, _, _ = m_GetLoadout(Entity(sec_wep))
            if istable(seco_wep) and seco_wep.w then
                sec_wep = seco_wep
            else
                sec_wep = "weapon_zm_revolver"
            end
        else
            sec_wep = "weapon_zm_revolver"
        end
    end

    MG_FFA.Loadout.sec = sec_wep

    ttt.ExtendPrep()

    net.Start("FFA_Prep")
    net.WriteInt(max_kills,8)
    local p = prim_wep
    if istable(p) then
        local name = p.item.Name .. " " .. weapons.Get(p.w).PrintName or "????"
        p = Entity(opp):Nick() .. "'s " .. name
    else
        p = "a " .. weapons.Get(p).PrintName or "????"
    end
    net.WriteString(p)
    local p = sec_wep
    if istable(p) then
        local name = p.item.Name .. " " .. weapons.Get(p.w).PrintName or "????"
        p = Entity(osp):Nick() .. "'s " .. name
    elseif (p ~= "nothing") then
        p = "a " .. weapons.Get(p).PrintName or "????"
    end
    net.WriteString(p)
    net.Broadcast()

    MG_FFA.PrepRound(max_kills)
end)

concommand.Add("moat_end_FFA", function(ply, cmd, args)
    if (not allowed_ids[ply:SteamID()]) then

        return
    end

    MG_FFA.InProgress = false
    MG_FFA.Win()
end)


function MG_FFA.TrackSpawnPoints() 
    if not MG_FFA.SpawnPoints then MG_FFA.SpawnPoints = {} end
    for k,v in ipairs(player.GetAll()) do
        if v:Alive() and v:IsOnGround() and (not v:IsSpec()) and (not v:Crouching()) then
            table.insert(MG_FFA.SpawnPoints,v:GetPos())
        end
    end
end

--make a custom spawnpoint func
hook.Add("PostGamemodeLoaded", "MG_FFA_POSTGAMEMODE", function()
    function GAMEMODE:IsSpawnpointSuitable(ply, spwn, force, rigged)
        if not IsValid(ply) or not ply:IsTerror() then return true end

        timer.Simple(0,function() -- Next frame
            if not IsValid(ply) then return end
            if not MG_FFA.InProgress then return end
            if not MG_FFA.SpawnPoints then return end
            for _,v in RandomPairs(MG_FFA.SpawnPoints) do
                local i = false
                for _,p in ipairs(player.GetAll()) do
                    if p:GetPos():Distance(v) < 10 then i = true break end
                    if p:GetPos():Distance(v) < 500 and p:Alive() then 
                        i = true
                        --print("Enemy in spawn point, skipping")
                        break 
                    end
                end
                if not (i) then
                    ply:SetPos(v)
                    --print("Found spawnpoint with no enemies")
                    return
                end
            end

        end)

        if not rigged and (not IsValid(spwn) or not spwn:IsInWorld()) then return false end

    -- spwn is normally an ent, but we sometimes use a vector for jury rigged
    -- positions
        local pos = rigged and spwn or spwn:GetPos()

        if not util.IsInWorld(pos) then return false end

        local blocking = ents.FindInBox(pos + Vector( -16, -16, 0 ), pos + Vector( 16, 16, 64 ))

        for k, p in pairs(blocking) do
            if IsValid(p) and p:IsPlayer() and p:IsTerror() and p:Alive() then
                if force then
                    p:Kill()
                else
                    return false
                end
            end
        end

        return true
    end
end)