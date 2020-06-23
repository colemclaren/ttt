local moat_convars = {
    ["moat_music"] = 1,
    ["moat_music_volume"] = 0.5,
    ["moat_clfov"] = 0.428571429,
    ["moat_chatplanetary"] = 1,
    ["moat_showtrades"] = 1,
    ["moat_chatjackpot"] = 1,
    ["moat_showstats_spawn"] = 1,
    ["moat_showstats_pickup"] = 1,
    ["moat_obtain_cosmetics"] = 0,
    ["moat_autodecline"] = 0,
    ["moat_autorotate_model"] = 0,
    ["moat_deconstruct_speed_multi"] = 1,
    ["moat_DisableCustomHUD"] = 0,
    ["moat_OutlineTBuddies"] = "Halos",
    ["moat_EnableShadows"] = 0,
    ["moat_EnableEffectHalos"] = 0,
    ["moat_EnableChristmasTheme"] = 1,
    ["moat_Theme"] = "Blur",
    ["moat_gangsta"] = 0,
    ["moat_dropcosmetics"] = 0,
    ["moat_auto_deconstruct"] = 0,
    ["moat_auto_deconstruct_rarity"] = "Worn",
    ["moat_fast_open"] = 0,
    ["moat_text_to_speech"] = 1,
    ["moat_disable_rare_warnings"] = 0,
    ["moat_auto_deconstruct_primary"] = 0,
    ["moat_auto_deconstruct_secondary"] = 0,
    ["moat_auto_deconstruct_melee"] = 0,
    ["moat_auto_deconstruct_powerup"] = 0,
    ["moat_auto_deconstruct_special"] = 0,
    ["moat_auto_deconstruct_head"] = 0,
    ["moat_auto_deconstruct_mask"] = 0,
    ["moat_auto_deconstruct_body"] = 0,
    ["moat_auto_deconstruct_effect"] = 0,
    ["moat_auto_deconstruct_model"] = 0,
    ["moat_chat_obtain_rarity"] = "Worn",
    ["moat_enable_deathcard"] = 1,
	["moat_enable_effects"] = 1,
    ["moat_mga_lowend"] = 0,
    ["moat_mga_playerlist"] = 0,
    ["moat_mga_animation"] = 1,
    ["moat_disable_motd"] = 0,
    ["moat_continue_scrolling"] = 1,
    ["moat_ViewModelFlip"] = 0,
    ["moat_multicore"] = 0,
    ["moat_red_screen"] = 0,
    ["moat_autodecline_active"] = 0,
    ["moat_DisableSpookyTheme"] = 0,
    ["moat_auto_deconstruct_usable"] = 0,
    ["moat_model_preview"] = 1,
    ["moat_scoreboard_ping"] = 0,
    ["moat_skybox"] = 0,
    ["moat_droppaint"] = 0,
    ["moat_post_music_holiday"] = 1,
    ["moat_inspect_stats"] = 1,
	["moat_pass_usable"] = 0,
	["moat_headshot_sounds"] = 1,
	["moat_headshot_sound"] = "Eagle Aim",
}

local function moat_InitializeConvars()
    for k, v in pairs(moat_convars) do
        if (not ConVarExists(k)) then
            CreateClientConVar(k, v, true, true)
        end
    end
end


moat_InitializeConvars()

surface.CreateFont("moat_ChatFont2", {
    font = "DermaLarge",
    size = 20,
    weight = 1200
})

local moat_rarity_colors = {
    ["Worn"] = Color(204, 204, 255),
    ["Standard"] = Color(0, 0, 255),
    ["Specialized"] = Color(127, 0, 255),
    ["Superior"] = Color(255, 0, 255),
    ["High-End"] = Color(255, 0, 0),
    ["Ascended"] = Color(255, 205, 0),
    ["Cosmic"] = Color(0, 255, 0)
}

/*
hook.Add("CalcView","Change FOV",function(ply, pos, angles, fov)
    if MOAT_IGNORE_FOV then return end
    if cur_random_round then return end
    if MOAT_ACTIVE_BOSS then return end
    if (not LocalPlayer():Alive()) or LocalPlayer():IsSpec() then return end
    if current_scene then return end
    if cur_random_round == "High FOV" then return end
    local view = {}
    local wep = LocalPlayer():GetActiveWeapon()--
    if IsValid(wep) then
        if wep.CalcView then
            local a,b,c,d = wep:CalcView(ply, pos, angles, fov)
            -- if weapon actually returns anything, use it
            if a or b or c or d then
                view.origin = a or pos
                view.angles = b or angles
                view.fov = c or fov
                view.drawviewer = d or false
                return view
            end
        end
        if wep.GetIronsights then
            if wep:GetIronsights() then return end
        end
        if wep.GetTauntActive then
            if wep:GetTauntActive() then return end
        end
    end

	view.origin = pos
	view.angles = angles
	view.fov = 75 + (math.min(GetConVar("moat_clfov"):GetFloat(),3) * 35)
    if view.fov > 175 then
        view.fov = 175
    end

	return view
end)
*/

local DevMode = CreateClientConVar("moat_developer_mode", 0, true, true)
local moat_Settings = {}
moat_Settings.Options = {
    {"General",
		{"Safe Messaging", {'Multi'}, 'moat_safety'},
        {"End Round Music", {"Multi"}, "moat_music"},
        {"End Round Music Volume", {"Slider", 0, 1}, "moat_music_volume"},
        {"FOV (75 to 110)", {"Slider", 0, 1}, "moat_clfov"},
        {"Disable MOTD on Join", {"Multi"}, "moat_disable_motd"},
        {"Invert Map [BETA]", {"Multi"}, "moat_map_invert"},
        {"Disable Multicore Rendering (Might Fix Crashes)", {"Multi"}, "moat_multicore"},
        {"Enable Hitmarkers", {"Multi"}, "moat_hitmarkers"},
        {"Enable Damage Numbers", {"Multi"}, "moat_damage_numbers"},
		{"Developer Mode", {"Multi"}, "moat_developer_mode"}
    },
    {"Gameplay",
		{"Headshot Sound", {"Multi"}, "moat_headshot_sounds"},
		{"Custom Headshot Sound", {"MultiText", "Eagle Aim", "Eagle Kill", "Eagle Clack", "Arcade Tap", "Arcade Headshot", "Arcade Kill", "Arcade Missed", "FPS Hitmarker", "FPS Headshot", "Rusty Aim"}, "moat_headshot_sound"},
        {"Automatically Bunny-hop", {"Multi"}, "moat_bunny_hop"},
        {"Outline Effect (FPS IMPACT)", {"MultiText", "Halos", "Chams", "Off"}, "moat_OutlineTBuddies"},
        {"Enable Shadows (FPS IMPACT)", {"Multi"}, "moat_EnableShadows"},
        {"Inventory Cosmetics Visible", {"Multi"}, "moat_EnableCosmetics"},
        {"Inventory Effects Visible", {"Multi"}, "moat_EnableEffects"},
        {"Inventory Effects Halos Visible (FPS IMPACT)", {"Multi"}, "moat_EnableEffectHalos"},
        {"Flip Weapon View Models", {"Multi"}, "moat_ViewModelFlip"},
        {"Disable 3D Skybox (Can Increase FPS)", {"Multi"}, "moat_skybox"},
        {"Display Item Stats when Inspecting Weapons", {"Multi"}, "moat_inspect_stats"},
    },
    {"HUD",
        {"Revert to Default HUD", {"Multi"}, "moat_DisableCustomHUD"},
        {"Show Weapon Stats on Spawn", {"Multi"}, "moat_showstats_spawn"},
        {"Show Weapon Stats on Pickup", {"Multi"}, "moat_showstats_pickup"},
        {"Enable Damage Numbers", {"Multi"}, "moat_damage_numbers"},
        {"Show Killer info card on Death", {"Multi"}, "moat_enable_deathcard"},
        {"Enable Custom Red Screen when Damaged", {"Multi"}, "moat_red_screen"},
        {"Display Numbers for Ping on Scoreboard", {"Multi"}, "moat_scoreboard_ping"},
		{"Enable Status Effect Notifications", {"Multi"}, "moat_enable_effects"}
    },
    {"Inventory",
        {"Automatically Decline All Trade Requests", {"Multi"}, "moat_autodecline"},
        {"Decline Trade Requests if Round is Active", {"Multi"}, "moat_autodecline_active"},
        {"Automaticallly Rotate Model in Loadout", {"Multi"}, "moat_autorotate_model"},
        {"Deconstruct Speed Multiplier", {"MultiText", "1", "3", "5", "10", "15", "20", "25", "100"}, "moat_deconstruct_speed_multi"},
        {"Inventory Theme", {"MultiText", "Original", "Dark", "Light", "Blur", "Clear", "Alpha"}, "moat_Theme"},
        {"Instantly Open Crates on Open", {"Multi"}, "moat_fast_open"},
        {"Enable UI Sound Effects", {"Multi"}, "moat_ui_sounds"},
        {"Enable Continuous Scrolling", {"Multi"}, "moat_continue_scrolling"},
        {"Enable Custom Model Preview when Using Crates", {"Multi"}, "moat_model_preview"},
        {"Disable Lighting in Inventory Model Preview", {"Multi"}, "moat_inventory_lighting"},
		-- {"Holiday Inventory Theme", {"Multi"}, "moat_holiday_theme_2020"}
        -- {"Inventory Model Smoke", {"Multi"}, "moat_model_smoke"},
        -- {"Spring Inventory Theme", {"Multi"}, "moat_spring_theme"}
    },
    {"Item Drops",
        {"Disable Rare Item Warnings", {"Multi"}, "moat_disable_rare_warnings"},
        {"Drop Cosmetic Items from End Round Drops", {"Multi"}, "moat_dropcosmetics"},
        {"Drop Paint/Tint from End Round Drops", {"Multi"}, "moat_droppaint"},
        {"Automatically Desconstruct Items after Obtained", {"Multi"}, "moat_auto_deconstruct"},
        {"Rarity of Items to Automatically Deconstruct", {"MultiText", "Worn", "Standard", "Specialized", "Superior", "High-End", "Ascended"}, "moat_auto_deconstruct_rarity"},
        {"Auto-Deconstruct filter Primaries", {"Multi"}, "moat_auto_deconstruct_primary"},
        {"Auto-Deconstruct filter Secondaries", {"Multi"}, "moat_auto_deconstruct_secondary"},
        {"Auto-Deconstruct filter Melees", {"Multi"}, "moat_auto_deconstruct_melee"},
        {"Auto-Deconstruct filter Power-Ups", {"Multi"}, "moat_auto_deconstruct_powerup"},
        {"Auto-Deconstruct filter Specials", {"Multi"}, "moat_auto_deconstruct_special"},
        {"Auto-Deconstruct filter Usables", {"Multi"}, "moat_auto_deconstruct_usable"},
        {"Auto-Deconstruct filter Head Cosmetics", {"Multi"}, "moat_auto_deconstruct_head"},
        {"Auto-Deconstruct filter Mask Cosmetics", {"Multi"}, "moat_auto_deconstruct_mask"},
        {"Auto-Deconstruct filter Body Cosmetics", {"Multi"}, "moat_auto_deconstruct_body"},
        {"Auto-Deconstruct filter Effect Cosmetics", {"Multi"}, "moat_auto_deconstruct_effect"},
        {"Auto-Deconstruct filter Model Cosmetics", {"Multi"}, "moat_auto_deconstruct_model"}
    },
    {"Chat",
        {"Display Jackpot wins in chat", {"Multi"}, "moat_chatjackpot"},
        {"Display Planetary drops in chat", {"Multi"}, "moat_chatplanetary"},
        {"Display trades in chat", {"Multi"}, "moat_showtrades"},
        {"Gangsta Speech Mode", {"Multi"}, "moat_gangsta"},
        {"Hear TTS when available", {"Multi"}, "moat_text_to_speech"},
        {"Minimum rarity required to see others obtaining items", {"MultiText", "Worn", "Standard", "Specialized", "Superior", "High-End", "Ascended"}, "moat_chat_obtain_rarity"},
    },
    {"MGA",
        {"Low-End Mode (Disables Blur)", {"Multi"}, "moat_mga_lowend"},
        {"Minimilist Player List", {"Multi"}, "moat_mga_playerlist"},
        {"Entrance/Leaving Animation", {"Multi"}, "moat_mga_animation"},
    },
	{"Dev",
		{"Allow more items to be skinned (Dangerous)", {"Multi"}, "moat_pass_usable"},
		{"(TTTBeginRound) Enable Taskbar Flashing", {"Multi"}, "moat_taskbar_flashing"}
	}
}

moat_Settings.CurCat = 1
moat_Settings.SettingsPnl = nil

local function m_RebuildSliderChoice(btn, var)
    if (IsValid(btn.Slider)) then
        btn.Slider:Remove()
    end

    local num = tonumber(GetConVar(var):GetString())
	if (not num) then num = moat_convars[var] or 1 end
    btn.Slider = vgui.Create("DButton", btn)
    btn.Slider:SetPos(btn:GetWide()-210, 10)
    btn.Slider:SetSize(200, 10)
    btn.Slider:SetText("")
    btn.Slider.Value = num
    btn.Slider.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 0, 50))
        draw.RoundedBox(0, 0, 0, math.Clamp(w*s.Value, 0, 200), h, Color(255, 255, 0, 200))
        --draw.SimpleText("25", "moat_ChatFont", 0, h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    btn.Slider.Think = function(s)
        if (s.Moving) then
            local x, y = s:CursorPos()
            s.Value = math.Clamp(x/200, 0, 1)
            GetConVar(var):SetString(tostring(s.Value))
        end


        if (input.IsMouseDown(MOUSE_LEFT) and s:IsHovered()) then
            s.Moving = true
        elseif (input.IsMouseDown(MOUSE_LEFT) and s.Moving) then
        elseif (s.Moving) then
            s.Moving = false
        end
    end
    
end

local function m_OnOffToNum(txt)
    local num = 0
    if (txt == "On") then
        num = 1
    end
    return num
end

local function m_NumToOnOff(num)
    local txt = "Off"
    if (num > 0) then
        txt = "On"
    end
    return txt
end

local function m_RebuildMultiChoice(btn, var)
    if (IsValid(btn.Left)) then
        btn.Left:Remove()
    end
    if (IsValid(btn.Choice)) then
        btn.Choice:Remove()
    end
    if (IsValid(btn.Right)) then
        btn.Right:Remove()
    end

    btn.Right = vgui.Create("DButton", btn)
    btn.Right:SetPos(btn:GetWide()-20, 5)
    btn.Right:SetSize(10, 20)
    btn.Right:SetText("")
    btn.Right.Paint = function(s, w, h)
        draw.SimpleText(">", "moat_ChatFont", 0, h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    btn.Right.DoClick = function(s)
        local con = GetConVar(var)
        if (con:GetInt() == 0) then
            con:SetInt(1)
        else
            con:SetInt(0)
        end

        btn.Left:Remove()
        btn.Choice:Remove()
        btn.Right:Remove()

		if (var == "moat_developer_mode") then
    		m_PopulateSettingsPanel()
		end

        return
    end

    local ConV = GetConVar(var):GetInt() or 0
    local ConVText = m_NumToOnOff(ConV)
    surface.SetFont("moat_ChatFont")
    local choice_w = surface.GetTextSize(ConVText)

    btn.Choice = vgui.Create("DButton", btn)
    btn.Choice:SetPos(btn:GetWide()-20-choice_w-10, 5)
    btn.Choice:SetSize(choice_w+10, 20)
    btn.Choice:SetText("")
    btn.Choice.ConText = ConVText
    btn.Choice.Paint = function(s, w, h)
        local col = Color(255, 0, 0)
        if (s.ConText == "On") then col = Color(0, 255, 0) end
        draw.SimpleText(s.ConText, "moat_ChatFont", w/2, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    btn.Choice.DoClick = btn.Right.DoClick

    btn.Left = vgui.Create("DButton", btn)
    btn.Left:SetPos(btn:GetWide()-40-choice_w, 5)
    btn.Left:SetSize(10, 20)
    btn.Left:SetText("")
    btn.Left.Paint = function(s, w, h)
        draw.SimpleText("<", "moat_ChatFont", 0, h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    btn.Left.DoClick = btn.Right.DoClick
end

local function m_ChangeConVarChoice(var, multiopt, multioptstr, dir)

    local nextnum = multiopt[1]

    if (dir > 0 and multioptstr[var:GetString()] and multiopt[multioptstr[var:GetString()] + 1]) then
        nextnum = multiopt[multioptstr[var:GetString()] + 1]
    elseif (dir < 0) then
        nextnum = multiopt[#multiopt]
        if (multioptstr[var:GetString()] and multiopt[multioptstr[var:GetString()] - 1]) then
            nextnum = multiopt[multioptstr[var:GetString()] - 1]
        end
    end

	var:SetString(nextnum)

    if (var:GetName() == "moat_Theme") then
		MOAT_THEMING = true
		if (m_ply2 and m_utrade) then
			if (IsValid(MOAT_TRADE_BG)) then MOAT_TRADE_BG:Remove() end
            moat_inv_cooldown = CurTime() + 5
            m_ClearInventory()
            net.Start("MOAT_SEND_INV_ITEM")
            net.SendToServer()
            net.Start("MOAT_RESPOND_TRADE")
            net.WriteBool(false)
            net.WriteDouble(m_ply2:EntIndex())
            net.WriteDouble(m_utrade)
            net.SendToServer()
		end

		if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
		m_OpenInventory()
    end

	if (var:GetName() == "moat_headshot_sound") then
        chat.AddText(Material("icon16/information.png"), Color(255, 0, 0), "Headshot Sound: " .. tostring(var:GetString()))

		hook.Run "Moat.Headshot"
    elseif (GetConVar("moat_ui_sounds"):GetInt() > 0) then
		sfx.Click1()
	end
end

local function m_RebuildMultiTextChoice(btn, var, convar, multiopt, multioptstr)
    if (IsValid(btn.Left)) then
        btn.Left:Remove()
    end
    if (IsValid(btn.Choice)) then
        btn.Choice:Remove()
    end
    if (IsValid(btn.Right)) then
        btn.Right:Remove()
    end

    btn.Right = vgui.Create("DButton", btn)
    btn.Right:SetPos(btn:GetWide()-20, 5)
    btn.Right:SetSize(10, 20)
    btn.Right:SetText("")
    btn.Right.Paint = function(s, w, h)
        draw.SimpleText(">", "moat_ChatFont", 0, h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    btn.Right.DoClick = function(s)
        m_ChangeConVarChoice(convar, multiopt, multioptstr, 1)

        btn.Left:Remove()
        btn.Choice:Remove()
        btn.Right:Remove()

		if (var == "moat_developer_mode") then
			m_PopulateSettingsPanel()
		end

        return
    end

    local ConV = GetConVar(var):GetString()
    surface.SetFont("moat_ChatFont")
    local choice_w = surface.GetTextSize(ConV)

    btn.Choice = vgui.Create("DButton", btn)
    btn.Choice:SetPos(btn:GetWide()-20-choice_w-10, 5)
    btn.Choice:SetSize(choice_w+10, 20)
    btn.Choice:SetText("")
    btn.Choice.ConText = ConV
    btn.Choice.Paint = function(s, w, h)
        local col = Color(255, 255, 255)

        if (moat_rarity_colors[s.ConText]) then
            col = moat_rarity_colors[s.ConText]
        end

        draw.SimpleText(s.ConText, "moat_ChatFont", w/2, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    btn.Choice.DoClick = function(s)
        m_ChangeConVarChoice(convar, multiopt, multioptstr, 1)

        btn.Left:Remove()
        btn.Choice:Remove()
        btn.Right:Remove()

		if (var == "moat_developer_mode") then
			m_PopulateSettingsPanel()
		end

        return
    end

    btn.Left = vgui.Create("DButton", btn)
    btn.Left:SetPos(btn:GetWide()-40-choice_w, 5)
    btn.Left:SetSize(10, 20)
    btn.Left:SetText("")
    btn.Left.Paint = function(s, w, h)
        draw.SimpleText("<", "moat_ChatFont", 0, h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    btn.Left.DoClick = function(s)
        m_ChangeConVarChoice(convar, multiopt, multioptstr, -1)

        btn.Left:Remove()
        btn.Choice:Remove()
        btn.Right:Remove()

		if (var == "moat_developer_mode") then
			m_PopulateSettingsPanel()
		end

        return
    end
end

function m_BuildSettingsPanel(pnl, num)
    local options = moat_Settings.Options[num]

    local option_y = 0
    local option_h = 30
    for i = 2, #options do

        local label = options[i][1]
        local otype = options[i][2][1]
        local multiopt, multioptstr = {}, {}

        if (otype == "MultiText") then
            for _, opt in ipairs(options[i][2]) do
                if (_ == 1) then continue end
                multiopt[_ - 1] = opt
                multioptstr[opt] = _ - 1
            end
        end

        local btn = vgui.Create("DButton", pnl)
        btn:SetPos(0, option_y)
        btn:SetSize(pnl:GetWide(), option_h)
        btn:SetText("")
        btn.HoverLerp = 0
        btn.DrawSetting = true
        btn.Paint = function(s, w, h)
            if (s:IsHovered() or (IsValid(s.Left) and s.Left:IsHovered()) or (IsValid(s.Choice) and s.Choice:IsHovered()) or (IsValid(s.Right) and s.Right:IsHovered()) or IsValid(s.Slider) and s.Slider:IsHovered()) then
                s.HoverLerp = Lerp(FrameTime() * 10, s.HoverLerp, 1)
                labelcol = Color(0, 0, 0)
                if (otype == "Multi" and (not IsValid(s.Left) or not IsValid(s.Right) or not IsValid(s.Choice))) then
                    btn.DrawSetting = false
                    m_RebuildMultiChoice(s, options[i][3])
                elseif (otype == "MultiText" and (not IsValid(s.Left) or not IsValid(s.Right) or not IsValid(s.Choice))) then
                    btn.DrawSetting = false
                    m_RebuildMultiTextChoice(s, options[i][3], GetConVar(options[i][3]), multiopt, multioptstr)
                end
            else
                s.HoverLerp = Lerp(FrameTime() * 10, s.HoverLerp, 0)
                if ((otype == "Multi" or otype == "MultiText") and (IsValid(s.Left) or IsValid(s.Right) or IsValid(s.Choice))) then
                    if (IsValid(s.Left)) then
                        s.Left:Remove()
                    end
                    if (IsValid(s.Choice)) then
                        s.Choice:Remove()
                    end
                    if (IsValid(s.Right)) then
                        s.Right:Remove()
                    end
                    btn.DrawSetting = true
                end
            end
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100 * s.HoverLerp))
            draw.SimpleText(label, "moat_ChatFont", 10, h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            if (otype == "Multi" and s.DrawSetting) then
                local ConV = GetConVar(options[i][3]):GetInt() or 0
                local ConVText = m_NumToOnOff(ConV)
                local col = Color(255, 0, 0)
                if (ConVText == "On") then col = Color(0, 255, 0) end
                draw.SimpleText(ConVText, "moat_ChatFont", w - 10, h/2, col, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            elseif (otype == "MultiText" and s.DrawSetting) then
                local ConV = GetConVar(options[i][3]):GetString()
                draw.SimpleText(ConV, "moat_ChatFont", w - 10, h/2, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end
        end
        btn.DoClick = function(s)
            if (otype == "Multi") then
                local con = GetConVar(options[i][3])
                if (con:GetInt() == 0) then
                    con:SetInt(1)
                else
                    con:SetInt(0)
                end

				if (GetConVar("moat_ui_sounds"):GetInt() > 0) then
					sfx.Click1()
				end

                m_RebuildMultiChoice(s, options[i][3])
            elseif (otype == "MultiText") then
                local con = GetConVar(options[i][3])
                m_ChangeConVarChoice(con, multiopt, multioptstr, 1)

                m_RebuildMultiTextChoice(s, options[i][3], GetConVar(options[i][3]), multiopt, multioptstr)
            end
        end
		sfx.HoverSound(btn)
        if (otype == "Slider") then
            m_RebuildSliderChoice(btn, options[i][3])
        end

        option_y = option_y + option_h
    end
end

function m_RebuildSettingsPanel(num)
	if (IsValid(moat_Settings.SettingsPnl)) then
        moat_Settings.SettingsPnl:Remove()
    end

	if (not IsValid(M_SETTINGS_PNL_SCROLL)) then
		return
	end

    local setpnl = vgui.Create("DScrollPanel", M_SETTINGS_PNL_SCROLL)
    setpnl:SetPos(155, 0)
    setpnl:SetSize(M_SETTINGS_PNL_SCROLL:GetWide()-155, M_SETTINGS_PNL_SCROLL:GetTall())
    m_BuildSettingsPanel(setpnl, num)

    moat_Settings.SettingsPnl = setpnl
end

local gradient_l = Material("vgui/gradient-l")
function m_PopulateSettingsPanel(pnl)
	pnl = IsValid(moat_Settings.SettingsPnl) and moat_Settings.SettingsPnl or pnl

	if (not IsValid(pnl)) then
		return
	end

    pnl.Paint = function(s, w, h)
        draw.RoundedBox(0, 155, 0, w-155, h, Color(0, 0, 0, 150))
    end

    for i = 1, #moat_Settings.Options do
        local caty = (35 * (i-1))
        local cat_btn = vgui.Create("DButton", pnl)
        cat_btn:SetPos(0, caty)
        cat_btn:SetSize(155, 30)
        cat_btn:SetText("")
        cat_btn.HoveredWidth = 0
        cat_btn.Paint = function(s, w, h)
			if (moat_Settings.Options[i][1] == "Dev") then
				if (DevMode and DevMode:GetInt() < 1) then
					if (s:IsHovered()) then
						s:SetCursor "arrow"
					end

					return s:SetDisabled(true)
				end

				if (s:IsHovered()) then
					s:SetCursor "hand"
				end

				s:SetDisabled(false)
			end

            local col = HSVToColor( i * 55 % 360, 1, 1 )

            surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
            surface.SetMaterial(gradient_l)
            surface.DrawTexturedRect(0, 0, (w-5) * s.HoveredWidth, h)

            surface.DrawTexturedRect(0, 0, (w-5) * s.HoveredWidth, 2)
            surface.DrawTexturedRect(0, h-2, (w-5) * s.HoveredWidth, 2)

            if (moat_Settings.CurCat ~= i) then w = 150 end
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
            draw.SimpleTextOutlined(moat_Settings.Options[i][1], "Trebuchet24", 10+(s.HoveredWidth*4), h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))

            if (moat_Settings.CurCat == i) then
                draw.RoundedBox(0, 0, 0, 4, h, HSVToColor( i * 55 % 360, 1, 1 ))
                surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
                surface.SetMaterial(gradient_l)
                surface.DrawTexturedRect(0, 0, (w-5) * 1, h)

                surface.DrawTexturedRect(0, 0, (w-5) * 1, 2)
                surface.DrawTexturedRect(0, h-2, (w-5) * 1, 2)
            elseif (s:IsHovered()) then
                s.HoveredWidth = Lerp(10 * FrameTime(), s.HoveredWidth, 1)
            elseif (not s:IsHovered()) then
                s.HoveredWidth = Lerp(10 * FrameTime(), s.HoveredWidth, 0)
            end
            draw.RoundedBox(0, 0, 0, 4 * s.HoveredWidth, h, HSVToColor( i * 55 % 360, 1, 1 ))
        end
        cat_btn.DoClick = function(s)
            moat_Settings.CurCat = i
            m_RebuildSettingsPanel(moat_Settings.CurCat)
        end
        sfx.SoundEffects(cat_btn)
    end

	if (MOAT_THEMING) then
		moat_Settings.CurCat = 4
	end

    m_RebuildSettingsPanel(moat_Settings.CurCat)

	MOAT_THEMING = false
end

local flip_convar = GetConVar("moat_ViewModelFlip")

hook.Add("InitPostEntity", "Moat.Flip.OnLoad", function()
    if (flip_convar:GetInt() == 1) then
        for _,tab in ipairs(weapons.GetList())do
            tab=weapons.GetStored(tab.ClassName)
            tab.ViewModelFlip = not tab.ViewModelFlip;
        end

        for _,tab in ipairs(LocalPlayer():GetWeapons())do
            tab.ViewModelFlip = not tab.ViewModelFlip;
        end
    end
end)


cvars.AddChangeCallback("moat_ViewModelFlip", function(_, o, n)
    for _,tab in ipairs(weapons.GetList())do
        tab=weapons.GetStored(tab.ClassName)
        tab.ViewModelFlip = not tab.ViewModelFlip;
    end

    for _,tab in ipairs(LocalPlayer():GetWeapons())do
        tab.ViewModelFlip = not tab.ViewModelFlip;
    end
end)

hook.Add("InitPostEntity", "Moat.Skybox.Load", function()
    if (GetConVar("moat_skybox"):GetInt() == 1) then
        RunConsoleCommand("r_3dsky", 0)
    end
end)

cvars.AddChangeCallback("moat_skybox", function(_, o, n)
    RunConsoleCommand("r_3dsky", tonumber(n) == 1 and 0 or 1)
end)

/*
        for _,tab in ipairs(weapons.GetList())do
            tab=weapons.GetStored(tab.ClassName)
            tab.ViewModelFlip = not tab.ViewModelFlip;
        end

        for _,tab in ipairs(LocalPlayer():GetWeapons())do
            tab.ViewModelFlip = not tab.ViewModelFlip;
        end
*/