
local PLAYER = FindMetaTable("Player")

surface.CreateFont("moat_ChatFont", {
    font = "Arial",
    size = 16,
    weight = 1200
})

local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBox = draw.RoundedBox
local draw_RoundedBoxEx = draw.RoundedBoxEx
local surface_SetFont = surface.SetFont
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_GetTextSize = surface.GetTextSize
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local blur = Material("pp/blurscreen")
local gradient_u = Material("vgui/gradient-u")
local gradient_r = Material("vgui/gradient-r")
local gradient_d = Material("vgui/gradient-d")
local terror_color = Color(0, 200, 0, 255)
local spec_color = Color(200, 200, 0, 255)
local default_x, default_y = chat.GetChatBoxPos()

if (moat_chat and IsValid(moat_chat.BG)) then
    moat_chat.BG:Remove()
end

moat_chat = moat_chat or {}

moat_chat.config = {
    x = default_x + 20,
    y = ScrH() - 200 - 384,
    w = 550,
    h = 384
}

moat_chat.font = "moat_ChatFont"
moat_chat.chattype = ""
moat_chat.alpha = 0
moat_chat.header = system.IsOSX() and "Moat Gaming | TTT Testing" or "Moat Gaming | TTT Testing | More fun @ moat.gg"
moat_chat.isopen = false

moat_chat.sayvars = {
    {
        w = 45
    },
    {
        w = 93
    }
}

moat_chat.curx = 0
moat_chat.FadeTime = 10
moat_chat.MaxItems = 128

moat_chat.TextSize = {
    w = 0,
    h = 0
}

moat_chat.click = CurTime()
moat_chat.SelectedMessage = nil
moat_chat.HighlightColor = Color(255, 255, 255, 100)

moat_chat.Theme = {
    CHAT_BG = function(s, w, h, a) end,
    CHAT_PANEL = function(s, w, h, a) end,
    CHAT_ENTRY = function(s, w, h, a) end,
    DefaultColor = Color(255, 255, 255)
}


MOAT_TYPERS = {}
MOAT_TYPING = {Count = 0}

local KEYS = {
    [KEY_0] = true,
    [KEY_1] = true,
    [KEY_2] = true,
    [KEY_3] = true,
    [KEY_4] = true,
    [KEY_5] = true,
    [KEY_6] = true,
    [KEY_7] = true,
    [KEY_8] = true,
    [KEY_9] = true,
    [KEY_A] = true,
    [KEY_B] = true,
    [KEY_C] = true,
    [KEY_D] = true,
    [KEY_E] = true,
    [KEY_F] = true,
    [KEY_G] = true,
    [KEY_H] = true,
    [KEY_I] = true,
    [KEY_J] = true,
    [KEY_K] = true,
    [KEY_L] = true,
    [KEY_M] = true,
    [KEY_N] = true,
    [KEY_O] = true,
    [KEY_P] = true,
    [KEY_Q] = true,
    [KEY_R] = true,
    [KEY_S] = true,
    [KEY_T] = true,
    [KEY_U] = true,
    [KEY_V] = true,
    [KEY_W] = true,
    [KEY_X] = true,
    [KEY_Y] = true,
    [KEY_Z] = true,
    [KEY_PAD_0] = true,
    [KEY_PAD_1] = true,
    [KEY_PAD_2] = true,
    [KEY_PAD_3] = true,
    [KEY_PAD_4] = true,
    [KEY_PAD_5] = true,
    [KEY_PAD_6] = true,
    [KEY_PAD_7] = true,
    [KEY_PAD_8] = true,
    [KEY_PAD_9] = true,
    [KEY_PAD_DIVIDE] = true,
    [KEY_PAD_MULTIPLY] = true,
    [KEY_PAD_MINUS] = true,
    [KEY_PAD_PLUS] = true,
    [KEY_PAD_DECIMAL] = true,
    [KEY_LBRACKET] = true,
    [KEY_RBRACKET] = true,
    [KEY_SEMICOLON] = true,
    [KEY_APOSTROPHE] = true,
    [KEY_BACKQUOTE] = true,
    [KEY_COMMA] = true,
    [KEY_PERIOD] = true,
    [KEY_SLASH] = true,
    [KEY_BACKSLASH] = true,
    [KEY_MINUS] = true,
    [KEY_EQUAL] = true,
    [KEY_SPACE] = true
}

function PLAYER:IsTyping()
	return IsValid(moat_chat.ENTRY) and moat_chat.ENTRY:IsEditing()
end

function PlayersTyping()
	local Count = 0

	for k, v in pairs(MOAT_TYPERS) do
		if (k == LocalPlayer()) then continue end

		if (IsValid(k) and CurTime() - v <= 5) then
			Count = Count + 1
		end
	end

	return Count
end

local blur = Material("pp/blurscreen")

local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface_SetDrawColor(255, 255, 255, moat_chat.alpha * 255)
    surface_SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface_DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

if (not ConVarExists("moat_gangsta")) then
    CreateClientConVar("moat_gangsta", 0, true, false)
end

function m_GetFullItemName(itemtbl)
    local ITEM_NAME_FULL = GetItemName(itemtbl)
    -- if (itemtbl and itemtbl.n) then
    --     return "\"" .. itemtbl.n:Replace("''", "'") .. "\""
    -- end

    return ITEM_NAME_FULL
end

function moat_chat.AlphaControl(s)
    if (moat_chat.isopen) then
        local ctime = CurTime() + 0.5
        local contents = moat_chat.SPNL.Chat.Contents

        for i = 1, #contents do
            if (isnumber(contents[i].CreateTime)) then
                if (contents[i].CreateTime >= ctime) then continue end
            end

            contents[i].CreateTime = ctime
        end

        return true
    else
        return false
    end
end

local function m_PaintChatVBar(sbar)
    sbar.moving = false
    sbar.alpha = 0

    function sbar:Paint(w, h)
        if (not moat_chat.isopen) then
            sbar.alpha = Lerp(10 * FrameTime(), sbar.alpha, 0)
        else
            sbar.alpha = Lerp(10 * FrameTime(), sbar.alpha, 1)
        end

        draw_RoundedBox(0, 0, 4, 11, h - 8, Color(0, 0, 0, 100 * sbar.alpha))
    end

    local vbar_moving = false

    function sbar.btnGrip:Paint(w, h)
        --[[
        local draw_color = Color(64, 64, 64, 255 * sbar.alpha)

        if (not input.IsMouseDown(MOUSE_LEFT) and vbar_moving) then
            vbar_moving = false
        end

        if (self:IsHovered()) then
            draw_color = Color(72, 72, 72, 255 * sbar.alpha)

            if (input.IsMouseDown(MOUSE_LEFT)) then
                vbar_moving = true
            end

            self:SetCursor("hand")
        end

        if (vbar_moving) then
            self:SetCursor("hand")
            draw_color = Color(64, 64, 100, 255 * sbar.alpha)
        end

        draw_RoundedBox(0, 0, 0, 11, h, draw_color)
        surface_SetDrawColor(Color(50, 50, 50, 255 * sbar.alpha))
        surface_SetMaterial(gradient_r)
        surface_DrawTexturedRect(0, 0, 11, h)]]
        local draw_color = Color(150, 150, 150, 50 * sbar.alpha)

        if (not input.IsMouseDown(MOUSE_LEFT) and sbar.moving) then
            sbar.moving = false
        end

        if (self:IsHovered()) then
            draw_color = Color(150, 150, 150, 100 * sbar.alpha)

            if (input.IsMouseDown(MOUSE_LEFT)) then
                sbar.moving = true
            end

            self:SetCursor("hand")
        end

        if (sbar.moving) then
            self:SetCursor("hand")
            draw_color = Color(200, 200, 200, 100 * sbar.alpha)
            sbar.LerpTarget = sbar:GetScroll()
        end

        draw_RoundedBox(0, 0, 0, 11, h, draw_color)
    end

    function sbar.btnUp:Paint(w, h)
        local draw_color = Color(150, 150, 150, 255 * sbar.alpha)

        if (self:IsHovered()) then
            draw_color = Color(255, 255, 255, 255 * sbar.alpha)
        end

        surface_SetDrawColor(draw_color)
        surface_DrawLine(1, 4 + 6, 6, 5)
        surface_DrawLine(9, 4 + 6, 4, 5)
        surface_DrawLine(2, 4 + 6, 6, 6)
        surface_DrawLine(8, 4 + 6, 4, 6)
    end

    function sbar.btnDown:Paint(w, h)
        local draw_color = Color(150, 150, 150, 255 * sbar.alpha)

        if (self:IsHovered()) then
            draw_color = Color(255, 255, 255, 255 * sbar.alpha)
        end

        surface_SetDrawColor(draw_color)
        surface_DrawLine(1, 4, 6, 4 + 5)
        surface_DrawLine(9, 4, 4, 4 + 5)
        surface_DrawLine(2, 4, 6, 4 + 4)
        surface_DrawLine(8, 4, 4, 4 + 4)
    end
end

function moat_chat.CloseChat()
    local mc = moat_chat
    mc.BG:KillFocus()
    mc.BG:SetKeyBoardInputEnabled(false)
    mc.BG:SetMouseInputEnabled(false)
    mc.ENTRY:KillFocus()
    hook.Call("FinishChat", GAMEMODE)
    hook.Call("ChatTextChanged", GAMEMODE, "")
end

function moat_chat.AutoComplete(entry, auto)
    local match
    local words = string.Explode(" ", entry:GetValue())
    match = words[#words]
    if (not match or match == "") then return end
    local ply

    for k, v in ipairs(player.GetAll()) do
        if ((string.find(v:Nick():lower(), match:lower(), 1, true) or -1) == 1) then
            ply = v
            break
        end
    end

    if (ply) then
        local pref = string.sub(entry:GetValue(), 1, 1)
        local add
        local firstarg = string.sub(entry:GetValue(), 1, (string.find(entry:GetValue(), " ") or (#entry:GetValue() + 1)) - 1)

        if ((pref == "!" or pref == "!") and (not auto)) then
            add = ply:SteamID()
        else
            add = ply:Nick()
        end

        if (not auto) then
            entry:SetText(string.sub(entry:GetValue(), 1, -(#match + 1)) .. add .. " ")
        else
            return string.sub(add, #match + 1)
        end

        return
    end
end

function moat_chat.Speak(str, t)
    if (t) then
        RunConsoleCommand("say_team", str)
    else
        RunConsoleCommand("say", str)
    end
end

function moat_chat.Gangsta(str, func)
    http.Post("http://www.gizoogle.net/textilizer.php", {
        translatetext = str
    }, function(res)
        func(res:match("<textarea type=\"text\" name=\"translatetext\" style=\"width: 600px; height:250px;\"/>(.-)</textarea>"))
    end)
end

local MousePressedX, MousePressedY, MouseReleasedX, MouseReleasedY, SelectedChatMsg, SelectingText

local function MousePress()
    local pan = vgui.GetHoveredPanel()
    if not pan or not pan.IsChatTextPanel then return end
    MousePressedX, MousePressedY = pan:CursorPos()
    SelectedChatMsg = pan
    SelectingText = true
end

local function MouseRelease()
    SelectingText = false
    local pan = vgui.GetHoveredPanel()
    if not pan or not pan.IsChatTextPanel then return end
    MouseReleasedX, MouseReleasedY = pan:CursorPos()
end

local mouseDown

-- GUIMousePressed/Released hooks are both broken, thanks garry :^) (aren't called when pressed on chat)
local function ChatThink()
    if (not moat_chat.isopen) then return end
    local down = input.IsMouseDown(MOUSE_LEFT)

    if down and not mouseDown then
        MousePress()
        mouseDown = true
    elseif not down and mouseDown then
        MouseRelease()
        mouseDown = false
    elseif not down and not mouseDown and SelectedChatMsg and input.IsMouseDown(MOUSE_RIGHT) then
        SelectedChatMsg = nil
    elseif SelectedChatMsg and SelectedChatMsg:IsValid() and input.IsKeyDown(KEY_LCONTROL) and input.IsKeyDown(KEY_C) then
        local str = ""

        for i = 1, #SelectedChatMsg.TextTable do
            if SelectedChatMsg.TextTable[i][4] then
                str = table.concat({str, SelectedChatMsg.TextTable[i][1]}, "")
            end
        end

        SetClipboardText(str)
    end
end

hook.Add("Think", "NewChatThink", ChatThink)
local customchatx = CreateConVar("moat_custom_chat_x", tostring(moat_chat.config.x), FCVAR_ARCHIVE)
local customchaty = CreateConVar("moat_custom_chat_y", tostring(moat_chat.config.y), FCVAR_ARCHIVE)

concommand.Add("moat_chat", function()
    moat_chat.config.x = tonumber(customchatx:GetDefault())
    moat_chat.config.y = tonumber(customchaty:GetDefault())
    customchatx:SetInt(moat_chat.config.x)
    customchaty:SetInt(moat_chat.config.y)
    moat_chat.BG:SetPos(customchatx:GetInt(), math.Clamp(customchaty:GetInt(), 50, ScrH() - 200 - 384))
end)

function moat_chat.Clear()
    -- if (IsValid(moat_chat.SPNL) and IsValid(moat_chat.SPNL.Chat) and moat_chat.SPNL.Chat.Contents) then
    --     for k, v in ipairs(moat_chat.SPNL.Chat.Contents) do
    --         if (IsValid(v)) then
    --             v:Remove()
    --         end
    --     end

    --     moat_chat.SPNL.Chat.Contents = {}
    --     moat_chat.SPNL.Chat:SetSize(moat_chat.SPNL:GetWide(), 0)
    -- end
end

hook("TTTBeginRound", function()
	if (not IsValid(LocalPlayer())) then
		return
	end

	local cur_round = (GetConVarNumber("ttt_round_limit")-GetGlobal("ttt_rounds_left")) + 1
	local role_color = GetRoleColor(LocalPlayer():GetRole()) or Color(255, 255, 255)
	chat.AddText(moat_blue, " | ", moat_pink, "Round Started", moat_blue, " | ", moat_green, "Round #" .. cur_round, moat_blue, " | ", moat_cyan, player.GetCount().." / "..game.MaxPlayers() .. " Players")
	chat.AddText(moat_blue, " | ", moat_white, "You're playing as " .. (LocalPlayer():GetRole() == ROLE_INNOCENT and "an" or "a"), role_color, " " .. (LocalPlayer():GetRoleString() or "Terrorist") .. " ", moat_white, "this round. Good luck!")
end)

hook("TTTEndRound", function()
	local cur_round = (GetConVarNumber("ttt_round_limit")-GetGlobal("ttt_rounds_left")) + 1
	chat.AddText(moat_blue, " | ", moat_pink, "Ending Round...", moat_blue, " | ", moat_green, "Round #" .. cur_round, moat_blue, " | ", moat_cyan, player.GetCount().." / "..game.MaxPlayers() .. " Players")
end)

hook("TTTPrepareRound", function()
	local cur_round = (GetConVarNumber("ttt_round_limit")-GetGlobal("ttt_rounds_left")) + 1
	chat.AddText(moat_blue, " | ", moat_pink, "Preparing Round", moat_blue, " | ", moat_green, "Round #" .. cur_round, moat_blue, " | ", moat_cyan, player.GetCount().." / "..game.MaxPlayers() .. " Players")
	chat.AddText(moat_blue, " | ", moat_orange, "You're playing on", moat_orange, " " .. game.GetMap(), moat_orange, ". Invite your Friends!")
end)

function moat_chat.InitChat()
    surface_SetFont("moat_ChatFont")
    moat_chat.TextSize.w, moat_chat.TextSize.h = surface_GetTextSize("AbC1230")
    local mc = moat_chat
    local mcc = mc.config
    mc.BG = vgui.Create("DFrame")
    local FRAME = mc.BG
    FRAME:SetTitle("")
    FRAME:ShowCloseButton(false)
    FRAME:SetDraggable(false)
    FRAME:SetSize(mcc.w, mcc.h)
    FRAME:SetPos(customchatx:GetInt(), math.Clamp(customchaty:GetInt(), 50, ScrH() - 200 - 384))
	
    FRAME.Paint = function(s, w, h)
        COLOR_WHITE = Color(255, 255, 255, 255)
        color_white = Color(255, 255, 255, 255)

        if (not mc.AlphaControl(s)) then
            mc.alpha = Lerp(10 * FrameTime(), moat_chat.alpha, 0)
        else
            mc.alpha = Lerp(10 * FrameTime(), moat_chat.alpha, 1)

            if (input.IsKeyDown(KEY_ESCAPE)) then
                RunConsoleCommand("cancelselect")
                SelectedChatMsg = nil
                mc.ENTRY:SetText("")
                mc.ENTRY.AutocompleteText = nil
                mc.CloseChat()
            end
        end

        --[[surface_SetDrawColor(62, 62, 64, 255 * mc.alpha)
        surface_DrawOutlinedRect(0, 0, w, h)
        draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250 * mc.alpha))
        surface_SetDrawColor(0, 0, 0, 120 * mc.alpha)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(0, 0, 0, 150 * mc.alpha)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, 20)]]
        --[[surface_SetDrawColor(0, 0, 0, 100 * mc.alpha)
        surface_DrawRect(0, 0, w, h)

        surface_SetDrawColor(83, 83, 83, 175 * mc.alpha)
        surface_DrawOutlinedRect(0, 0, w, h)]]
        if (moat_chat.Theme.CHAT_BG) then
			local COMPATABILE = table.Copy(moat_chat)
			COMPATABILE.config.h = COMPATABILE.config.h - 17
            moat_chat.Theme.CHAT_BG(s, w, h, COMPATABILE, DrawBlur)
        end

		if (MOAT_TYPERS and PlayersTyping() >= 1) then
            local str, are, chars = "", "is", {}

            for pl, time in pairs(MOAT_TYPERS) do
                if (IsValid(pl) and pl ~= LocalPlayer()) then
                    if (#chars == 0) then
                        str = pl:Nick()

						surface.SetFont "moat_CardFont2"
						table.insert(chars, {str, surface.GetTextSize(str), true})
                    elseif (PlayersTyping() > 3) then
                        str = "Several  people"

						surface.SetFont "moat_CardFont2"
						chars = {[1] = {str, surface.GetTextSize(str), true}}
                    else
                        str = str .. ", and " .. pl:Nick()

						surface.SetFont "moat_CardFont"
						table.insert(chars, {", and ", surface.GetTextSize(", and "), false})

						surface.SetFont "moat_CardFont2"
						table.insert(chars, {pl:Nick(), surface.GetTextSize(pl:Nick()), true})
                    end

					if (CurTime() - time > 5) then
						MOAT_TYPERS[pl] = nil
                    end
                end
            end

			if (chars[#chars] and chars[#chars][1] and chars[#chars][1] == ", and ") then
				table.remove(chars, #chars)
			end

            if (PlayersTyping() > 1) then
                are = "are"
            end

			str = str .. " " .. are .. " typing..."
			table.insert(chars, {" " .. are .. " typing...", surface.GetTextSize(" " .. are .. " typing..."), false})

			local xpos = 57
			if (#mc.chattype > 1) then
				xpos = moat_chat.sayvars[2].w + 12
			end

			if (PlayersTyping() > 0) then
				local text, color = str .. " " .. are .. " typing...", moat_chat.Theme.TextColor or Color(255, 255, 255)
				
				-- draw.RoundedBox(4, xpos - 45, h - 15, 7, 7, Color(color.r, color.g, color.b, 200 * math.abs(math.sin((RealTime() - (2 * 0.15)) * 2)) * mc.alpha))
				-- draw.RoundedBox(4, xpos - 35, h - 15, 7, 7, Color(color.r, color.g, color.b, 200 * math.abs(math.sin((RealTime() - (3 * 0.15)) * 2)) * mc.alpha))
				-- draw.RoundedBox(4, xpos - 25, h - 15, 7, 7, Color(color.r, color.g, color.b, 200 * math.abs(math.sin((RealTime() - (4 * 0.15)) * 2)) * mc.alpha))
				
				local center = math.abs(math.sin((RealTime() - (2 * 0.15)) * 2))
				surface.SetDrawColor(255, 255, 255, 200 * center * mc.alpha)
				draw.NoTexture()
				ux.DrawCircle(xpos - 45 + 4, h - 15 + 4, 4, 10)
				
				local left = math.abs(math.sin((RealTime() - (3 * 0.15)) * 2))
				surface.SetDrawColor(255, 255, 255, 200 * left * mc.alpha)
				draw.NoTexture()
				ux.DrawCircle(xpos - 35 + 4, h - 15 + 4, 4, 10)

				local right = math.abs(math.sin((RealTime() - (4 * 0.15)) * 2))
				surface.SetDrawColor(255, 255, 255, 200 * right * mc.alpha)
				draw.NoTexture()
				ux.DrawCircle(xpos - 25 + 4, h - 15 + 4, 4, 10)

				for i = 1, #chars do
					draw.DrawText(chars[i][1], chars[i][3] and "moat_CardFont2" or "moat_CardFont", xpos, h - 20, Color(color.r, color.g, color.b, 200 * mc.alpha))

					xpos = xpos + chars[i][2]
				end
			end
        end

		if (moat_chat.Theme.CHAT_BG) then
			return
        end

        DrawBlur(s, 5)
        draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50 * mc.alpha))
        draw_RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50 * mc.alpha))
        surface_SetDrawColor(150, 150, 150, 50 * mc.alpha)
        surface_DrawRect(0, 0, w, 21)
        draw.DrawText(moat_chat.header, moat_chat.font, 10, 1, Color(255, 255, 255, 255 * mc.alpha))
        local chat_str = "Say :"
        local chat_type = 1

        if (#mc.chattype > 1) then
            chat_str = "Say (TEAM) :"
            chat_type = 2
        end

        --[[surface_SetDrawColor(62, 62, 64, 255 * mc.alpha)
        surface_DrawOutlinedRect(5, mcc.h - 25, moat_chat.sayvars[chat_type].w, 20)
        surface_SetDrawColor(0, 0, 0, 150 * mc.alpha)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(5, mcc.h - 25, moat_chat.sayvars[chat_type].w, 20)]]
        draw.DrawText(chat_str, moat_chat.font, 28, h - 52, Color(255, 255, 255, 255 * mc.alpha))
    end

    local moveicon = Material("icon16/arrow_out.png")
    mc.MOVE = vgui.Create("DButton", FRAME)
    mc.MOVE:SetPos(mcc.w - 20, 2)
    mc.MOVE:SetSize(18, 18)
    mc.MOVE:SetText("")
    mc.MOVE.Moving = false
    mc.MOVE.MovingX = 0
    mc.MOVE.MovingY = 0
    mc.MOVE.HoverColor = 0

    mc.MOVE.Think = function(s)
        if (s:IsHovered()) then
            s.HoverColor = Lerp(FrameTime() * 10, s.HoverColor, 200)
        elseif (s.HoverColor > 1) then
            s.HoverColor = Lerp(FrameTime() * 10, s.HoverColor, 0)
        end

        if (input.IsMouseDown(MOUSE_LEFT) and s:IsHovered() and not s.Moving) then
            s.Moving = true
            s.MovingX, s.MovingY = mc.BG:CursorPos()
        end

        if (not input.IsMouseDown(MOUSE_LEFT) and s.Moving) then
            s.Moving = false

            return
        end

        if (s.Moving) then
            local mx, my = gui.MousePos()
            customchatx:SetInt(mx - s.MovingX)
            customchaty:SetInt(my - s.MovingY)
            mc.BG:SetPos(mx - s.MovingX, my - s.MovingY)
        end
    end

    mc.MOVE.Paint = function(s, w, h)
        cdn.DrawImage("https://static.moat.gg/f/dfc5c8d9272b952101d36e284799544c.png", 0, 0, w, h, Color(255, 255, 255, (50 + s.HoverColor) * mc.alpha))
    end

    mc.MOVE:SetToolTip("Hold left click to drag around, Right click to reset")

    mc.MOVE.DoRightClick = function(s)
        RunConsoleCommand("moat_chat")
    end

    sfx.HoverSound(mc.MOVE, sfx.Click2)
    sfx.ClickSound(mc.MOVE)
    mc.SPNL = vgui.Create("DScrollPanel", FRAME)
    mc.SPNL:SetPos(5, 30)
    mc.SPNL:SetSize(mcc.w - 10, mcc.h - 82)

    mc.SPNL.Paint = function(s, w, h)
        if (moat_chat.Theme.CHAT_PANEL) then
            moat_chat.Theme.CHAT_PANEL(s, w, h, moat_chat, DrawBlur)

            return
        end
    end

    --draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 15 * mc.alpha))
    local SPNL = mc.SPNL

    -- because the default scroll to child does a dumb glitchy animation
    function SPNL:ScrollToChild(panel)
        self:PerformLayout()
        local x, y = self.pnlCanvas:GetChildPosition(panel)
        local w, h = panel:GetSize()
        y = y + h * 0.5
        y = y - self:GetTall() * 0.5
        self.VBar:SetScroll(y)
    end

    function SPNL:ShouldScrollToChild(panel)
        local x, y = self.pnlCanvas:GetChildPosition(panel)
        local w, h = panel:GetSize()
        y = y + h * 0.5
        y = y - self:GetTall() * 0.5

        return y
    end

    local sbar = mc.SPNL:GetVBar()
    m_PaintChatVBar(sbar)
    mc.SPNL.Chat = vgui.Create("DPanel", mc.SPNL)
    mc.SPNL.Chat:SetPaintBackground(false)
    mc.SPNL.Chat.Contents = {}
    mc.SPNL.Chat:SetSize(mc.SPNL:GetWide(), 0)

    FRAME.AddItem = function(s, item)
        s = mc.SPNL
        local size = #s.Chat.Contents
        local chatc = s.Chat.Contents

        if (size == mc.MaxItems) then
            table.remove(chatc, 1):Remove()
            table.insert(chatc, item)
            item:SetParent(s.Chat)
            local curPos = 0
            local itemSize = 0

            for i = 1, #chatc do
                itemSize = chatc[i - 1] and chatc[i - 1]:GetTall() + 3 or 0
                curPos = curPos + itemSize

                if (IsValid(chatc[i])) then
                    chatc[i]:SetPos(0, curPos)
                end
            end

            --rebuild positions
            local x, y = chatc[#chatc]:GetPos()
            itemSize = chatc[#chatc]:GetTall()
            y = y + itemSize
            local tallsize, ypos = s.Chat:GetPos()
            tallsize = -s.Chat:GetTall() + s:GetTall()
            s.Chat:SetTall(y)

            if (not mc.AlphaControl(s) or ((s:ShouldScrollToChild(item) - s:GetVBar():GetScroll() <= 96))) then
                s:ScrollToChild(item)
            end

            return
        end

        local itemSize = item:GetTall() + 3
        s.Chat:SetTall(s.Chat:GetTall() + itemSize)
        table.insert(chatc, item)
        item:SetParent(s.Chat)
        item:SetPos(0, s.Chat:GetTall() - itemSize)
        local x, y = s.Chat:GetPos()

        if (not mc.AlphaControl(s) or ((s:ShouldScrollToChild(item) - s:GetVBar():GetScroll() <= 96))) then
            s:ScrollToChild(item)
        end
    end

    mc.ENTRY = vgui.Create("DTextEntry", FRAME)
    mc.ENTRY:SetSize(mcc.w - 65, 42)
    mc.ENTRY:SetPos(55, mcc.h - 42)
    mc.ENTRY:SetFont(mc.font)
    mc.ENTRY.Stored = {}

	local stored = cookie.GetString("moat_chat_sent")
	if (stored) then
		mc.ENTRY.Stored = bON(stored)
		if (not mc.ENTRY.Stored or not istable(mc.ENTRY.Stored)) then
			mc.ENTRY.Stored = {}
		end
	end

    mc.ENTRY.Paint = function(s, w, h)
        --[[
        surface_SetDrawColor(62, 62, 64, 255 * mc.alpha)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(0, 0, 0, 150 * mc.alpha)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(0, 0, w, h)]]
        if (moat_chat.Theme.CHAT_ENTRY) then
            moat_chat.Theme.CHAT_ENTRY(s, w, h, moat_chat, DrawBlur)

            return
        end

        surface_SetDrawColor(150, 150, 150, 50 * mc.alpha)
        surface_DrawRect(0, 0, w, h)
        s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))
    end

    mc.ENTRY.PaintOver = function(s, w, h)
        if (not s.AutocompleteText) then return end
        surface_SetFont(mc.font)
        local x = surface_GetTextSize(s:GetValue())
        local w, h = surface_GetTextSize(s.AutocompleteText)
        surface_SetDrawColor(s:GetHighlightColor())
        surface_DrawRect(x + 3, 2, w, h + 1)
        surface.SetTextColor(Color(255, 255, 255, 255))
        surface.SetTextPos(x + 3, 2)
        surface.DrawText(s.AutocompleteText)
    end

    mc.ENTRY.OnTextChanged = function(s)
        local autocomplete = mc.AutoComplete(s, true)
        s.AutocompleteText = autocomplete or nil

        if (s:GetValue():len() > 126) then
            s:SetText(s:GetValue():sub(1, 126))
            s:SetCaretPos(126)
            surface.PlaySound("/resource/warning.wav")
        end

        hook.Call("ChatTextChanged", GAMEMODE, s:GetValue())
    end

    mc.ENTRY.OnEnter = function(s)
        local teamchat = #mc.chattype > 1

        if (GetConVar("moat_gangsta"):GetInt() == 1) then
            moat_chat.Gangsta(s:GetValue(), function(txt)
                moat_chat.Speak(txt, teamchat)
            end)
        else
            moat_chat.Speak(s:GetValue(), teamchat)
        end

        if (string.Trim(s:GetValue()) ~= "") then
            table.insert(s.Stored, 1, s:GetValue())
			table.remove(s.Stored, 31)

			local store = bON.serialize(s.Stored)
			if (store) then
				cookie.Set("moat_chat_sent", store)
			end
        end

        SelectedChatMsg = nil
        s.AutocompleteText = nil
        s:SetText("")
        mc.CloseChat()
    end

    mc.ENTRY.OnKeyCodeTyped = function(s, k)
        if (k == KEY_BACKQUOTE) then
            RunConsoleCommand("cancelselect")
        elseif (k == KEY_ESCAPE) then
            RunConsoleCommand("cancelselect")
            SelectedChatMsg = nil
            s.AutocompleteText = nil
            s:SetText("")
            mc.CloseChat()
        elseif (k == KEY_TAB) or ((k == KEY_RIGHT) and (s:GetCaretPos() == #s:GetValue())) then
            mc.AutoComplete(s)
            s:OnTextChanged()
            s:SetCaretPos(#s:GetValue())
        elseif (k == KEY_UP and (s.Stored[s.storagePos + 1])) then
            s.storagePos = s.storagePos + 1
            s:SetText(s.Stored[s.storagePos])
            s:SetCaretPos(#s:GetValue())
        elseif (k == KEY_DOWN and (s.Stored[s.storagePos - 1] or s.storagePos - 1 == 0)) then
            s.storagePos = s.storagePos - 1
            s:SetText(s.Stored[s.storagePos] or "")
            s:SetCaretPos(#s:GetValue())
        elseif (k == KEY_ENTER) then
            s:OnEnter()
        end
    end

    mc.ENTRY.OnLoseFocus = function(s)
        if (input.IsKeyDown(KEY_TAB)) then
            s:RequestFocus()
            s:SetCaretPos(#s:GetText())
        end
    end
end

hook("InitPostEntity", moat_chat.InitChat)

function moat_chat.OpenChat()
    if (not IsValid(moat_chat.ENTRY)) then return moat_chat.InitChat() end
    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()

    if (not MT[CurTheme]) then
        CurTheme = "Blur"
    end

    moat_chat.Theme.CHAT_BG = MT[CurTheme].CHAT and MT[CurTheme].CHAT.CHAT_BG
    moat_chat.Theme.CHAT_PANEL = MT[CurTheme].CHAT and MT[CurTheme].CHAT.CHAT_PANEL
    moat_chat.Theme.CHAT_ENTRY = MT[CurTheme].CHAT and MT[CurTheme].CHAT.CHAT_ENTRY
    moat_chat.Theme.DefaultColor = MT[CurTheme].CHAT and MT[CurTheme].CHAT.DefaultColor
	moat_chat.Theme.TextColor = MT[CurTheme].TextColor
    moat_chat.header = "Moat Gaming | " .. GetServerName():sub(1, 18) .. (system.IsOSX() and "" or " | moat.gg")
    local mc = moat_chat
    local mcc = moat_chat.config
    mc.ENTRY:SetSize(mcc.w - 65, 20)
    mc.ENTRY:SetPos(55, mcc.h - 42)

    if (#mc.chattype > 1) then
        mc.ENTRY:SetSize(mcc.w - (mc.sayvars[2].w + 20), 20)
        mc.ENTRY:SetPos(mc.sayvars[2].w + 10, mcc.h - 42)
    end

    mc.BG:MakePopup()
    mc.ENTRY:RequestFocus()
    mc.ENTRY.storagePos = 0
end

function moat_chat.IsHovering(self, w, h, x, y)
    local xx, yy = self:CursorPos()

    if (xx > x and xx < x + w and yy > y and yy < y + h) then
        return true
    else
        return false
    end
end

function moat_chat.DrawText(self, texte, texttbl, a, name, data)
    surface_SetFont("moat_ChatFont")

    if (texttbl.IsItem and texttbl.item_tbl and texttbl.item_tbl.item) then
        local itemtbl = texttbl.item_tbl
        local ITEM_NAME_FULL = texttbl[1] --texttbl.ItemName
        local name_font = "moat_ChatFont"
        local draw_name_x = 4 + texttbl[2]
        local draw_name_y = texttbl[3]
        local name_col = itemtbl.item.NameColor or rarity_names[itemtbl.item.Rarity][2]:Copy()
        local TextSize = emoji.GetTextSize
        local DrawText = emoji.SimpleTextOutlined
		name_col.a = 255
        if (texttbl.IgnoreEmoji) then
            TextSize = surface_GetTextSize
            DrawText = draw_SimpleTextOutlined
        end

        if (itemtbl.item.NameEffect) then
            local tfx = itemtbl.item.NameEffect

            if (tfx == "glow") then
                m_DrawGlowingText(false, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
            elseif (tfx == "fire") then
                m_DrawFireText(itemtbl.item.Rarity, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
            elseif (tfx == "bounce") then
                m_DrawBouncingText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
            elseif (tfx == "enchanted") then
                m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, itemtbl.item.NameEffectMods[1], nil, nil, true)
			elseif (tfx == "threecolors") then
				if (not itemtbl.item.NameEffectMods[4]) then itemtbl.item.NameEffectMods[4] = 1 end
				if (not itemtbl.item.NameEffectMods[5]) then itemtbl.item.NameEffectMods[5] = RealTime() end
				if (itemtbl.item.NameEffectMods[5] <= RealTime()) then
					itemtbl.item.NameEffectMods[4] = itemtbl.item.NameEffectMods[4]  + 1
					if (itemtbl.item.NameEffectMods[4] > 3) then itemtbl.item.NameEffectMods[4] = 1 end
					itemtbl.item.NameEffectMods[5] = RealTime() + (FrameTime() * 5)
				end

                m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, itemtbl.item.NameEffectMods[itemtbl.item.NameEffectMods[4]], nil, nil, true)
            elseif (tfx == "electric") then
                m_DrawElecticText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, true)
            elseif (tfx == "frost") then
                DrawFrostingText(10, 1.5, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, Color(100, 100, 255), Color(255, 255, 255), true)
            else
                DrawText(ITEM_NAME_FULL, "moat_ChatFont", 4 + texttbl[2] + 1, texttbl[3] + 1, Color(name_col.r, name_col.g, name_col.b, 25), 0, 0, 0, Color(10, 10, 10, 0), true)
                DrawText(ITEM_NAME_FULL, "moat_ChatFont", 4 + texttbl[2] + 1, texttbl[3] + 1, Color(0, 0, 0, 175), 0, 0, 0, Color(10, 10, 10, 0), true)
                DrawText(ITEM_NAME_FULL, "moat_ChatFont", 4 + texttbl[2], texttbl[3], name_col, 0, 0, 0, Color(10, 10, 10, 0))
            end
        else
            DrawText(ITEM_NAME_FULL, "moat_ChatFont", 4 + texttbl[2] + 1, texttbl[3] + 1, Color(name_col.r, name_col.g, name_col.b, 25), 0, 0, 0, Color(10, 10, 10, 0), true)
            DrawText(ITEM_NAME_FULL, "moat_ChatFont", 4 + texttbl[2] + 1, texttbl[3] + 1, Color(0, 0, 0, 175), 0, 0, 0, Color(10, 10, 10, 0), true)
            DrawText(ITEM_NAME_FULL, "moat_ChatFont", 4 + texttbl[2], texttbl[3], name_col, 0, 0, 0, Color(10, 10, 10, 0))
        end

        if (not texttbl or (texttbl and not texttbl[1])) then return end
        local text_w, text_h = TextSize(texttbl[1])
        local text_x, text_y = 4 + texttbl[2], texttbl[3]

        if (moat_chat.IsHovering(self, text_w, text_h, text_x, text_y)) then
            self:SetCursor("hand")
            surface_SetDrawColor(name_col.r, name_col.g, name_col.b, a)
            surface_DrawLine(text_x, text_y + text_h - 1, text_x + text_w, text_y + text_h - 1)

            if (input.IsMouseDown(MOUSE_LEFT) and moat_chat.click <= CurTime()) then
                m_DrawFoundItem(itemtbl, "chat", name)
                moat_chat.click = CurTime() + 1
            end
        end

        return
    end

    local textpos = 0
    local spw = surface_GetTextSize(" ")

    for i = 1, #texte do
        local str = texte[i]
        local space = " "

        if (i == 1) then
            space = ""
        end

        local TextSize = emoji.GetTextSize
        local DrawText = emoji.SimpleTextOutlined

        if (texttbl.IgnoreEmoji) then
            TextSize = surface_GetTextSize
            DrawText = draw_SimpleTextOutlined
        end

        local tw, th = TextSize(space .. str)

        if (string.StartWith(str:lower(), "http://") or string.StartWith(str:lower(), "https://") or string.StartWith(str:lower(), "www.")) then
            DrawText(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos + 1, texttbl[3] + 1, Color(100, 100, 255, 25), 0, 0, 0, Color(10, 10, 10, 0), true)
            DrawText(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos + 1, texttbl[3] + 1, Color(0, 0, 0, 175), 0, 0, 0, Color(10, 10, 10, 0), true)
            DrawText(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos, texttbl[3], Color(100, 100, 255), 0, 0, 0, Color(10, 10, 10, 0))
            --draw_SimpleTextOutlined(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos, texttbl[3], Color(100, 100, 255), 0, 0, 0.5, Color(10, 10, 10, a))
            local text_w, text_h = TextSize(str)
            local text_x, text_y = 4 + texttbl[2] + textpos + spw, texttbl[3]

            if (moat_chat.IsHovering(self, text_w, text_h, text_x, text_y)) then
                self:SetCursor("hand")
                surface_SetDrawColor(100, 100, 255, a)
                surface_DrawLine(text_x, text_y + text_h - 1, text_x + text_w, text_y + text_h - 1)

                if (input.IsMouseDown(MOUSE_LEFT) and moat_chat.click <= CurTime()) then
                    gui.OpenURL(str)
                    moat_chat.click = CurTime() + 1
                end
            end
        else
            DrawText(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos + 1, texttbl[3] + 1, Color(texttbl[4].r, texttbl[4].g, texttbl[4].b, 25), 0, 0, 0, Color(10, 10, 10, 0), true)
            DrawText(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos + 1, texttbl[3] + 1, Color(0, 0, 0, 175), 0, 0, 0, Color(10, 10, 10, 0), true)
            DrawText(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos, texttbl[3], texttbl[4], 0, 0, 0, Color(10, 10, 10, 0))
            --draw_SimpleTextOutlined(space .. str, "moat_ChatFont", 4 + texttbl[2] + textpos, texttbl[3], texttbl[4], 0, 0, 0.5, Color(10, 10, 10, a))
            local text_w, text_h = TextSize(str)
            local text_x, text_y = 4 + texttbl[2] + textpos + spw, texttbl[3]

            if (moat_chat.IsHovering(self, text_w, text_h, text_x, text_y)) then
                self:SetCursor("arrow")
            end
        end

        textpos = textpos + tw
    end
end

function moat_chat.ChatObjectPaint(self)
    local curtime = CurTime()
    local a = self.CreateTime - curtime <= 1 and (self.CreateTime - curtime) * 510 or 255
    local mc = moat_chat
    if a < 0 then return end

    if SelectedChatMsg == self and mc.AlphaControl(self) then
        if SelectingText then
            MouseReleasedX, MouseReleasedY = self:CursorPos()

            for i = 1, #self.TextTable do
                if (MousePressedX < self.TextTable[i][2] and MousePressedY - mc.TextSize.h <= self.TextTable[i][3] and MouseReleasedY - mc.TextSize.h > self.TextTable[i][3]) or (MousePressedX <= self.TextTable[i][2] and MouseReleasedX >= self.TextTable[i][2] and MousePressedY - mc.TextSize.h < self.TextTable[i][3] and MouseReleasedY > self.TextTable[i][3]) or (MousePressedY <= mc.TextSize.h and MouseReleasedY > mc.TextSize.h and self.TextTable[i][3] >= mc.TextSize.h and self.TextTable[i][3] <= mc.TextSize.h and MouseReleasedX >= self.TextTable[i][2]) then
                    self.TextTable[i][4] = true
                else
                    self.TextTable[i][4] = nil
                end
            end
        end

        local lines = self.TextTable[#self.TextTable][3] / mc.TextSize.h + 1
        surface_SetDrawColor(mc.HighlightColor)

        for i = 1, lines do
            local xsize, x, start = 0, 0

            for a = 1, #self.TextTable do
                if self.TextTable[a][4] and self.TextTable[a][3] == i * mc.TextSize.h - mc.TextSize.h then
                    x = a == 1 and 4 or x == 0 and self.TextTable[a][2] - 4 or x
                    xsize = self.TextTable[a][2] - x + 4
                end
            end

            surface_DrawRect(x, moat_chat.TextSize.h * i - mc.TextSize.h, xsize, moat_chat.TextSize.h)
        end
    end

    if self.Icon then
        surface_SetDrawColor(255, 255, 255, a)
        surface_SetMaterial(self.Icon)
        surface_DrawTexturedRect(2, 2, 16, 16)
    end

    for i = 1, #self.Text do
        self.Text[i][4].a = a
        if (not self.Text[i] or (self.Text[i] and not self.Text[i][1])) then continue end
        local texte = string.Explode(" ", self.Text[i] and self.Text[i][1] or "")
        if (not texte) then return end
        moat_chat.DrawText(self, texte or "", self.Text[i], a, self.Text[1][1])
    end
end

moat_chat.Queue, moat_chat.CheckQueue = {}, 0

hook.Add("Think", "Moat.Chat.Queue", function()
    if (moat_chat.CheckQueue <= CurTime() and next(moat_chat.Queue)) then
        if (not IsValid(moat_chat.BG) or not IsValid(moat_chat.SPNL)) then return end

        for k, v in ipairs(moat_chat.Queue) do
            chat.AddText(unpack(v))
            moat_chat.Queue[k] = nil
        end

        moat_chat.CheckQueue = CurTime() + 0.1
    end
end)

function chat.AddText(...)
    if (not IsValid(moat_chat.BG) or not IsValid(moat_chat.SPNL)) then
        table.insert(moat_chat.Queue, {...})

        return
    end

    local TextTable, TextPosX, TextPosY, icon = {...}, 0, 0
    local type1 = type(TextTable[1])

    if type1 == "IMaterial" then
        icon = TextTable[1]
        TextPosX = 20
        table.remove(TextTable, 1)
    end

    local TextTableNum, OnPlayerChatBlocked, Safe, Sender = #TextTable, false, true

    for i = 1, TextTableNum do
        local t = type(TextTable[i])

        if (t == "Player") then
			if (not Sender) then
				Sender = TextTable[i]
			end

			if (IsValid(TextTable[i]) and IsValid(LocalPlayer())) then
                local block = hook.Run("PrePlayerChat", TextTable[i])

                if (block and isbool(block) and block == true and TextTable[i] ~= LocalPlayer()) then
                    OnPlayerChatBlocked = true
                    break
                end
            else
                OnPlayerChatBlocked = true
                break
            end

            if (TextTable[i - 1] and IsColor(TextTable[i - 1])) then
                TextTable[i] = TextTable[i]:Nick()
                continue
            end

            table.insert(TextTable, i + 1, {
                IgnoreEmoji = true,
                Text = TextTable[i]:Nick()
            })

            TextTableNum = TextTableNum + 1

            if (TextTable[i]:Team() == TEAM_SPEC or (isstring(TextTable[2]) and TextTable[2] == "*DEAD* ")) then
                TextTable[i] = spec_color
            else
                TextTable[i] = terror_color
            end
        elseif t ~= "string" and t ~= "table" and (not TextTable[i].IsItem) then
            if TextTable[i].IsValid and TextTable[i]:IsValid() then
                TextTable[i] = TextTable[i]:GetClass()
            else
                TextTable[i] = "NULL"
            end
		end
    end


    for i = 1, TextTableNum do
		if (not IsValid(LocalPlayer()) or not IsValid(Sender)) then
			break
		end

		local t = type(TextTable[i])

		if (t == "string") then
			local safe, str = FamilyFriendly(TextTable[i], Sender)

			if (safe) then
				TextTable[i] = safe
			elseif (Sender == LocalPlayer()) then
				TextTable[i] = str
			else
				Safe = false
			end
		elseif (t == "table") then
			if (TextTable[i][1]) then
				local safe, str = FamilyFriendly(TextTable[i][1], Sender)

				if (safe) then
					TextTable[i][1] = safe
				elseif (Sender == LocalPlayer()) then
					TextTable[i][1] = str
				else
					Safe = false
				end
			elseif (TextTable[i].Text) then
				local safe, str = FamilyFriendly(TextTable[i].Text, Sender)

				if (safe) then
					TextTable[i].Text = safe
				elseif (Sender == LocalPlayer()) then
					TextTable[i].Text = str
				else
					Safe = false
				end
			end
		end
	end

    if (OnPlayerChatBlocked or (not Safe)) then return end
	
    return moat_chat.AddText(TextTable, TextPosX, TextPosY, icon, TextTableNum)
end

function moat_chat.AddText(TextTable, TextPosX, TextPosY, icon, TextTableNum)
    local mc = moat_chat
    local FinalText = {}
    local windowSizeX = 486
    surface_SetFont("moat_ChatFont")
    local _, tall = surface_GetTextSize("AbC1230")
    TextTableNum = #TextTable
    local pos = 0
    local LineText = ""
    local LastColor = Color(255, 255, 255, 255)

    while pos ~= TextTableNum do
        pos = pos + 1

        if (type(TextTable[pos]) == "table" and TextTable[pos].IsItem and type(TextTable[pos][2]) == "table") then
            local text = TextTable[pos][1]
            local TextSize = emoji.GetTextSize

            if (TextTable[pos].IsItem) then
                text = TextTable[pos]["ItemName"] or "Scripted Weapon"
            end

			text = FamilyFriendly(text)
            if (TextTable[pos].IgnoreEmoji) then
                TextSize = surface_GetTextSize
            end

            local x, y = TextSize(text)

            table.insert(FinalText, {
                text,
                TextPosX,
                TextPosY,
                TextTable[pos][2],
                1,
                IgnoreEmoji = TextTable[pos].IgnoreEmoji
            })

            TextPosX = TextPosX + x
        else
            while IsColor(TextTable[pos]) do
                LastColor = TextTable[pos]
                pos = pos + 1
            end

            if (not TextTable[pos]) then break end
            local text, cap = TextTable[pos]
            local TextSize = emoji.GetTextSize
            local IgnoreEmoji = false
            local cur = TextTable[pos]

            if (istable(cur)) then
                if (cur.IgnoreEmoji) then
                    TextSize = surface_GetTextSize
                    IgnoreEmoji = true
                end

                if (cur.IsItem) then
                    text = cur["ItemName"] or "Scripted Weapon"

					if (text[1] and string.match(text[1], '^%u')) then
						cap = true 
					end
                elseif (cur.Text) then
                    text = cur.Text or "error"
                else
                    text = cur[1]
                end
            end

			text = FamilyFriendly(text)

			if (istable(cur) and cur.IsItem and cap) then
				text = string.Title(text)
            end

            if (not text) then break end
            local x, y = TextSize(text)

            if TextPosX + x >= windowSizeX then
                local startpos, t, t2, size = #FinalText

                for line in text:gmatch("[^%s]+") do
                    if t then
                        t2 = table.concat({t, line}, " ")
                    else
                        t2 = line
                        t = ""
                    end

                    size = TextSize(t2)

                    if TextPosX + size >= windowSizeX then
                        local data = {
                            t,
                            TextPosX,
                            TextPosY,
                            LastColor,
                            IgnoreEmoji = IgnoreEmoji
                        }

                        if (istable(cur) and cur.IsItem) then
                            data.IsItem = true
                            data.item_tbl = cur.item_tbl
                            data.ItemName = text
                        end

                        table.insert(FinalText, data)
                        table.insert(FinalText, {" ", TextPosX, TextPosY, LastColor})
                        TextPosX = 0
                        TextPosY = TextPosY + tall
                        t = line
                    else
                        t = t2
                    end
                end

                --table.insert(FinalText, {t, TextPosX, TextPosY, LastColor})
                local data = {
                    t,
                    TextPosX,
                    TextPosY,
                    LastColor,
                    IgnoreEmoji = IgnoreEmoji
                }

                if (istable(cur) and cur.IsItem) then
                    data.IsItem = true
                    data.item_tbl = cur.item_tbl
                    data.ItemName = t
                end

                table.insert(FinalText, data)

                if (t) then
                    TextPosX = TextPosX + TextSize(t)
                end
            else
                local data = {
                    text,
                    TextPosX,
                    TextPosY,
                    LastColor,
                    IgnoreEmoji = IgnoreEmoji
                }

                if (istable(cur) and cur.IsItem) then
                    data.IsItem = true
                    data.item_tbl = cur.item_tbl
                    data.ItemName = text
                end

                table.insert(FinalText, data)
                TextPosX = TextPosX + x
            end
        end
    end

    local ListItem = vgui.Create("DPanel", moat_chat.SPNL)
    ListItem.IsChatTextPanel = true
    ListItem.Icon = icon
    ListItem.CreateTime = CurTime() + mc.FadeTime
    ListItem.Text = FinalText
    ListItem:SetSize(mc.SPNL:GetWide(), TextPosY + tall)
    ListItem.Paint = mc.ChatObjectPaint
    ListItem:SetPaintBackground(false)
    local TextTable = {}

    for i = 1, #FinalText do
        if (not FinalText[i] or (FinalText[i] and not FinalText[i][1])) then continue end
        local len = FinalText[i][1]:len()
        local TextX, TextY = FinalText[i][2], FinalText[i][3]

        for a = 1, len do
            local x = surface_GetTextSize(FinalText[i][1][a])
            TextX = TextX + x
            table.insert(TextTable, {FinalText[i][1][a], TextX, TextY})
        end
    end

    ListItem.TextTable = TextTable
    mc.BG:AddItem(ListItem)
    local pack, a = {}, 0

    for i = 1, #FinalText do
        a = a + 1
        pack[a] = Color(FinalText[i][4].r, FinalText[i][4].g, FinalText[i][4].b, 255)
        a = a + 1
        pack[a] = FinalText[i][1]
    end

    pack[a + 1] = "\n"
    MsgC(unpack(pack))
    if (pack and pack[4] and type(pack[4]) == "string" and string.find(pack[4], "obtained")) then return end

    if (math.random(100) <= 50) then
        sfx.Hover()
    else
        sfx.Click1()
    end
end

hook.Add("PlayerBindPress", "moat_OpenChat", function(ply, bind, pressed)
    if (string.sub(bind, 1, 11) == "messagemode") then
        if (bind == "messagemode2") then
            moat_chat.chattype = "team"
        else
            moat_chat.chattype = ""
        end

        moat_chat.OpenChat()
        hook.Call("StartChat", GAMEMODE, bind == "messagemode2")

        return true
    end
end)

hook.Add("StartChat", "moat_StartChat", function()
    moat_chat.isopen = true
end)

hook.Add("FinishChat", "moat_FinishChat", function()
    moat_chat.isopen = false
    m_DrawFoundItem({}, "remove_chat")
end)

local hud_tbl = {
    ["CHudChat"] = true
}

hook.Add("HUDShouldDraw", "moat_DisableDefaultChat", function(name)
    if (hud_tbl[name]) then return false end
end)

local function StartedTyping(pl, key)
	if (KEYS[key] and pl:IsTyping()) then
        if (not MOAT_TYPING[LocalPlayer()]) then
            net.Start"Moat.Typing"
            net.WriteBool(true)
            net.SendToServer()
        end

		MOAT_TYPING[LocalPlayer()] = CurTime()
    end
end

hook("PlayerButtonDown", StartedTyping)

hook("Think", function()
    if (LocalPlayer():IsTyping()) then
        if (MOAT_TYPING[LocalPlayer()] and CurTime() - MOAT_TYPING[LocalPlayer()] >= 5) then
            MOAT_TYPING[LocalPlayer()] = nil
            net.Start"Moat.Typing"
            net.WriteBool(false)
            net.SendToServer()
        end

		for k, v in ipairs(KEYS) do
			if (input.IsKeyDown(k) and not MOAT_TYPING[LocalPlayer()]) then
				StartedTyping(LocalPlayer(), k)

				break
			end
		end
    elseif (MOAT_TYPING[LocalPlayer()]) then
        MOAT_TYPING[LocalPlayer()] = nil
        net.Start"Moat.Typing"
        net.WriteBool(false)
        net.SendToServer()
    end
end)

net.ReceivePlayer("Moat.Typing", function(pl)
	if (pl == LocalPlayer()) then return end
    local is = net.ReadBool()

    if (is and (pl:Team() == LocalPlayer():Team() or LocalPlayer():Team() == TEAM_SPEC or GetRoundState() ~= ROUND_ACTIVE)) then
        MOAT_TYPERS[pl] = CurTime()
    else
        MOAT_TYPERS[pl] = nil
    end
end)

local effect_offset = CreateConVar("moat_chat_effect_offset", 15, FCVAR_ARCHIVE)
local effect_size = 50

hook("PostDrawTranslucentRenderables", function(depth, skybox)
	if (skybox) then return end

	for pl, time in pairs(MOAT_TYPERS) do
		if (not IsValid(pl) or pl == LocalPlayer()) then
			continue
		end

		if (not pl.PlayerVisible or pl:Team() == TEAM_SPEC or pl:GetNoDraw()) then
			continue
		end

		local attachment_id = pl:LookupAttachment("anim_attachment_head") or 0
		local attachment = pl:GetAttachment(attachment_id)
		local base_pos = attachment and attachment.Pos or (pl:LocalToWorld(pl:OBBCenter()) + pl:GetUp() * 24)
		local render_pos = base_pos + pl:GetUp() * effect_offset:GetFloat()
		local render_ang = EyeAngles()
		render_ang:RotateAroundAxis(render_ang:Right(), 90)
		render_ang:RotateAroundAxis(-render_ang:Up(), 90)

		cam.Start3D2D(render_pos, render_ang, 0.05)
			local center = math.abs(math.sin((RealTime() - (2 * 0.15)) * 2))
			surface.SetDrawColor(255, 255, 255, 200 * center)
			draw.NoTexture()
			ux.DrawCircle(-effect_size/2 - (effect_size * 2.5), -effect_size/2, effect_size, 20)
			
			local left = math.abs(math.sin((RealTime() - (3 * 0.15)) * 2))
			surface.SetDrawColor(255, 255, 255, 200 * left)
			draw.NoTexture()
			ux.DrawCircle(-effect_size/2, -effect_size/2, effect_size, 20)

			local right = math.abs(math.sin((RealTime() - (4 * 0.15)) * 2))
			surface.SetDrawColor(255, 255, 255, 200 * right)
			draw.NoTexture()
			ux.DrawCircle(-effect_size/2 + (effect_size * 2.5), -effect_size/2, effect_size, 20)
		cam.End3D2D()
	end
end)