util.AddNetworkString("HS_Prep")
util.AddNetworkString("HS_Current")
util.AddNetworkString("HS_Begin")
util.AddNetworkString("HS_Time")
util.AddNetworkString("HS_Prep")
util.AddNetworkString("HS_End")

MG_HS = MG_HS or {}
MG_HS.Hooks = MG_HS.Hooks or {}
MG_HS.Players = MG_HS.Players or {}
MG_HS.DefaultLoadout = {
}
MG_HS.TDMOver = false
MG_HS.InProgress = MG_HS.InProgress or false
MG_HS.TimeEnd = MG_HS.TimeEnd or 0
MG_HS.Players = {}
MG_HS.DeadPlayers = {}
MG_HS.AlivePlayers = {}
function MG_HS.HookAdd(event, func)
    hook.Add(event, "MG_HS_" .. event, func)
    table.insert(MG_HS.Hooks, {event, "MG_HS_" .. event})
end

function MG_HS.RemoveHooks()
	for k, v in pairs(MG_HS.Hooks) do
		hook.Remove(v[1], v[2])
	end
end

function MG_HS:DoEnding(force)
    MG_HS.RemoveHooks()
    MG_HS.ResetVars()
    MG_HS.HandleDamageLogStuff(true)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "MG_HS_DELAYWIN")
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    MG_HS.InProgress = false
end

function MG_HS.ResetVars()
    MG_HS.Hooks = {}
    MG_HS.Players = {}
    MG_HS.AlivePlayers = {}
end

function MG_HS.StripWeapons(ply)
    for k, v in pairs(ply:GetWeapons()) do
        if (not MG_HS.DefaultLoadout[v:GetClass()]) then
            if (v.SetZoom) then
                v:SetZoom(false)
            end
            if (v.SetIronSights) then
                v:SetIronsights(false)
            end
            ply:StripWeapon(v:GetClass())
        end
    end
end


function MG_HS.PreventLoadouts()
    return true
end

function MG_HS.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_HS.DoKill(ply)
    
end

function MG_HS.PlayerDeath(vic, inf, att)
    print("PlayerDeath")
    for k,v in pairs(MG_HS.AlivePlayers) do
        if v == vic then MG_HS.AlivePlayers[k] = nil end
    end
    print("Players Left")
    PrintTable(MG_HS.AlivePlayers)
    vic.HSPlace = (#MG_HS.Players - #MG_HS.DeadPlayers)
	table.insert(MG_HS.DeadPlayers,vic)
    if not vic.KnownDeath then
        if MG_HS.Current == vic then
            MG_HS.Current = table.Random(MG_HS.AlivePlayers)
        end
        if table.Count(MG_HS.AlivePlayers) < 2 then
            MG_HS.Current.HSPlace = 1
            MG_HS.Win()
            MG_HS.InProgress = false
            return
        end
    end
end

function MG_HS.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_HS.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end

function MG_HS.PlayerSpawn(ply)
    ply:ResetEquipment()
    ply:SetCredits(0)
end

local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}

function MG_HS.Win()
    timer.Simple(25, function() MG_HS:DoEnding() end)

    net.Start("HS_End")
    local t = {}
    for k,v in pairs(MG_HS.Players) do
        if not IsValid(v) then continue end
        table.insert(t,{v,math.Round(v.HSPlace)})
    end
    table.sort(t,function(a,b) return a[2] < b[2] end)
    net.WriteTable(t)
    net.Broadcast()

    PrintTable(t)
    
    timer.Simple((0.2 * ((#t - 3) + 0.5 ) + (4.5)),function()
        for k, v in ipairs(t) do
            if not IsValid(v[1]) then continue end
            if (rarity_to_placing[k]) then
                v[1]:m_DropInventoryItem("Holiday Crate")
            else
                v[1]:m_DropInventoryItem(3)
            end
        end
    end)
end

function MG_HS.PlayerSpeed(ply)
    if ply == MG_HS.Current then return 1.5 end 
end

function MG_HS.Think()
    if not MG_HS.InProgress then return end
    if MG_HS.NextDie < CurTime() then
        print("Nextdie Dead: ",MG_HS.Current)
        print(table.Count(MG_HS.AlivePlayers))
        if not IsValid(MG_HS.Current) then return end
        MG_HS.Current:StripWeapons()
        MG_HS.Current.KnownDeath = true
        local exp = ents.Create("env_explosion")
        exp:SetOwner(MG_HS.Current)
        exp:SetPos(MG_HS.Current:GetPos())
        exp:Spawn()
        exp:SetKeyValue("iMagnitude", "0")
        exp:Fire("Explode", 0, 0)
        MG_HS.Current:Kill()
        MG_HS.Current.KnownDeath = false
        MG_HS.Current = table.Random(MG_HS.AlivePlayers)
        if table.Count(MG_HS.AlivePlayers) < 2 then
            if table.Count(MG_HS.AlivePlayers) < 1 then MG_HS.Win() MG_HS.InProgress = false return end --?
            MG_HS.Current.HSPlace = 1
            MG_HS.Win()
            MG_HS.InProgress = false
            return
        end
        MG_HS.Current:Give("snowball_hs")
        net.Start("HS_Current")
        net.Send(MG_HS.Current)
        MG_HS.NextDie = CurTime() + 15;
        net.Start("HS_Time")
        net.WriteInt(MG_HS.NextDie,32)
        net.Broadcast()
    end
end

function MG_HS.TakeDamage(ply, dmginfo)
    if (IsValid(ply) and ply:IsPlayer() and dmginfo:GetDamage() >= 1 and dmginfo:GetAttacker():IsPlayer() and GetRoundState() == ROUND_ACTIVE ) then
        return false
    end
end

function MG_HS.PlayerShouldTakeDamage(ply,ent)
    if (ent:IsPlayer() and ply:IsPlayer()) then
        return false
    end
end

function MG_HS.KarmaStuff()
    return true
end

function MG_HS.PlayerDisconnected(ply)
    for k,v in pairs(MG_HS.AlivePlayers) do
        if v == ply then MG_HS.AlivePlayers[k] = nil end
    end
    for k,v in pairs(MG_HS.Players) do
        if v == ply then MG_HS.Players[k] = nil end
    end
    for k,v in pairs(MG_HS.DeadPlayers) do
        if v == ply then MG_HS.DeadPlayers[k] = nil end
    end
    if MG_HS.Current == ply then
        MG_HS.Current = table.Random(MG_HS.AlivePlayers)
        if table.Count(MG_HS.AlivePlayers) < 2 then
            MG_HS.Current.HSPlace = 1
            MG_HS.Win()
            MG_HS.InProgress = false
            return
        end
        MG_HS.Current:Give("snowball_hs")
        net.Start("HS_Current")
        net.Send(MG_HS.Current)
        MG_HS.NextDie = CurTime() + 15;
        net.Start("HS_Time")
        net.WriteInt(MG_HS.NextDie,32)
        net.Broadcast()
    end
end

function MG_HS:PrepRound(mk, pri, sec, creds)
    MG_HS.Current = nil
    MG_HS.AlivePlayers = {}
    net.Start("HS_Prep")
    net.Broadcast()
    MG_HS.Players = {}
    MG_HS.DeadPlayers = {}
	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Hot Santa")
	MG_HS.HandleDamageLogStuff(false)
    MG_HS.NextDie = CurTime() + 9000;
    for k, v in pairs(player.GetAll()) do
        MG_HS.StripWeapons(v)
        v:StripAmmo()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_HS.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_HS.StripWeapons(v)
        v:StripAmmo()
        v.TDM_Cache = {}
    end

	MG_HS.HookAdd("MoatInventoryShouldGiveLoadout", MG_HS.PreventLoadouts)
	MG_HS.HookAdd("ttt.BeginRound", MG_HS.BeginRound)
	MG_HS.HookAdd("CanPlayerSuicide", function(ply) return false end)
    MG_HS.HookAdd("PlayerDeath",MG_HS.PlayerDeath)
    MG_HS.HookAdd("PlayerSpawn",MG_HS.PlayerSpawn)
    MG_HS.HookAdd("Think",MG_HS.Think)
    MG_HS.HookAdd("EntityTakeDamage",MG_HS.TakeDamage)
    MG_HS.HookAdd("PlayerShouldTakeDamage",MG_HS.PlayerShouldTakeDamage)
    MG_HS.HookAdd("TTTKarmaGivePenalty", MG_HS.KarmaStuff)
    MG_HS.HookAdd("PlayerDisconnected", MG_HS.PlayerDisconnected)
    MG_HS.HookAdd("StartCommand", MG_HS.StartCommand)
    MG_HS.HookAdd("TTTCanUseTraitorButton",function() return false end)
    MG_HS.HookAdd("TTTPlayerSpeed",MG_HS.PlayerSpeed)
    MG_HS.SpawnPoints = {}


    hook.Add("TTTCheckForWin", "MG_HS_DELAYWIN", function() return WIN_NONE end)
end

function MG_HS.BeginRound()
    SetRoundEnd(CurTime() + 490)
    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_HS.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    MG_HS.InProgress = true
    net.Start("HS_Begin")
    net.Broadcast()

    local pls = player.GetAll()

    for k, v in pairs(pls) do
        MG_HS.StripWeapons(v)
        v:StripAmmo()
        table.insert(MG_HS.Players,v)
        table.insert(MG_HS.AlivePlayers,v)
        v:SetRole(ROLE_INNOCENT)
    end
    MG_HS.NextDie = CurTime() + 20;
    net.Start("HS_Time")
    net.WriteInt(MG_HS.NextDie,32)
    net.Broadcast()
    MG_HS.Current = table.Random(MG_HS.Players)
    print("Current HS: " , MG_HS.Current)
    MG_HS.Current:Give("snowball_hs")
    print("Begin round")

    net.Start("HS_Current")
    net.Send(MG_HS.Current)
end

concommand.Add("moat_start_hs", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    ttt.ExtendPrep()

    MG_HS.PrepRound()
end)

concommand.Add("moat_end_hs", function(ply, cmd, args)
    if (not allowed_ids[ply:SteamID()]) then

        return
    end

    MG_HS.InProgress = false
    local r = MG_HS.Kills.r > MG_HS.Kills.b
    MG_HS.Win(r)
end)