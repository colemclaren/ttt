

util.AddNetworkString("FFAS_I_Just_Joined")
util.AddNetworkString("FFAS_Begin")
util.AddNetworkString("FFAS_End")
util.AddNetworkString("FFAS_NewKills")
util.AddNetworkString("FFAS_Prep")
util.AddNetworkString("FFAS_Kill")
util.AddNetworkString("FFAS_KStreak")


MG_FFAS = MG_FFAS or {}
MG_FFAS.Hooks = MG_FFAS.Hooks or {}
MG_FFAS.Players = MG_FFAS.Players or {}
MG_FFAS.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_FFAS.DefaultLoadout = {
}
MG_FFAS.FFASOver = false
MG_FFAS.KillsMax = 50
MG_FFAS.InProgress = MG_FFAS.InProgress or false
MG_FFAS.TimeEnd = MG_FFAS.TimeEnd or 0

function MG_FFAS.HookAdd(event, func)
    hook.Add(event, "MG_FFAS_" .. event, func)
    table.insert(MG_FFAS.Hooks, {event, "MG_FFAS_" .. event})
end

function MG_FFAS.RemoveHooks()
	for k, v in pairs(MG_FFAS.Hooks) do
		hook.Remove(v[1], v[2])
	end
end

function MG_FFAS:DoEnding(force)
    MG_FFAS.RemoveHooks()
    MG_FFAS.ResetVars()
    MG_FFAS.HandleDamageLogStuff(true)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "MG_FFAS_DELAYWIN")
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    MG_FFAS.InProgress = false
    timer.Remove("FFAS.SpawnPoints")
end

function MG_FFAS.ResetVars()
    MG_FFAS.Hooks = {}
    MG_FFAS.Players = {}
	MG_FFAS.Loadout = {
		prim = "snowball_harmful"
	}
end

function MG_FFAS.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_FFAS.DeafultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
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

function MG_FFAS.GiveAmmo(ply)
    for k, v in pairs(MG_FFAS.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end


function MG_FFAS.PreventLoadouts()
    return true
end

function MG_FFAS.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_FFAS.DoKill(ply)
    local mk = MG_FFAS.Kills()
    ply.ffaSKills = ply.ffaSKills + 1
    if ply.ffaSKills > mk then
        net.Start("FFAS_NewKills")
        net.WriteInt(MG_FFAS.Kills(),8)
        net.Broadcast()
    end
end

function MG_FFAS.PlayerDeath(vic, inf, att)
	timer.Simple(5, function()
        if not IsValid(vic) then return end
		MG_FFAS.RespawnPlayer(vic)
	end)
    print("Death",vic,att)
	if (att == vic) then return end
	if (att ~= vic and att:IsPlayer()) then
        MG_FFAS.DoKill(att)
        vic:SetCredits(0)
        timer.Simple(1,function()
            if not IsValid(att) then return end
            att:SetCredits(0)
        end)

        net.Start("FFAS_Kill")
        net.WriteEntity(att)
        net.WriteBool(att:GetRole() == ROLE_DETECTIVE)
        net.WriteEntity(vic)
        net.WriteBool(vic:GetRole() == ROLE_DETECTIVE)
        net.Broadcast()
	end
end

function MG_FFAS.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_FFAS.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end

function MG_FFAS.Move(ply,mv)
    if mv:GetButtons() ~= 0 then
        ply.T_Moved = CurTime() + 7.5
    end
end

function MG_FFAS.RespawnPlayer(ply)
    if (not IsValid(ply)) then return end

	local indx = ply:EntIndex()
    timer.Create("respawn_player"..indx, 0.1, 0, function()
        if (not IsValid(ply)) then timer.Remove("respawn_player"..indx) return end
		if (not MG_FFAS.InProgress) then timer.Remove("respawn_player"..indx) return end

        local corpse = MG_FFAS.FindCorpse(ply)
        if (corpse) then 
            MG_FFAS.RemoveCorpse(corpse)
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
function MG_FFAS.GiveWeapon(ply,v)
    local a = ply:Give(v)
    a.Primary.Damage = 500
end

function MG_FFAS.GiveWeapons(ply)
    MG_FFAS.StripWeapons(ply)
	MG_FFAS.GiveWeapon(ply,"snowball_harmful")
    timer.Simple(0,function()
        for k,v in pairs(ply:GetWeapons()) do
            function v:PreDrop()
                self:Remove()
            end
            v.AllowDrop = false
        end
    end)
end

local sp_time = 5

function MG_FFAS.StartCommand(ply,cmd)
    if not ply:Alive() then return end
    if ply.SpawnProtection then
        if cmd:KeyDown(IN_ATTACK) then
            ply.SpawnProtection = false
            ply:SetRenderMode(RENDERMODE_NORMAL)
            ply:SetColor(Color(255,255,255,255))
            timer.Simple(1,function()
                ply:SetColor(Color(255,255,255,255))
            end)
            ply:SetNW2Int("MG_FFAS_SPAWNPROTECTION",0)
        end
    end
end

function MG_FFAS.PlayerSpawn(ply)
    ply:ResetEquipment()
    ply:SetCredits(0)
    timer.Simple(0,function() MG_FFAS.GiveWeapons(ply) end)
    MG_FFAS.GiveAmmo(ply)
    ply:ShouldDropWeapon(false)
    ply.KillStreak = 0
    ply.SpawnProtection = true
    ply:SetNW2Int("MG_FFAS_SPAWNPROTECTION",CurTime() + sp_time)
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
function MG_FFAS.Win()
    timer.Simple(25, function() MG_FFAS:DoEnding() end)
    --print("WIN:",team)
    net.Start("FFAS_End")
    local t = {}
    for k,v in pairs(MG_FFAS.Players) do
        if not IsValid(v) then continue end
        table.insert(t,{v,math.Round(v.ffaSKills)})
    end
    table.sort(t,function(a,b) return a[2] > b[2] end)
    net.WriteTable(t)
    net.Broadcast()

    timer.Simple((0.2 * ((#t - 3) + 0.5 ) + (4.5)),function()
        for k, v in ipairs(t) do
            if not IsValid(v[1]) then continue end
            if k < (#t * 0.5) then
                v[1]:m_DropInventoryItem("Holiday Crate")
            else
                v[1]:m_DropInventoryItem(3)
            end
        end
    end)
end

function MG_FFAS.Kills()
    local t = {}
    for k,v in pairs(MG_FFAS.Players) do
        if not IsValid(v) then continue end
        table.insert(t,{v,math.Round(v.ffaSKills)})
    end
    table.sort(t,function(a,b) return a[2] > b[2] end)
    return t[1][2],t[1][1]
end


function MG_FFAS.Think()
    if not MG_FFAS.InProgress then return end

    if (MG_FFAS.Kills() >= MG_FFAS.KillsMax) then
        MG_FFAS.InProgress = false
        MG_FFAS.Win(e)
	end

    if MG_FFAS.TimeEnd < CurTime() then
        MG_FFAS.InProgress = false
        MG_FFAS.Win()
    end
end

function MG_FFAS.TakeDamage(ply, dmginfo)
    if (IsValid(ply) and ply:IsPlayer() and dmginfo:GetDamage() >= 1 and dmginfo:GetAttacker():IsPlayer() and GetRoundState() == ROUND_ACTIVE ) then
        local att = dmginfo:GetAttacker()
        if (not att.FFASDamage) then
            att.FFASDamage = 0
        end
        if ply.SpawnProtection or att.SpawnProtection then return end
        --print(ply:Health(),"Add: ",(math.min(dmginfo:GetDamage(),ply:Health())))
        att.FFASDamage = att.FFASDamage + (math.min(dmginfo:GetDamage(),ply:Health()))
    end
end

function MG_FFAS.PlayerShouldTakeDamage(ply,ent)
    if ply.SpawnProtection or ent.SpawnProtection then
        return false
    end
    if (((not ent:IsPlayer()) and (not ent:IsWorld())) or GetRoundState() == ROUND_PREP) then return false end
end

function MG_FFAS.KarmaStuff()
    return true
end

function MG_FFAS.PlayerDisconnected(ply)

end

function MG_FFAS:PrepRound(mk, pri, sec, creds)
	MG_FFAS.FFASOver = false
	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "FFA Santa")
	MG_FFAS.HandleDamageLogStuff(false)

    for k, v in pairs(player.GetAll()) do
        MG_FFAS.StripWeapons(v)
        v:StripAmmo()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_FFAS.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_FFAS.StripWeapons(v)
        v:StripAmmo()
        v.FFAS_Cache = {}
        v.ffaSKills = 0
    end
    

	MG_FFAS.HookAdd("MoatInventoryShouldGiveLoadout", MG_FFAS.PreventLoadouts)
	MG_FFAS.HookAdd("ttt.BeginRound", MG_FFAS.BeginRound)
	MG_FFAS.HookAdd("CanPlayerSuicide", function(ply) return true end)
    MG_FFAS.HookAdd("PlayerDeath",MG_FFAS.PlayerDeath)
    MG_FFAS.HookAdd("PlayerSpawn",MG_FFAS.PlayerSpawn)
    MG_FFAS.HookAdd("Think",MG_FFAS.Think)
    MG_FFAS.HookAdd("EntityTakeDamage",MG_FFAS.TakeDamage)
    MG_FFAS.HookAdd("PlayerShouldTakeDamage",MG_FFAS.PlayerShouldTakeDamage)
    MG_FFAS.HookAdd("Move",MG_FFAS.Move)
    MG_FFAS.HookAdd("TTTKarmaGivePenalty", MG_FFAS.KarmaStuff)
    MG_FFAS.HookAdd("PlayerDisconnected", MG_FFAS.PlayerDisconnected)
    MG_FFAS.HookAdd("StartCommand", MG_FFAS.StartCommand)
    MG_FFAS.HookAdd("TTTCanUseTraitorButton",function() return false end)
    MG_FFAS.SpawnPoints = {}
    timer.Create("FFAS.SpawnPoints",5,0,MG_FFAS.TrackSpawnPoints)


    hook.Add("TTTCheckForWin", "MG_FFAS_DELAYWIN", function() return WIN_NONE end)
end

function MG_FFAS.DecideTeams(pls)
    MG_FFAS.Players = {}

	for i,v in RandomPairs(player.GetAll()) do
		table.insert(MG_FFAS.Players, v)

		v:SetRole(ROLE_INNOCENT)
	end
end

function MG_FFAS.BeginRound()
    SetRoundEnd(CurTime() + 900)
    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_FFAS.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    for k,v in pairs(player.GetAll()) do
        v.ffaSKills = 0
    end
    MG_FFAS.InProgress = true
    MG_FFAS.TimeEnd = CurTime() + (60 * 10)
    net.Start("FFAS_Begin")
    net.WriteInt(MG_FFAS.KillsMax,8)
    net.Broadcast()

    local pls = player.GetAll()

    for k, v in pairs(pls) do
        MG_FFAS.StripWeapons(v)
        v:StripAmmo()
        MG_FFAS.GiveWeapons(v)
        MG_FFAS.GiveAmmo(v)
        v.KillStreak = 0
        v.FFASDamage = 0
    end

    MG_FFAS.DecideTeams(pls)
    print("Begin round")
end

concommand.Add("moat_start_FFAS", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end


    local max_kills = tonumber(args[1]) or 25
    max_kills = math.max(0,math.min(max_kills,35)) -- max kills
    MG_FFAS.KillsMax = max_kills
    print("mk:" .. max_kills)

    ttt.ExtendPrep()

    net.Start("FFAS_Prep")
    net.WriteInt(max_kills,8)
    net.WriteBool(creds)
    net.Broadcast()

    MG_FFAS.PrepRound(max_kills)
end)

concommand.Add("moat_end_FFAS", function(ply, cmd, args)
    if (not allowed_ids[ply:SteamID()]) then

        return
    end

    MG_FFAS.InProgress = false
    MG_FFAS.Win()
end)


function MG_FFAS.TrackSpawnPoints() 
    if not MG_FFAS.SpawnPoints then MG_FFAS.SpawnPoints = {} end
    for k,v in ipairs(player.GetAll()) do
        if v:Alive() and v:IsOnGround() and (not v:IsSpec()) then
            table.insert(MG_FFAS.SpawnPoints,v:GetPos())
        end
    end
end

--make a custom spawnpoint func
hook.Add("PostGamemodeLoaded", "MG_FFAS_POSTGAMEMODE", function()
    function GAMEMODE:IsSpawnpointSuitable(ply, spwn, force, rigged)
        if not IsValid(ply) or not ply:IsTerror() then return true end

        timer.Simple(0,function() -- Next frame
            if not IsValid(ply) then return end
            if not MG_FFAS.InProgress then return end
            if not MG_FFAS.SpawnPoints then return end
            for _,v in RandomPairs(MG_FFAS.SpawnPoints) do
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