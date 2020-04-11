util.AddNetworkString("MG_OC_PREP")
util.AddNetworkString("MG_OC_END")
util.AddNetworkString("MG_OC_LADDER")
util.AddNetworkString("MG_OC_TOP")
util.AddNetworkString("MG_OC_KILLS")
util.AddNetworkString "MG_OC_DEATHS"
util.AddNetworkString "MG_OC_HALOS"

MG_OC = MG_OC or {}
MG_OC.Players = {}
MG_OC.ReqKills = 1
MG_OC.SpawnProtectionTime = 5
MG_OC.Ladder = {
    ""
}
MG_OC.DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    --["weapon_zm_improvised"] = true,
    --["weapon_zm_carry"] = true
}
MG_OC.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_OC.Hooks = {}
MG_OC.Rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
MG_OC.GunGameOver = false

function MG_OC.HookAdd(event, id, func)
    hook.Add(event, id, func)
    table.insert(MG_OC.Hooks, {event, id})
end

function MG_OC.ResetVars()
    MG_OC.Hooks = {}
    MG_OC.Players = {}
end

function MG_OC.UpdateTop(ply)
    if (not IsValid(ply)) then return end

    local tbl = MG_OC.Players[ply:EntIndex()]

    net.Start("MG_OC_TOP")
    net.WriteString(ply:Nick())
    net.WriteUInt(tbl.kills, 8)
    net.Broadcast()
end

function MG_OC.PreventLoadouts(ply)
    return true
end

function MG_OC.UpdatePlayerTop(ply)
    if (not IsValid(ply)) then return end

    local top = true
    local lad = MG_OC.Players[ply:EntIndex()]["kills"]

    for k, v in pairs(MG_OC.Players) do
        if (v.kills > lad and k ~= ply:EntIndex()) then
            top = false

            break
        end
    end

    if (top) then
        MG_OC.UpdateTop(ply)
    end
end

function MG_OC.CheckForWin(ply)
    --if (not IsValid(ply)) then return false end

    local alive = 0
    local alivetbl = {}

    for k, v in pairs(MG_OC.Players) do
        if (v.deaths < 4) then
            alive = alive + 1
            table.insert(alivetbl, Entity(k))
        end
    end

    if (alive <= 5) then
        net.Start("MG_OC_HALOS")
        net.WriteTable(alivetbl)
        net.Broadcast()
    end
    
    if (alive < 2 and not MG_OC.GunGameOver) then
        MG_OC.DoEnding()

        return true
    end

    return false
end

function MG_OC.GiveCorrectWeapon(ply)
    MG_OC.StripWeapons(ply)

    MG_OC.UpdatePlayerTop(ply)

    if (MG_OC.CheckForWin(ply)) then
        return
    end

    --local pl = ply:EntIndex()

    ply:Give("weapon_ttt_ocpistol")
    ply:Give("weapon_ttt_knife")

    ply:SelectWeapon("weapon_ttt_ocpistol")
end

function MG_OC.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_OC.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end


function MG_OC.DoEnding()

    MG_OC.GunGameOver = true

    local tbl = {}

    for k, v in pairs(MG_OC.Players) do
        local ply = Entity(k)
        if (IsValid(ply) and v.kills and v.kills > 0) then
            table.insert(tbl, {ply:Nick(), v.kills, k})
        end
    end

    net.Start("MG_OC_END")
    net.WriteTable(tbl)
    net.Broadcast()

    local ply_tbl = {}

    for k, v in pairs(MG_OC.Players) do
        local ply = Entity(k)
        if (IsValid(ply) and v.kills and v.kills > 0) then
            table.insert(ply_tbl, {ply, v.kills})
        end
    end

    table.sort(ply_tbl, function(a, b) return a[2] > b[2] end)

    PrintTable(ply_tbl)

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

        if (MG_OC.Rarity_to_placing[k]) then
            v[1]:m_DropInventoryItem(MG_OC.Rarity_to_placing[k])
        else
            v[1]:m_DropInventoryItem(3)
        end
    end

    timer.Simple(20, function()
		if (MOAT_MINIGAMES.CantEnd()) then return end

        for k, v in pairs(MG_OC.Hooks) do
            hook.Remove(v[1], v[2])
        end

        MG_OC.ResetVars()
        MG_OC.HandleDamageLogStuff(true)

        RunConsoleCommand("ttt_roundrestart")
        -- Can do this like the others or the round will actually end
        hook.Remove("TTTCheckForWin", "MG_OC_DELAYWIN")
        SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    end)
end

function MG_OC.RespawnPlayer(ply)
    if (not IsValid(ply)) then return end

	local indx = ply:EntIndex()
    timer.Create("respawn_player"..indx, 0.1, 0, function()
        if (not IsValid(ply)) then timer.Remove("respawn_player"..indx) return end
		if (MG_OC.GunGameOver) then timer.Remove("respawn_player"..indx) return end

        local corpse = MG_OC.FindCorpse(ply)
        if (corpse) then 
            MG_OC.RemoveCorpse(corpse)
        end

        ply:SpawnForRound(true)
        ply:SetRole(ROLE_INNOCENT)

        if (ply:IsActive()) then timer.Remove("respawn_player"..indx) return end
    end)
end

function MG_OC.StartSpawnProtection(ply)
    ply:SetNW2Int("MG_OC_SPAWNPROTECTION", CurTime() + MG_OC.SpawnProtectionTime)
end

function MG_OC.RemoveSpawnProtection(ply)
    if (not IsValid(ply)) then return end

    local prot = ply:GetNW2Int("MG_OC_SPAWNPROTECTION")

    if (prot and prot > CurTime()) then
        ply:SetNW2Int("MG_OC_SPAWNPROTECTION", CurTime())
    end
end

function MG_OC.ShouldTakeDamage(ply, ent)
    local plyspn = ply:GetNW2Int("MG_OC_SPAWNPROTECTION")
    local entspn = nil

    if (ent:IsPlayer()) then
        entspn = ent:GetNW2Int("MG_OC_SPAWNPROTECTION")
    end

    if ((GetRoundState() == ROUND_PREP) or (plyspn and plyspn > CurTime()) or (entspn and entspn > CurTime())) then
        return false
    end
end

function MG_OC.SpawnProtectionDraw()
    if (MG_OC.GunGameOver) then
        for k, v in pairs(player.GetAll()) do
            v:SetColor(Color(255, 255, 255, 255))
            v:SetRenderMode(RENDERMODE_NORMAL)
        end

        return
    end

    for k, v in pairs(player.GetAll()) do

        local plys = v:GetNW2Int("MG_OC_SPAWNPROTECTION", 0)
        
        if (plys and plys > CurTime()) then
            v:SetRenderMode(RENDERMODE_TRANSALPHA)
            v:SetColor(Color(255, 255, 255, 50))
        else
            v:SetColor(Color(255, 255, 255, 255))
        end
    end
end

function MG_OC.PlayerSpawn(ply)
    if (not IsValid(ply) or not MG_OC.Players[ply:EntIndex()]) then return end

    MG_OC.GiveCorrectWeapon(ply)
    MG_OC.StartSpawnProtection(ply)

    timer.Simple(1, function()
        if (not IsValid(ply) or not ply:IsActive()) then return end
        ply:SetModel(GAMEMODE.playermodel or "models/player/phoenix.mdl")
    end)
end

function MG_OC.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_OC.DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
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

function MG_OC.GiveAmmo(ply)
    for k, v in pairs(MG_OC.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end

function MG_OC.UpTable(index, key)
    MG_OC.Players[index][key] = MG_OC.Players[index][key] + 1
end

function MG_OC.CheckShouldGiveNextWeapon(ply)
    if (not IsValid(ply)) then return end

    local pl = ply:EntIndex()

    for k, v in pairs(ply:GetWeapons()) do
        if (v.ClassName == "weapon_ttt_ocpistol") then
            v:SetClip1(v:Clip1() + 1)
        end
    end

    net.Start("MG_OC_LADDER")
    net.WriteUInt(MG_OC.Players[pl]["kills"], 8)
    net.Send(ply)
end

function MG_OC.PlayerDeath(vic, inf, att)
    if (MG_OC.Players[vic:EntIndex()]["deaths"] < 3) then
        timer.Simple(5, function()
            MG_OC.RespawnPlayer(vic)
        end)
    else
        timer.Simple(1, function()
            if (IsValid(vic.server_ragdoll)) then
                local pl = player.GetByUniqueID(vic.server_ragdoll.uqid)
                if not IsValid(pl) then return end
                pl:SetCleanRound(false)
                pl:SetNW2Bool("body_found", true)
                CORPSE.SetFound(vic.server_ragdoll, true)
                vic.server_ragdoll:Remove()
            end
        end)
    end

    if (IsValid(att)) then
        net.Start("MG_OC_KILLS")
        net.Send(att)
    end

    net.Start("MG_OC_DEATHS")
    net.Send(vic)

    --att:SetHealth(100)
    if (IsValid(att) and att:IsPlayer()) then
        local attindex = att:EntIndex()
        MG_OC.UpTable(attindex, "kills")

        /*local att_weps = att:GetWeapons()
        local knife_found = false

        for k, v in pairs(att_weps) do
            if (v.ClassName == "weapon_ttt_knife") then knife_found = true end
        end

        if (not knife_found) then*/
        timer.Simple(1, function()
            att:Give("weapon_ttt_knife")
        end)
        --end
    end
    
    local vicindex = vic:EntIndex()
    MG_OC.UpTable(vicindex, "deaths")

    local alive = 0

    for k, v in pairs(MG_OC.Players) do
        if (v.deaths < 4) then
            alive = alive + 1
        end
    end

    if (MG_OC.Players[vic:EntIndex()]["deaths"] > 3) then
        if (alive == 1) then
            BroadcastLua("chat.AddText(Color(0, 255, 255), '" .. alive .. " player remaining!')")
        else
            BroadcastLua("chat.AddText(Color(0, 255, 255), '" .. alive .. " players remaining!')")
        end
    end

    if (IsValid(att)) then
        MG_OC.UpdatePlayerTop(att)
        MG_OC.CheckShouldGiveNextWeapon(att)
    end
    
    MG_OC.CheckForWin()
end

function MG_OC.PlayerDisconnected(ply)
    -- poor players
    MG_OC.Players[ply:EntIndex()] = nil
    MG_OC.CheckForWin(ply)
end

function MG_OC.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_OC.BeginRound()
    for k, v in pairs(player.GetAll()) do
        if (v:Team() == TEAM_SPEC) then continue end

        MG_OC.Players[v:EntIndex()] = {kills = 0, deaths = 0}
        v:SetRole(ROLE_INNOCENT)
    end
    
    for k, v in pairs(player.GetAll()) do
        if (v:Team() == TEAM_SPEC) then continue end
        
        MG_OC.StripWeapons(v)
        MG_OC.GiveCorrectWeapon(v)
        v:SetModel(GAMEMODE.playermodel or "models/player/phoenix.mdl")
    end

    MG_OC.HookAdd("PlayerSpawn", "MG_OC_SPAWN", MG_OC.PlayerSpawn)
    MG_OC.HookAdd("PlayerDeath", "MG_OC_DEATH", MG_OC.PlayerDeath)
    MG_OC.HookAdd("PlayerDisconnected", "MG_OC_DISCONNECT", MG_OC.PlayerDisconnected)
end

function MG_OC.KarmaStuff()
    return true
end

function MG_OC.PrepRound()
    for k, v in pairs(player.GetAll()) do
        MG_OC.StripWeapons(v)
        v:StripAmmo()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_OC.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end

    MG_OC.GunGameOver = false
    MG_OC.HandleDamageLogStuff(false)

    MG_OC.HookAdd("ttt.BeginRound", "MG_OC_BEGIN", MG_OC.BeginRound)
    MG_OC.HookAdd("TTTKarmaGivePenalty", "MG_OC_PREVENTKARMA", MG_OC.KarmaStuff)
    MG_OC.HookAdd("MoatInventoryShouldGiveLoadout", "MG_OC_PL", MG_OC.PreventLoadouts)
    MG_OC.HookAdd("EntityFireBullets", "MG_OC_REMOVESPAWNPROT", MG_OC.RemoveSpawnProtection)
    MG_OC.HookAdd("PlayerShouldTakeDamage", "MG_OC_PL", MG_OC.ShouldTakeDamage)
    MG_OC.HookAdd("Think", "MG_OC_DRAWSPAWN", MG_OC.SpawnProtectionDraw)
    MG_OC.HookAdd("CanPlayerSuicide", "MG_OC_STOPSUICIDE", function(ply) return false end)

    hook.Add("TTTCheckForWin", "MG_OC_DELAYWIN", function() return WIN_NONE end)

    for k, v in pairs(player.GetAll()) do
        MG_OC.StripWeapons(v)
        v:StripAmmo()
    end

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "One in the Chamber")

    net.Start "MG_OC_PREP"
    net.Broadcast()
end

concommand.Add("moat_start_onechamber", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    ttt.ExtendPrep()

    MG_OC.PrepRound()
end)