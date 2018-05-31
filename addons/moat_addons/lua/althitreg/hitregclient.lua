surface.CreateFont("moat_LabelFont", {
    font = "DermaLarge",
    size = 16,
    weight = 1200
})

local function moat_BoolToNum(bool)
    local num = 0

    if (tostring(bool) == "true") then
        num = 1
    end

    return num
end

if (not ConVarExists("moat_alt_hitreg")) then
    CreateClientConVar("moat_alt_hitreg", moat_BoolToNum(MOAT_HITREG.HitRegDefaultEnabled), true, true) -- Default disabled
end

if (not ConVarExists("moat_hitmarkers")) then
    CreateClientConVar("moat_hitmarkers", moat_BoolToNum(MOAT_HITREG.HitmarkerDefaultEnabled), true, true)
end

if (not ConVarExists("moat_hitmarker_sound")) then
    CreateClientConVar("moat_hitmarker_sound", moat_BoolToNum(MOAT_HITREG.HitMarkerSoundDefaultEnabled), true, false)
end

if (not ConVarExists("moat_hitmarker_size")) then
    CreateClientConVar("moat_hitmarker_size", MOAT_HITREG.HitMarkerSizeDefault, true, false)
end

if (not ConVarExists("moat_hitmarker_color_r")) then
    CreateClientConVar("moat_hitmarker_color_r", MOAT_HITREG.HitMarkerColorDefault.r, true, false)
end

if (not ConVarExists("moat_hitmarker_color_g")) then
    CreateClientConVar("moat_hitmarker_color_g", MOAT_HITREG.HitMarkerColorDefault.g, true, false)
end

if (not ConVarExists("moat_hitmarker_color_b")) then
    CreateClientConVar("moat_hitmarker_color_b", MOAT_HITREG.HitMarkerColorDefault.b, true, false)
end

if (not ConVarExists("moat_hitmarker_color_a")) then
    CreateClientConVar("moat_hitmarker_color_a", MOAT_HITREG.HitMarkerColorDefault.a or 255, true, false)
end

local moat_Settings = {}
moat_Settings[1] = {"Enable alternative hit registration?", {"Yes", "No"}, "moat_alt_hitreg"}
moat_Settings[2] = {"Enable hitmarkers?", {"Yes", "No"}, "moat_hitmarkers"}
moat_Settings[3] = {"Enable hitmarker sound?", {"Yes", "No"}, "moat_hitmarker_sound"}
moat_Settings[4] = {"Hitmarker Size", {"Small", "Normal", "Large"}, "moat_hitmarker_size"}
moat_Settings[5] = {"Hitmarker Color", {"moat_hitmarker_color_r", "moat_hitmarker_color_g", "moat_hitmarker_color_b", "moat_hitmarker_color_a"}}
local initial_x = 5
local drop_menu_width = 60
local setting_spacingline = 22
local setting_spacing = 27

local function moatCreateSettingDropDown(pnl, x, y, settings_tbl)
    local OPTION_SETTING = vgui.Create("DComboBox", pnl)
    OPTION_SETTING:SetSize(drop_menu_width, 20)
    OPTION_SETTING:SetPos(x, y)
    local yes_or_no = false

    for k, v in ipairs(settings_tbl[2]) do
        OPTION_SETTING:AddChoice(v)

        if (v == "Yes" or v == "No") then
            yes_or_no = true
        end
    end

    local client_convar = GetConVar(settings_tbl[3])

    if (yes_or_no) then
        if (client_convar:GetInt() == 1) then
            OPTION_SETTING:SetValue("Yes")
        else
            OPTION_SETTING:SetValue("No")
        end
    elseif (settings_tbl[3] == "moat_hitmarker_size") then
        if (client_convar:GetInt() == 1) then
            OPTION_SETTING:SetValue("Small")
        elseif (client_convar:GetInt() == 2) then
            OPTION_SETTING:SetValue("Normal")
        else
            OPTION_SETTING:SetValue("Large")
        end
    else
        OPTION_SETTING:SetValue(tostring(client_convar:GetFloat()))
    end

    OPTION_SETTING.OnSelect = function(self, index, value)
        local client_convar1 = GetConVar(settings_tbl[3])

        if (value == "Yes") then
            client_convar1:SetInt(1)

            return
        elseif (value == "No") then
            client_convar1:SetInt(0)

            return
        else
            if (settings_tbl[3] == "moat_hitmarker_size") then
                if (value == "Small") then
                    client_convar1:SetInt(1)

                    return
                elseif (value == "Normal") then
                    client_convar1:SetInt(2)

                    return
                else
                    client_convar1:SetInt(3)

                    return
                end
            else
                client_convar1:SetFloat(value)
            end
        end
    end
end

local MOAT_BG

local function moatHitRegSettings()
    if (MOAT_BG) then
        MOAT_BG:Remove()
    end

    local MOAT_BG_DATA = {
        x = (ScrW() / 2) - 200,
        y = (ScrH() / 2) - 225
    }

    MOAT_BG = vgui.Create("DFrame")
    MOAT_BG:SetSize(400, 450)
    MOAT_BG:MakePopup()
    MOAT_BG:SetKeyboardInputEnabled(false)
    MOAT_BG:ShowCloseButton(false)
    MOAT_BG:SetTitle("")
    MOAT_BG:SetPos(MOAT_BG_DATA.x, 0)
    MOAT_BG:SetAlpha(0)

    MOAT_BG.Paint = function(s, w, h)
        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(0, 25, w, 25)
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(0, 26, w, 26)
        draw.SimpleTextOutlined("Alternative Hit Registration Settings - By Moat", "moat_LabelFont", 10, 12, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
    end

    local MOAT_CLOSE = vgui.Create("DButton", MOAT_BG)
    MOAT_CLOSE:SetPos(MOAT_BG:GetWide() - 36, 3)
    MOAT_CLOSE:SetSize(33, 19)
    MOAT_CLOSE:SetText("")

    MOAT_CLOSE.Paint = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(Color(137, 137, 137, 255))
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 15))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 20))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end

    MOAT_CLOSE.DoClick = function()
        MOAT_BG:MoveTo(MOAT_BG_DATA.x, ScrH() - 450, 0.5, 0, 1)
        MOAT_BG:AlphaTo(0, 0.5, 0)

        timer.Simple(0.5, function()
            if (IsValid(MOAT_BG)) then
                MOAT_BG:Remove()
            end
        end)
    end

    local settings = {
        x = 5,
        y = 30,
        w = MOAT_BG:GetWide() - 10,
        h = MOAT_BG:GetTall() - 35
    }

    local MOAT_SETTINGS = vgui.Create("DPanel", MOAT_BG)
    MOAT_SETTINGS:SetPos(settings.x, settings.y)
    MOAT_SETTINGS:SetSize(settings.w, settings.h)
    --{{ user_id }}
    MOAT_SETTINGS.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(initial_x, 5, w - initial_x, 5)
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(initial_x, 5, w - initial_x, 5)
        local initial_y = 10

        for i = 1, 4 do
            draw.SimpleTextOutlined(moat_Settings[i][1], "moat_LabelFont", initial_x, initial_y, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 20))
            surface.SetDrawColor(Color(100, 100, 100, 50))
            surface.DrawLine(initial_x, initial_y + setting_spacingline, w - initial_x, initial_y + setting_spacingline)
            surface.SetDrawColor(Color(0, 0, 0, 100))
            surface.DrawLine(initial_x, initial_y + setting_spacingline, w - initial_x, initial_y + setting_spacingline)
            initial_y = initial_y + setting_spacing
        end

        draw.SimpleTextOutlined(moat_Settings[5][1], "moat_LabelFont", initial_x, initial_y, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 20))
    end

    local initial_y = 9

    for i = 1, 4 do
        moatCreateSettingDropDown(MOAT_SETTINGS, MOAT_SETTINGS:GetWide() - initial_x - drop_menu_width, initial_y, moat_Settings[i])
        initial_y = initial_y + setting_spacing
    end

    local MOAT_COLOR = vgui.Create("DColorMixer", MOAT_SETTINGS)
    MOAT_COLOR:SetConVarR("moat_hitmarker_color_r")
    MOAT_COLOR:SetConVarB("moat_hitmarker_color_b")
    MOAT_COLOR:SetConVarG("moat_hitmarker_color_g")
    MOAT_COLOR:SetConVarA("moat_hitmarker_color_a")
    MOAT_COLOR:SetPos(5 + 55, 138)
    MOAT_COLOR:SetSize(settings.w - 10 - 110, settings.h - 148)
    MOAT_BG:MoveTo(MOAT_BG_DATA.x, MOAT_BG_DATA.y, 0.5, 0, 1)
    MOAT_BG:AlphaTo(255, 0.5, 0)
end

concommand.Add("moat_hitreg", moatHitRegSettings)

net.Receive( "moat_hitreg_command", function(len, ply)
    moatHitRegSettings()
end)
/*
hook.Add("OnPlayerChat", "moat_MenuCommand", function(ply, text)
    if (ply == LocalPlayer() and table.HasValue(MOAT_HITREG.ChatCommands, text) or table.HasValue(MOAT_HITREG.ChatCommands, text:lower())) then
        moatHitRegSettings()

        return true
    end
end)*/

local moat_val = 0

net.Receive("moat_value", function()
    if (moat_val == 0) then
        moat_val = net.ReadString()
    end
end)

local hitmarker_alpha = 0
local hitmarker_time = CurTime()

net.Receive("moat_hitmarker", function(len)
    hitmarker_alpha = 1
    hitmarker_time = CurTime() + 0.5
    local hitmarker_sound = Sound("npc/antlion/shell_impact2.wav")
    local hs = CreateSound(LocalPlayer(), hitmarker_sound)
    hs:ChangeVolume(1, 1)
    hs:Play()
end)

local hitmarker_length = {10, 12, 16}

hook.Add("HUDPaint", "moat_DrawHitmarkers", function()
    if (CurTime() >= hitmarker_time and hitmarker_alpha > 0) then
        hitmarker_alpha = hitmarker_alpha - (1 / 100)
    end

    local hitmarker_size = hitmarker_length[GetConVar("moat_hitmarker_size"):GetInt()] or MOAT_HITREG.HitMarkerSizeDefault

    local hitmarker_color = {
        r = GetConVar("moat_hitmarker_color_r"):GetInt(),
        g = GetConVar("moat_hitmarker_color_g"):GetInt(),
        b = GetConVar("moat_hitmarker_color_b"):GetInt(),
        a = GetConVar("moat_hitmarker_color_a"):GetInt()
    }

    surface.SetDrawColor(hitmarker_color.r, hitmarker_color.g, hitmarker_color.b, hitmarker_color.a * hitmarker_alpha)
    surface.DrawLine((ScrW() / 2) - hitmarker_size, (ScrH() / 2) - hitmarker_size, (ScrW() / 2) - 8, (ScrH() / 2) - 8)
    surface.DrawLine((ScrW() / 2) + hitmarker_size, (ScrH() / 2) + hitmarker_size, (ScrW() / 2) + 8, (ScrH() / 2) + 8)
    surface.DrawLine((ScrW() / 2) - hitmarker_size, (ScrH() / 2) + hitmarker_size, (ScrW() / 2) - 8, (ScrH() / 2) + 8)
    surface.DrawLine((ScrW() / 2) + hitmarker_size, (ScrH() / 2) - hitmarker_size, (ScrW() / 2) + 8, (ScrH() / 2) - 8)
end)

local function moatFireBullets(ent, data)
    local attacker = data.Attacker

    if (ent:IsValid() and attacker == LocalPlayer() and not MOAT_ACTIVE_BOSS) then
        data.Callback = function(att, tr, dmginfo)
            if (tr.Hit and IsValid(tr.Entity)) then
                if MOAT_PH and tr.Entity:IsPlayer() then return end
                local trace = {}
                trace.trEnt = tr.Entity
                trace.trHGrp = tr.HitGroup
                trace.trAtt = att
                trace.dmgFor = dmginfo:GetDamageForce()
                trace.dmgPos = dmginfo:GetDamagePosition()
                trace.dmgType = dmginfo:GetDamageType()
                trace.dmgInf = att:GetActiveWeapon()
                net.Start("moatBulletTrace" .. moat_val)
                net.WriteUInt(trace.trEnt:EntIndex(), 16)
                net.WriteUInt(trace.trHGrp, 4)
                net.WriteVector(trace.dmgFor)
                net.WriteVector(trace.dmgPos)
                net.WriteUInt(trace.dmgType, 32)
                net.WriteUInt(trace.dmgInf:EntIndex(), 16)
                net.SendToServer()

                return true
            end
        end
        if MOAT_PH then
            local e = LocalPlayer():GetEyeTrace().Entity
            if not IsValid(e) then return end
            if e:IsPlayer() then
                data.IgnoreEntity = e
            end
        end
    end
end

hook.Add("EntityFireBullets", "moatFireBullets", moatFireBullets)

hook.Add("CreateMove", "moat_DisableCombatCrouch", function(cmd)
    if (cmd:KeyDown(IN_DUCK) and CurTime() <= LocalPlayer():GetNWInt("moat_JumpCooldown") and not LocalPlayer():IsOnGround()) then
        --print(LocalPlayer():GetNWInt("moat_JumpCooldown") - CurTime())
        RunConsoleCommand("-duck")
    end
end)


MOAT_DMGNUMS = MOAT_DMGNUMS or {}
MOAT_DMGNUMS.Live = {}

function MOAT_DMGNUMS.CreateDamageNumber(dmg, grp, pos)

    local randnum = math.Rand(-0.4, 0.4)

    local NumTable = {}
    NumTable.Dmg = dmg
    NumTable.Pos = pos
    NumTable.Change = Vector(randnum, randnum*-1, math.Rand(-0.1, 0.4))
    NumTable.Alpha = 255
    NumTable.Col = Color(255, 255, 255)

    if (grp == 1) then
        NumTable.Col = Color(255, 51, 51)
    elseif (grp == 2 or grp == 3) then
        NumTable.Col = Color(255, 153, 51)
    end

    table.insert(MOAT_DMGNUMS.Live, NumTable)
end

function MOAT_DMGNUMS.LoopDamageNumbers()
    if (GetConVar("moat_showdamagenumbers"):GetInt() < 1 or not MOAT_DMGNUMS.Live or #MOAT_DMGNUMS.Live < 1) then return end
    
    local num
    for i = 1, #MOAT_DMGNUMS.Live do
        num = MOAT_DMGNUMS.Live[i]

        if (not num) then continue end
        
        if (num.Alpha <= 1) then
            table.remove(MOAT_DMGNUMS.Live, i)
            continue
        end

        num.Alpha = Lerp(FrameTime() * 5, num.Alpha, 0)
        num.Pos = num.Pos + num.Change
    end
end

local cam_Start3D2D        = cam.Start3D2D
local cam_End3D2D          = cam.End3D2D
local draw_SimpleText      = draw.SimpleText

surface.CreateFont("moat_HitNumberFont", {
    font = "Trebuchet24",
    size = 200,
    weight = 700
})

function MOAT_DMGNUMS.DrawDamageNumbers()
    if (GetConVar("moat_showdamagenumbers"):GetInt() < 1 or not MOAT_DMGNUMS.Live or #MOAT_DMGNUMS.Live < 1) then return end

    local observer = (LocalPlayer():GetViewEntity() or LocalPlayer())
    local ang = observer:EyeAngles()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)
    ang = Angle(0, ang.y, ang.r)

    cam.IgnoreZ(true)

    local num
    for i = 1, #MOAT_DMGNUMS.Live do
        num = MOAT_DMGNUMS.Live[i]
        cam_Start3D2D(num.Pos, ang, 0.1)
            draw_SimpleText(num.Dmg, "moat_HitNumberFont", 0, 0, Color(num.Col.r, num.Col.g, num.Col.b, num.Alpha))
            draw_SimpleText(num.Dmg, "moat_HitNumberFont", 7, 7, Color(0, 0, 0, num.Alpha))
        cam_End3D2D()
    end

    cam.IgnoreZ(false)
end

hook.Add("Think", "moat_DamageNumberVars", MOAT_DMGNUMS.LoopDamageNumbers)
hook.Add("PostDrawTranslucentRenderables", "moat_DrawDamageNumbers", MOAT_DMGNUMS.DrawDamageNumbers)

net.Receive("moat_damage_number", function()
    local dmg = net.ReadUInt(8)
    local grp = net.ReadUInt(4)
    local pos = net.ReadVector()

    MOAT_DMGNUMS.CreateDamageNumber(dmg, grp, pos)
end)