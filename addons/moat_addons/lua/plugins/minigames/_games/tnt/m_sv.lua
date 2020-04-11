util.AddNetworkString("TNT_I_Just_Joined")
util.AddNetworkString("TNT_Begin")
util.AddNetworkString("TNT_End")
util.AddNetworkString("TNT_NewKills")
util.AddNetworkString("TNT_Prep")
util.AddNetworkString("TNT_Kill")
util.AddNetworkString("TNT_KStreak")

MG_TNT = MG_TNT or {}
MG_TNT.Hooks = MG_TNT.Hooks or {}
MG_TNT.Players = MG_TNT.Players or {}
MG_TNT.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_TNT.DefaultLoadout = {
}
MG_TNT.JOver = false
MG_TNT.KillsMax = 50
MG_TNT.InProgress = MG_TNT.InProgress or false
MG_TNT.TimeEnd = MG_TNT.TimeEnd or 0

function MG_TNT.HookAdd(event, func)
    hook.Add(event, "MG_TNT_" .. event, func)
    table.insert(MG_TNT.Hooks, {event, "MG_TNT_" .. event})
end

function MG_TNT.RemoveHooks()
	for k, v in pairs(MG_TNT.Hooks) do
		hook.Remove(v[1], v[2])
	end
end

function MG_TNT:DoEnding(force)
	if (MOAT_MINIGAMES.CantEnd()) then return end

    MG_TNT.RemoveHooks()
    MG_TNT.ResetVars()
    MG_TNT.HandleDamageLogStuff(true)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "MG_TNT_DELAYWIN")
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    MG_TNT.InProgress = false
end

function MG_TNT.ResetVars()
    MG_TNT.Hooks = {}
    MG_TNT.Players = {}
	MG_TNT.Loadout = {}
end

function MG_TNT.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_TNT.DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
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


function MG_TNT.GiveAmmo(ply)
end


function MG_TNT.PreventLoadouts()
    return true
end

function MG_TNT.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_TNT.DoKill(ply)
end

function MG_TNT.PlayerDeath(vic, inf, att)
end

function MG_TNT.FindCorpse(ply)
end

function MG_TNT.RemoveCorpse(corpse)
end

function MG_TNT.Move(ply,mv)
end

function MG_TNT.RespawnPlayer(ply)

end

function MG_TNT.GiveWeapon(ply,v)

end

function MG_TNT.GiveWeapons(ply)
    MG_TNT.StripWeapons(ply)
end

local sp_time = 5

function MG_TNT.StartCommand(ply,cmd)

end

function MG_TNT.PlayerSpawn(ply)
    ply.DidThing = false 
    ply:SetRole(ROLE_INNOCENT)
    ply:ResetEquipment()
    ply:SetCredits(0)
	MG_TNT.StripWeapons(ply)
    timer.Simple(1,function()
		if (not IsValid(ply)) then return end
        MG_TNT.StripWeapons(ply)
        ply:Give("tnt_fists")
        ply:SelectWeapon("tnt_fists")
        ply:ShouldDropWeapon(false)
    end)
    ply:SetCustomCollisionCheck(true)
    ply:CollisionRulesChanged()
    if ply.Skeleton then
        timer.Simple(1.1,function()
			if (not IsValid(ply)) then return end
            ply:SetModel("models/player/skeleton.mdl")
        end)
    end
end
local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
function MG_TNT.Win()
    if MG_TNT.Won then return end
    MG_TNT.Won = true
    timer.Simple(25, function() MG_TNT:DoEnding() end)
    --print("WIN:",team)
    net.Start("TNT_End")
    local t = {}
    for k,v in pairs(player.GetAll()) do
        v.SpeedMod = 1
        if not v.TNTScore then v.TNTScore = 0 end
        table.insert(t,{v,math.Round(v.TNTScore)})
    end
    table.sort(t,function(a,b) return a[2] > b[2] end)
    net.WriteTable(t)
    net.Broadcast()

    timer.Simple((0.2 * ((#t - 3) + 0.5 ) + (4.5)),function()
        for k, v in ipairs(t) do
            if not IsValid(v[1]) then continue end
            if (k == 1) then
                local es = math.random(1, 6)

                if (es == 6) then
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

function MG_TNT.Kills()
    
end

function player.GetAlive()
	local tab = {}
	for _,Player in ipairs( player.GetAll() ) do
		if Player:Alive() and (not Player:IsSpec()) and (not Player.Skeleton) then
			table.insert( tab, Player )
		end
	end
	return tab
end
/*
    local exp = ents.Create("env_explosion")
        exp:SetOwner(MG_HS.Current)
        exp:SetPos(MG_HS.Current:GetPos())
        exp:Spawn()
        exp:SetKeyValue("iMagnitude", "0")
        exp:Fire("Explode", 0, 0)
*/
function MG_TNT.Think()
    if not MG_TNT.InProgress then return end
    local i = 0
    for k,v in ipairs(player.GetAll()) do
        if v:Alive() and (not v:IsSpec()) and (not v.Skeleton) then 
            if not v.TNTScore then v.TNTScore = 0 end
            i = i + 1 
            v.TNTScore = v.TNTScore + 1 -- ik this is lazy
            if v.IsBomb then
                local diff = TNTFuseTime - CurTime()
                local speed = ((15 - diff))
                if not MG_TNT.Won then 
                    v.SpeedMod = 1 + (speed * 0.05)
                end
            end
        elseif v.Skeleton and v:Alive() then
            if IsValid(CurTNTBomb) then
                if v:GetPos():DistToSqr(CurTNTBomb:GetPos()) < 20000 then
                    v:Kill()
                end
            end
            if IsValid(CurTNTThrow) then
                if v:GetPos():DistToSqr(CurTNTThrow:GetPos()) < 20000 then
                    v:Kill()
                end
            end
        end
    end
    if i < 2 then
        MG_TNT.Win()
    end
    if CurTime() > MG_TNT.TimeEnd then
        MG_TNT.Win()
    end

    if MG_TNT.Won then return end
    if TNTFuseTime > CurTime() then
        --print("Blowing up in ", TNTFuseTime - CurTime())
    else
        if MG_TNT.BlewUp then return end
        for k,v in ipairs(ents.GetAll()) do
            if v.IsBomb then
                MG_TNT.BlewUp = true
                local exp = ents.Create("env_explosion")
                exp:SetOwner(v)
                exp:SetPos(v:GetPos())
                exp:Spawn()
                exp:SetKeyValue("iMagnitude", "0")
                exp:Fire("Explode", 0, 0)
                v:Kill()
                v.KilledByMe = true
            end
        end
        MG_TNT.BlewUp = true
        timer.Simple(0.1,function()
            local r = MG_TNT.RandomPlayer()
            TNTSetBomb(r)
            ChangeTNTFuseTime(15,true)--s
            MG_TNT.BlewUp = false
        end)
    end
end

local SoundsList = {"vo/npc/male01/help01.wav", "ambient/voices/m_scream1.wav", "vo/npc/male01/myleg02.wav", "vo/npc/male01/myleg01.wav", "vo/npc/male01/ohno.wav", "vo/npc/male01/moan01.wav", "vo/npc/male01/moan03.wav", "vo/ravenholm/monk_helpme03.wav"}


function MG_TNT.PlayerTick(Player)
end
util.AddNetworkString("TNT.Skeleton")
function MG_TNT.PostPlayerDeath(Player)
    if not MG_TNT.InProgress then return end
    Player:Extinguish()
    net.Start("TNT.Skeleton")
    net.WriteEntity(Player)
    net.Broadcast()
    Player.Skeleton = true
    Player:SetCustomCollisionCheck(true)
    Player:CollisionRulesChanged()
    Player.SpeedMod = 1
    timer.Simple(10,function()
        Player:SpawnForRound(true)
        Player:SetRole(ROLE_INNOCENT)
        Player:Spawn()
    end)
    print("Skeleton",Player)
end

function MG_TNT.TakeDamage(ply, dmginfo)
    if ply:IsPlayer() then
        if dmginfo:IsDamageType(DMG_CRUSH) or dmginfo:IsDamageType(DMG_BURN) then
            dmginfo:ScaleDamage(0)
        end
    end
end

function MG_TNT.PlayerShouldTakeDamage(ply,ent)
    if ent:GetClass() == "prop_physics" then return false end
    if ply:IsPlayer() and ent:IsPlayer() then return false end -- ?
end

function MG_TNT.KarmaStuff()
    return true
end

function MG_TNT.PlayerDisconnected(ply)

end

function MG_TNT.Collide(a,b)
    /*if a:IsPlayer() and b:IsPlayer() and (a:GetMoveType() == MOVETYPE_LADDER or b:GetMoveType() == MOVETYPE_LADDER) then
        return false
    end
    return true*/
end

function MG_TNT.PlayerSpeed(ply)
end

--MOVETYPE_LADDER
function MG_TNT.PrepRound(mk, pri, sec, creds)
    TEST_TNT = false
    MG_TNT.Won = false
	MG_TNT.JOver = false
	MG_TNT.HandleDamageLogStuff(false)

    for k, v in pairs(player.GetAll()) do
        MG_TNT.StripWeapons(v)
        v:StripAmmo()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_TNT.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end

	MG_TNT.HookAdd("MoatInventoryShouldGiveLoadout", MG_TNT.PreventLoadouts)
	MG_TNT.HookAdd("ttt.BeginRound", MG_TNT.BeginRound)
	MG_TNT.HookAdd("CanPlayerSuicide", function(ply) return true end)
    MG_TNT.HookAdd("PlayerDeath",MG_TNT.PlayerDeath)
    MG_TNT.HookAdd("PlayerSpawn",MG_TNT.PlayerSpawn)
    MG_TNT.HookAdd("Think",MG_TNT.Think)
    MG_TNT.HookAdd("EntityTakeDamage",MG_TNT.TakeDamage)
    MG_TNT.HookAdd("PlayerShouldTakeDamage",MG_TNT.PlayerShouldTakeDamage)
    MG_TNT.HookAdd("Move",MG_TNT.Move)
    MG_TNT.HookAdd("TTTKarmaGivePenalty", MG_TNT.KarmaStuff)
    MG_TNT.HookAdd("PlayerDisconnected", MG_TNT.PlayerDisconnected)
    MG_TNT.HookAdd("StartCommand", MG_TNT.StartCommand)
    MG_TNT.HookAdd("TTTCanUseTraitorButton",function() return false end)
    MG_TNT.HookAdd("PlayerTick",MG_TNT.PlayerTick)
    MG_TNT.HookAdd("PostPlayerDeath",MG_TNT.PostPlayerDeath)
    MG_TNT.HookAdd("ShouldCollide",MG_TNT.Collide)
    MG_TNT.HookAdd("TTTPlayerSpeed",MG_TNT.PlayerSpeed)
    MG_TNT.SpawnPoints = {}

    hook.Add("TTTCheckForWin", "MG_TNT_DELAYWIN", function() return WIN_NONE end)

    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_TNT.StripWeapons(v)
        v.IsBomb = false
        v.Skeleton = false
        v.KilledByMe = false
    end

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "TNT Tag")
end

function MG_TNT.RandomPlayer()
    local p = player.GetAll()

    for k,v in RandomPairs(p) do
        if (not v:Alive()) or (v:IsSpec()) or (v.Skeleton) then continue end

        local f = false
        for i,o in ipairs(p) do

            if (not o:Alive()) or (v:IsSpec()) or (v.Skeleton) then continue end

            if v:GetPos():DistToSqr(o:GetPos()) < 372154.71837072 then
                f = true
            end
        end
        if not f then
            return v
        end
    end

    for k,v in RandomPairs(p) do
        if v:Alive() and (not v:IsSpec()) and (not v.Skeleton) then
            return v
        end
    end
end


function MG_TNT.BeginRound()
    SetRoundEnd(CurTime() + 900)
    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_TNT.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    for k,v in ipairs(player.GetAll()) do
        if v.Skeleton then v.Skeleton = false v:Spawn() end
        v:SetRole(ROLE_INNOCENT)
        v.TNTScore = 0
        MG_TNT.StripWeapons(v)
        v:SetModel("models/player/leet.mdl")
        v:Give("tnt_fists")
        v:ShouldDropWeapon(false)
        v.SpeedMod = 1
        timer.Simple(0.1,function()
            v:SelectWeapon("tnt_fists")
        end)
    end
    local r = MG_TNT.RandomPlayer()
    TNTSetBomb(r)
    ChangeTNTFuseTime(15,true)
    MG_TNT.InProgress = true
    MG_TNT.TimeEnd = CurTime() + (#player.GetAll() * 15) + 30
    net.Start("TNT_Begin")
    net.Broadcast()

end

concommand.Add("moat_start_TNT", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    ttt.ExtendPrep()

    net.Start("TNT_Prep")
    net.Broadcast()

    MG_TNT.PrepRound(max_kills)
end)

concommand.Add("moat_end_TNT", function(ply, cmd, args)
    if (not allowed_ids[ply:SteamID()]) then

        return
    end

    MG_TNT.InProgress = false
    MG_TNT.Win()
end)


function MG_TNT.TrackSpawnPoints() 

end
