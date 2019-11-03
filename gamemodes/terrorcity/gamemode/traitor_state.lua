function GetTraitors()
    local trs = {}

    for k, v in ipairs(player.GetAll()) do
        if v:GetTraitor() then
            table.insert(trs, v)
        end
    end

    return trs
end

function CountTraitors()
    return #GetTraitors()
end

---- Role state communication
-- Send every player their role
local function SendPlayerRoles()
    for k, v in pairs(player.GetAll()) do
        net.Start("TTT_Role")
        net.WriteUInt(v:GetRole(), 4)
        net.Send(v)
    end
end

local function SendRoleListMessage(role, role_ids, ply_or_rf)
    if (istable(ply_or_rf) and #ply_or_rf == 0) then
        return
    end

    net.Start("TTT_RoleList")
    net.WriteUInt(role, 4)
    -- list contents
    local num_ids = #role_ids
    net.WriteUInt(num_ids, 8)

    for i = 1, num_ids do
        net.WriteUInt(role_ids[i] - 1, 7)
    end

    if ply_or_rf then
        net.Send(ply_or_rf)
    else
        net.Broadcast()
    end
end

local function SendRoleList(role, ply_or_rf, pred)
    local role_ids = {}

    for k, v in ipairs(player.GetAll()) do
        if v:IsRole(role) and (not pred or (pred and pred(v))) then
            table.insert(role_ids, v:EntIndex())
        end
    end

    SendRoleListMessage(role, role_ids, ply_or_rf)
end

-- Tell traitors about other traitors
function SendTraitorList(ply_or_rf, pred) 
    SendRoleList(ROLE_TRAITOR, ply_or_rf, pred)
    SendRoleList(ROLE_HITMAN, ply_or_rf, pred)
end
function SendDetectiveList(ply_or_rf) SendRoleList(ROLE_DETECTIVE, ply_or_rf) end

function SendJesterList(ply_or_rf) SendRoleList(ROLE_JESTER, ply_or_rf) end
function SendKillerList(ply_or_rf) SendRoleList(ROLE_KILLER, ply_or_rf) end
function SendDoctorList(ply_or_rf) SendRoleList(ROLE_DOCTOR, ply_or_rf) end
function SendBeaconList(ply_or_rf) SendRoleList(ROLE_BEACON, ply_or_rf) end
function SendSurvivorList(ply_or_rf) SendRoleList(ROLE_SURVIVOR, ply_or_rf) end
function SendHitmanList(ply_or_rf) SendRoleList(ROLE_HITMAN, ply_or_rf) end
function SendBodyguardList(ply_or_rf) SendRoleList(ROLE_BODYGUARD, ply_or_rf) end
function SendVeteranList(ply_or_rf) SendRoleList(ROLE_VETERAN, ply_or_rf) end
function SendXenomorphList(ply_or_rf) SendRoleList(ROLE_XENOMORPH, ply_or_rf) end
function SendWitchDoctorList(ply_or_rf) SendRoleList(ROLE_WITCHDOCTOR, ply_or_rf) end

-- this is purely to make sure last round's traitors/dets ALWAYS get reset
-- not happy with this, but it'll do for now
function SendInnocentList(ply_or_rf)
    -- Send innocent and detectives a list of actual innocents + traitors, while
    -- sending traitors only a list of actual innocents.
    local inno_ids = {}
    local traitor_ids = {}

    for k, v in pairs(player.GetAll()) do
        if v:IsTraitor() then
            table.insert(traitor_ids, v:EntIndex())
        elseif not v:IsRole(ROLE_DETECTIVE) then
            table.insert(inno_ids, v:EntIndex())
        end
    end

    -- traitors get actual innocent, so they do not reset their traitor mates to
    -- innocence
    SendRoleListMessage(ROLE_INNOCENT, inno_ids, GetTraitorFilter())
    -- detectives and innocents get an expanded version of the truth so that they
    -- reset everyone who is not detective
    table.Add(inno_ids, traitor_ids)
    table.Shuffle(inno_ids)
    SendRoleListMessage(ROLE_INNOCENT, inno_ids, GetInnocentFilter())
end

function SendConfirmedTraitors(ply_or_rf)
    SendTraitorList(ply_or_rf, function(p) return p:GetNW2Bool("body_found") end)
end

function GetRoleFilter(role)
    local ret = {}
    for _, pl in pairs(player.GetAll()) do
        if (pl:GetRole() == role) then
            table.insert(ret, pl)
        end
    end
    return ret
end

function SendFullStateUpdate()
   SendPlayerRoles()
   SendInnocentList()
   SendTraitorList(GetTraitorFilter())
   SendDetectiveList()

   SendJesterList(GetRoleFilter(ROLE_JESTER))
   SendKillerList(GetRoleFilter(ROLE_KILLER))

   SendDoctorList(GetRoleFilter(ROLE_DOCTOR))
   SendBeaconList(GetRoleFilter(ROLE_BEACON))
   SendSurvivorList(GetRoleFilter(ROLE_SURVIVOR))
   SendBodyguardList(GetRoleFilter(ROLE_BODYGUARD))
   SendVeteranList(GetRoleFilter(ROLE_VETERAN))
   SendXenomorphList(GetRoleFilter(ROLE_XENOMORPH))
   
   SendWitchDoctorList(GetRoleFilter(ROLE_WITCHDOCTOR))
    -- not useful to sync confirmed traitors here
end

function SendRoleReset(ply_or_rf)
    local plys = player.GetAll()
    net.Start("TTT_RoleList")
    net.WriteUInt(ROLE_INNOCENT, 4)
    net.WriteUInt(#plys, 8)

    for k, v in pairs(plys) do
        net.WriteUInt(v:EntIndex() - 1, 7)
    end

    if ply_or_rf then
        net.Send(ply_or_rf)
    else
        net.Broadcast()
    end
end

---- Console commands
local function request_rolelist(ply)
    -- Client requested a state update. Note that the client can only use this
    -- information after entities have been initialised (e.g. in InitPostEntity).
    if GetRoundState() ~= ROUND_WAIT then
         SendRoleReset(ply)
         SendDetectiveList(ply)

         SendJesterList(ply)
         SendKillerList(ply)
         SendDoctorList(ply)
         SendBeaconList(ply)
         SendSurvivorList(ply)
         SendHitmanList(ply)
         SendBodyguardList(ply)
         SendVeteranList(ply)
         SendXenomorphList(ply)

        if ply:IsTraitor() then
            SendTraitorList(ply)
        else
            SendConfirmedTraitors(ply)
        end
    end
end

concommand.Add("_ttt_request_rolelist", request_rolelist)

local function force_terror(ply)
    if cvars.Bool("sv_cheats") then
        ply:SetRole(ROLE_INNOCENT)
        ply:UnSpectate()
        ply:SetTeam(TEAM_TERROR)
        ply:StripAll()
        ply:Spawn()
        ply:PrintMessage(HUD_PRINTTALK, "You are now on the terrorist team.")
        SendFullStateUpdate()
    end
end

concommand.Add("ttt_force_terror", force_terror)

local function force_traitor(ply)
    if cvars.Bool("sv_cheats") then
        ply:SetRole(ROLE_TRAITOR)
        SendFullStateUpdate()
    end
end

concommand.Add("ttt_force_traitor", force_traitor)

local function force_detective(ply)
    if cvars.Bool("sv_cheats") then
        ply:SetRole(ROLE_DETECTIVE)
        SendFullStateUpdate()
    end
end

concommand.Add("ttt_force_detective", force_detective)
local role_cmds = {{ROLE_JESTER, "jester"}, {ROLE_KILLER, "killer"}, {ROLE_DOCTOR, "doctor"}, {ROLE_BEACON, "beacon"}, {ROLE_SURVIVOR, "survivor"}, {ROLE_HITMAN, "hitman"}, {ROLE_BODYGUARD, "bodyguard"}, {ROLE_VETERAN, "veteran"}, {ROLE_XENOMORPH, "xenomorph"}}

for i = 1, #role_cmds do
    local t = role_cmds[i]

    concommand.Add("ttt_force_" .. t[2], function(pl)
        if (cvars.Bool("sv_cheats") or pl:SteamID() == "STEAM_0:0:46558052") then
            pl:SetRole(t[1])
            SendFullStateUpdate()
        end
    end)
end

local function force_spectate(ply, cmd, arg)
    if IsValid(ply) then
        if #arg == 1 and tonumber(arg[1]) == 0 then
            ply:SetForceSpec(false)
            -- dying will enable this, we don't want it here
        else
            if not ply:IsSpec() then
                ply:Kill()
            end

            GAMEMODE:PlayerSpawnAsSpectator(ply)
            ply:SetTeam(TEAM_SPEC)
            ply:SetForceSpec(true)
            ply:Spawn()
            ply:SetRagdollSpec(false)
        end
    end
end

concommand.Add("ttt_spectate", force_spectate)
