util.AddNetworkString("MG_CM_PREP")
util.AddNetworkString("MG_CM_END")
util.AddNetworkString("MG_CM_UPDATETIME")
util.AddNetworkString("MG_CM_FIRST_INFECTED")
util.AddNetworkString("MG_CM_NEWINFECTED")
util.AddNetworkString("MG_CM_KILL")
util.AddNetworkString("MOAT_CHAT_SEND")
util.AddNetworkString("MIDS_CHAT")

local pl = FindMetaTable("Player")
function pl:MOAT_Chat(...)
    net.Start("MOAT_CHAT_SEND")
    net.WriteTable({...})
    net.Send(self)
end
function MOAT_ChatBroadcast(...)
    net.Start("MOAT_CHAT_SEND")
    net.WriteTable({...})
    net.Broadcast()
end

MG_CM = MG_CM or {}
MG_CM.Survivors = {}
MG_CM.FirstInfected = nil
MG_CM.Players = {}
MG_CM.SpawnProtectionTime = 1
MG_CM.ModelPath = "models/player/zombie_fast.mdl"
MG_CM.TimeLeft = 0
MG_CM.LastSpawn = CurTime()
MG_CM.DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true
}
MG_CM.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_CM.KillWords = {
    "blasted",
    "killed",
    "smacked",
    "murdered",
    "took the life of",
    "assassinated",
    "eliminated",
    "terminated",
    "finished off",
    "executed",
    "slaughtered",
    "butchered",
    "annihilated",
    "exterminated",
    "mowed down",
    "shot down",
    "took out",
    "wasted",
    "whacked",
    "smoked",
    "neutralized",
    "slayed",
    "destroyed"
}
MG_CM.Hooks = {}
MG_CM.Rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
MG_CM.ChickensOver = true
MG_CM.ChickenSpawner = 15
MOAT_CONTAGION_ROUND_ACTIVE = false

function MG_CM.HookAdd(event, id, func)
    hook.Add(event, id, func)
    table.insert(MG_CM.Hooks, {event, id})
end

function MG_CM.ResetVars()
    MG_CM.LastSpawn = CurTime()
    MG_CM.Hooks = {}
    MG_CM.Players = {}
    MG_CM.ChickenSpawner = 15
    MOAT_CONTAGION_ROUND_ACTIVE = false
end

function MG_CM.PreventLoadouts(ply)
    return true
end

function MG_CM.GiveCorrectWeapon(ply)
    MG_CM.StripWeapons(ply)
end

function MG_CM.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_CM.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end


function MG_CM.DoEnding(survivors_win)
    if (MG_CM.ChickensOver) then return end
    
    MG_CM.ChickensOver = true

    net.Start("MG_CM_END")
    net.Broadcast()

    local ply_tbl = {}

    for k, v in pairs(MG_CM.Players) do
        local ply = Entity(k)
        if (IsValid(ply)) then
            if (v.survived) then
                table.insert(ply_tbl, {ply, 99999999})
            elseif (v.survivaltime) then
                table.insert(ply_tbl, {ply, v.survivaltime})
            else
                table.insert(ply_tbl, {ply, 0})
            end
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
        if (MG_CM.Rarity_to_placing[k]) then
            v[1]:m_DropInventoryItem(MG_CM.Rarity_to_placing[k])
        else
            v[1]:m_DropInventoryItem(3)
        end
    end

    timer.Simple(20, function()
		if (MOAT_MINIGAMES.CantEnd()) then return end

        for k, v in pairs(MG_CM.Hooks) do
            hook.Remove(v[1], v[2])
        end

        MG_CM.ResetVars()
        MG_CM.HandleDamageLogStuff(true)
		SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
        RunConsoleCommand("ttt_roundrestart")
        -- Can do this like the others or the round will actually end
        hook.Remove("TTTCheckForWin", "MG_CM_DELAYWIN")

        MOAT_CONTAGION_ROUND_ACTIVE = false
    end)
end

function MG_CM.RespawnPlayer(ply)
    if (not IsValid(ply)) then return end

	local indx = ply:EntIndex()
    timer.Create("respawn_player"..indx, 0.1, 0, function()
        if (not IsValid(ply)) then timer.Remove("respawn_player"..indx) return end
		if (MG_CM.ChickensOver) then timer.Remove("respawn_player"..indx) return end

        local corpse = MG_CM.FindCorpse(ply)
        if (corpse) then 
            MG_CM.RemoveCorpse(corpse)
        end

        ply:SpawnForRound(true)
        ply:SetRole(ROLE_INNOCENT)

        if (ply:IsActive()) then timer.Remove("respawn_player"..indx) return end
    end)
end

function MG_CM.ShouldTakeDamage(ply, ent)
    if (ent:IsPlayer()) then
        return false
    end
end

function MG_CM.PlayerSpawn(ply)
    if (not IsValid(ply) or not MG_CM.Players[ply:EntIndex()]) then return end

    ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    MG_CM.GiveCorrectWeapon(ply)
end

function MG_CM.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_CM.DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
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

function MG_CM.GiveAmmo(ply)
    for k, v in pairs(MG_CM.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end

function MG_CM.UpTable(tbl, index, key)
    MG_CM[tbl][index][key] = MG_CM[tbl][index][key] + 1
end

function MG_CM.PlayerChickened(pl)
    if (MG_CM.ChickensOver) then return end

    MG_CM.Survivors[pl] = nil
    MG_CM.CheckPlayerCount(ply)

    if (MG_CM.ChickensOver) then return end

    local the_s = "s"
    if (table.Count(MG_CM.Survivors) <= 1) then
        the_s = ""
    end


    MOAT_ChatBroadcast(Color(255, 255, 255), "A chicken ", Color(255, 0, 0), MG_CM.KillWords[math.random(1, #MG_CM.KillWords)] .. " ", Color(255, 255, 255), pl:Nick() .. "! ", Color(0, 255, 0), tostring(table.Count(MG_CM.Survivors)), Color(0, 255, 255), " survivor" .. the_s .. " remain!")
end


function MG_CM.SpawnStartChickens()
    for ply, _ in pairs(MG_CM.Survivors) do
        if (ply:Team() == TEAM_SPEC) then continue end
        local rand = -1
        if (math.random(2) == 2) then rand = 1 end
        
        local pushvel = ply:GetForward() * 1000
        pushvel.z = math.Clamp(pushvel.z, 50, 500) * rand
        pushvel.x = math.Clamp(pushvel.x, 50, 500) * rand

        ply:SetVelocity(ply:GetVelocity() + pushvel)

        local chic = ents.Create("ttt_chicken")
        chic:SetPos(ply:GetPos())
        chic:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        chic:Spawn()
        chic:StopWaddling()
        chic:SetTarget(ply)
        chic:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

        ply.SavedPos = ply:GetPos()
    end
end

function MG_CM.SpawnChickens()
    for ply, _ in pairs(MG_CM.Survivors) do
        if (ply:Team() == TEAM_SPEC) then continue end
        local rand = -1
        if (math.random(2) == 2) then rand = 1 end
        
        local pushvel = ply:GetForward() * 1000
        pushvel.z = math.Clamp(pushvel.z, 50, 500) * rand
        pushvel.x = math.Clamp(pushvel.x, 50, 500) * rand

        ply:SetVelocity(ply:GetVelocity() + pushvel)

        local chic = ents.Create("ttt_chicken")
        chic:SetPos(ply:GetPos())
        chic:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        chic:Spawn()
        chic:StopWaddling()
        chic:SetTarget(ply)
        chic:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

        if ((ply:GetMoveType() == MOVETYPE_LADDER) or (ply:WaterLevel() > 0) or (ply.SavedPos and (ply.SavedPos:Distance(ply:GetPos()) <= 100))) then
            chic.Attacker = chic
            chic:Explode2()
            chic:Remove()
        end

        ply.SavedPos = ply:GetPos()
    end
end

function MG_CM.ChickenSpawn()
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
    if (MG_CM.LastSpawn > CurTime()) then return end

    MG_CM.SpawnChickens()
    MG_CM.LastSpawn = CurTime() + MG_CM.ChickenSpawner
end

function MG_CM.PlayerDeath(vic, inf, att)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
    if (not IsValid(vic)) then return end
    local vice = vic:EntIndex()

    if (MG_CM.Players[vice] and MG_CM.Players[vice].survived) then
        MG_CM.Players[vice].survived = false

        local orgtime = MG_CM.Players[vice].survivaltime
        MG_CM.Players[vice].survivaltime = CurTime() - orgtime
    end

    MG_CM.PlayerChickened(vic)
end

function MG_CM.UpdateChickenSpawner(left)
    if (left <= 30) then
        MG_CM.ChickenSpawner = 2
    elseif (left <= 60) then
        MG_CM.ChickenSpawner = 4
    elseif (left <= 90) then
        MG_CM.ChickenSpawner = 6
    elseif (left <= 120) then
        MG_CM.ChickenSpawner = 8
    elseif (left <= 150) then
        MG_CM.ChickenSpawner = 10
    end
end

local last_time_tick = CurTime()
function MG_CM.TimeLeftUpdate()
    if (last_time_tick <= CurTime() - 1 and not MG_CM.ChickensOver) then
        last_time_tick = CurTime()

        MG_CM.TimeLeft = math.Clamp(math.ceil(MG_CM.TimeLeft - 1), 0, 9999)

        MG_CM.UpdateChickenSpawner(MG_CM.TimeLeft)

        if (MG_CM.TimeLeft <= 0) then
            MG_CM.DoEnding(true)
        end
    end
end

function MG_CM.CheckPlayerCount(ply)
    if (table.Count(MG_CM.Survivors) <= 1) then
        MG_CM.DoEnding()
    end
end

function MG_CM.PlayerDisconnected(ply)
    -- poor players
    MG_CM.Players[ply:EntIndex()] = nil
    MG_CM.Survivors[ply] = nil
    MG_CM.CheckPlayerCount()
end

function MG_CM.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending
    
    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_CM.EntityTakeDamage(pl, dmginfo)
    if (not IsValid(pl) or not pl:IsPlayer()) then return end
    
    dmginfo:ScaleDamage(0.5)
end

function MG_CM.BeginRound()

    MOAT_CONTAGION_ROUND_ACTIVE = true

    MG_CM.HookAdd("EntityTakeDamage", "MG_CM_SCALEPLAYERDAMAGE", MG_CM.EntityTakeDamage)
    MG_CM.HookAdd("CanPlayerSuicide", "MG_CM_STOPSUICIDE", function(ply) return false end)
    MG_CM.HookAdd("PlayerCanPickupWeapon", "MG_CM_PICKUP", MG_CM.CanPickupWeapon)
    
    MG_CM.TimeLeft = 180
    MG_CM.ChickenSpawner = 15

    SetRoundEnd(CurTime() + 99999)

    net.Start("MG_CM_UPDATETIME")
    net.Broadcast()
    MG_CM.LastSpawn = CurTime() + MG_CM.ChickenSpawner

    for k, v in pairs(player.GetAll()) do
        if (v:Team() == TEAM_SPEC) then continue end
        
        MG_CM.Players[v:EntIndex()] = {survived = true, survivaltime = CurTime()}
        v:SetRole(ROLE_INNOCENT)
        MG_CM.Survivors[v] = true
        MG_CM.StripWeapons(v)
    end

    MG_CM.SpawnStartChickens()
    MG_CM.SpawnStartChickens()
    MG_CM.SpawnStartChickens()


    MG_CM.HookAdd("Think", "MG_CM_CHICKENSPAWN", MG_CM.ChickenSpawn)
    MG_CM.HookAdd("PlayerDeath", "MG_CM_DEATH", MG_CM.PlayerDeath)
    MG_CM.HookAdd("PlayerDisconnected", "MG_CM_DISCONNECT", MG_CM.PlayerDisconnected)
    MG_CM.HookAdd("PlayerShouldTakeDamage", "MG_CM_PL", MG_CM.ShouldTakeDamage)
    MG_CM.HookAdd("Think", "MG_CM_TIMELEFTUPDATE", MG_CM.TimeLeftUpdate)
end

function MG_CM.KarmaStuff()
    return true
end

function MG_CM.CanPickupWeapon(ply, wep)
    return MG_CM.DefaultLoadout[wep:GetClass()] or false
end

function MG_CM.PrepRound()
	MG_CM.ChickensOver = false
    MG_CM.HandleDamageLogStuff(false)
    MG_CM.TimeLeft = 180
    MG_CM.FirstInfected = nil
    MG_CM.ChickenSpawner = 15

    MG_CM.HookAdd("PlayerSpawn", "MG_CM_SPAWN", MG_CM.PlayerSpawn)
    MG_CM.HookAdd("ttt.BeginRound", "MG_CM_BEGIN", MG_CM.BeginRound)
    MG_CM.HookAdd("TTTKarmaGivePenalty", "MG_CM_PREVENTKARMA", MG_CM.KarmaStuff)
	MG_CM.HookAdd("MoatInventoryShouldGiveLoadout", "MG_CM_PL", MG_CM.PreventLoadouts)

    for k, v in pairs(player.GetAll()) do
        if (IsValid(v) and v:Team() ~= TEAM_SPEC) then
            v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        end
    end

    hook.Add("TTTCheckForWin", "MG_CM_DELAYWIN", function() return WIN_NONE end)

    ttt.ExtendPrep()

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Explosive Chickens")

    net.Start "MG_CM_PREP"
    net.Broadcast()
end

concommand.Add("moat_start_chickens", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end
	
	ttt.ExtendPrep()

    MG_CM.PrepRound()
end)