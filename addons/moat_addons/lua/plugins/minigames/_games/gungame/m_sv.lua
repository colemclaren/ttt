util.AddNetworkString("MG_GG_PREP")
util.AddNetworkString("MG_GG_END")
util.AddNetworkString("MG_GG_LADDER")
util.AddNetworkString("MG_GG_TOP")
util.AddNetworkString("MG_GG_KILLS")

MG_GG = MG_GG or {}
MG_GG.Players = {}
MG_GG.ReqKills = 1
MG_GG.SpawnProtectionTime = 5
MG_GG.Ladder = {
    "weapon_ttt_m16",
    "weapon_ttt_ak47",
    "weapon_ttt_famas",
    "weapon_zm_mac10",
    "weapon_ttt_galil",
    "weapon_ttt_mp5",
    "weapon_ttt_p90",
    "weapon_ttt_sg552",
    "weapon_ttt_aug",
    "weapon_zm_rifle",
    "weapon_zm_sledge",
    "weapon_ttt_shotgun",
    "weapon_zm_shotgun",
    "weapon_ttt_sipistol",
    "weapon_zm_pistol",
    "weapon_ttt_glock",
    "weapon_zm_revolver",
    "weapon_ttt_cardboardknife"
}
MG_GG.DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    --["weapon_zm_improvised"] = true,
    --["weapon_zm_carry"] = true
}
MG_GG.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_GG.Hooks = {}
MG_GG.Rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
MG_GG.GunGameOver = false

function MG_GG.HookAdd(event, id, func)
    hook.Add(event, id, func)
    table.insert(MG_GG.Hooks, {event, id})
end

function MG_GG.ResetVars()
    MG_GG.Hooks = {}
    MG_GG.Players = {}
end

function MG_GG.UpdateTop(ply)
    if (not IsValid(ply)) then return end

    local tbl = MG_GG.Players[ply:EntIndex()]

    net.Start("MG_GG_TOP")
    net.WriteString(ply:Nick())
    net.WriteUInt(tbl.ladder, 5)
    net.WriteUInt(tbl.kills, 8)
    net.Broadcast()
end

function MG_GG.PreventLoadouts(ply)
    return true
end

function MG_GG.UpdatePlayerTop(ply)
    if (not IsValid(ply)) then return end

    local top = true
    local lad = MG_GG.Players[ply:EntIndex()]["ladder"]

    for k, v in pairs(MG_GG.Players) do
        if (v.ladder > lad and k ~= ply:EntIndex()) then
            top = false

            break
        end
    end

    if (top) then
        MG_GG.UpdateTop(ply)
    end
end

function MG_GG.CheckForWin(ply)
    if (not IsValid(ply)) then return false end
    
    if (MG_GG.Players[ply:EntIndex()] and MG_GG.Players[ply:EntIndex()]["ladder"] > #MG_GG.Ladder and not MG_GG.GunGameOver) then
        MG_GG.DoEnding()

        return true
    end

    return false
end

function MG_GG.RemoveWeaponDrop(ply)
	timer.Simple(0,function()
		if (not IsValid(ply)) then return end
        for k, v in pairs(ply:GetWeapons()) do
			if (not IsValid(v)) then continue end
            function v:PreDrop()
                self:Remove()
            end
            v.AllowDrop = false
        end
    end)
end

function MG_GG.GiveCorrectWeapon(ply)
	if (not IsValid(ply)) then return end

    MG_GG.StripWeapons(ply)

    MG_GG.UpdatePlayerTop(ply)

    if (MG_GG.CheckForWin(ply)) then
        return
    end

    local pl = ply:EntIndex()
    local wpn = MG_GG.Ladder[MG_GG.Players[pl]["ladder"]]

    if (wpn) then
        ply:Give(wpn)
        ply:SelectWeapon(wpn)
        MG_GG.GiveAmmo(ply)
		MG_GG.RemoveWeaponDrop(ply)
    end
end

function MG_GG.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_GG.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end


function MG_GG.DoEnding()

    MG_GG.GunGameOver = true

    local tbl = {}

    for k, v in pairs(MG_GG.Players) do
        local ply = Entity(k)
        if (IsValid(ply) and v.kills and v.kills > 0) then
            table.insert(tbl, {ply:Nick(), v.kills, k})
        end
    end

    net.Start("MG_GG_END")
    net.WriteTable(tbl)
    net.Broadcast()

    local ply_tbl = {}

    for k, v in pairs(MG_GG.Players) do
        local ply = Entity(k)
        if (IsValid(ply) and v.kills and v.kills > 0) then
            table.insert(ply_tbl, {ply, v.kills})
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

        if (MG_GG.Rarity_to_placing[k]) then
            v[1]:m_DropInventoryItem(MG_GG.Rarity_to_placing[k])
        else
            v[1]:m_DropInventoryItem(3)
        end
    end

    timer.Simple(20, function()
		if (MOAT_MINIGAMES.CantEnd()) then return end

        for k, v in pairs(MG_GG.Hooks) do
            hook.Remove(v[1], v[2])
        end

        MG_GG.ResetVars()
        MG_GG.HandleDamageLogStuff(true)

        SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)

        RunConsoleCommand("ttt_roundrestart")
        -- Can do this like the others or the round will actually end
        hook.Remove("TTTCheckForWin", "MG_GG_DELAYWIN")
    end)
end

function MG_GG.GiveNextWeapon(ply)
    if (not IsValid(ply)) then return end

    MG_GG.StripWeapons(ply)

    MG_GG.UpdatePlayerTop(ply)

    if (MG_GG.CheckForWin(ply)) then
        return
    end

    local pl = ply:EntIndex()
    local wpn = MG_GG.Ladder[MG_GG.Players[pl]["ladder"]]

    if (wpn) then
        ply:Give(wpn)
        ply:SelectWeapon(wpn)
        MG_GG.GiveAmmo(ply)
		MG_GG.RemoveWeaponDrop(ply)
    end
end

function MG_GG.RespawnPlayer(ply)
    if (not IsValid(ply)) then return end

	local indx = ply:EntIndex()
    timer.Create("respawn_player"..indx, 0.1, 0, function()
        if (not IsValid(ply)) then timer.Remove("respawn_player"..indx) return end
		if (MG_GG.GunGameOver) then timer.Remove("respawn_player"..indx) return end

        local corpse = MG_GG.FindCorpse(ply)
        if (corpse) then 
            MG_GG.RemoveCorpse(corpse)
        end

        ply:SpawnForRound(true)
        ply:SetRole(ROLE_INNOCENT)

        if (ply:IsActive()) then timer.Remove("respawn_player"..indx) return end
    end)
end

function MG_GG.StartSpawnProtection(ply)
    ply:SetNW2Int("MG_GG_SPAWNPROTECTION", CurTime() + MG_GG.SpawnProtectionTime)
end

function MG_GG.RemoveSpawnProtection(ply)
    if (not IsValid(ply)) then return end

    local prot = ply:GetNW2Int("MG_GG_SPAWNPROTECTION")

    if (prot and prot > CurTime()) then
        ply:SetNW2Int("MG_GG_SPAWNPROTECTION", CurTime())
    end
end

function MG_GG.ShouldTakeDamage(ply, ent)
    local plyspn = ply:GetNW2Int("MG_GG_SPAWNPROTECTION")
    local entspn = nil

    if (ent:IsPlayer()) then
        entspn = ent:GetNW2Int("MG_GG_SPAWNPROTECTION")
    end

    if ((GetRoundState() == ROUND_PREP) or (plyspn and plyspn > CurTime()) or (entspn and entspn > CurTime())) then
        return false
    end
end

function MG_GG.SpawnProtectionDraw()
    if (MG_GG.GunGameOver) then
        for k, v in pairs(player.GetAll()) do
            v:SetColor(Color(255, 255, 255, 255))
            v:SetRenderMode(RENDERMODE_NORMAL)
        end

        return
    end

    for k, v in pairs(player.GetAll()) do

        local plys = v:GetNW2Int("MG_GG_SPAWNPROTECTION", 0)
        
        if (plys and plys > CurTime()) then
            v:SetRenderMode(RENDERMODE_TRANSALPHA)
            v:SetColor(Color(255, 255, 255, 50))
        else
            v:SetColor(Color(255, 255, 255, 255))
        end
    end
end

function MG_GG.PlayerSpawn(ply)
    if (not IsValid(ply) or not MG_GG.Players[ply:EntIndex()]) then return end

    MG_GG.GiveCorrectWeapon(ply)
    MG_GG.StartSpawnProtection(ply)

    timer.Simple(1, function()
        if (not IsValid(ply) or not ply:IsActive()) then return end
        ply:SetModel(GAMEMODE.playermodel or "models/player/phoenix.mdl")
    end)
end

function MG_GG.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_GG.DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
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

function MG_GG.GiveAmmo(ply)
    for k, v in pairs(MG_GG.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end

function MG_GG.UpTable(index, key)
    MG_GG.Players[index][key] = MG_GG.Players[index][key] + 1
end

function MG_GG.CheckShouldGiveNextWeapon(ply)
    if (not IsValid(ply)) then return end

    local pl = ply:EntIndex()

    if (MG_GG.Players[pl]["curkills"] > MG_GG.ReqKills - 1) then
        MG_GG.UpTable(pl, "ladder")
        MG_GG.Players[pl]["curkills"] = 0

        net.Start("MG_GG_LADDER")
        net.WriteUInt(MG_GG.Players[pl]["ladder"], 5)
        net.Send(ply)

        MG_GG.GiveNextWeapon(ply)
    end
end

function MG_GG.PlayerDeath(vic, inf, att)
    timer.Simple(5, function()
        MG_GG.RespawnPlayer(vic)
    end)

    if (not IsValid(vic) or not IsValid(att)) then return end

    local wpn = att:GetActiveWeapon()

    if (vic == att or not wpn) then
        return
    end

    local msg = att:Nick() .. " killed " .. vic:Nick()
    local vowels = {["a"] = true, ["e"] = true, ["i"] = true, ["o"] = true, ["u"] = true}
    if (wpn.PrintName) then
        local grammar = "a"
        if (vowels[wpn.PrintName:sub(1, 1):lower()]) then
            grammar = "an"
        end
        msg = msg .. " with " .. grammar .. " " .. wpn.PrintName
    end

    for k, v in pairs(player.GetAll()) do
        if (v == att) then
			D3A.Chat.SendToPlayer2(v, Color(255, 0, 0), msg)
        elseif (v == vic) then
			D3A.Chat.SendToPlayer2(v, Color(0, 0, 255), msg)
        else
			D3A.Chat.SendToPlayer2(v, Color(255, 255, 0), msg)
        end
    end

    net.Start("MG_GG_KILLS")
    net.Send(att)

    att:SetHealth(100)

    local attindex = att:EntIndex()
    local vicindex = vic:EntIndex()

    MG_GG.UpTable(vicindex, "deaths")
    MG_GG.UpTable(attindex, "kills")
    
    local atttbl = MG_GG.Players[attindex]
    local wpnc = wpn:GetClass()
    local ladwpn = MG_GG.Ladder[MG_GG.Players[attindex]["ladder"]]

    if (ladwpn and wpnc and ladwpn == wpnc) then
        MG_GG.UpTable(attindex, "curkills")
        MG_GG.UpdatePlayerTop(att)
        MG_GG.CheckForWin(att)

        MG_GG.CheckShouldGiveNextWeapon(att)
    end
end

function MG_GG.PlayerDisconnected(ply)
    -- poor players
    MG_GG.Players[ply:EntIndex()] = nil
end

function MG_GG.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_GG.BeginRound()
    for k, v in pairs(player.GetAll()) do
        MG_GG.Players[v:EntIndex()] = {ladder = 1, kills = 0, deaths = 0, curkills = 0}
        v:SetRole(ROLE_INNOCENT)
        MG_GG.StripWeapons(v)
        MG_GG.GiveCorrectWeapon(v)
        v:SetModel(GAMEMODE.playermodel or "models/player/phoenix.mdl")
    end

    MG_GG.HookAdd("PlayerSpawn", "MG_GG_SPAWN", MG_GG.PlayerSpawn)
    MG_GG.HookAdd("PlayerDeath", "MG_GG_DEATH", MG_GG.PlayerDeath)
end

function MG_GG.KarmaStuff()
    return true
end

function MG_GG.PrepRound()
    for k, v in pairs(player.GetAll()) do
        MG_GG.StripWeapons(v)
    end

    for k, v in pairs(ents.GetAll()) do
        if (IsValid(v) and v:GetClass():StartWith("weapon_") and not MG_GG.DefaultLoadout[v:GetClass()]) then
            v:Remove()
        end
    end

    MG_GG.GunGameOver = false
    MG_GG.HandleDamageLogStuff(false)

	MG_GG.HookAdd("MoatInventoryShouldGiveLoadout", "MG_GG_PL", MG_GG.PreventLoadouts)
    MG_GG.HookAdd("ttt.BeginRound", "MG_GG_BEGIN", MG_GG.BeginRound)
    MG_GG.HookAdd("TTTKarmaGivePenalty", "MG_GG_PREVENTKARMA", MG_GG.KarmaStuff)
    MG_GG.HookAdd("PlayerDisconnected", "MG_GG_DISCONNECT", MG_GG.PlayerDisconnected)
    MG_GG.HookAdd("EntityFireBullets", "MG_GG_REMOVESPAWNPROT", MG_GG.RemoveSpawnProtection)
    MG_GG.HookAdd("PlayerShouldTakeDamage", "MG_GG_PL", MG_GG.ShouldTakeDamage)
    MG_GG.HookAdd("Think", "MG_GG_DRAWSPAWN", MG_GG.SpawnProtectionDraw)
    MG_GG.HookAdd("CanPlayerSuicide", "MG_GG_STOPSUICIDE", function(ply) return false end)

    hook.Add("TTTCheckForWin", "MG_GG_DELAYWIN", function() return WIN_NONE end)

	ttt.ExtendPrep()

    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_GG.StripWeapons(v)
    end

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Gun Game")

    net.Start "MG_GG_PREP"
    net.Broadcast()
end

concommand.Add("moat_start_gungame", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    MG_GG.PrepRound()
end)