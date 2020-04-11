

util.AddNetworkString("TDM_I_Just_Joined")
util.AddNetworkString("TDM_Begin")
util.AddNetworkString("TDM_End")
util.AddNetworkString("TDM_NewKills")
util.AddNetworkString("TDM_Prep")
util.AddNetworkString("TDM_Kill")
util.AddNetworkString("TDM_KStreak")


MG_TDM = MG_TDM or {}
MG_TDM.Killstreaks_r = {
    [2] = {
        {
        name = "Double kill",
        reward = "a Radar", 
        fun = function(ply)
            ply:AddEquipmentItem(EQUIP_RADAR)
            ply:ConCommand("ttt_radar_scan")
        end
        },
        {
        name = "Double kill",
        reward = "a Flare gun", 
        fun = function(ply)
            ply:Give("weapon_ttt_flaregun")
        end
        },
        {
        name = "Double kill",
        reward = "a Freeze gun", 
        fun = function(ply)
            ply:Give("weapon_ttt_freezegun")
        end
        },
    },
    [4] = { 
        {
        name = "Quadruple kill",
        reward = "Double ammo clip",
        fun = function(ply)
            for k,v in pairs(ply:GetWeapons()) do
                v:SetClip1(v:GetMaxClip1() * 2)
                v.Primary.ClipSize = v.Primary.ClipSize * 2
            end
        end
        },
        {
        name = "Quadruple kill",
        reward = "Hermes boots",
        fun = function(ply)
            ply:AddEquipmentItem(EQUIP_HERMES_BOOTS)
        end
        },
        {
        name = "Quadruple kill",
        reward = "a Boomerang",
        fun = function(ply)
            ply:Give("weapon_ttt_boomerang")
        end
        },
        {
        name = "Quadruple kill",
        reward = "a Harpoon",
        fun = function(ply)
            ply:Give("ttt_m9k_harpoon")
        end
        },
        
    },
    [6] = {
        {
        name = "Sextuple kill",
        reward = "a Health Station",
        fun = function(ply)
            ply:Give("weapon_ttt_health_station")
        end
        },
        {
            name = "Sextuple kill",
            reward = "Body Armor",
            fun = function(ply)
                ply:AddEquipmentItem(EQUIP_ARMOR)
            end
        }
    },
    [8] = {
        {
        name = "Octuple kill",
        reward = "50 extra HP",
        fun = function(ply)
            ply:SetHealth(ply:Health() + 50)
        end
        },
        {
        name = "Octuple kill",
        reward = "a Silenced AWP",
        fun = function(ply)
            ply:Give("weapon_ttt_awp")
        end
        },
        {
            name = "Octuple kill",
            reward = "a S&W 500",
            fun = function(ply)
                ply:Give("weapon_ttt_revolver")
            end
        },
        {
        name = "Octuple kill",
        reward = "25% more RPM",
        fun = function(ply)
            for k,v in pairs(ply:GetWeapons()) do
                v.Primary.Delay = v.Primary.Delay - (v.Primary.Delay/8)
            end
        end
        },
    },
    [15] = {
        name = "15th kill",
        reward = "Jihad Bomb",
        fun = function(ply)
            ply:Give("weapon_ttt_jihad")
        end
    }
}
MG_TDM.Hooks = MG_TDM.Hooks or {}
MG_TDM.Players = MG_TDM.Players or {}
MG_TDM.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_TDM.DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true
}
MG_TDM.TDMOver = false
MG_TDM.KillsMax = 50
MG_TDM.InProgress = MG_TDM.InProgress or false
MG_TDM.Kills = MG_TDM.Kills or {
	r = 0,
	b = 0
}
MG_TDM.Loadout = {
	prim = "weapon_ttt_m16",
	sec = "weapon_zm_revolver",
	cred = false
}
MG_TDM.TimeEnd = MG_TDM.TimeEnd or 0

net.Receive("TDM_I_Just_Joined",function(l,ply)
    if not MG_TDM.InProgress then return end
    if ply.tdm_jk then return end
    ply.tdm_jk = true
    net.Start("TDM_I_Just_Joined")
    net.WriteInt(MG_TDM.KillsMax,8)
    net.WriteInt(MG_TDM.Kills.b,8)
    net.WriteInt(MG_TDM.Kills.r,8)
    net.WriteInt(MG_TDM.TimeEnd,32)
    net.Send(ply)
end)

function MG_TDM.HookAdd(event, func)
    hook.Add(event, "MG_TDM_" .. event, func)
    table.insert(MG_TDM.Hooks, {event, "MG_TDM_" .. event})
end

function MG_TDM.RemoveHooks()
	for k, v in pairs(MG_TDM.Hooks) do
		hook.Remove(v[1], v[2])
	end
end

function MG_TDM:DoEnding(force)
	if (MOAT_MINIGAMES.CantEnd()) then return end

    MG_TDM.RemoveHooks()
    MG_TDM.ResetVars()
    MG_TDM.HandleDamageLogStuff(true)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "MG_TDM_DELAYWIN")
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    MG_TDM.InProgress = false
    timer.Remove("TDM.SpawnPoints")
end

function MG_TDM.ResetVars()
    MG_TDM.Hooks = {}
    MG_TDM.Players = {}
	MG_TDM.Kills = {
		r = 0,
		b = 0
	}
	MG_TDM.Loadout = {
		prim = "weapon_ttt_m16",
		sec = "weapon_zm_revolver",
		cred = false
	}
    MG_TDM.NoSecondary = false
end

function MG_TDM.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_TDM.DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
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

function MG_TDM.GiveAmmo(ply)
    for k, v in pairs(MG_TDM.AmmoTypes) do
        ply:GiveAmmo(9999, v, true)
    end
end


function MG_TDM.PreventLoadouts()
    return true
end

function MG_TDM.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_TDM.DoKill(ply)
	if (not ply.KillStreak) then ply.KillStreak = 0 end

    ply.KillStreak = ply.KillStreak + 1
    if not MG_TDM.Killstreaks then return end
    if MG_TDM.Killstreaks_r[ply.KillStreak] then
        if MG_TDM.Killstreaks_r[ply.KillStreak][1] then
            local v = table.Random(MG_TDM.Killstreaks_r[ply.KillStreak])
            v.fun(ply)
            net.Start("TDM_KStreak")
            net.WriteBool(ply:GetRole() == ROLE_DETECTIVE)
            net.WriteEntity(ply)
            net.WriteString(v.name)
            net.WriteString(v.reward)
            net.Broadcast()
        else
            MG_TDM.Killstreaks_r[ply.KillStreak].fun(ply)
            net.Start("TDM_KStreak")
            net.WriteBool(ply:GetRole() == ROLE_DETECTIVE)
            net.WriteEntity(ply)
            net.WriteString(MG_TDM.Killstreaks_r[ply.KillStreak].name)
            net.WriteString(MG_TDM.Killstreaks_r[ply.KillStreak].reward)
            net.Broadcast()
        end
    end
end

function MG_TDM.PlayerDeath(vic, inf, att)
	timer.Simple(5, function()
        if not IsValid(vic) then return end
		MG_TDM.RespawnPlayer(vic)
	end)

	if (att == vic) then return end
	if (att ~= vic and att:IsPlayer()) then
        MG_TDM.DoKill(att)
        vic:SetCredits(0)
        timer.Simple(1,function()
            if not IsValid(att) then return end
            att:SetCredits(0)
        end)

		MG_TDM.Kills.r = (att.TDMRole == ROLE_TRAITOR and (MG_TDM.Kills.r + 1)) or MG_TDM.Kills.r
		MG_TDM.Kills.b = (att.TDMRole == ROLE_DETECTIVE and (MG_TDM.Kills.b + 1)) or MG_TDM.Kills.b
        net.Start("TDM_NewKills")
        net.WriteInt(MG_TDM.Kills.b,8)
        net.WriteInt(MG_TDM.Kills.r,8)
        net.Broadcast()

        net.Start("TDM_Kill")
        net.WriteEntity(att)
        net.WriteBool(att:GetRole() == ROLE_DETECTIVE)
        net.WriteEntity(vic)
        net.WriteBool(vic:GetRole() == ROLE_DETECTIVE)
        net.Broadcast()
	end
end

function MG_TDM.FindCorpse(ply)
    if (not IsValid(ply)) then return end
    
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
        if (v.uqid == ply:UniqueID() and IsValid(v)) then
            return v or false
        end
    end
end

function MG_TDM.RemoveCorpse(corpse)
    player.GetByUniqueID(corpse.uqid):SetNW2Bool("body_found", false)
    corpse:Remove()
end

function MG_TDM.Move(ply,mv)
    if mv:GetButtons() ~= 0 then
        ply.T_Moved = CurTime() + 7.5
    end
end

function MG_TDM.RespawnPlayer(ply)
    if (not IsValid(ply)) then return end

	local indx = ply:EntIndex()
    timer.Create("respawn_player"..indx, 0.1, 0, function()
        if (not IsValid(ply)) then timer.Remove("respawn_player"..indx) return end
		if (not MG_TDM.InProgress) then timer.Remove("respawn_player"..indx) return end

        local corpse = MG_TDM.FindCorpse(ply)
        if (corpse) then 
            MG_TDM.RemoveCorpse(corpse)
        end
        if (ply.T_Moved or 0) > CurTime() then
            ply:SpawnForRound(true)
            ply:SetRole(ply.TDMRole or ROLE_DETECTIVE)
        end

        if (ply:IsActive()) then timer.Remove("respawn_player"..indx) return end
    end)
end
local item_kind_codes = {
    ["tier"] = "1"
}
function MG_TDM.GiveWeapon(ply,v)
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

util.AddNetworkString("MOAT_NO_STORED")

net.Receive("MOAT_NO_STORED", function(_, ply)
	local wpn = net.ReadString()
	local indx = net.ReadUInt(16)
	if (not wpn or not indx or not ply.TDM_Cache or not ply.TDM_Cache[wpn]) then return end
	
	net.Start("MOAT_UPDATE_WEP")
		net.WriteString(wpn)
		net.WriteUInt(indx, 16)
		net.WriteBool(true)
    	net.WriteTable(ply.TDM_Cache[wpn] or {})
	net.Send(ply)
end)

function MG_TDM.GiveWeapons(ply)
    MG_TDM.StripWeapons(ply)
	if (MG_TDM.Loadout.prim) then
		MG_TDM.GiveWeapon(ply,MG_TDM.Loadout.prim)
	end

	if (MG_TDM.Loadout.sec and MG_TDM.Loadout.sec ~= "nothing") then
		MG_TDM.GiveWeapon(ply,MG_TDM.Loadout.sec)
	end

	if (MG_TDM.Loadout.cred) then
		
	end
    timer.Simple(0,function()
        for k,v in pairs(ply:GetWeapons()) do
            function v:PreDrop()
                self:Remove()
            end
            v.AllowDrop = false
            if MG_TDM.Loadout.prim then
                if not istable(MG_TDM.Loadout.prim) then
                    ply:SelectWeapon(MG_TDM.Loadout.prim)
                else
                    ply:SelectWeapon(MG_TDM.Loadout.prim.w or "")
                end
            elseif (MG_TDM.Loadout.sec and MG_TDM.Loadout.sec ~= "nothing") then
                if not istable(MG_TDM.Loadout.sec) then
                    ply:SelectWeapon(MG_TDM.Loadout.sec)
                else
                    ply:SelectWeapon(MG_TDM.Loadout.sec.w or "")
                end
            end
        end
    end)
end

local sp_time = 5

function MG_TDM.StartCommand(ply,cmd)
    if not ply:Alive() then return end
    if ply.SpawnProtection then
        if cmd:KeyDown(IN_ATTACK) then
            ply.SpawnProtection = false
            ply:SetRenderMode(RENDERMODE_NORMAL)
            if ply:GetRole() == ROLE_TRAITOR then
                ply:SetColor(Color(255,0,0,255))
            else
                ply:SetColor(Color(0,0,255,255))
            end
            timer.Simple(1,function()
                if ply:GetRole() == ROLE_TRAITOR then
                    ply:SetColor(Color(255,0,0,255))
                else
                    ply:SetColor(Color(0,0,255,255))
                end
            end)
            ply:SetNW2Int("MG_TDM_SPAWNPROTECTION",0)
        end
    end
end

function MG_TDM.PlayerSpawn(ply)
    ply:ResetEquipment()
    ply:SetCredits(0)
    timer.Simple(0,function() MG_TDM.GiveWeapons(ply) end)
    MG_TDM.GiveAmmo(ply)
    ply:ShouldDropWeapon(false)
    ply.KillStreak = 0
    ply.SpawnProtection = true
    ply:SetNW2Int("MG_TDM_SPAWNPROTECTION",CurTime() + sp_time)
    ply:SetRenderMode(RENDERMODE_TRANSALPHA)
    timer.Simple(0.1,function()
        ply:ResetEquipment()
        if ply:GetRole() == ROLE_TRAITOR then
            ply:SetColor(Color(255,0,0,100))
        else
            ply:SetColor(Color(0,0,255,100))
        end
    end)
    timer.Simple(1,function()
        if not IsValid(ply) then return end
        ply:SetModel(GAMEMODE.playermodel or "models/player/phoenix.mdl")
        if ply:GetRole() == ROLE_TRAITOR then
            ply:SetColor(Color(255,0,0,100))
        else
            ply:SetColor(Color(0,0,255,100))
        end
    end)
    timer.Simple(sp_time,function()
        if not IsValid(ply) then return end
        if not ply.SpawnProtection then return end
        ply.SpawnProtection = false
        ply:SetRenderMode(RENDERMODE_NORMAL)
        if ply:GetRole() == ROLE_TRAITOR then
            ply:SetColor(Color(255,0,0,255))
        else
            ply:SetColor(Color(0,0,255,255))
        end
    end)
end
local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
function MG_TDM.Win(team)
    timer.Simple(25, function() MG_TDM:DoEnding() end)
    --print("WIN:",team)
    net.Start("TDM_End")
    local t = {}
    if team then
        for k,v in pairs(MG_TDM.Players.r) do
            if not IsValid(v) then continue end
            table.insert(t,{v,math.Round(v.TDMDamage)})
        end
    else
        for k,v in pairs(MG_TDM.Players.b) do
            if not IsValid(v) then continue end
            table.insert(t,{v,math.Round(v.TDMDamage)})
        end
    end
    table.sort(t,function(a,b) return a[2] > b[2] end)
    net.WriteTable(t)
    net.WriteBool(team)
    net.Broadcast()

    timer.Simple((0.2 * ((#t - 3) + 0.5 ) + (4.5)),function()
        for k, v in ipairs(t) do
            if not IsValid(v[1]) then continue end
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


function MG_TDM.Think()
    if not MG_TDM.InProgress then return end

    if (MG_TDM.Kills.r >= MG_TDM.KillsMax) then
        MG_TDM.InProgress = false
        MG_TDM.Win(true)
	elseif (MG_TDM.Kills.b >= MG_TDM.KillsMax) then
        MG_TDM.InProgress = false
        MG_TDM.Win(false)
	end

    if MG_TDM.TimeEnd < CurTime() then
        MG_TDM.InProgress = false
        local r = MG_TDM.Kills.r > MG_TDM.Kills.b
        MG_TDM.Win(r)
    end
end

function MG_TDM.TakeDamage(ply, dmginfo)
    if (IsValid(ply) and ply:IsPlayer() and dmginfo:GetDamage() >= 1 and dmginfo:GetAttacker():IsPlayer() and GetRoundState() == ROUND_ACTIVE and (ply:GetRole() ~= dmginfo:GetAttacker():GetRole())) then
        local att = dmginfo:GetAttacker()
        if (not att.TDMDamage) then
            att.TDMDamage = 0
        end
        if (ply.SpawnProtection and att:IsPlayer() and (ply ~= att)) or (att.SpawnProtection and ply:IsPlayer() and (ply ~= att)) then return end
        --print(ply:Health(),"Add: ",(math.min(dmginfo:GetDamage(),ply:Health())))
        att.TDMDamage = att.TDMDamage + (math.min(dmginfo:GetDamage(),ply:Health()))
    elseif (IsValid(ply) and ply:IsPlayer() and dmginfo:GetDamage() >= 1 and dmginfo:GetAttacker():IsPlayer() and GetRoundState() == ROUND_ACTIVE and ply:GetRole() == dmginfo:GetAttacker():GetRole()) then
        return false
    end
end

function MG_TDM.PlayerShouldTakeDamage(ply,ent)
    if ply.SpawnProtection or ent.SpawnProtection then
        return false
    end
    if (ent:IsPlayer() and ply:GetRole() == ent:GetRole()) then
        return false
    end
    if (((not ent:IsPlayer()) and (not ent:IsWorld())) or GetRoundState() == ROUND_PREP) then return false end
end

function MG_TDM.KarmaStuff()
    return true
end

function MG_TDM.PlayerDisconnected(ply)

end

function MG_TDM:PrepRound(mk, pri, sec, creds)
	MG_TDM.TDMOver = false
	MG_TDM.HandleDamageLogStuff(false)

    for k, v in pairs(player.GetAll()) do
        MG_TDM.StripWeapons(v)
        v:StripAmmo()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_TDM.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end

    MG_TDM.Kills = {
		r = 0,
		b = 0
	}
    

	MG_TDM.HookAdd("MoatInventoryShouldGiveLoadout", MG_TDM.PreventLoadouts)
	MG_TDM.HookAdd("ttt.BeginRound", MG_TDM.BeginRound)
	MG_TDM.HookAdd("CanPlayerSuicide", function(ply) return true end)
    MG_TDM.HookAdd("PlayerDeath",MG_TDM.PlayerDeath)
    MG_TDM.HookAdd("PlayerSpawn",MG_TDM.PlayerSpawn)
    MG_TDM.HookAdd("Think",MG_TDM.Think)
    MG_TDM.HookAdd("EntityTakeDamage",MG_TDM.TakeDamage)
    MG_TDM.HookAdd("PlayerShouldTakeDamage",MG_TDM.PlayerShouldTakeDamage)
    MG_TDM.HookAdd("Move",MG_TDM.Move)
    MG_TDM.HookAdd("TTTKarmaGivePenalty", MG_TDM.KarmaStuff)
    MG_TDM.HookAdd("PlayerDisconnected", MG_TDM.PlayerDisconnected)
    MG_TDM.HookAdd("StartCommand", MG_TDM.StartCommand)
    MG_TDM.HookAdd("TTTCanUseTraitorButton",function() return false end)
    MG_TDM.SpawnPoints = {}
    timer.Create("TDM.SpawnPoints",5,0,MG_TDM.TrackSpawnPoints)


    hook.Add("TTTCheckForWin", "MG_TDM_DELAYWIN", function() return WIN_NONE end)

    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_TDM.StripWeapons(v)
        v:StripAmmo()
        v.TDM_Cache = {}
    end

	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Team Deathmatch")
end

function MG_TDM.DecideTeams(pls)
    MG_TDM.Players = {r = {},b = {}}

	for i,v in RandomPairs(player.GetAll()) do
		table.insert(MG_TDM.Players, v)

		if (i % 2 == 0) then 
			v.TDMRole = ROLE_TRAITOR
			v:SetRole(ROLE_TRAITOR)
            table.insert(MG_TDM.Players.r,v)
		else
			v.TDMRole = ROLE_DETECTIVE
			v:SetRole(ROLE_DETECTIVE)
            table.insert(MG_TDM.Players.b,v)
		end
		
        
		v:SetCredits(0)
	end
end

function MG_TDM.BeginRound()
    SetRoundEnd(CurTime() + 900)
    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_TDM.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    MG_TDM.InProgress = true
    MG_TDM.TimeEnd = CurTime() + (60 * 10)
    net.Start("TDM_Begin")
    net.WriteInt(MG_TDM.KillsMax,8)
    net.Broadcast()

    local pls = player.GetAll()

    for k, v in pairs(pls) do
        MG_TDM.StripWeapons(v)
        v:StripAmmo()
        MG_TDM.GiveWeapons(v)
        MG_TDM.GiveAmmo(v)
        v.KillStreak = 0
        v.TDMDamage = 0
        timer.Simple(1.1,function()
            if not IsValid(v) then return end
            v:SetModel(GAMEMODE.playermodel or "models/player/phoenix.mdl")
            if v:GetRole() == ROLE_TRAITOR then
                v:SetColor(Color(255,0,0))
            else
                v:SetColor(Color(0,0,255))
            end
        end)
    end

    MG_TDM.DecideTeams(pls)
    print("Begin round")
end

concommand.Add("moat_start_tdm", function(ply, cmd, args)
    if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then

        return
    end


    local max_kills = tonumber(args[1]) or 25
    max_kills = math.max(25,math.min(max_kills,75)) -- max kills
    MG_TDM.KillsMax = max_kills
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

    MG_TDM.Loadout.prim = prim_wep

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

    MG_TDM.Loadout.sec = sec_wep

    local creds = tobool(args[4]) or false

    MG_TDM.Killstreaks = creds

    ttt.ExtendPrep()

    net.Start("TDM_Prep")
    net.WriteInt(max_kills,8)
    net.WriteBool(creds)
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

    MG_TDM.PrepRound(max_kills, prim_wep, sec_wep, creds)
end)

concommand.Add("moat_end_tdm", function(ply, cmd, args)
    if (not allowed_ids[ply:SteamID()]) then

        return
    end

    MG_TDM.InProgress = false
    local r = MG_TDM.Kills.r > MG_TDM.Kills.b
    MG_TDM.Win(r)
end)


function MG_TDM.TrackSpawnPoints() 
    if not MG_TDM.SpawnPoints then MG_TDM.SpawnPoints = {} end
    for k,v in ipairs(player.GetAll()) do
        if v:Alive() and v:IsOnGround() and (not v:IsSpec()) and (not v:Crouching()) then
            table.insert(MG_TDM.SpawnPoints,v:GetPos())
        end
    end
end

--make a custom spawnpoint func
hook.Add("PostGamemodeLoaded", "MG_TDM_POSTGAMEMODE", function()
    function GAMEMODE:IsSpawnpointSuitable(ply, spwn, force, rigged)
        if not IsValid(ply) or not ply:IsTerror() then return true end

        timer.Simple(0,function() -- Next frame
            if not IsValid(ply) then return end
            if not MG_TDM.InProgress then return end
            if not MG_TDM.SpawnPoints then return end
            for _,v in RandomPairs(MG_TDM.SpawnPoints) do
                local i = false
                for _,p in ipairs(player.GetAll()) do
                    if p:GetPos():Distance(v) < 10 then i = true break end
                    if p:GetPos():Distance(v) < 500 and (p:GetRole() ~= ply:GetRole()) and p:Alive() then 
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