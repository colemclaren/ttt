util.AddNetworkString("MG_CG_PREP")
util.AddNetworkString("MG_CG_END")
util.AddNetworkString("MG_CG_UPDATETIME")
util.AddNetworkString("MG_CG_FIRST_INFECTED")
util.AddNetworkString("MG_CG_NEWINFECTED")
util.AddNetworkString("MG_CG_KILL")
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

MG_CG = MG_CG or {}
MG_CG.Survivors = {}
MG_CG.FirstInfected = nil
MG_CG.Infected = {}
MG_CG.Players = {}
MG_CG.SpawnProtectionTime = 1
MG_CG.ModelPath = "models/player/zombie_fast.mdl"
MG_CG.TimeLeft = 0
MG_CG.DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
	["realistic_hook"] = true,
	["weapon_ttt_jetpack"] = true
}
MG_CG.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_CG.KillWords = {
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
MG_CG.Hooks = {}
MG_CG.Rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
MG_CG.ContagionOver = true
MOAT_CONTAGION_ROUND_ACTIVE = false

function MG_CG.HookAdd(event, id, func)
    hook.Add(event, id, func)
    table.insert(MG_CG.Hooks, {event, id})
end

function MG_CG.ResetVars()
    MG_CG.Hooks = {}
    MG_CG.Survivors = {}
    MG_CG.Infected = {}
    MG_CG.Players = {}
    MOAT_CONTAGION_ROUND_ACTIVE = false
end

function MG_CG.PreventLoadouts(ply)
    return MG_CG.Infected[ply] or false
end

function MG_CG.GiveCorrectWeapon(ply)
    if (MG_CG.Infected[ply]) then
        MG_CG.StripWeapons(ply)
    else
        MG_CG.GiveAmmo(ply)
    end
end

function MG_CG.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_CG.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end


function MG_CG.DoEnding(survivors_win)
    if (MG_CG.ContagionOver) then return end
    
    MG_CG.ContagionOver = true

    for k, v in pairs(player.GetAll()) do
        v.SpeedMod = nil
    end

    net.Start("MG_CG_END")
    net.Broadcast()

    local ply_tbl = {}

    for k, v in pairs(MG_CG.Players) do
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
        if (MG_CG.Rarity_to_placing[k]) then
            v[1]:m_DropInventoryItem(MG_CG.Rarity_to_placing[k])
        else
            v[1]:m_DropInventoryItem(3)
        end
    end

    MG_CG.Survivors = {}
    MG_CG.Infected = {}

    timer.Simple(20, function()
		if (MOAT_MINIGAMES.CantEnd()) then return end

        for k, v in pairs(MG_CG.Hooks) do
            hook.Remove(v[1], v[2])
        end

        MG_CG.ResetVars()
        MG_CG.HandleDamageLogStuff(true)
		SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
		
        RunConsoleCommand("ttt_roundrestart")
        -- Can do this like the others or the round will actually end
        hook.Remove("TTTCheckForWin", "MG_CG_DELAYWIN")

        MOAT_CONTAGION_ROUND_ACTIVE = false
    end)
end

function MG_CG.RespawnPlayer(ply)
    if (not IsValid(ply)) then return end

	local indx = ply:EntIndex()
    timer.Create("respawn_player"..indx, 0.1, 0, function()
        if (not IsValid(ply)) then timer.Remove("respawn_player"..indx) return end
		if (MG_CG.ContagionOver) then timer.Remove("respawn_player"..indx) return end
        local corpse = MG_CG.FindCorpse(ply)
        if (corpse) then 
            MG_CG.RemoveCorpse(corpse)
        end

        ply:SpawnForRound(true)
        ply:SetRole(ROLE_INNOCENT)

        if (ply:IsActive()) then timer.Remove("respawn_player"..indx) return end
    end)
end

function MG_CG.ShouldTakeDamage(ply, ent)
    if (GetRoundState() == ROUND_PREP or (MG_CG.Survivors[ply] and (ent:IsPlayer() and MG_CG.Survivors[ent])) or (MG_CG.Infected[ply] and (ent:IsPlayer() and MG_CG.Infected[ent])) or (not ent:IsPlayer())) then
        return false
    end
end

function MG_CG.PlayerSpawn(ply)
    if (not IsValid(ply) or not MG_CG.Players[ply:EntIndex()]) then return end

    ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    MG_CG.GiveCorrectWeapon(ply)

    if (MG_CG.Infected[ply]) then
        ply.SpeedMod = 2
        timer.Simple(1, function()
            if (not IsValid(ply) or ply:Team() == TEAM_SPEC) then return end
            ply:SetModel(MG_CG.ModelPath)
            MG_CG.StripWeapons(ply)
            ply:Give("realistic_hook")
            ply:Give("weapon_ttt_jetpack")
            if (ply == MG_CG.FirstInfected) then
                ply:SetMaxHealth(125)
                ply:SetHealth(125)
                ply:SetColor(Color(255, 0, 0))
            else
                ply:SetMaxHealth(25)
                ply:SetHealth(25)
                ply:SetColor(Color(0, 255, 0))
            end
        end)
    end
end

function MG_CG.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_CG.DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
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

function MG_CG.GiveAmmo(ply)
    for k, v in pairs(MG_CG.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end

function MG_CG.UpTable(tbl, index, key)
    MG_CG[tbl][index][key] = MG_CG[tbl][index][key] + 1
end

function MG_CG.PlayerInfected(infector, infected)
    if (MG_CG.ContagionOver) then return end
    
    infected:Kill()

    MG_CG.Survivors[infected] = nil
    MG_CG.Infected[infected] = true

    MG_CG.CheckPlayerCount()

    if (MG_CG.ContagionOver) then return end

    MG_CG.TimeLeft = 120

    net.Start("MG_CG_UPDATETIME")
    net.Broadcast()

    infector:m_DropInventoryItem("endrounddrop", "endrounddrop", {tonumber(infector:GetInfo("moat_dropcosmetics")) == 1, tonumber(infector:GetInfo("moat_droppaint")) == 1})

    MOAT_ChatBroadcast(Color(0, 255, 0), infector:Nick() .. " has infected " .. infected:Nick() .. "!")
    
    local the_s = "s"
    if (table.Count(MG_CG.Survivors) <= 1) then
        the_s = ""
    end

    MOAT_ChatBroadcast(Color(0, 255, 255), table.Count(MG_CG.Survivors) .. " survivor" .. the_s .. " left!")

    net.Start("MG_CG_NEWINFECTED")
    net.WriteEntity(infected)
    net.Broadcast()
end

function MG_CG.CanInfectPlayer(inf, ply)

    return not util.TraceLine({start = inf:GetShootPos(), endpos = ply:GetShootPos()}).HitWorld
end

function MG_CG.InfectedCheck()
    if (GetRoundState() ~= ROUND_ACTIVE) then return end

    for ply, _ in pairs(MG_CG.Infected) do
        if (ply:Team() == TEAM_SPEC) then continue end
        
        local entsnear = ents.FindInSphere(ply:GetPos(), 50)
        if (#entsnear < 1) then continue end

        for k, v in pairs(entsnear) do
            if (v and v ~= NULL and v:IsPlayer() and v ~= ply and MG_CG.Survivors[v] and v:Team() ~= TEAM_SPEC and MG_CG.CanInfectPlayer(ply, v)) then
                MG_CG.PlayerInfected(ply, v)
                
                continue
            end
        end
    end
end

function MG_CG.PlayerDeath(vic, inf, att)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
    
    if (MG_CG.Players[vic:EntIndex()] and MG_CG.Players[vic:EntIndex()].survived) then
        MG_CG.Players[vic:EntIndex()].survived = false

        local orgtime = MG_CG.Players[vic:EntIndex()].survivaltime
        MG_CG.Players[vic:EntIndex()].survivaltime = CurTime() - orgtime
    end

    vic.SpeedMod = nil

    timer.Simple(1, function()
        MG_CG.RespawnPlayer(vic)
    end)

    if (not IsValid(vic) or not IsValid(att)) then return end
    if (not att:IsPlayer()) then return end

    if (vic == att) then
        return
    end

    MOAT_ChatBroadcast(Color(255, 255, 255), att:Nick(), Color(255, 0, 0), " " .. MG_CG.KillWords[math.random(1, #MG_CG.KillWords)] .. " ", Color(255, 255, 255), vic:Nick() .. "!")
end

local last_time_tick = CurTime()
function MG_CG.TimeLeftUpdate()
    if (last_time_tick <= CurTime() - 1 and not MG_CG.ContagionOver) then
        last_time_tick = CurTime()

        MG_CG.TimeLeft = math.Clamp(math.ceil(MG_CG.TimeLeft - 1), 0, 9999)

        if (MG_CG.TimeLeft <= 0) then
            MG_CG.DoEnding(true)
        end
    end
end

function MG_CG.CheckPlayerCount()
	local inf, infn = MG_CG.Infected, 0
	for k, v in pairs(inf) do
		if (not IsValid(k)) then continue end
		infn = infn + 1
	end
	if (infn == 0) then MG_CG.DoEnding(true) return end

	local sur, surn = MG_CG.Survivors, 0
	for k, v in pairs(sur) do
		if (not IsValid(k)) then continue end
		surn = surn + 1
	end
	if (surn <= 1) then MG_CG.DoEnding(false) return end

	local pls, plsn = MG_CG.Players, 0
	for k, v in pairs(pls) do
		if (not IsValid(Entity(k))) then continue end
		plsn = plsn + 1
	end
	if (plsn == 0) then MG_CG.DoEnding(true) end
end

function MG_CG.PlayerDisconnected(ply)
    -- poor players
    MG_CG.Players[ply:EntIndex()] = nil
    MG_CG.Infected[ply] = nil
    MG_CG.Survivors[ply] = nil
    MG_CG.CheckPlayerCount()
end

function MG_CG.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending
    
    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_CG.BeginRound()
    MOAT_CONTAGION_ROUND_ACTIVE = true

    MG_CG.HookAdd("CanPlayerSuicide", "MG_CG_STOPSUICIDE", function(ply) return false end)
    MG_CG.HookAdd("PlayerCanPickupWeapon", "MG_CG_PICKUP", MG_CG.CanPickupWeapon)
    
    MG_CG.TimeLeft = 120

    SetRoundEnd(CurTime() + 99999)

    net.Start("MG_CG_UPDATETIME")
    net.Broadcast()

    for k, v in RandomPairs(player.GetAll()) do
        if (v:Team() == TEAM_SPEC) then continue end
        
        MG_CG.Players[v:EntIndex()] = {survived = true, survivaltime = CurTime()}
        v:SetRole(ROLE_INNOCENT)
        MG_CG.Survivors[v] = true
        MG_CG.GiveAmmo(v)
        v.SpeedMod = nil

		if (MG_CG.FirstInfected) then continue end
        MG_CG.FirstInfected = v

        MG_CG.Survivors[v] = nil
        MG_CG.Infected[v] = true

        net.Start("MG_CG_NEWINFECTED")
        net.WriteEntity(v)
        net.Broadcast()

        v:Kill()

        MOAT_ChatBroadcast(Color(0, 255, 0), v:Nick() .. " is the first infected!")
    end

	MG_CG.CheckPlayerCount()
    MG_CG.HookAdd("PlayerDisconnected", "MG_CG_DISCONNECT", MG_CG.PlayerDisconnected)
end

function MG_CG.KarmaStuff()
    return true
end

function MG_CG.CanPickupWeapon(ply, wep)
	if (not MG_CG.DefaultLoadout[wep:GetClass()] and MG_CG.Infected[ply]) then
		return false
	end
end

function MG_CG.StopFallDamage(ent, dmginfo)
    if (ent:IsPlayer() and MG_CG.Infected[ent] and dmginfo:IsFallDamage()) then
        return true
    end
end

function MG_CG.PrepRound()
    MG_CG.ContagionOver = false
    MG_CG.HandleDamageLogStuff(false)
    MG_CG.TimeLeft = 180
    MG_CG.FirstInfected = nil

    MG_CG.HookAdd("PlayerSpawn", "MG_CG_SPAWN", MG_CG.PlayerSpawn)
    MG_CG.HookAdd("ttt.BeginRound", "MG_CG_BEGIN", MG_CG.BeginRound)
    MG_CG.HookAdd("TTTKarmaGivePenalty", "MG_CG_PREVENTKARMA", MG_CG.KarmaStuff)
    MG_CG.HookAdd("PlayerDeath", "MG_CG_DEATH", MG_CG.PlayerDeath)
    MG_CG.HookAdd("MoatInventoryShouldGiveLoadout", "MG_CG_PL", MG_CG.PreventLoadouts)
    MG_CG.HookAdd("PlayerShouldTakeDamage", "MG_CG_PL", MG_CG.ShouldTakeDamage)
    MG_CG.HookAdd("EntityTakeDamage", "MG_CG_ETG", MG_CG.StopFallDamage)
    MG_CG.HookAdd("Think", "MG_CG_TIMELEFTUPDATE", MG_CG.TimeLeftUpdate)
    MG_CG.HookAdd("Think", "MG_CG_INFECTEDCHECK", MG_CG.InfectedCheck)
	MG_CG.HookAdd("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents", function(att, vic)
		return att:GetRole() == vic:GetRole()
	end)

    for k, v in pairs(player.GetAll()) do
        if (IsValid(v) and v:Team() ~= TEAM_SPEC) then
            v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        end
    end

    hook.Add("TTTCheckForWin", "MG_CG_DELAYWIN", function() return WIN_NONE end)

    ttt.ExtendPrep()

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Contagion")

    net.Start "MG_CG_PREP"
    net.Broadcast()
end

concommand.Add("moat_start_contagion", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    MG_CG.PrepRound()
end)