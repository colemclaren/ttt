if (util.NetworkStringToID"ttt_enable_tc" ~= 0) then
    print"loading terrorcity"
    DeriveGamemode"terrorcity"

    return
end

include("shared.lua")

-- Define GM12 fonts for compatibility
surface.CreateFont("DefaultBold", {
    font = "Tahoma",
    size = 13,
    weight = 1000
})

surface.CreateFont("TabLarge", {
    font = "Tahoma",
    size = 13,
    weight = 700,
    shadow = true,
    antialias = false
})

surface.CreateFont("Trebuchet22", {
    font = "Trebuchet MS",
    size = 22,
    weight = 900
})

include("scoring_shd.lua")
include("corpse_shd.lua")
include("player_ext_shd.lua")
include("weaponry_shd.lua")
include("vgui/ColoredBox.lua")
include("vgui/SimpleIcon.lua")
include("vgui/ProgressBar.lua")
include("vgui/ScrollLabel.lua")
include("cl_radio.lua")
include("cl_disguise.lua")
include("cl_transfer.lua")
include("cl_targetid.lua")
include("cl_search.lua")
include("cl_radar.lua")
include("cl_tbuttons.lua")
include("cl_scoreboard.lua")
include("cl_tips.lua")
include("cl_help.lua")
include("cl_hud.lua")
include("cl_msgstack.lua")
include("cl_hudpickup.lua")
include("cl_keys.lua")
include("cl_wepswitch.lua")
include("cl_scoring.lua")
include("cl_scoring_events.lua")
include("cl_popups.lua")
include("cl_equip.lua")
include("cl_voice.lua")
include "cl_chat.lua"
include "role_hooks.lua"

function GM:Initialize()
    -- MsgN("TTT Client initializing...")
    GAMEMODE.round_state = ROUND_WAIT
    LANG.Init()
    self.BaseClass:Initialize()
    RunConsoleCommand("ttt_spectate", GetConVar("ttt_spectator_mode"):GetInt())
end

function GM:InitPostEntity()
    -- MsgN("TTT Client post-init...")

    if not game.SinglePlayer() then
        timer.Create("idlecheck", 5, 0, CheckIdle)
    end

    -- make sure player class extensions are loaded up, and then do some
    -- initialization on them
    if IsValid(LocalPlayer()) and LocalPlayer().GetTraitor then
        GAMEMODE:ClearClientState()
    end

    timer.Create("cache_ents", 1, 0, GAMEMODE.DoCacheEnts)

	net.Start "TTTPlayerLoaded"
	net.SendToServer()

	RecvServerLang()
    RunConsoleCommand("_ttt_request_rolelist")
end

function GM:DoCacheEnts()
    RADAR:CacheEnts()
    TBHUD:CacheEnts()
end

function GM:HUDClear()
    RADAR:Clear()
    TBHUD:Clear()
end

KARMA = {}

function KARMA.IsEnabled()
    return GetGlobal("ttt_karma")
end

function GetRoundState()
    return GAMEMODE.round_state
end

local function RoundStateChange(o, n)
	local pls = player.GetAll()

    if n == ROUND_PREP then
        -- prep starts
        GAMEMODE:ClearClientState()
        GAMEMODE:CleanUpMap()

        -- show warning to spec mode players
        if GetConVar("ttt_spectator_mode"):GetBool() and IsValid(LocalPlayer()) then
            LANG.Msg("spec_mode_warning")
        end

		hook.Run("TTTPrepareRound")

		for k, v in ipairs(pls) do
			if (not IsValid(v)) then continue end
			v.traitor_gvoice = false

			hook.Run("TTTPrepareRoundPlayer", v)
		end
    elseif n == ROUND_ACTIVE then
        -- round starts
        VOICE.CycleMuteState(MUTE_NONE)
        CLSCORE:ClearPanel()

        -- clear blood decals produced during prep
        RunConsoleCommand("r_cleardecals")
		if (o ~= ROUND_PREP) then return end
		hook.Run("TTTBeginRound")

		for k, v in ipairs(pls) do
			if (not IsValid(v)) then continue end
			v.search_result = nil
			v.traitor_gvoice = false

			hook.Run("TTTBeginRoundPlayer", v)
		end
    elseif n == ROUND_POST then
        RunConsoleCommand("ttt_cl_traitorpopup_close")

		if (o ~= ROUND_ACTIVE) then return end
		hook.Run("TTTEndRound")

		for k, v in ipairs(pls) do
			if (not IsValid(v)) then continue end
			v.traitor_gvoice = false

			hook.Run("TTTEndRoundPlayer", v)
		end
    end
end

--- optional sound cues on round start and end
CreateConVar("ttt_cl_soundcues", "0", FCVAR_ARCHIVE)
local cues = {Sound("ttt/thump01e.mp3"), Sound("ttt/thump02e.mp3")}

local function PlaySoundCue()
    if GetConVar("ttt_cl_soundcues"):GetBool() then
        surface.PlaySound(table.Random(cues))
    end
end

GM.TTTBeginRound = PlaySoundCue
GM.TTTEndRound = PlaySoundCue

--- usermessages
local function ReceiveRole()
    local client = LocalPlayer()
    local role = net.ReadUInt(6)
    -- after a mapswitch, server might have sent us this before we are even done
    -- loading our code
    if not client.SetRole then return end
    client:SetRole(role)
    Msg("You are: ")

    if client:IsTraitor() then
        MsgN("TRAITOR")
    elseif client:IsDetective() then
        MsgN("DETECTIVE")
    elseif client:IsJester() then
        MsgN("JESTER")
    else
        MsgN("INNOCENT")
    end
end

net.Receive("TTT_Role", ReceiveRole)

local function ReceiveRoleList()
    local role = net.ReadUInt(6)
    local num_ids = net.ReadUInt(8)

    for i = 1, num_ids do
        local eidx = net.ReadUInt(7) + 1 -- we - 1 worldspawn=0
        local ply = player.GetByID(eidx)

        if IsValid(ply) and ply.SetRole then
            ply:SetRole(role)

            if ply:IsTraitor() then
                ply.traitor_gvoice = false -- assume traitorchat by default
            end
        end
    end
end

net.Receive("TTT_RoleList", ReceiveRoleList)

-- Round state comm
local function ReceiveRoundState()
    local o = GetRoundState()
    GAMEMODE.round_state = net.ReadUInt(3)

    if o ~= GAMEMODE.round_state then
        RoundStateChange(o, GAMEMODE.round_state)
    end

    MsgN("Round state: " .. GAMEMODE.round_state)
end

net.Receive("TTT_RoundState", ReceiveRoundState)

-- Cleanup at start of new round
function GM:ClearClientState()
    GAMEMODE:HUDClear()
    local client = LocalPlayer()
    if (not client.SetRole) then return end -- code not loaded yet

    client:SetRole(ROLE_INNOCENT)
    client.equipment_items = EQUIP_NONE
    client.equipment_credits = 0
    client.bought = {}
    client.last_id = nil
    client.radio = nil
    client.called_corpses = {}
    VOICE.InitBattery()

    for _, p in ipairs(player.GetAll()) do
        if IsValid(p) then
            p.sb_tag = nil
            p:SetRole(ROLE_INNOCENT)
            p.search_result = nil
        end
    end

    VOICE.CycleMuteState(MUTE_NONE)
    RunConsoleCommand("ttt_mute_team_check", "0")

    if GAMEMODE.ForcedMouse then
        gui.EnableScreenClicker(false)
    end
end

net.Receive("TTT_ClearClientState", GM.ClearClientState)

function GM:CleanUpMap()
    -- Ragdolls sometimes stay around on clients. Deleting them can create issues
    -- so all we can do is try to hide them.
    for _, ent in pairs(ents.FindByClass("prop_ragdoll")) do
        if IsValid(ent) and CORPSE.GetPlayerNick(ent, "") ~= "" then
            ent:SetNoDraw(true)
            ent:SetSolid(SOLID_NONE)
            ent:SetColor(Color(0, 0, 0, 0))
            -- Horrible hack to make targetid ignore this ent, because we can't
            -- modify the collision group clientside.
            ent.NoTarget = true
        end
    end

    -- This cleans up decals since GMod v100
    game.CleanUpMap()
end

-- server tells us to call this when our LocalPlayer has spawned
local function PlayerSpawn()
    local as_spec = net.ReadBit() == 1

    if as_spec then
        TIPS.Show()
    else
        TIPS.Hide()
    end
end

net.Receive("TTT_PlayerSpawned", PlayerSpawn)

local function PlayerDeath()
    TIPS.Show()
end

net.Receive("TTT_PlayerDied", PlayerDeath)

function GM:ShouldDrawLocalPlayer(ply)
    return false
end

local view = {
    origin = vector_origin,
    angles = angle_zero,
    fov = 0
}

local custom_fov = CreateClientConVar("moat_clfov", 0.428571429, true)
function GM:CalcView(ply, origin, angles, fov)
    view.origin = origin
    view.angles = angles

    -- first person ragdolling
    if ply:Team() == TEAM_SPEC and ply:GetObserverMode() == OBS_MODE_IN_EYE then
        local tgt = ply:GetObserverTarget()

        if IsValid(tgt) and (not tgt:IsPlayer()) then
            -- assume if we are in_eye and not speccing a player, we spec a ragdoll
            local eyes = tgt:LookupAttachment("eyes") or 0
            eyes = tgt:GetAttachment(eyes)

            if eyes then
                view.origin = eyes.Pos
                view.angles = eyes.Ang
            end
        end
    end

    local wep, lerp, sights, changed = ply:GetActiveWeapon(), true

    if (IsValid(wep)) then
		if (wep.Scope) then
			lerp = false
		end

        if (wep.GetTauntActive) then
            if (wep:GetTauntActive()) then
                sights = true
            end
        end

        if (wep.GetIronsights) then
            if (wep:GetIronsights()) then
                sights = true
            end
        end

        if (cur_random_round) then
            if cur_random_round == "High FOV" then
                sights = true
            end
        end

        local func = wep.CalcView
        view.drawviewer = false

        if (not sights) then
            view.fov = lerp and Lerp(FrameTime() * 10, view.fov, math.min(175, 75 + (math.min(custom_fov:GetFloat(), 3) * 35))) or math.min(175, 75 + (math.min(custom_fov:GetFloat(), 3) * 35))
			changed = true
        end

        if func then
            local o, a, f, d = func(wep, ply, origin * 1, angles * 1, view.fov)

            if (o) then
                view.origin, view.angles, view.fov, view.drawviewer = o, a, f, d
            end
        end
    elseif (not cur_random_round) or (cur_random_round and cur_random_round ~= "High FOV") then
		view.fov = lerp and Lerp(FrameTime() * 10, view.fov, math.min(175, 75 + (math.min(custom_fov:GetFloat(), 3) * 35))) or math.min(175, 75 + (math.min(custom_fov:GetFloat(), 3) * 35))
		changed = true
    end

	if (not changed) then
		view.fov = lerp and Lerp(FrameTime() * 10, view.fov, fov) or fov
	end

    return view
end

function GM:AddDeathNotice()
end

function GM:DrawDeathNotice()
end

function GM:Tick()
    local client = LocalPlayer()

    if IsValid(client) then
        if client:Alive() and client:Team() ~= TEAM_SPEC then
            WSWITCH:Think()
            RADIO:StoreTarget()
        end

        VOICE.Tick()
    end
end

-- Simple client-based idle checking
local idle = {
    ang = nil,
    pos = nil,
    mx = 0,
    my = 0,
    t = 0
}

function CheckIdle()
    local client = LocalPlayer()
    if not IsValid(client) then return end

    if not idle.ang or not idle.pos then
        -- init things
        idle.ang = client:GetAngles()
        idle.pos = client:GetPos()
        idle.mx = gui.MouseX()
        idle.my = gui.MouseY()
        idle.t = CurTime()

        return
    end

    if GetRoundState() == ROUND_ACTIVE and client:IsTerror() and client:Alive() then
        local idle_limit = GetGlobal("ttt_idle_limit")

        -- networking sucks sometimes
        if idle_limit <= 0 then
            idle_limit = 300
        end

        if client:GetAngles() ~= idle.ang then
            -- Normal players will move their viewing angles all the time
            idle.ang = client:GetAngles()
            idle.t = CurTime()
        elseif gui.MouseX() ~= idle.mx or gui.MouseY() ~= idle.my then
            -- Players in eg. the Help will move their mouse occasionally
            idle.mx = gui.MouseX()
            idle.my = gui.MouseY()
            idle.t = CurTime()
        elseif client:GetPos():Distance(idle.pos) > 10 then
            -- Even if players don't move their mouse, they might still walk
            idle.pos = client:GetPos()
            idle.t = CurTime()
        elseif CurTime() > (idle.t + idle_limit) then
            RunConsoleCommand("say", "(AUTOMATED MESSAGE) I have been moved to the Spectator team because I was idle/AFK.")

            timer.Simple(0.3, function()
                RunConsoleCommand("ttt_spectator_mode", 1)
                RunConsoleCommand("ttt_cl_idlepopup")
            end)
        elseif CurTime() > (idle.t + (idle_limit / 2)) then
            -- will repeat
            LANG.Msg("idle_warning")
        end
    end
end

function GM:OnEntityCreated(ent)
    -- Make ragdolls look like the player that has died
    if ent:IsRagdoll() then
        local ply = CORPSE.GetPlayer(ent)

        if IsValid(ply) then
            -- Only copy any decals if this ragdoll was recently created
            if ent:GetCreationTime() > CurTime() - 1 then
                ent:SnatchModelInstance(ply)
            end

            -- Copy the color for the PlayerColor matproxy
            local playerColor = ply:GetPlayerColor()
            ent.GetPlayerColor = function() return playerColor end
        end
    end

    return self.BaseClass.OnEntityCreated(self, ent)
end