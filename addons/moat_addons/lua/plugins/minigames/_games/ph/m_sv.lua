util.AddNetworkString("PH_I_Just_Joined")
util.AddNetworkString("PH_Begin")
util.AddNetworkString("PH_End")
util.AddNetworkString("PH_NewKills")
util.AddNetworkString("PH_Prep")
util.AddNetworkString("PH_Kill")
util.AddNetworkString("PH_KStreak")
util.AddNetworkString("PH.Role")

MG_PH = MG_PH or {}
MG_PH.Hooks = MG_PH.Hooks or {}
MG_PH.Players = MG_PH.Players or {}
MG_PH.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_PH.DefaultLoadout = {
}
MG_PH.JOver = false
MG_PH.KillsMax = 50
MG_PH.InProgress = MG_PH.InProgress or false
MG_PH.TimeEnd = MG_PH.TimeEnd or 0

function MG_PH.HookAdd(event, func)
    hook.Add(event, "MG_PH_" .. event, func)
    table.insert(MG_PH.Hooks, {event, "MG_PH_" .. event})
end

function MG_PH.RemoveHooks()
	for k, v in pairs(MG_PH.Hooks) do
		hook.Remove(v[1], v[2])
	end
end

function MG_PH:DoEnding(force)
	if (MOAT_MINIGAMES.CantEnd()) then return end

    for k,v in ipairs(player.GetAll()) do
        if v.ph_prop && IsValid(v.ph_prop) then
            v.ph_prop:Remove()
            v.ph_prop = nil
        end
    end
    MG_PH.RemoveHooks()
    MG_PH.ResetVars()
    MG_PH.HandleDamageLogStuff(true)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "MG_PH_DELAYWIN")
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    MG_PH.InProgress = false
end

function MG_PH.ResetVars()
    MG_PH.Hooks = {}
    MG_PH.Players = {}
	MG_PH.Loadout = {}
end

function MG_PH.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and v.Kind ~= WEAPON_UNARMED) then
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


function MG_PH.GiveAmmo(ply)
    for k, v in pairs(MG_TDM.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end


function MG_PH.PreventLoadouts()
    return true
end

function MG_PH.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_PH.DoKill(ply)
end
MG_PH.DeadProps = {}
function MG_PH.PlayerDeath(v, inf, att)
    if att:IsPlayer() and att.t_hunter then
        att:SetCredits(0)
        if not att.PHScore then att.PHScore = 0 end
        att.PHScore = att.PHScore + 1 
        net.Start("PH_Kill")
        net.WriteEntity(attacker)
        net.WriteString(v:Nick())
        net.Broadcast()
        att:SetHealth(att:Health() + 10)
    end
    if v.t_prop then
        table.insert(MG_PH.DeadProps,v)
    end
    if v.ph_prop && IsValid(v.ph_prop) then
        v.ph_prop:Remove()
        v.ph_prop = nil
    end
end

function MG_PH.FindCorpse(ply)
end

function MG_PH.RemoveCorpse(corpse)
end

function MG_PH.Move(ply,mv)
end

function MG_PH.RespawnPlayer(ply)

end

function MG_PH.GiveWeapon(ply,v)

end

function MG_PH.GiveWeapons(ply)
    MG_PH.StripWeapons(ply)
end

local sp_time = 5

function MG_PH.StartCommand(ply,cmd)

end

function MG_PH.PlayerSpawn(ply)
    ply.DidThing = false 
    ply:SetRole(ROLE_INNOCENT)
    ply:ResetEquipment()
    ply:SetCredits(0)
    ply:StripWeapons()
    ply:CollisionRulesChanged()
end
local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
function MG_PH.Win(props)
    if MG_PH.Won then return end
    MG_PH.Won = true
    timer.Simple(25, function() MG_PH:DoEnding() end)
    --print("WIN:",team)
    net.Start("PH_End")
    local t = {}
    if props then
        for k,v in pairs(MG_PH.DeadProps) do
            if not IsValid(v) then continue end
            if (not v:IsSpec()) and (v:Alive()) then continue end --?
            table.insert(t,{v,k})
        end
    end
    for k,v in pairs(player.GetAll()) do
        v:SetModelScale(1,0)
        v:ResetHull()
        v:SetColor( Color(255, 255, 255, 255))
        v.SpeedMod = 1
        if not v.PHScore then v.PHScore = 0 end
        if props and v.t_prop then
            if (not v:IsSpec()) and (v:Alive()) then
                table.insert(t,{v,math.Round(v.PHScore)})
            end
        elseif (not props) and v.t_hunter then
            table.insert(t,{v,math.Round(v.PHScore)})
        end
        v.t_hunter = nil
        v.t_prop = nil
        if v.ph_prop && IsValid(v.ph_prop) then
            v.ph_prop:Remove()
            v.ph_prop = nil
        end
    end
    MG_PH.DeadProps = {}
    table.sort(t,function(a,b) return a[2] > b[2] end)
    net.WriteBool(props or false)
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

function MG_PH.Kills()
    
end

function player.GetAlive()
	local tab = {}
	for _,Player in ipairs( player.GetAll() ) do
		if Player:Alive() and (not Player:IsSpec()) then
			table.insert( tab, Player )
		end
	end
	return tab
end

function MG_PH.Think()
    if not MG_PH.InProgress then return end
    local p,h = 0,0
    for k,v in ipairs(player.GetAll()) do
        v:SetCredits(0)
        if v:Alive() and (not v:IsSpec()) then 
            if not v.PHScore then v.PHScore = 0 end
            if v.t_prop then
                p = p + 1
                v.PHScore = v.PHScore + (v:Health()) + 1
            elseif v.t_hunter then
                h = h + 1
            end 
        end
    end
    if p < 1 then
        MG_PH.Win(false)
    end
    if h < 1 then
        MG_PH.Win(true)
    end
    if CurTime() > MG_PH.TimeEnd then
        MG_PH.Win(true)
    end

    if MG_PH.Won then return end
end

local SoundsList = {"vo/npc/male01/help01.wav", "ambient/voices/m_scream1.wav", "vo/npc/male01/myleg02.wav", "vo/npc/male01/myleg01.wav", "vo/npc/male01/ohno.wav", "vo/npc/male01/moan01.wav", "vo/npc/male01/moan03.wav", "vo/ravenholm/monk_helpme03.wav"}


function MG_PH.PlayerTick(Player)
end

function MG_PH.PostPlayerDeath(Player)
    if not MG_PH.InProgress then return end
    Player:Extinguish()
    Player.SpeedMod = 1
end

function MG_PH.TakeDamage(ent, dmginfo)
    local att = dmginfo:GetAttacker()
    if ent && ent:GetClass() ~= "ph_prop" && !ent:IsPlayer() && att && att:IsPlayer() && att.t_hunter && att:Alive() then
        if not ent.LastHitp then ent.LastHitp = {} end
        if (ent.LastHitp[att] or 0) > CurTime() then return end
        ent.LastHitp[att] = CurTime() + 0.1
        att:SetHealth(att:Health() - 5)
        att:SendLua([[surface.PlaySound("common/warning.wav")]])
        att:SendLua([[chat.AddText(Color(255,0,0),"That's not a player!")]])
        if att:Health() < 0 then att:Kill() end
    end

    if att == Entity(0) then return end
    if ent.t_prop and (not att.t_hunter) then dmginfo:ScaleDamage(0) return true end
    if att.t_hunter and ent.t_hunter then
        dmginfo:ScaleDamage(0)
        return true
    end
end

function MG_PH.PlayerShouldTakeDamage(ply,ent)
    if ent:GetClass() == "prop_physics" then return false end
    if ply:IsPlayer() and ent:IsPlayer() then
        if ply.t_prop and ent.t_prop then return false end
        if ply.t_hunter and ent.t_hunter then return false end
    end -- ?
end

function MG_PH.KarmaStuff()
    return true
end

function MG_PH.PlayerDisconnected(ply)

end

function MG_PH.PlayerSpeed(ply)
end

local EXPLOITABLE_DOORS = {
	"func_door",
	"prop_door_rotating", 
	"func_door_rotating"
}

local USABLE_PROP_ENTITIES = {
	"prop_physics",
	"prop_physics_multiplayer"
}

function PH_PROP(pl,ent)
    pl.prop_cool = CurTime() + 1
    local ent_health = math.Clamp(ent:GetPhysicsObject():GetVolume() / 250, 1, 200)
    local new_health = math.Clamp((pl.ph_prop.health / pl.ph_prop.max_health) * ent_health, 1, 200)
    local per = pl.ph_prop.health / pl.ph_prop.max_health
    pl.ph_prop.health = new_health
    
    pl.ph_prop.max_health = ent_health
    pl.ph_prop:SetModel(ent:GetModel())
    pl.ph_prop:SetSkin(ent:GetSkin())
    pl.ph_prop:SetSolid(SOLID_BSP)
    pl.ph_prop:SetPos(pl:GetPos() - Vector(0, 0, ent:OBBMins().z))
    pl.ph_prop:SetAngles(pl:GetAngles())
    
    local hullxymax = math.Round(math.Max(ent:OBBMaxs().x, ent:OBBMaxs().y))
    local hullxymin = hullxymax * -1
    local hullz = math.Round(ent:OBBMaxs().z)
    
    pl:SetHull(Vector(hullxymin, hullxymin, 0), Vector(hullxymax, hullxymax, hullz))
    pl:SetHullDuck(Vector(hullxymin, hullxymin, 0), Vector(hullxymax, hullxymax, hullz))
    pl:SetHealth(new_health)
    
    umsg.Start("SetHull", pl)
        umsg.Long(hullxymax)
        umsg.Long(hullz)
        umsg.Short(new_health)
    umsg.End()
end

function MG_PH.PlayerUse(pl, ent)
    if not pl.t_prop then return end
	if (not IsValid(pl) or not IsValid(ent)) then return end
    if pl:IsSpec() or (not pl:Alive()) then return end
    if (pl.prop_cool or 0) > CurTime() then return end
    if table.HasValue(USABLE_PROP_ENTITIES, ent:GetClass()) && ent:GetModel() then
        if IsValid(ent:GetPhysicsObject()) && pl.ph_prop:GetModel() != ent:GetModel() then
            PH_PROP(pl,ent)
        end
    end
	
	// Prevent the door exploit
	if table.HasValue(EXPLOITABLE_DOORS, ent:GetClass()) && pl.last_door_time && pl.last_door_time + 1 > CurTime() then
		return false
	end
	
	pl.last_door_time = CurTime()
	return true
end

function MG_PH.FireBullets(ent, data)
    if not ent:IsPlayer() then return end
    local e = ent:GetEyeTrace().Entity
    if IsValid(e) then
        if e:IsPlayer() then
            data.IgnoreEntity = e
        end
    end
end

function MG_PH.Loadout()
    return false
end

--MOVETYPE_LADDER
function MG_PH.PrepRound(mk, pri, sec, creds)
    TEST_PH = false
    MG_PH.Won = false
	MG_PH.JOver = false
	MG_PH.HandleDamageLogStuff(false)

    for k, v in pairs(player.GetAll()) do
        v.PHScore = 0
        MG_PH.StripWeapons(v)
        v:StripAmmo()
        v:ResetHull()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_PH.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end

	MG_PH.HookAdd("MoatInventoryShouldGiveLoadout", MG_PH.PreventLoadouts)
    MG_PH.HookAdd("PlayerUse", MG_PH.PlayerUse)
	MG_PH.HookAdd("ttt.BeginRound", MG_PH.BeginRound)
	MG_PH.HookAdd("CanPlayerSuicide", function(ply) return true end)
    MG_PH.HookAdd("PlayerDeath",MG_PH.PlayerDeath)
    MG_PH.HookAdd("PlayerSpawn",MG_PH.PlayerSpawn)
    MG_PH.HookAdd("Think",MG_PH.Think)
    MG_PH.HookAdd("EntityTakeDamage",MG_PH.TakeDamage)
    MG_PH.HookAdd("EntityFireBullets",MG_PH.FireBullets)
    MG_PH.HookAdd("PlayerShouldTakeDamage",MG_PH.PlayerShouldTakeDamage)
    MG_PH.HookAdd("Move",MG_PH.Move)
    MG_PH.HookAdd("TTTKarmaGivePenalty", MG_PH.KarmaStuff)
    MG_PH.HookAdd("PlayerDisconnected", MG_PH.PlayerDisconnected)
    MG_PH.HookAdd("StartCommand", MG_PH.StartCommand)
    MG_PH.HookAdd("TTTCanUseTraitorButton",function() return false end)
    MG_PH.HookAdd("PlayerTick",MG_PH.PlayerTick)
    MG_PH.HookAdd("PostPlayerDeath",MG_PH.PostPlayerDeath)
    MG_PH.HookAdd("TTTPlayerSpeed",MG_PH.PlayerSpeed)
    MG_PH.SpawnPoints = {}

    hook.Add("TTTCheckForWin", "MG_PH_DELAYWIN", function() return WIN_NONE end)

    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_PH.StripWeapons(v)
        v.IsBomb = false
        v.KilledByMe = false
    end

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Prop Hunt")
end


function MG_PH.BeginRound()
    MG_PH.DeadProps = {}
    SetRoundEnd(CurTime() + 900)
    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_PH.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    local total_active = 0
    for k,v in ipairs(player.GetAll()) do
        v:Spawn()
        v.t_prop = false
        v.t_hunter = false
        if not v:IsSpec() then
            total_active = total_active + 1
        end
    end
    local hunters = 0
    for i,v in RandomPairs(player.GetAll()) do
        MG_PH.StripWeapons(v)
        if (hunters <= (total_active * 0.3)) or (hunters < 3) then 
            v.t_hunter = true
            net.Start("PH.Role")
            net.WriteBool(true)
            net.Send(v)
            hunters = hunters + 1
            v:SetRole(ROLE_TRAITOR)
            v:Give("weapon_ttt_m16")
            v:Give("weapon_virustnt")
            v:Give("weapon_flakgun")
            timer.Simple(0,function()
                for i,o in pairs(v:GetWeapons()) do
                    function o:PreDrop()
                        self:Remove()
                    end
                    o.AllowDrop = false
                end
            end)
            MG_PH.GiveAmmo(v)
            timer.Simple(1,function()
                v:Lock()
                v:Freeze(true)
            end)
            timer.Simple(25,function()
                if IsValid(v) then
                    v:UnLock()
                    v:Freeze(false)
                end
            end)
            v.SpeedMod = 1.2
        else
            v.SpeedMod = 1.4
            timer.Simple(25,function()
                v.SpeedMod = 1
            end)
            v.t_prop = true
			v:SetModelScale(0,0)
            v:SetRenderMode( RENDERMODE_TRANSALPHA )
            v:SetColor( Color(255, 255, 255, 0))
            v.ph_prop = ents.Create("ph_prop")
            v.ph_prop:SetPos(v:GetPos())
            v.ph_prop:SetAngles(v:GetAngles())
            v.ph_prop:Spawn()
            v.ph_prop:SetSolid(SOLID_BBOX)
            v.ph_prop:SetParent(v)
            v.ph_prop:SetOwner(v)
            v:SetRole(ROLE_INNOCENT)
            v.ph_prop.max_health = 100
            
            timer.Simple(0.1,function()
                net.Start("PH.Role")
                net.WriteBool(false)
                net.WriteEntity(v.ph_prop)
                net.Send(v)
            end)
        end
    end
    MG_PH.InProgress = true
    MG_PH.TimeEnd = CurTime() + (#player.GetAll() * 13) + 30
    net.Start("PH_Begin")
    net.Broadcast()
end

concommand.Add("moat_start_PH", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end
	if (not IsValid(ply) and MSE.Player) then ply = MSE.Player end

	-- make sure we can start it on this map
	local found_ents = 0
	for k, v in pairs(USABLE_PROP_ENTITIES) do
		local e = ents.FindByClass(v)
		if (not e) then continue end

		found_ents = found_ents + #e
	end

    if (found_ents < 10) then
		if (IsValid(ply)) then
        	ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "There aren't enough props on the map to start!" )]])
		end

        return
    end

    ttt.ExtendPrep()

    net.Start("PH_Prep")
    net.Broadcast()

    MG_PH.PrepRound()
end)

concommand.Add("moat_end_PH", function(ply, cmd, args)
    if (not allowed_ids[ply:SteamID()]) then

        return
    end

    MG_PH.InProgress = false
    MG_PH.Win()
end)


function MG_PH.TrackSpawnPoints() 

end