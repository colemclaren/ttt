MOAT_GAMBLE = MOAT_GAMBLE or {}
MOAT_GAMBLE.CurCat = 1
MOAT_GAMBLE.ChatTable = {}
MOAT_GAMBLE.GlobalTable = {}
versus_logs_games = {}
local GLOBAL_LAST = 0
local GLOBAL_LAST_A = 0
surface.CreateFont("moat_GambleTitle", {
    font = "DermaLarge",
    size = 22,
    weight = 800
})

surface.CreateFont("moat_CardFont", {
    font = "DermaLarge",
    size = 14,
    weight = 800
})

MOAT_GAMBLE.TitlePoly = {
	{x = 1, y = 1},
	{x = 140, y = 1},
	{x = 170, y = 45},
	{x = 1, y = 45}
}

local gradient_d = Material("vgui/gradient-d")
local gradient_u = Material("vgui/gradient-u")
local mat_coins = Material("icon16/coins.png")
local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

function m_PopulateGambleMenu(pnl)
end

local function m_GetFontWidth(font, txt)
	surface.SetFont(font)
	return surface.GetTextSize(txt)
end

local gamble_help = {
	["Mines"] = "In the Mines gamemode, you make money by trying to uncover tiles that don't have mines in them.\nIf you uncover a tile with a bomb however, you lose all your money.\nYou can cashout your earnings anytime.",
	["Roulette"] = "Welcome to Roulette!\nYou can bet for what color the spinner is going to be and win 2x that amount if it's black or red\nor 14x the amount if it's green!",
	-- ["Crash"] = "Place a bet and watch the multiplier go up!\nIf the multiplier 'Crashes' before you cash out then you lose all your money.\nThe multiplier can crash at 0x as well.",
	["Blackjack"] = "Welcome to Blackjack!\nThe goal is to not go over 21,\nand to have a higher number than the dealer!\nMake sure to practice with small bets.\nGood luck!",
	["Jackpot"] = "Everyone places their money into a big pot and the winner get's all of it.\nYour chance of winning what percentage of the pot you are.\n(There is a 5% tax on the winnings from jackpot)\nJackpot is connected to multiple servers!\nYou can also click on people's pictures to view info about them!!",
	["Versus"] = "Versus is like coinflip.\nYou create or join a game and have a 50% chance of winning.\nThere is a tax on winnings as well."
}

versus_stats = {
	top = {},
	streak = {}
}

function m_CreateGamblePanel(pnl_x, pnl_y, pnl_w, pnl_h)
	if (IsValid(MOAT_GAMBLE_BG)) then return end
	net.Start("gversus.Sync")
	net.SendToServer()

	net.Start("versus.Sync")
	net.SendToServer()
	net.Start("versus.stats")
	net.SendToServer()
	net.Start("versus.last")
	net.SendToServer()

	MOAT_GAMBLE.LocalChat = false
	MOAT_GAMBLE.CurCat = 1
	MOAT_GAMBLE.TitlePoly = {
		{x = 1, y = 1},
		{x = 0, y = 1},
		{x = 30, y = 45},
		{x = 1, y = 45}
	}

    MOAT_GAMBLE_BG = vgui.Create("DFrame")
    MOAT_GAMBLE_BG:SetSize(pnl_w, pnl_h)
    MOAT_GAMBLE_BG:SetPos(pnl_x, pnl_y)
    MOAT_GAMBLE_BG:MakePopup()
    MOAT_GAMBLE_BG:SetKeyboardInputEnabled(false)
    MOAT_GAMBLE_BG:SetDraggable(false)
    MOAT_GAMBLE_BG:ShowCloseButton(false)
    MOAT_GAMBLE_BG:SetTitle("")
    MOAT_GAMBLE_BG:SetAlpha(0)
    MOAT_GAMBLE_BG.Think = function(s)
    	if (not IsValid(MOAT_INV_BG)) then
    		s:Remove()
    	else
			local x, y = MOAT_INV_BG:GetPos()
            s:SetPos(x + 5, y + 30)
    	end

    	if ((input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT)) and not s:IsHovered() and not IsValid(MOAT_REQ_BG)) then
    		s:MakePopup()
			if (IsValid(MOAT_REQ_BG)) then
				MOAT_REQ_BG:MakePopup()
			end
    	end
    end
    MOAT_GAMBLE_BG.Paint = function(s, w, h)
    	draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 255))
    	
    	--[[Header Stuff]]--
    	draw.RoundedBox(0, 0, 0, w, 45, Color(56, 56, 56, 255))
    	draw.RoundedBox(0, 0, 45, w, 1, Color(86, 86, 86, 255))

    	MOAT_GAMBLE.TitlePoly[2].x = Lerp(FrameTime() * 10, MOAT_GAMBLE.TitlePoly[2].x, 140)
    	MOAT_GAMBLE.TitlePoly[3].x = Lerp(FrameTime() * 10, MOAT_GAMBLE.TitlePoly[3].x, 170)

    	surface.SetDrawColor(46, 46, 46)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TitlePoly)

    	surface.SetDrawColor(15, 15, 15, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(0, 0, w, 45)

		local w2, h2 = draw.SimpleText("Moat", "moat_GambleTitle", 5, 1, Color(0, 25, 50))
    	draw.SimpleText(" Gaming", "moat_GambleTitle", 5 + w2, 1, Color(50, 50, 50))

    	draw.SimpleText("Moat", "moat_GambleTitle", 4, 0, Color(0, 198, 255))
    	draw.SimpleText(" Gaming", "moat_GambleTitle", 4 + w2, 0, Color(255, 255, 255))

    	draw.SimpleText("Gambling Room", "moat_GambleTitle", 6, 21, Color(50, 50, 0))
    	draw.SimpleText("Gambling Room", "moat_GambleTitle", 5, 20, Color(255, 255, 0))

    	draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 194, 6, Color(0, 0, 0))
    	draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 193, 5, Color(255, 255, 255))

    	draw.SimpleText("IC: " .. string.Comma(MOAT_INVENTORY_CREDITS), "moat_ItemDesc", 208, 27, Color(0, 0, 0))
        draw.SimpleText("IC: " .. string.Comma(MOAT_INVENTORY_CREDITS), "moat_ItemDesc", 207, 26, Color(255, 255, 255))
        surface.SetMaterial(mat_coins)
        surface.SetDrawColor(Color(255, 255, 255))
        surface.DrawTexturedRect(185, 26, 16, 16)


        --[[Chat Stuff]]--
    	draw.RoundedBox(0, 1, 46, 225, h-46, Color(25, 25, 25))
    	//draw.RoundedBox(0, 1, 46, 225, 25, Color(45, 45, 45))
    	surface.SetDrawColor(86, 86, 86)
    	//surface.DrawLine(1, 46+25, 225, 46+25)
    	//surface.DrawLine(225, 46, 225, 46+25)

    	//draw.SimpleText("Chat Lounge", "moat_ItemDesc", 1+113, 59, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    	draw.RoundedBox(4, 6, h-51, 215, 45, Color(86, 86, 86))
    	draw.RoundedBox(4, 7, h-50, 213, 43, Color(20, 20, 20))

		if MOAT_GAMBLE.LocalChat then
    		draw.SimpleText("Say something..", "moat_ItemDesc", 13, h-47, Color(255, 255, 255, MOAT_GAMBLE_CHAT_COL))
		elseif (MOAT_GAMBLE.GlobalBlock or 0) > CurTime() then
			draw.SimpleText("Please wait " .. string.NiceTime((MOAT_GAMBLE.GlobalBlock+1) - CurTime()), "moat_ItemDesc", 13, h-47, Color(255, 255, 255, MOAT_GAMBLE_CHAT_COL))
		else
			draw.SimpleText("Say something...", "moat_ItemDesc", 13, h-47, Color(255, 255, 255, MOAT_GAMBLE_CHAT_COL))
		end

    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawOutlinedRect(0, 0, w, h)
    end
	
	local gamble_chat_local = vgui.Create("DButton",MOAT_GAMBLE_BG)
	gamble_chat_local:SetSize(112,28)
	gamble_chat_local:SetPos(114,46)
	gamble_chat_local:SetText("")
	sfx.SoundEffects(gamble_chat_local)
	function gamble_chat_local:Paint(w,h)
		if MOAT_GAMBLE.LocalChat then
			draw.SimpleText("Local Chat", "moat_GambleTitle", 6, 3, Color(255,255,255))
		else
			draw.RoundedBox(0,0,0,w,h,Color(86,86,86,50))
			draw.SimpleText("Local Chat", "moat_GambleTitle", 6, 3, Color(255,255,255))
		end
	end
	function gamble_chat_local:DoClick()
		MOAT_GAMBLE.LocalChat = true
		MOAT_GAMBLE.ToggleChat()
	end
	local cb = false
	local global_color = Color(255,255,255)

	local gamble_chat_global = vgui.Create("DButton",MOAT_GAMBLE_BG)
	gamble_chat_global:SetSize(112,28)
	gamble_chat_global:SetPos(2,46)
	gamble_chat_global:SetText("")
	sfx.SoundEffects(gamble_chat_global)
	timer.Create("GambleChatGlobal",0.5,0,function()
		if not IsValid(gamble_chat_global) then return end
		if GLOBAL_LAST_A < GLOBAL_LAST then
			if cb then
				global_color = Color(255,255,255)
				cb = false
			else
				global_color = Color(255,0,0)
				cb = true
			end
		end
	end)
	function gamble_chat_global:Paint(w,h)
		if not MOAT_GAMBLE.LocalChat then
			local c = Color(255,255,255)
			draw.SimpleText("Global Chat", "moat_GambleTitle", 5, 3, c)
		else
			local c = Color(255,255,255)
			if GLOBAL_LAST_A < GLOBAL_LAST then
				c = global_color
			end
			draw.RoundedBox(0,0,0,w,h,Color(86,86,86,50))
			draw.SimpleText("Global Chat", "moat_GambleTitle", 5, 3, c)
		end
	end
	function gamble_chat_global:DoClick()
		GLOBAL_LAST_A = GLOBAL_LAST
		MOAT_GAMBLE.LocalChat = false
		MOAT_GAMBLE.ToggleChat()
	end

    local MOAT_GAMBLE_AVA = vgui.Create("AvatarImage", MOAT_GAMBLE_BG)
    MOAT_GAMBLE_AVA:SetPos(170, 4)
    MOAT_GAMBLE_AVA:SetSize(17, 17)
    MOAT_GAMBLE_AVA:SetPlayer(LocalPlayer(), 32)

    -- local MOAT_GAMBLE_CATS = {{"Mines", Color(150, 0, 255)}, {"Roulette", Color(255, 0, 50)}, {"Crash", Color(255, 255, 0)}, {"Jackpot", Color(0, 255, 0)}, {"Versus", Color(0, 255, 255)}}
	local MOAT_GAMBLE_CATS = {
		{"Versus", Color(0, 255, 255)},
		{"Blackjack", Color(255, 255, 0)},
		{"Roulette", Color(255, 0, 50)},
		-- {"Jackpot", Color(0, 255, 0)},
		{"Mines", Color(150, 0, 255)}
	}
    local CAT_WIDTHS = 0

    for i = 1, #MOAT_GAMBLE_CATS do
    	local MOAT_GAMBLE_CAT_BTN = vgui.Create("DButton", MOAT_GAMBLE_BG)
    	MOAT_GAMBLE_CAT_BTN:SetSize(81, 30)
    	MOAT_GAMBLE_CAT_BTN:SetPos(320 + CAT_WIDTHS, 15)
    	MOAT_GAMBLE_CAT_BTN:SetText("")
    	MOAT_GAMBLE_CAT_BTN.HoveredNum = 0
        MOAT_GAMBLE_CAT_BTN.Paint = function(s, w, h)
            local col = MOAT_GAMBLE_CATS[i][2]

            surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(0, h - (h * s.HoveredNum), w, h * s.HoveredNum)

            draw.SimpleTextOutlined(MOAT_GAMBLE_CATS[i][1], "GModNotify", w/2, (h/2)-(s.HoveredNum*4), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))

            if (MOAT_GAMBLE.CurCat == i) then
                draw.RoundedBox(0, 0, h-4, w, 4, MOAT_GAMBLE_CATS[i][2])
                surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
                surface.SetMaterial(gradient_d)
                surface.DrawTexturedRect(0, 0, w, h)
            elseif (s:IsHovered()) then
                s.HoveredNum = Lerp(10 * FrameTime(), s.HoveredNum, 1)
            elseif (not s:IsHovered()) then
                s.HoveredNum = Lerp(10 * FrameTime(), s.HoveredNum, 0)
            end

            draw.RoundedBox(0, 0, h - (4 * s.HoveredNum), w, 4 * s.HoveredNum, MOAT_GAMBLE_CATS[i][2])
        end
    	
        MOAT_GAMBLE_CAT_BTN.DoClick = function(s)
        	if (i == MOAT_GAMBLE.CurCat) then return end

            
            net.Start("MOAT_GAMBLE_CAT")
            net.WriteUInt(i, 4)
            net.SendToServer()

			if gamble_help[MOAT_GAMBLE_CATS[i][1]] then
				if cookie.GetString("mGambleHelp" .. MOAT_GAMBLE_CATS[i][1],"") ~= gamble_help[MOAT_GAMBLE_CATS[i][1]] then
					-- check the string so it pops up again if we change it
					Derma_Message(gamble_help[MOAT_GAMBLE_CATS[i][1]], MOAT_GAMBLE_CATS[i][1] .. " Info", "Got it!")
					cookie.Set("mGambleHelp" .. MOAT_GAMBLE_CATS[i][1],gamble_help[MOAT_GAMBLE_CATS[i][1]])
				end
			end
        end

        sfx.SoundEffects(MOAT_GAMBLE_CAT_BTN)

        CAT_WIDTHS = CAT_WIDTHS + 83
    end

	if gamble_help[MOAT_GAMBLE_CATS[1][1]] then
		if cookie.GetString("mGambleHelp" .. MOAT_GAMBLE_CATS[1][1],"") ~= gamble_help[MOAT_GAMBLE_CATS[1][1]] then
			-- check the string so it pops up again if we change it
			Derma_Message(gamble_help[MOAT_GAMBLE_CATS[1][1]], MOAT_GAMBLE_CATS[1][1] .. " Info", "Got it!")
			cookie.Set("mGambleHelp" .. MOAT_GAMBLE_CATS[1][1],gamble_help[MOAT_GAMBLE_CATS[1][1]])
		end
	end

    MOAT_GAMBLE_CHAT = vgui.Create("RichText", MOAT_GAMBLE_BG)
    MOAT_GAMBLE_CHAT:SetPos(1, 46 + 25)
    MOAT_GAMBLE_CHAT:SetSize(225, pnl_h-46-25-50)
    function MOAT_GAMBLE_CHAT:PerformLayout()
		self:SetFontInternal("moat_ItemDesc")
		self:SetFGColor(Color(255, 255, 255))
	end
	function MOAT_GAMBLE_CHAT:ActionSignal(a,b)
		print(a,b)
	end
	MOAT_GAMBLE_CHAT:SetText(" ")
	function MOAT_GAMBLE.ToggleChat()
		MOAT_GAMBLE_CHAT:SetText(" ")
		if MOAT_GAMBLE.LocalChat then
			for i = 1, #MOAT_GAMBLE.ChatTable do
				m_AddGambleChatMessage(unpack(MOAT_GAMBLE.ChatTable[i]))
			end
			MOAT_GAMBLE_CHAT:GotoTextEnd()
		else
			for i = 1, #MOAT_GAMBLE.GlobalTable do
				m_AddGambleChatMessage(unpack(MOAT_GAMBLE.GlobalTable[i]))
			end
			MOAT_GAMBLE_CHAT:GotoTextEnd()
		end
	end

	local MOAT_GAMBLE_CHAT_ENTRY = vgui.Create("DTextEntry", MOAT_GAMBLE_BG)
    MOAT_GAMBLE_CHAT_ENTRY:SetPos(10, pnl_h - 48)
    MOAT_GAMBLE_CHAT_ENTRY:SetSize(210, 43)
    MOAT_GAMBLE_CHAT_ENTRY:SetFont("moat_ItemDesc")
    MOAT_GAMBLE_CHAT_ENTRY:SetTextColor(Color(255, 255, 255))
    MOAT_GAMBLE_CHAT_ENTRY:SetCursorColor(Color(255, 255, 255))
    MOAT_GAMBLE_CHAT_ENTRY:SetHistoryEnabled(true)
    MOAT_GAMBLE_CHAT_ENTRY:SetEnterAllowed(true)
    MOAT_GAMBLE_CHAT_ENTRY:SetTabbingDisabled(true)
    MOAT_GAMBLE_CHAT_ENTRY:SetDrawBackground(false)
    MOAT_GAMBLE_CHAT_ENTRY:SetMultiline(true)
    MOAT_GAMBLE_CHAT_ENTRY:SetVerticalScrollbarEnabled(false)

    MOAT_GAMBLE_CHAT_ENTRY.Think = function(s)
        if (#tostring(s:GetValue():Trim() or "") == 0) then
            MOAT_GAMBLE_CHAT_COL = 50
        else
            MOAT_GAMBLE_CHAT_COL = 0
        end
    end

    MOAT_GAMBLE_CHAT_ENTRY.OnEnter = function(s)
        local val = s:GetValue()
		if (MOAT_GAMBLE.GlobalBlock or 0) > CurTime() and (not MOAT_GAMBLE.LocalChat) then
			m_AddGambleChatMessage(Color(255,0,0),"Wait another " .. string.NiceTime(MOAT_GAMBLE.GlobalBlock - CurTime()) .." before sending any global messages!")
			return
		end 
        if (#tostring(val) > 0) then
            s:AddHistory(val)
			if MOAT_GAMBLE.LocalChat then
            	net.Start("MOAT_GAMBLE_NEW_CHAT")
			else
				net.Start("MOAT_GAMBLE_GLOBAL")
				MOAT_GAMBLE.GlobalBlock = CurTime() + 3
			end
            net.WriteString(tostring(val))
            net.SendToServer()
            s:SetText("")
            s:SetValue("")

            MOAT_GAMBLE_CHAT_COL = 50
        end
		return false
    end

    MOAT_GAMBLE_CHAT_ENTRY.OnKeyCodeTyped = function(s, k)
		if ((MOAT_GAMBLE.GlobalBlock or 0) > CurTime()) and (not MOAT_GAMBLE.LocalChat) then return true end
    	if (k == KEY_ENTER) then
    		s:OnEnter()
			return true
    	end
    end

    MOAT_GAMBLE_CHAT_ENTRY.MaxChars = 192

    MOAT_GAMBLE_CHAT_ENTRY.OnTextChanged = function(s)
		if ((MOAT_GAMBLE.GlobalBlock or 0) > CurTime()) and (not MOAT_GAMBLE.LocalChat) then s:SetText("") return end
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.sub(tostring(txt), #txt, #txt) == "#") then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end

    m_DrawVersusPanel()

	MOAT_GAMBLE_BG:AlphaTo(255, 0.15, 0.15)
	MOAT_GAMBLE.ToggleChat()
	timer.Simple(1,function()
		if not IsValid(MOAT_GAMBLE_CHAT) then return end
		MOAT_GAMBLE_CHAT:GotoTextEnd()
	end)
end

MOAT_GAMBLE.DiceProfitPoly = {
	{x = 290, y = 0},
	{x = 505, y = 0},
	{x = 505, y = 100},
	{x = 345, y = 100}
}

MOAT_GAMBLE.DiceArrowPoly = {
	{x = 228, y = 350},
	{x = 278, y = 350},
	{x = 253, y = 375}
}

MOAT_GAMBLE.TextEntryPoly = {
	{x = 15, y = 65},
	{x = 139, y = 65},
	{x = 162, y = 100},
	{x = 15, y = 100}
}

MOAT_GAMBLE.TextEntryPolyOutline = {
	{x = 14, y = 64},
	{x = 140, y = 64},
	{x = 164, y = 101},
	{x = 14, y = 101}
}

MOAT_GAMBLE.TextEntryPoly2 = {
	{x = 15, y = 180},
	{x = 139, y = 180},
	{x = 162, y = 215},
	{x = 15, y = 215}
}

MOAT_GAMBLE.TextEntryPoly2Outline = {
	{x = 14, y = 179},
	{x = 140, y = 179},
	{x = 164, y = 216},
	{x = 14, y = 216}
}

MOAT_GAMBLE.TextEntryPoly3 = {
	{x = 342, y = 180},
	{x = 466, y = 180},
	{x = 489, y = 215},
	{x = 342, y = 215}
}

MOAT_GAMBLE.TextEntryPoly3Outline = {
	{x = 341, y = 179},
	{x = 467, y = 179},
	{x = 491, y = 216},
	{x = 341, y = 216}
}

surface.CreateFont("moat_DiceWin", {
    font = "DermaLarge",
    size = 48,
    weight = 600
})

MOAT_GAMBLE.DiceBet = 47.5
MOAT_GAMBLE.DiceUnder = true
MOAT_GAMBLE.DiceBetAmount = 10
MOAT_GAMBLE.DiceWinChance = 1
MOAT_GAMBLE.DiceMultiplier = 1

function m_oldDrawDicePanel()

	MOAT_GAMBLE_DICE = vgui.Create("DPanel", MOAT_GAMBLE_BG)
	MOAT_GAMBLE_DICE:SetPos(230, 50)
	MOAT_GAMBLE_DICE:SetSize(505, 460)
	MOAT_GAMBLE_DICE.Paint = function(s, w, h)
		--[[Background & Outline]]
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawOutlinedRect(0, 0, w, h)

    	local winchance = MOAT_GAMBLE.DiceBet
    	local multiplier = math.Round(100/MOAT_GAMBLE.DiceBet, 2)
    	if (not MOAT_GAMBLE.DiceUnder) then
    		winchance = math.Round(100 - MOAT_GAMBLE.DiceBet, 2)
    		if (IsValid(MOAT_DICE_WINCHANCE) and not MOAT_DICE_WINCHANCE:IsEditing()) then
    			MOAT_DICE_WINCHANCE:SetText(winchance)
    		end
    		multiplier = math.Round(100/(100-MOAT_GAMBLE.DiceBet), 2)
    	end

    	--[[Bet Amount]]
    	draw.SimpleText("BET AMOUNT", "moat_GambleTitle", 15, 35, Color(255, 255, 255))

    	if (MOAT_GAMBLE.DiceBetAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.DiceBetAmount < 0.01)) then
    		surface.SetDrawColor(255, 0, 0)
    	else
    		surface.SetDrawColor(86, 86, 86)
    	end
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyOutline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly)

    	--[[Profit On Win]]
    	surface.SetDrawColor(46, 46, 46)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.DiceProfitPoly)

    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawLine(290, 0, 345, 100)
    	surface.DrawLine(345, 100, 505, 100)
    	surface.DrawLine(0, 115, w, 115)

    	draw.SimpleText("PROFIT ON WIN", "moat_GambleTitle", w-15, 15, Color(0, 150, 0), TEXT_ALIGN_RIGHT)
    	draw.SimpleText(math.Round((MOAT_GAMBLE.DiceBetAmount * multiplier) - MOAT_GAMBLE.DiceBetAmount, 2) .. " IC", "moat_DiceWin", w-85, 40, Color(255,255,102), TEXT_ALIGN_CENTER)

		--[[Win Chance & Multiplier]]
    	draw.SimpleText("WIN CHANCE", "moat_GambleTitle", 15, 150, Color(255, 255, 255))

    	surface.SetDrawColor(86, 86, 86)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly2Outline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly2)

    	draw.SimpleText("MULTIPLIER", "moat_GambleTitle", 342, 150, Color(255, 255, 255))

    	surface.SetDrawColor(86, 86, 86)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly3Outline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly3)

    	draw.SimpleText(multiplier, "moat_GambleTitle", 352, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    	--[[Slidey Bar]]
    	--draw.RoundedBox(4, 15, 250, w-30, 15, Color(46, 46, 46))
    	/*draw.RoundedBox(4, 15, 250, (w-30) / 2, 15, Color(146, 146, 146))

    	draw.RoundedBox(4, (w / 2) - 6, 245, 12, 25, Color(255, 255, 255))*/


		--[[Roll Under Things]]
        draw.RoundedBox(0, 1, 300, w-2, 50, Color(20, 20, 20, 255))
        surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.DiceArrowPoly)

    	draw.RoundedBox(4, 175, 310, 320, 30, Color(65, 65, 70))
    	draw.RoundedBox(4, 176, 311, 318, 28, Color(35, 35, 40))

    	local num = math.Round(MOAT_GAMBLE.DiceBet, 2)
    	local under = MOAT_GAMBLE.DiceUnder and "UNDER" or "OVER"
    	local text = "ROLL " .. under .. " " .. num .. " TO WIN"
    	local rollpos = m_GetFontWidth("moat_GambleTitle", text)
    	local daw, dah = draw.SimpleText("ROLL " .. under .. " ", "moat_GambleTitle", 335 - (rollpos/2), 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da2w, da2h = draw.SimpleText(num, "moat_GambleTitle", 335 - (rollpos/2) + daw, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	draw.SimpleText(" TO WIN", "moat_GambleTitle", 335 - (rollpos/2) + daw + da2w, 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_DICE)
	MOAT_DICE_BET:SetPos(22, 67)
	MOAT_DICE_BET:SetSize(100, 30)
	MOAT_DICE_BET:SetFont("moat_GambleTitle")
    MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetEnterAllowed(true)
    MOAT_DICE_BET:SetNumeric(true)
    MOAT_DICE_BET:SetDrawBackground(false)
    MOAT_DICE_BET:SetMultiline(false)
    MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_BET:SetEditable(true)
    MOAT_DICE_BET:SetValue("1")
    MOAT_DICE_BET:SetText("1")
    MOAT_DICE_BET.MaxChars = 7
    MOAT_DICE_BET.Think = function(s)
    	if (not s:IsEditing() and MOAT_GAMBLE.DiceBetAmount ~= tonumber(s:GetText())) then
    		s:SetText(MOAT_GAMBLE.DiceBetAmount)
    	end
    end
    MOAT_DICE_BET.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_BET.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.EndsWith(tostring(txt), ".") or (string.sub(tostring(txt), 1, 1) == "0" and #tostring(txt) > 1) or string.EndsWith(tostring(txt), "-")) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
	function MOAT_DICE_BET:CheckNumeric(strValue)
		if (not string.find("1234567890.", strValue, 1, true)) then
			return true
		end

		return false
	end
	MOAT_DICE_BET.OnEnter = function(s)
		if (s:GetText() == "") then s:SetText("0") end
		
		MOAT_GAMBLE.DiceBetAmount = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 1, 5000)
	end
	MOAT_DICE_BET.OnLoseFocus = function(s)
		s:OnEnter()
	end

	MOAT_DICE_WINCHANCE = vgui.Create("DTextEntry", MOAT_GAMBLE_DICE)
	MOAT_DICE_WINCHANCE:SetPos(22, 182)
	MOAT_DICE_WINCHANCE:SetSize(100, 30)
	MOAT_DICE_WINCHANCE:SetFont("moat_GambleTitle")
    MOAT_DICE_WINCHANCE:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_WINCHANCE:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_WINCHANCE:SetEnterAllowed(true)
    MOAT_DICE_WINCHANCE:SetNumeric(true)
    MOAT_DICE_WINCHANCE:SetDrawBackground(false)
    MOAT_DICE_WINCHANCE:SetMultiline(false)
    MOAT_DICE_WINCHANCE:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_WINCHANCE:SetEditable(true)
    MOAT_DICE_WINCHANCE:SetValue(MOAT_GAMBLE.DiceBet)
    MOAT_DICE_WINCHANCE:SetText(MOAT_GAMBLE.DiceBet)
    MOAT_DICE_WINCHANCE.MaxChars = 7
    MOAT_DICE_WINCHANCE.Think = function(s)
    	if (not s:IsEditing() and MOAT_GAMBLE.DiceBet ~= tonumber(s:GetText())) then
    		s:SetText(MOAT_GAMBLE.DiceBet)
    	end
    end
    MOAT_DICE_WINCHANCE.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_WINCHANCE.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
	function MOAT_DICE_WINCHANCE:CheckNumeric(strValue)
		if (not string.find("1234567890.", strValue, 1, true)) then
			return true
		end

		return false
	end
	MOAT_DICE_WINCHANCE.OnEnter = function(s)
		if (s:GetText() == "") then s:SetText("0") end
		
		MOAT_GAMBLE.DiceBet = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 1, 95)
	end
	MOAT_DICE_WINCHANCE.OnLoseFocus = function(s)
		s:OnEnter()
	end

	local BTN1 = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	BTN1:SetPos(178, 15)
	BTN1:SetSize(50, 40)
	BTN1:SetText("")
	BTN1.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("1/2", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN1.DoClick = function(s, w, h)
		MOAT_GAMBLE.DiceBetAmount = math.max(MOAT_GAMBLE.DiceBetAmount/2, 1)
	end

	local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	BTN2:SetPos(178+55, 15)
	BTN2:SetSize(50, 40)
	BTN2:SetText("")
	BTN2.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("2x", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN2.DoClick = function(s, w, h)
		MOAT_GAMBLE.DiceBetAmount = math.min(MOAT_GAMBLE.DiceBetAmount * 2, 5000)
	end

	local BTN3 = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	BTN3:SetPos(178, 15+45)
	BTN3:SetSize(50, 40)
	BTN3:SetText("")
	BTN3.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("Min", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN3.DoClick = function(s, w, h)
		MOAT_GAMBLE.DiceBetAmount = 1
	end

	local BTN4 = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	BTN4:SetPos(178+55, 15+45)
	BTN4:SetSize(50, 40)
	BTN4:SetText("")
	BTN4.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("Max", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN4.DoClick = function(s, w, h)
		MOAT_GAMBLE.DiceBetAmount = math.Clamp(MOAT_INVENTORY_CREDITS, 1, 5000)
	end

	local BTN_SLIDER = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	BTN_SLIDER:SetPos(15, 250)
	BTN_SLIDER:SetSize(475, 15)
	BTN_SLIDER:SetText("")
	BTN_SLIDER.SliderPos = 475 * (MOAT_GAMBLE.DiceBet/95)
	BTN_SLIDER.Paint = function(s, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(46, 46, 46))
		draw.RoundedBox(4, 0, 0, s.SliderPos, h, Color(146, 146, 146))
	end
	BTN_SLIDER.Moving = false
	BTN_SLIDER.Think = function(s)
		if (input.IsMouseDown(MOUSE_LEFT) and (s:IsHovered() or s.Moving)) then
			s.Moving = true

			local x, y = s:CursorPos()
			MOAT_GAMBLE.DiceBet = math.Clamp(95 * (x/475), 1, 95)
		elseif (not input.IsMouseDown(MOUSE_LEFT)) then
			s.Moving = false
		end

		s.SliderPos = 475 * (MOAT_GAMBLE.DiceBet/95)
	end

	local BTN_SLIDER_CNTRL = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	BTN_SLIDER_CNTRL:SetPos(15 + (475 * (MOAT_GAMBLE.DiceBet/95)) - 6, 245)
	BTN_SLIDER_CNTRL:SetSize(12, 25)
	BTN_SLIDER_CNTRL:SetText("")
	BTN_SLIDER_CNTRL.Paint = function(s, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255))
	end
	BTN_SLIDER_CNTRL.Think = function(s)
		s:SetPos(15 + (475 * (MOAT_GAMBLE.DiceBet/95)) - 6, 245)
	end
	BTN_SLIDER_CNTRL.OnMousePressed = function(s, k)
		if (k ~= MOUSE_LEFT) then return end
		
		BTN_SLIDER.Moving = true
	end
	BTN_SLIDER_CNTRL.OnMouseReleased = function(s, k)
		if (k ~= MOUSE_LEFT) then return end
		
		BTN_SLIDER.Moving = false
	end

	local UNDER = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	UNDER:SetPos(10, 310)
	UNDER:SetSize(75, 30)
	UNDER:SetText("")
	UNDER.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered() or MOAT_GAMBLE.DiceUnder) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("UNDER", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	UNDER.DoClick = function(s, w, h)
		MOAT_GAMBLE.DiceUnder = true
	end

	local OVER = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	OVER:SetPos(90, 310)
	OVER:SetSize(75, 30)
	OVER:SetText("")
	OVER.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered() or not MOAT_GAMBLE.DiceUnder) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("OVER", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	OVER.DoClick = function(s, w, h)
		MOAT_GAMBLE.DiceUnder = false
	end

	MOAT_DICE_ROLL = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	MOAT_DICE_ROLL:SetPos(10, 460-75)
	MOAT_DICE_ROLL:SetSize(505-20, 65)
	MOAT_DICE_ROLL:SetText("")
	MOAT_DICE_ROLL.Rolling = false
	MOAT_DICE_ROLL.Output = false
	MOAT_DICE_ROLL.Won = false
	MOAT_DICE_ROLL.OutputRoll = 0
	MOAT_DICE_ROLL.OutputNum = 0
	MOAT_DICE_ROLL.Paint = function(s, w, h)
		if (s.Output and s.Won) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(64, 165, 71)
			if (s:IsHovered()) then
				btncolor = Color(44, 145, 51)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("You've rolled " .. s.OutputRoll .. " and WON " .. s.OutputNum, "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		elseif (s.Output and not s.Won) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(165, 30, 30)
			if (s:IsHovered()) then
				btncolor = Color(145, 10, 10)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(131, 0, 0, 255))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("You've rolled " .. s.OutputRoll .. " and lost " .. s.OutputNum, "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		end

		if (s.Rolling) then
			draw.RoundedBox(4, 0, 5, w, 60, Color(67, 68, 67))
    		draw.RoundedBox(4, 0, 0, w, 60, Color(128, 128, 128))

    		draw.SimpleText("Rolling...", "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		local btndown = 0
		if (s:IsDown()) then
			btndown = 2
		end
		local btncolor = Color(64, 165, 71)
		if (s:IsHovered()) then
			btncolor = Color(44, 145, 51)
		end
		draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
		draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    	draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 60)

    	draw.SimpleText("ROLL!", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	MOAT_DICE_ROLL.DoClick = function(s)
		if (s.Rolling) then
			return
		end

		if (s.Output) then
			s.Output = false

			return
		end

		s.Output = false
		s.Rolling = true

		net.Start("MOAT_GAMBLE_DICE")
		net.WriteDouble(MOAT_GAMBLE.DiceBetAmount)
		net.WriteDouble(MOAT_GAMBLE.DiceBet)
		net.WriteBool(MOAT_GAMBLE.DiceUnder)
		net.SendToServer()
	end
end
MOAT_GAMBLE.MinesAmount = 0
function math.toK(n)
	if n > 999 then
		return math.Round(n/1000,2) .. "k"
	end
	return n
end
local mines_active = false
local profit = 0
local mines_game = 0
local curbomb = 1
local bombs = {1,3,5,24}
local maximum = {15,15,15,20}
local next_profit = 0
local tiles_left = 0
local bomb_tiles = 0
local mines = {}
for i = 1,25 do
	mines[i] = 0
end
local e = {0.02,0.02,0.02,0.03,0.03,0.03,0.03,0.04,0.04,0.05,0.05,0.05,0.06,0.06,0.1,0.2,0.3,0.4,0.5,0.7,1,2.0,3.0,5.0}
local function getmaximum(c)
	local i = 0
	local m = 1
	if curbomb == 2 then m = 1.25 elseif curbomb == 3 then m = 1.5 end
	if curbomb == 4 then return c * 12.5 end
	for k,v in pairs(e) do
		i = i + ((c * v) * m)
	end
	return i
end
function aaaam_DrawDicePanel()
	MOAT_GAMBLE_DICE = vgui.Create("DPanel", MOAT_GAMBLE_BG)
	MOAT_GAMBLE_DICE:SetPos(230, 50)
	MOAT_GAMBLE_DICE:SetSize(505, 460)
	MOAT_GAMBLE_DICE.Paint = function(s, w, h)
		--[[Background & Outline]]
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
    	surface.SetDrawColor(86, 86, 86)
		surface.DrawLine(0,150,w,150)
    	surface.DrawOutlinedRect(0, 0, w, h)

		draw.SimpleText("Temporarily Disabled", "moat_GambleTitle", 15, 15, Color(255, 255, 255))

	end
end

local bomb_sounds = {
    ["win"] = "https://static.moat.gg/f/9PIiSvHopONR7egMCMSzWCbhgzTo.mp3",
    ["boom"] = "https://static.moat.gg/f/f0VWNHpOfBrTK8SzNu4OP6Qqaj2w.mp3",
    ["end"] = "https://static.moat.gg/f/oa2TST8otq3qoHg1VzfNkbJmu4OZ.mp3",
	["versus_win"] = "https://static.moat.gg/f/moat_versus_win_pn.mp3",
	[1] = "https://static.moat.gg/f/HFYN4ZEEuObwgbs7yoO7UmvgUG9B.mp3",
	[2] = "https://static.moat.gg/f/JLbZfNntpdmPOrcRcdRnWDdEG5iU.mp3",
}

local function PlayMinesSound(var)
	cdn.PlayURL(bomb_sounds[var])
end

local function PlayVersusSound(var)
    cdn.PlayURL(bomb_sounds[var])
end

function m_DrawDicePanel()
	MOAT_GAMBLE_DICE = vgui.Create("DPanel", MOAT_GAMBLE_BG)
	MOAT_GAMBLE_DICE:SetPos(230, 50)
	MOAT_GAMBLE_DICE:SetSize(505, 460)
	MOAT_GAMBLE_DICE.Paint = function(s, w, h)
		--[[Background & Outline]]
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
    	surface.SetDrawColor(86, 86, 86)
		surface.DrawLine(0,150,w,150)
    	surface.DrawOutlinedRect(0, 0, w, h)

		draw.SimpleText("BET AMOUNT: ", "moat_GambleTitle", 15, 15, Color(255, 255, 255))

		draw.SimpleText("BOMB AMOUNT: ", "moat_GambleTitle", 15, 55, Color(255, 255, 255))

	--"moat_ItemDesc"
		draw.SimpleText("(Min 100, Max 2,500)", "moat_ItemDesc", 305, 25, Color(100,100,100))
		if (MOAT_GAMBLE.MinesAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.MinesAmount < 100)) then
    		surface.SetDrawColor(255, 0, 0)
    	else
    		surface.SetDrawColor(86, 86, 86)
    	end
		surface.DrawOutlinedRect(150, 11, 150, 30)

		local ow = w - 239
		surface.SetDrawColor(86, 86, 86)
		surface.DrawLine(249,230,487,230)
		surface.DrawLine(249,310,487,310)
		draw.SimpleText("NEXT PROFIT", "moat_GambleTitle", 239 + (ow/2), 180, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		draw.SimpleText(string.Comma(next_profit) .. " IC", "moat_GambleTitle", 239 + (ow/2), 210, Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		draw.SimpleText("TILES LEFT", "moat_GambleTitle", 239 + (ow/2), 255, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		draw.SimpleText(tiles_left .. " TILES", "moat_GambleTitle", 239 + (ow/2), 285, Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		draw.SimpleText("PROFIT CHANCE", "moat_GambleTitle", 239 + (ow/2), 330, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		local p = ((100) - (100 * (bomb_tiles/(bomb_tiles + tiles_left))))
		p = math.Round(p,2)
		if p ~= p then p = "0" end
		draw.SimpleText( p .. "%", "moat_GambleTitle", 239 + (ow/2), 360, Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
	local make_game = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	make_game:SetPos(10,100)
	make_game:SetSize(484,31)
	make_game:SetText("")
	function make_game:Paint(w,h)
		local a = 255
		if self:IsHovered() then a = 175 end
		local c = Color(10,200,10,a)
		if (MOAT_GAMBLE.MinesAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.MinesAmount < 100)) or mines_active  then
			c = Color(86,86,86)
			--print("ding",inGame)
			--print("lp",versus_players[LocalPlayer()])
			a = 10
		end
		draw.RoundedBox(0,0,0,w,h,c)
		surface.SetDrawColor(0,255,0,a)
		surface.DrawOutlinedRect(0,0,w,h)
		draw.SimpleText("MAKE GAME", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
	function make_game.DoClick()
		if (MOAT_GAMBLE.MinesAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.MinesAmount < 100))  then return end
		if mines_active then return end
		net.Start("mines.CreateGame")
		net.WriteInt(MOAT_GAMBLE.MinesAmount,16)
		net.WriteInt(curbomb,8)
		net.SendToServer()
		profit = MOAT_GAMBLE.MinesAmount
		mines_game = MOAT_GAMBLE.MinesAmount
		bomb_tiles = bombs[curbomb]
		tiles_left = 25 - bomb_tiles
	end
	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_DICE)
	MOAT_DICE_BET:SetPos(150, 11)
	MOAT_DICE_BET:SetSize(150, 30)
	MOAT_DICE_BET:SetFont("moat_GambleTitle")
    MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetEnterAllowed(true)
    MOAT_DICE_BET:SetNumeric(true)
    MOAT_DICE_BET:SetDrawBackground(false)
    MOAT_DICE_BET:SetMultiline(false)
    MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_BET:SetEditable(true)
    MOAT_DICE_BET:SetValue("1")
    MOAT_DICE_BET:SetText("1")
    MOAT_DICE_BET.MaxChars = 7
    MOAT_DICE_BET.Think = function(s)
    	if (not s:IsEditing() and MOAT_GAMBLE.MinesAmount ~= tonumber(s:GetText())) then
    		s:SetText(MOAT_GAMBLE.MinesAmount)
    	end
    end
    MOAT_DICE_BET.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_BET.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.EndsWith(tostring(txt), ".") or (string.sub(tostring(txt), 1, 1) == "0" and #tostring(txt) > 1) or string.EndsWith(tostring(txt), "-")) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
	function MOAT_DICE_BET:CheckNumeric(strValue)
		if (not string.find("1234567890.", strValue, 1, true)) then
			return true
		end

		return false
	end
	MOAT_DICE_BET.OnEnter = function(s)
		if (s:GetText() == "") then s:SetText("0") end
		
		MOAT_GAMBLE.MinesAmount = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 100, 2500)
	end
	MOAT_DICE_BET.OnLoseFocus = function(s)
		s:OnEnter()
	end
	for i = 1,4 do 
		local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_DICE)
		BTN2:SetPos(130 + (35 * i-1), 52)
		BTN2:SetSize(30, 30)
		BTN2:SetText("")
		BTN2.Paint = function(s, w, h)
			local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

			if (s:IsHovered()) then
				cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
			end

			if curbomb == i then
				cols[1] = Color(0,255,0)
			end


			draw.RoundedBox(0, 0, 0, w, h, cols[1])
			draw.RoundedBox(0 , 1, 1, w-2, h-2, cols[2])

			draw.SimpleText(bombs[i], "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		BTN2.DoClick = function(s, w, h)
			curbomb = i
		end
	end
	local curi = 0
	net.Receive("mines.Start",function()
		for i = 1,25 do
			mines[i] = 0
		end
		next_profit = net.ReadInt(32)
		mines_active = true
		mines_lock = false
		mines_blown = false
		mines_cashed = false
	end)
	mines_cashed = false
	mines_blown = false
	net.Receive("mines.Uncover",function()
		mines_lock = false
		local a = net.ReadInt(32)
		if a > 0 then profit = profit + a end--s
		mines[net.ReadInt(8)] = a
		if net.ReadBool() then
            if (not mines_cashed and not mines_blown) then
                PlayMinesSound("boom")
            end
			mines_active = false
			mines_blown = true
		else
            PlayMinesSound("win")
			tiles_left = tiles_left - 1
			next_profit = net.ReadInt(32)
		end
	end)
	for y = 0,4 do
		for x = 0,4 do
			curi = curi + 1
			local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_DICE)
			BTN2.i = curi
			BTN2:SetPos(10 + (45 * x), 160 + (45 * y))
			BTN2:SetSize(40, 40)
			BTN2:SetText("")
			BTN2.Paint = function(s, w, h)
				/*local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

				if (s:IsHovered()) then
					cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
				end*/
				if mines[s.i] == 0 then
					draw.RoundedBox(0, 0, 0, w, h, s:IsHovered() and Color(207, 207, 230) or Color(187, 187, 210))
				elseif mines[s.i] > 0 then
					draw.RoundedBox(0, 0, 0, w, h, Color(114,188,120))
					draw.SimpleText("" .. math.toK(mines[s.i]), "moat_ItemDesc", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				elseif mines[s.i] == -1 then
					draw.RoundedBox(0,0,0,w,h,Color(235, 84, 36))
                    cdn.DrawImage("https://static.moat.gg/f/mg_bomb.png", 0, 0, 64, 64)
				end
				--draw.SimpleText(bombs[i], "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			BTN2.DoClick = function(s, w, h)
				--print(s.i)
				if not mines_active then return end
				if mines_lock then return end
				if mines[s.i] ~= 0 then return end
				mines_lock = true
				net.Start("mines.Uncover")
				net.WriteInt(s.i,8)
				net.SendToServer()
			end
		end
	end
	MOAT_DICE_ROLL = vgui.Create("DButton", MOAT_GAMBLE_DICE)
	MOAT_DICE_ROLL:SetPos(5, 460-62)
	MOAT_DICE_ROLL:SetSize(505-10, 56)
	MOAT_DICE_ROLL:SetText("")
	MOAT_DICE_ROLL.Rolling = false
	MOAT_DICE_ROLL.Output = false
	MOAT_DICE_ROLL.Won = false
	MOAT_DICE_ROLL.OutputRoll = 0
	MOAT_DICE_ROLL.OutputNum = 0
	MOAT_DICE_ROLL.Paint = function(s, w, h)
		local btndown = 0
		local btncolor = Color(64, 165, 71)
		if (s:IsHovered()) then
			btncolor = Color(44, 145, 51)
		end
		if (not mines_active) and mines_blown and (not mines_cashed) then
			btncolor = Color(150,0,0)
			draw.RoundedBox(4, 0, 5, w, 51, Color(170,0,0, 255))
			draw.RoundedBox(4, 0, btndown, w, 51, Color(170, 0,0))
			draw.RoundedBox(4, 1, btndown + 1, w-2, 51-2, btncolor)
		else
			if (s:IsDown()) then
				btndown = 2
			end
			draw.RoundedBox(4, 0, 5, w, 51, Color(0, 131, 61, 255))
			draw.RoundedBox(4, 0, btndown, w, 51, Color(170, 170, 170))
			draw.RoundedBox(4, 1, btndown + 1, w-2, 51-2, btncolor)
		end

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 51)
		if mines_cashed then
			draw.SimpleText("Cashed out @ " .. string.Comma(profit) .. " IC!", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif mines_active then
    		draw.SimpleText("Cash out @ " .. string.Comma(profit) .. " IC", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif mines_blown then
			draw.SimpleText("Blew up @ " .. string.Comma(profit) .. " IC", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("Waiting for game...", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	function MOAT_DICE_ROLL.DoClick()
		if mines_active and (profit ~= mines_game) then
			mines_cashed = true
			mines_active = false
            net.Start("mines.CashOut")
            net.SendToServer()
            PlayMinesSound("end")
		end
	end
end

net.Receive("MOAT_GAMBLE_DICE", function(len)
	local success = net.ReadBool()

	if (not success) then
		MOAT_DICE_ROLL.Rolling = false
		MOAT_DICE_ROLL:SetDisabled(false)

		return
	end

	local won = net.ReadBool()
	local roll = net.ReadDouble()
	local amt = net.ReadDouble()

	MOAT_DICE_ROLL.Won = won
	MOAT_DICE_ROLL.OutputRoll = math.Round(roll, 2)
	MOAT_DICE_ROLL.OutputNum = math.Round(amt, 2)
	MOAT_DICE_ROLL.Output = true

	MOAT_DICE_ROLL.Rolling = false
end)

function m_RemoveDicePanel()
	if (IsValid(MOAT_GAMBLE_DICE)) then
		MOAT_GAMBLE_DICE:Remove()
	end
end

MOAT_GAMBLE.TextEntryPolyR = {
    {x = 15, y = 45},
    {x = 139, y = 45},
    {x = 162, y = 80},
    {x = 15, y = 80}
}

MOAT_GAMBLE.TextEntryPolyOutlineR = {
    {x = 14, y = 44},
    {x = 140, y = 44},
    {x = 164, y = 81},
    {x = 14, y = 81}
}

surface.CreateFont("moat_RouletteAmount", {
    font = "DermaLarge",
    size = 30,
    weight = 800
})
surface.CreateFont("moat_RoulettTime", {
    font = "DermaLarge",
    size = 50,
    weight = 800
})
surface.CreateFont("moat_RoulettRoll", {
    font = "DermaLarge",
    size = 26,
    weight = 1200
})
surface.CreateFont("moat_RoulettBet", {
    font = "DermaLarge",
    size = 17,
    weight = 800
})
local bg = Color(86, 86, 86)
local fsize = 505, 460
local mats = {
    wheel = "https://static.moat.gg/f/KrsoP3vZn2GJoyHK2yidAT4roLe5.png",
    mat_green_normal = "https://static.moat.gg/f/hMJafIYykyzKw2daM8zXwICHN4Kq.png",
    mat_green_red = "https://static.moat.gg/f/m1z4PprRigdVQIZ3yNg7pUUgM69P.png",
    mat_green_black = "https://static.moat.gg/f/91DaxiCjyvv7ACrgUT7di8IzOD0I.png",
    mat_green_normal_hover = "https://static.moat.gg/f/WJhJgSHgT3Yh6q42SZwdcoBtyVg1.png",
    mat_green_black_hover = "https://static.moat.gg/f/jECkhuCfEbRiuACRvPXr3FWoHMfi.png",
    mat_green_red_hover = "https://static.moat.gg/f/7oKAmGxFqozCePoq8EiRbkxYyoxT.png"
}

MOAT_GAMBLE.RouletteAmount = 0
MOAT_GAMBLE.RouletteMax = 5000
MOAT_GAMBLE.RedAmount = 0 
MOAT_GAMBLE.BlackAmount = 0
MOAT_GAMBLE.GreenAmount = 0
roulette_players = {}
local angs = { -- Can do math for this but im lazy
    [0] = {95,116},
    [1] = {119,140},
    [8] = {143,164},
    [2] = {167,188},
    [9] = {191.6,212},
    [3] = {214.6,235.7},
    [10] = {239,259},
    [4] = {262,283},
    [11] = {287,307},
    [5] = {310,330},
    [12] = {334,354},
    [6] = {358,378},
    [13] = {383,403},
    [7] = {407,427},
    [14] = {431,451} 
}

local function getangle(num)
    local ang = angs[math.floor(num)]
    local m = num - math.floor(num)
    if m < 0.1 then m = 0.1 end -- Avoid shit going right to the edge.
    return ang[1] + (math.abs(ang[1] - ang[2]) * m)
end

roulette_nextroll = 0
roulette_spinterval = 20
roulette_number = 0
spin_duration = 12 -- Make sure same as serverside
local doing = false
-- net.Receive("roulette.SyncMe",function()
--     roulette_nextroll = net.ReadDouble()
-- end)

local previous_rolls = {}
-- net.Receive("roulette.finishroll",function() 
--         doing = false 
--         found = nil
--         time_m = 1 
--         ------print("finishroll")
--         roulette_nextroll = CurTime() + roulette_spinterval
--         MOAT_GAMBLE.RedAmount = 0 
--         MOAT_GAMBLE.BlackAmount = 0
--         MOAT_GAMBLE.GreenAmount = 0
--         roulette_players = {}
--        -- updatelist()
-- 		table.insert(previous_rolls,1,math.floor(roulette_number))
--     end)

-- net.Receive("roulette.roll",function()
--         roulette_number = net.ReadDouble()
--         ang = 0
--         toang = (360 * 30) + getangle(roulette_number)
--         doing = true
--     end)

local ang = 0
local toang = 0
net.Receive("roulette.roll",function()
	roulette_number = net.ReadDouble()
	ang = 0
	toang = (360 * 30) + getangle(roulette_number)
	doing = true
end)
function m_DrawRoulettePanel()
    local time_m = 1
    local found = nil

    net.Start("roulette.SyncMe")
    net.SendToServer()

    MOAT_GAMBLE_ROUL = vgui.Create("DPanel", MOAT_GAMBLE_BG)
    MOAT_GAMBLE_ROUL:SetPos(230, 50)
    MOAT_GAMBLE_ROUL:SetSize(505, 460)
    MOAT_GAMBLE_ROUL.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
//        draw.SimpleText("Roulette is Under Construction", "moat_ItemDesc", w/2, h/2, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local bg = MOAT_GAMBLE_ROUL

    local MOAT_DICE_BET = vgui.Create("DTextEntry", bg)
    function bg:Paint(w,h)
        draw.RoundedBox(0, 0, 0, w, h,Color(25, 25, 25, 255))
        surface.SetDrawColor(86, 86, 86)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.SimpleText("BET AMOUNT", "moat_GambleTitle", 15, 15, Color(255, 255, 255))

        if (MOAT_GAMBLE.RouletteAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.RouletteAmount < 0.01)) then
            surface.SetDrawColor(255, 0, 0)
        else
             surface.SetDrawColor(86, 86, 86)
        end
        draw.NoTexture()
        surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyOutlineR)

        surface.SetDrawColor(20, 20, 20)
        draw.NoTexture()
        surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyR)

        draw.RoundedBox(0,260,80,170,170,Color(32,32,34))

        if doing then
            ang = Lerp(FrameTime()*time_m,ang,toang)
        end
		cdn.SmoothImageRotated(mats["wheel"], w/4*2.75,h/3*1.1, 250, 250, Color(255, 255, 255, 255), ang)
		draw.NoTexture()
		for k,v in pairs(previous_rolls) do
			if k > 6 then continue end
			local n = 0
			if v < 1 then n = 0 elseif v < 8 then n = 1 else n = 2 end
			if n == 0 then
				surface.SetDrawColor(64,158,63,(255 - (30 * k)))
			elseif n == 1 then
				surface.SetDrawColor(206,46,37,(255 - (30 * k)))
			else
				surface.SetDrawColor(0,0,0,(255 - (30 * k)))
			end
			draw.Circle(205 + k*40,23,15,60)
			--draw.SimpleText(v,"moat_GambleTitle",w/4*2.75+1,h/3*1.1+1,Color(0,0,0, 130),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        	draw.SimpleText(v,"moat_GambleTitle",205 + k*40,23,Color(255,255,255,(255 - (30 * k))),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
        local y = h/3*0.99
        y = y - 1 
        surface.SetDrawColor(86,86,86,255)
        surface.DrawOutlinedRect(0,0,190,y*2)
        surface.DrawLine(190, y*2-1, w, y*2-1)
		y = h/3*1.1
        y = y - 1 
        //draw.RoundedBox(0,190,y,100,2,Color(86,86,86,255))
        draw.RoundedBox(0,222,y,57,2,Color(255,255,0,255))
        local t = math.floor(roulette_nextroll - CurTime()) + 0.25
        t = math.floor(t)
        local tf = "moat_RoulettTime"
        if t < 0 or doing then
            if t < spin_duration * -1 then
                roulette_nextroll = CurTime() + roulette_spinterval
            end
            t = "ROLLING"
            tf = "moat_RoulettRoll"
            if ang > toang - 2 and doing then
                t = math.floor(roulette_number)
                tf = "moat_RoulettTime"
                ------print("found")
                if roulette_number < 1 then found = 0 elseif roulette_number < 8 then found = 1 else found = 2 end
            else
                found = nil
            end 
        end
        if tostring(t):len() == 1 and not found then t = "0" .. t end
		draw.SimpleText(t,tf,w/4*2.75+1,h/3*1.1+1,Color(0,0,0, 130),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(t,tf,w/4*2.75,h/3*1.1,found and Color(255, 255, 0, 255) or Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end
    net.Receive("roulette.SyncMe",function()
        roulette_nextroll = net.ReadDouble()
        local spinning = net.ReadBool()
        roulette_number = net.ReadDouble()
        if spinning then
            ang = 0
            toang = (360 * 30) + getangle(roulette_number)
            doing = true
            time_m = roulette_nextroll - roulette_spinterval
            time_m = spin_duration / (time_m - CurTime()) 
        end
    end)

    MOAT_DICE_BET:SetPos(22, 47)
    MOAT_DICE_BET:SetSize(100, 30)
    MOAT_DICE_BET:SetFont("moat_GambleTitle")
    MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetEnterAllowed(true)
    MOAT_DICE_BET:SetNumeric(true)
    MOAT_DICE_BET:SetDrawBackground(false)
    MOAT_DICE_BET:SetMultiline(false)
    MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_BET:SetEditable(true)
    MOAT_DICE_BET:SetValue("1")
    MOAT_DICE_BET:SetText("1")
    MOAT_DICE_BET.MaxChars = 7
    MOAT_DICE_BET.Think = function(s)
        if (not s:IsEditing() and MOAT_GAMBLE.RouletteAmount ~= tonumber(s:GetText())) then
            s:SetText(MOAT_GAMBLE.RouletteAmount)
        end
    end
    MOAT_DICE_BET.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_BET.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.EndsWith(tostring(txt), ".") or (string.sub(tostring(txt), 1, 1) == "0" and #tostring(txt) > 1) or string.EndsWith(tostring(txt), "-")) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
    function MOAT_DICE_BET:CheckNumeric(strValue)
        if (not string.find("1234567890.", strValue, 1, true)) then
            return true
        end

        return false
    end
    MOAT_DICE_BET.OnEnter = function(s)
        if (s:GetText() == "") then s:SetText("0") end
        
        MOAT_GAMBLE.RouletteAmount = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 1, MOAT_GAMBLE.RouletteMax)
    end
    MOAT_DICE_BET.OnLoseFocus = function(s)
        s:OnEnter()
    end

    local BTN2 = vgui.Create("DButton", bg)
    BTN2:SetPos(14, 89)
    BTN2:SetSize(50, 40)
    BTN2:SetText("")
    BTN2.Paint = function(s, w, h)
        local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

        if (s:IsHovered()) then
            cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
        end

        draw.RoundedBox(4, 0, 0, w, h, cols[1])
        draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

        draw.SimpleText("2x", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    BTN2.DoClick = function(s, w, h)
        MOAT_GAMBLE.RouletteAmount = math.min(MOAT_GAMBLE.RouletteAmount * 2, MOAT_GAMBLE.RouletteMax)
    end

    local BTN2 = vgui.Create("DButton", bg)
    BTN2:SetPos(66, 89)
    BTN2:SetSize(50, 40)
    BTN2:SetText("")
    BTN2.Paint = function(s, w, h)
        local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

        if (s:IsHovered()) then
            cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
        end

        draw.RoundedBox(4, 0, 0, w, h, cols[1])
        draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

        draw.SimpleText("1/2", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    BTN2.DoClick = function(s, w, h)
        MOAT_GAMBLE.RouletteAmount = math.max(MOAT_GAMBLE.RouletteAmount / 2, 1)
    end

    local BTN2 = vgui.Create("DButton", bg)
    BTN2:SetPos(118, 89)
    BTN2:SetSize(47, 19)
    BTN2:SetText("")
    BTN2.Paint = function(s, w, h)
        local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

        if (s:IsHovered()) then
            cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
        end

        draw.RoundedBox(4, 0, 0, w, h, cols[1])
        draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

        draw.SimpleText("Min", "Trebuchet18", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    BTN2.DoClick = function(s, w, h)
        MOAT_GAMBLE.RouletteAmount = 1
    end

    local BTN2 = vgui.Create("DButton", bg)
    BTN2:SetPos(118, 110)
    BTN2:SetSize(47, 19)
    BTN2:SetText("")
    BTN2.Paint = function(s, w, h)
        local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

        if (s:IsHovered()) then
            cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
        end

        draw.RoundedBox(4, 0, 0, w, h, cols[1])
        draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

        draw.SimpleText("Max", "Trebuchet18", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    BTN2.DoClick = function(s, w, h)
        MOAT_GAMBLE.RouletteAmount = math.Clamp(MOAT_INVENTORY_CREDITS, 1, 5000)
    end

    local moat_roulette_place = vgui.Create("DButton",bg)
    moat_roulette_place:SetSize(125*1.2, 38*1.2)
    moat_roulette_place:SetPos(14, 137)
    moat_roulette_place:SetText("")
	sfx.SoundEffects(moat_roulette_place)
    function moat_roulette_place:Paint(w,h)
        draw.RoundedBox(0,0,0,w,h,Color(255,0,0))

		cdn.SmoothImage(mats["mat_green_red" .. (self:IsHovered() and "_hover" or "")], 0, 0, w, h)

        surface.SetDrawColor(86,86,86,255)
        surface.DrawOutlinedRect(0, 0, w, h)
        if found and doing and MOAT_GAMBLE.RedAmount > 0 then
            if found == 1 then
                draw.DrawText("+" .. MOAT_GAMBLE.RedAmount * 2 .. "!","moat_RouletteAmount",5,7,Color(255,255,255))
            else
                draw.DrawText("-" .. MOAT_GAMBLE.RedAmount,"moat_RouletteAmount",5,7,Color(255,255,255))
            end
        else
            draw.DrawText(MOAT_GAMBLE.RedAmount,"moat_RouletteAmount",5,7,Color(255,255,255))
        end
    end
    --"roulette.bet"
    function moat_roulette_place:DoClick()
        net.Start("roulette.bet")
        net.WriteInt(1,8)
        net.WriteDouble(MOAT_GAMBLE.RouletteAmount)
        net.SendToServer()
    end

    local moat_roulette_place = vgui.Create("DButton",bg)
    moat_roulette_place:SetSize(125*1.2, 38*1.2)
    moat_roulette_place:SetPos(14, 187)
    moat_roulette_place:SetText("")
	sfx.SoundEffects(moat_roulette_place)
    function moat_roulette_place:Paint(w,h)
        draw.RoundedBox(0,0,0,w,h,Color(255,0,0))

		cdn.SmoothImage(mats["mat_green_normal" .. (self:IsHovered() and "_hover" or "")], 0, 0, w, h)

        surface.SetDrawColor(86,86,86,255)
        surface.DrawOutlinedRect(0, 0, w, h)
        if found and doing and MOAT_GAMBLE.GreenAmount > 0 then
            if found == 0 then
                draw.DrawText("+" .. MOAT_GAMBLE.GreenAmount * 14 .. "!","moat_RouletteAmount",5,7,Color(255,255,255))
            else
                draw.DrawText("-" .. MOAT_GAMBLE.GreenAmount,"moat_RouletteAmount",5,7,Color(255,255,255))
            end
        else
            draw.DrawText(MOAT_GAMBLE.GreenAmount,"moat_RouletteAmount",5,7,Color(255,255,255))
        end
    end
    function moat_roulette_place:DoClick()
        net.Start("roulette.bet")
        net.WriteInt(0,8)
        net.WriteDouble(MOAT_GAMBLE.RouletteAmount)
        net.SendToServer()
    end


    local moat_roulette_place = vgui.Create("DButton",bg)
    moat_roulette_place:SetSize(125*1.2, 38*1.2)
    moat_roulette_place:SetPos(14, 237)
    moat_roulette_place:SetText("")
	sfx.SoundEffects(moat_roulette_place)
    function moat_roulette_place:Paint(w,h)
        draw.RoundedBox(0,0,0,w,h,Color(255,0,0))

		cdn.SmoothImage(mats["mat_green_black" .. (self:IsHovered() and "_hover" or "")], 0, 0, w, h)

        surface.SetDrawColor(86,86,86,255)
        surface.DrawOutlinedRect(0, 0, w, h)
        if found and doing and MOAT_GAMBLE.BlackAmount > 0 then
            if found == 2 then
                draw.DrawText("+" .. MOAT_GAMBLE.BlackAmount * 2 .. "!","moat_RouletteAmount",5,7,Color(255,255,255))
            else
                draw.DrawText("-" .. MOAT_GAMBLE.BlackAmount,"moat_RouletteAmount",5,7,Color(255,255,255))
            end
        else
            draw.DrawText(MOAT_GAMBLE.BlackAmount,"moat_RouletteAmount",5,7,Color(255,255,255))
        end
    end
    function moat_roulette_place:DoClick()
        net.Start("roulette.bet")
        net.WriteInt(2,8)
        net.WriteDouble(MOAT_GAMBLE.RouletteAmount)
        net.SendToServer()
    end

    local highscore = vgui.Create("DScrollPanel",bg)
    highscore:DockMargin(0, 306, 0, 0)
    highscore:Dock(FILL)
    highscore:GetVBar():SetWide(0)
    highscore.Paint = function(s, w,h) end
    local function gettotalic(n)
        local a = 0
        if not istable(roulette_players[n]) then return 0 end
        for k,v in pairs(roulette_players[n]) do
            a = a + v[2]
        end
        return a
    end

    local left = vgui.Create("DPanel",highscore)
    left:SetSize(155,100)
    left:DockMargin(5, 0, 5, 0)
    left:Dock(LEFT)
    function left:Paint(w,h)
        draw.RoundedBox(0,0,0,w,7,Color(206,46,37))
        draw.RoundedBox(0,0,7,w,30,Color(206,46,37,100))
        surface.SetDrawColor(60, 60, 60, 255)
     --   surface.DrawOutlinedRect(0, 7, w, 30)
       -- draw.SimpleText("TOTAL BET:", "moat_RoulettBet", 1, 7 + 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
       draw.SimpleText("Total: " .. string.Comma(math.Round(gettotalic(1))) .. " IC", "moat_RoulettBet", 11, 7 + 16, Color( 0, 0, 0, 140 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Total: " .. string.Comma(math.Round(gettotalic(1))) .. " IC", "moat_RoulettBet", 10, 7 + 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local right = vgui.Create("DPanel",highscore)
    right:SetSize(155,100)
    right:DockMargin(5, 0, 5, 0)
    right:Dock(RIGHT)
    function right:Paint(w,h)
        draw.RoundedBox(0,0,0,w,7,Color(10,10,10))
        draw.RoundedBox(0,0,7,w,30,Color(0,0,0,100))
        surface.SetDrawColor(60, 60, 60, 255)
        --surface.DrawOutlinedRect(0, 7, w, 30)
        --draw.SimpleText("TOTAL BET:", "moat_RoulettBet", 1, 7 + 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Total: " .. string.Comma(math.Round(gettotalic(2))) .. " IC", "moat_RoulettBet", 11, 7 + 16, Color( 0, 0, 0, 140 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Total: " .. string.Comma(math.Round(gettotalic(2))) .. " IC", "moat_RoulettBet", 10, 7 + 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local mid = vgui.Create("DPanel",highscore)
    mid:SetSize(150,100)
    mid:DockMargin(0, 0, 0, 0)
    mid:Dock(FILL)
    function mid:Paint(w,h)
        draw.RoundedBox(0,0,0,w,7,Color(64,158,63))
        draw.RoundedBox(0,0,7,w,30,Color(64,158,63,100))
        surface.SetDrawColor(60, 60, 60, 255)
        --surface.DrawOutlinedRect(0, 7, w, 30)
       -- draw.SimpleText("TOTAL BET:", "moat_RoulettBet", 1, 7 + 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
       draw.SimpleText("Total: " .. string.Comma(math.Round(gettotalic(0))) .. " IC", "moat_RoulettBet", 11, 7 + 16, Color( 0, 0, 0, 140 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Total: " .. string.Comma(math.Round(gettotalic(0))) .. " IC", "moat_RoulettBet", 10, 7 + 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local function updatelist()
        if not IsValid(left) then return end
        for k,v in pairs(left:GetChildren()) do
            v:Remove()
            left:SetTall(500)
        end
        for k,v in pairs(mid:GetChildren()) do
            v:Remove()
            mid:SetTall(500)
        end
        for k,v in pairs(right:GetChildren()) do
            v:Remove()
            mid:SetTall(500)
        end
        if istable(roulette_players[1]) then
            local p = vgui.Create("DPanel",left)
            p:SetSize(7+30,7+30)
            p:Dock(TOP)
            function p:Paint() end
            local i = 0
            for k,v in pairs(roulette_players[1]) do
                local ply = v[1]
                if not IsValid(ply) then continue end
                i = i + 1
                local o = i
                local a = vgui.Create("DPanel",left)
                a:SetSize(0,20)
                a:Dock(TOP)
                function a:Paint(w,h)
                    local c = Color(40,40,40)
                  --  if (o % 2 == 0) then c = Color(60,60,60) end
                    draw.RoundedBox(0,0,0,w,h,c)
                    if o%2 == 0 then
                        surface.SetDrawColor(90,90,90, 90)
                        surface.DrawRect(0, 0, w, h)
                    end
                   -- surface.DrawOutlinedRect(0, 0, w, h)
                    draw.SimpleText(string.Comma(math.Round(v[2])) .. " IC", "moat_RoulettBet", w-5, h/2-1, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                end
                left:SetTall(left:GetTall() + 20)
                local av = vgui.Create("AvatarImage",a)
                av:SetSize(18,18)
                av:DockMargin(2,2,2,2)
                av:Dock(LEFT)
                av:SetPlayer(ply,64)
                av:SetTooltip(ply:Nick())
            end
        end
        if istable(roulette_players[0]) then
            local p = vgui.Create("DPanel",mid)
            p:SetSize(7+30,7+30)
            p:Dock(TOP)
            function p:Paint() end
            local i = 0
            for k,v in pairs(roulette_players[0]) do
                local ply = v[1]
                if not IsValid(ply) then continue end
                i = i + 1
                local o = i
                local a = vgui.Create("DPanel",mid)
                a:SetSize(0,20)
                a:Dock(TOP)
                function a:Paint(w,h)
                    local c = Color(40,40,40)
                  --  if (o % 2 == 0) then c = Color(60,60,60) end
                    draw.RoundedBox(0,0,0,w,h,c)
                    if o%2 == 0 then
                        surface.SetDrawColor(90,90,90, 90)
                        surface.DrawRect(0, 0, w, h)
                    end
                   -- surface.DrawOutlinedRect(0, 0, w, h)
                    draw.SimpleText(string.Comma(math.Round(v[2])) .. " IC", "moat_RoulettBet", w-5, h/2-1, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                end
                mid:SetTall(mid:GetTall() + 20)
                local av = vgui.Create("AvatarImage",a)
                av:SetSize(18,18)
                av:DockMargin(2,2,2,2)
                av:Dock(LEFT)
                av:SetPlayer(ply,64)
                av:SetTooltip(ply:Nick())
            end
        end
        if istable(roulette_players[2]) then
            local p = vgui.Create("DPanel",right)
            p:SetSize(7+30,7+30)
            p:Dock(TOP)
            function p:Paint() end
            local i = 0
            for k,v in pairs(roulette_players[2]) do
                local ply = v[1]
                if not IsValid(ply) then continue end
                i = i + 1
                local o = i -- localize for drawing
                local a = vgui.Create("DPanel",right)
                a:SetSize(0,20)
                a:Dock(TOP)
                function a:Paint(w,h)
                    local c = Color(40,40,40)
                  --  if (o % 2 == 0) then c = Color(60,60,60) end
                    draw.RoundedBox(0,0,0,w,h,c)
                    if o%2 == 0 then
                        surface.SetDrawColor(90,90,90, 90)
                        surface.DrawRect(0, 0, w, h)
                    end
                   -- surface.DrawOutlinedRect(0, 0, w, h)
                    draw.SimpleText(string.Comma(math.Round(v[2])) .. " IC", "moat_RoulettBet", w-5, h/2-1, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                end
                right:SetTall(right:GetTall() + 16)
                local av = vgui.Create("AvatarImage",a)
                av:SetSize(18,18)
                av:DockMargin(2,2,2,2)
                av:Dock(LEFT)
                av:SetPlayer(ply,64)
                av:SetTooltip(ply:Nick())
            end
        end
    end
    /*
    roulette_players[1] = {}
    roulette_players[0] = {}
    roulette_players[2] = {}
    for i =1,10 do
        table.insert(roulette_players[1],{LocalPlayer(),math.random()*10000})
        table.sort(roulette_players[1], function(a,b)
            return a[2] > b[2]
        end) 
        table.insert(roulette_players[0],{LocalPlayer(),math.random()*10000})
        table.sort(roulette_players[0], function(a,b)
            return a[2] > b[2]
        end) 
        table.insert(roulette_players[2],{LocalPlayer(),math.random()*10000})
        table.sort(roulette_players[2], function(a,b)
            return a[2] > b[2]
        end) 
    end*/
    updatelist()

    net.Receive("roulette.finishroll",function() 
        doing = false 
        found = nil
        time_m = 1 
        ------print("finishroll")
        roulette_nextroll = CurTime() + roulette_spinterval
        MOAT_GAMBLE.RedAmount = 0 
        MOAT_GAMBLE.BlackAmount = 0
        MOAT_GAMBLE.GreenAmount = 0
        roulette_players = {}
        updatelist()
		table.insert(previous_rolls,1,math.floor(roulette_number))
    end)

    net.Receive("roulette.player",function()
        local ply = net.ReadEntity()
        local n = net.ReadInt(8)
        local am = net.ReadDouble()
        if ply == LocalPlayer() then
            if n == 0 then MOAT_GAMBLE.GreenAmount = am end
            if n == 1 then MOAT_GAMBLE.RedAmount = am end
            if n == 2 then MOAT_GAMBLE.BlackAmount = am end
        end
        if not roulette_players[n] then
            roulette_players[n] = {}
        end
        table.insert(roulette_players[n],{ply,am})
        table.sort(roulette_players[n], function(a,b)
            return a[2] > b[2]
        end) 
        ------print("added",ply,"to",n)
        updatelist()
    end)
end

function m_RemoveRoulettePanel()
	if (IsValid(MOAT_GAMBLE_ROUL)) then
		MOAT_GAMBLE_ROUL:Remove()
	end
end


MOAT_GAMBLE.CrashAmount = 0
MOAT_GAMBLE.AutoCashOut = 0
MOAT_GAMBLE.CrashMax = 5000
local crash_number = 0
local crash_crashing = false
local crash_players = {}
local crash_nextcrash = 0
local crash_startcrash = 0
local crash_startnumber = 1
local crash_inside = false
local crash_load = false
local crash_delay = 20
local crash_games = {}
local crash_players = {}
local crash_waitingfor = false
local function round(num)
    return tonumber(string.format("%.2f", num))
end

for i =1,5 do
	table.insert(crash_games,1,round(math.random() * 5))
end

surface.CreateFont("moat_crashRoll", {
    font = "DermaLarge",
    size = 50,
    weight = 800
})

surface.CreateFont("moat_crash", {
    font = "DermaLarge",
    size = 40,
    weight = 800
})

surface.CreateFont("moat_crashTime", {
    font = "DermaLarge",
    size = 20,
    weight = 800
})

net.Receive("crash.player",function()
	local ply = net.ReadEntity()
	if ply == LocalPlayer() then crash_inside = true end
	local e = net.ReadBool()
	if crash_waitingfor then
		crash_players = {}
		crash_waitingfor = false
	end
	if not e then
		crash_players[ply] = {0,net.ReadDouble()}
	else
		if ply == LocalPlayer() then crash_inside = false end
		crash_players[ply] = {1,net.ReadDouble()}
	end
end)


net.Receive("crash.syncme", function()
	crash_load = true
	crash_crashing = net.ReadBool()
	if crash_crashing then
		crash_number = net.ReadDouble()
		crash_startcrash = CurTime()
		crash_startnumber = crash_number
	else
		crash_number = net.ReadDouble()
		crash_nextcrash = net.ReadDouble()
	end
	crash_number = round(crash_number)
end)

net.Receive("crash.finish",function()
	crash_inside = false
	crash_crashing = false
	crash_number = round(net.ReadDouble())
	crash_nextcrash = CurTime() + crash_delay
	table.insert(crash_games,1,crash_number)
	crash_waitingfor = true
	crash_players = {}
end)

net.Receive("crash.start",function()
	crash_crashing = true
	crash_number = 1
	crash_startcrash = CurTime()
	crash_startnumber = 1
end)

MOAT_GAMBLE.TextEntryPolyC = {
    {x = 15, y = 265},
    {x = 189, y = 265},
    {x = 212, y = 300},
    {x = 15, y = 300}
}

MOAT_GAMBLE.TextEntryPolyOutlineC = {
    {x = 14, y = 264},
    {x = 190, y = 264},
    {x = 214, y = 301},
    {x = 14, y =301}
}

MOAT_GAMBLE.TextEntryPolyCA = {
    {x = 15, y = 357},
    {x = 189, y = 357},
    {x = 212, y = 392},
    {x = 15, y = 392}
}

MOAT_GAMBLE.TextEntryPolyOutlineCA = {
    {x = 14, y = 356},
    {x = 190, y = 356},
    {x = 214, y = 393},
    {x = 14, y =393}
}

hook.Add("Think","AutoCashOut",function()
	if crash_crashing then
		crash_number = round(((CurTime() - crash_startcrash) * 0.1) + crash_startnumber)
	end
	if MOAT_GAMBLE.AutoCashOut > 1 and crash_inside and crash_crashing then
		if crash_number >= MOAT_GAMBLE.AutoCashOut then
			net.Start("crash.getout")
			net.SendToServer()
		end
	end
end)

-- function m_DrawCrashPanel()
-- 	net.Start("crash.syncme")
-- 	net.SendToServer()
-- 	MOAT_GAMBLE_CRASH = vgui.Create("DPanel", MOAT_GAMBLE_BG)
-- 	MOAT_GAMBLE_CRASH:SetPos(230, 50)
-- 	MOAT_GAMBLE_CRASH:SetSize(505, 460)
-- 	MOAT_GAMBLE_CRASH.Paint = function(s, w, h)
-- 		if not crash_load then return end
-- 		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
-- 		--draw.SimpleText("Crash is Under Construction", "moat_ItemDesc", w/2, h/2, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 		draw.RoundedBox(0, 0, 0, w, h,Color(25, 25, 25, 255))
-- 		draw.RoundedBox(0,0,0,w,(h/2)/6,Color(40,40,40))
--         surface.SetDrawColor(86, 86, 86)
--         surface.DrawOutlinedRect(0, 0, w, h)
-- 		surface.DrawOutlinedRect(0, 0, w/2, h)
-- 		surface.DrawOutlinedRect(0, 0, w/2, h/2)
-- 		surface.DrawOutlinedRect(0, 0, w, (h/2)/6)
-- 		for k,v in pairs(crash_games) do
-- 			if k > 5 then continue end
-- 			draw.SimpleText(v .. "x","Trebuchet18",-24 + (k*50),((h/2)/6/2),Color(255,255,255,255 - (k*40)),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
-- 		end
-- 		draw.SimpleText("Player","moat_crashTime",w/2 + 2,((h/2)/6/2),Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
-- 		draw.SimpleText("Bet / Net Profit","moat_crashTime",w - 2,((h/2)/6/2),Color(255,255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
-- 		local s = crash_number
-- 		if tostring(s):match("%..$") then
-- 			s = s .. "0"
-- 		elseif not tostring(s):match("%...$") then
-- 			s = s .. ".00"
-- 		end
-- 		draw.SimpleText("BET AMOUNT", "moat_GambleTitle", 15, 240, Color(255, 255, 255))
-- 		draw.SimpleText("AUTO CASHOUT", "moat_GambleTitle", 15, 332, Color(255, 255, 255))
-- 		--Trebuchet18
-- 		draw.SimpleText("(0 to disable)", "Trebuchet18", 160 , 336, Color(60, 60, 60))
-- 		if (MOAT_GAMBLE.CrashAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.CrashAmount < 0.01)) then
--     		surface.SetDrawColor(255, 0, 0)
--     	else
--     		surface.SetDrawColor(86, 86, 86)
--     	end
--     	draw.NoTexture()
--     	surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyOutlineC)
-- 		surface.SetDrawColor(86, 86, 86)
-- 		surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyOutlineCA)

--     	surface.SetDrawColor(20, 20, 20)
--     	draw.NoTexture()
--     	surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyC)
-- 		surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyCA)
		
-- 		h = h + (h/2)/6
-- 		if crash_crashing then
-- 			draw.SimpleText("CRASHING...","moat_crash", w/4, (h/2) / 3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 			draw.SimpleText(s .. "x", "moat_crashRoll", w/4, (h/4),HSVToColor((SysTime()*50)%360,0.65,0.9), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 		else
-- 			draw.SimpleText("CRASHED @","moat_crash", w/4, (h/2) / 3, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 			draw.SimpleText(s .. "x", "moat_crashRoll", w/4, (h/4), Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 			local t = crash_nextcrash - CurTime()
-- 			if t > 0 then
-- 				t = string.format("%.1f", t)
-- 				draw.SimpleText("Next round in " .. t .. "s","moat_crashTime", w/4, ((h/2) / 3) * 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 			end
-- 		end
-- 	end

-- 	local bcore = vgui.Create("DScrollPanel",MOAT_GAMBLE_CRASH)
-- 	bcore:SetSize(505/2,460 - ((460/2)/6))
-- 	bcore:SetPos(505/2,((460/2)/6))
-- 	bcore:GetVBar():SetWide(0)
-- 	function bcore:Paint() end

-- 	local highscore = vgui.Create("DPanel",bcore)
-- 	highscore:Dock(FILL)
-- 	function highscore:Paint() end

-- 	/*for k,v in pairs(player.GetAll()) do
-- 		crash_players[v] =  {0,math.random()*1000}
-- 	end--s*/

-- 	local function updatelist()
-- 		if not IsValid(highscore) then return end
-- 		for k,v in pairs(highscore:GetChildren()) do
-- 			v:Remove()
-- 		end

-- 		local p = {}
-- 		local d = {}
-- 		for k,v in pairs(crash_players) do
-- 			if v[1] == 1 then
-- 				table.insert(d,{k,v[2]})
-- 			else
-- 				table.insert(p,{k,v[2]})
-- 			end
-- 			/*for i =1,10 do
-- 			if math.random() > 0.5 then
-- 				table.insert(p,{k,v[2]})
-- 			else
-- 				if math.random() > 0.5 then
-- 					table.insert(d,{k,v[2] * -1})
-- 				else
-- 					table.insert(d,{k,v[2]})
-- 				end
-- 			end
-- 			end*/
-- 		end

-- 		table.sort(p, function(a,b)
-- 			return a[2] > b[2]
-- 		end)


-- 		table.sort(d,function(a,b)
-- 			return a[2] > b[2]
-- 		end)

-- 		local i = 0

-- 		for k,v in pairs(p) do
-- 			local ply = v[1]
-- 			if not IsValid(ply) then continue end
-- 			i = i + 1
-- 			local o = i -- localize for drawing
-- 			local a = vgui.Create("DPanel",highscore)
-- 			a:SetSize(0,20)
-- 			a:Dock(TOP)
-- 			function a:Paint(w,h)
-- 				if not crash_load then return end
-- 				local c = Color(40,40,40)
-- 			--  if (o % 2 == 0) then c = Color(60,60,60) end
-- 				draw.RoundedBox(0,0,0,w,h,c)
-- 				if o%2 == 0 then
-- 					surface.SetDrawColor(90,90,90, 90)
-- 					surface.DrawRect(0, 0, w, h)
-- 				end
-- 			-- surface.DrawOutlinedRect(0, 0, w, h)
-- 				draw.SimpleText(string.Comma(round(v[2])) .. " IC", "moat_RoulettBet", w-5, h/2-1, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
-- 				draw.SimpleText(IsValid(ply) and ply:Nick() or "Disconnected", "moat_RoulettBet", 18 + 5, h/2-1, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
-- 			end
-- 			--right:SetTall(right:GetTall() + 16)
-- 			local av = vgui.Create("AvatarImage",a)
-- 			av:SetSize(18,18)
-- 			av:DockMargin(2,2,2,2)
-- 			av:Dock(LEFT)
-- 			av:SetPlayer(ply,64)
-- 			av:SetTooltip(ply:Nick())
-- 		end

-- 		for k,v in pairs(d) do
-- 			local ply = v[1]
-- 			if not IsValid(ply) then continue end
-- 			i = i + 1
-- 			local o = i -- localize for drawing
-- 			local a = vgui.Create("DPanel",highscore)
-- 			a:SetSize(0,20)
-- 			a:Dock(TOP)
-- 			function a:Paint(w,h)
-- 			if not crash_load then return end
-- 				local c = Color(40,40,40)
-- 			--  if (o % 2 == 0) then c = Color(60,60,60) end
-- 				draw.RoundedBox(0,0,0,w,h,c)
-- 				if o%2 == 0 then
-- 					surface.SetDrawColor(90,90,90, 90)
-- 					surface.DrawRect(0, 0, w, h)
-- 				end
-- 			-- surface.DrawOutlinedRect(0, 0, w, h)
-- 				local c = Color(206,46,37)
-- 				if v[2] > 0 then
-- 					c = Color(64,158,63)
-- 				end
-- 				draw.SimpleText(string.Comma(round(v[2])) .. " IC", "moat_RoulettBet", w-5, h/2-1, c, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
-- 				draw.SimpleText(IsValid(ply) and ply:Nick() or "Disconnected", "moat_RoulettBet", 18 + 5, h/2-1, c, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
-- 			end
-- 			--right:SetTall(right:GetTall() + 16)
-- 			local av = vgui.Create("AvatarImage",a)
-- 			av:SetSize(18,18)
-- 			av:DockMargin(2,2,2,2)
-- 			av:Dock(LEFT)
-- 			av:SetPlayer(ply,64)
-- 			av:SetTooltip(ply:Nick())
-- 		end

-- 	end
-- 	updatelist()
-- 	net.Receive("crash.player",function()
-- 		local ply = net.ReadEntity()
-- 		if ply == LocalPlayer() then crash_inside = true end
-- 		local e = net.ReadBool()
-- 		if not crash_players then crash_players = {} end
-- 		if crash_waitingfor then
-- 			crash_players = {}
-- 			updatelist()
-- 			crash_waitingfor = false
-- 		end
-- 		if not e then
-- 			crash_players[ply] = {0,net.ReadDouble()}
-- 		else
-- 			if ply == LocalPlayer() then crash_inside = false end
-- 			crash_players[ply] = {1,net.ReadDouble()}
-- 		end
-- 		updatelist()
-- 	end)	
-- 	net.Receive("crash.finish",function()
-- 		crash_inside = false
-- 		crash_crashing = false
-- 		crash_number = round(net.ReadDouble())
-- 		crash_nextcrash = CurTime() + crash_delay
-- 		table.insert(crash_games,1,crash_number)
-- 		for k,v in pairs(crash_players) do
-- 			if v[1] ~= 1 then
-- 				crash_players[k] = {1,v[2] * -1}
-- 			end
-- 		end
-- 		updatelist()
-- 		crash_waitingfor = true
-- 		timer.Simple(5,function()
-- 			if crash_waitingfor then
-- 				crash_players = {}
-- 				updatelist()
-- 			end
-- 		end)
-- 	end)

-- 	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_CRASH)
-- 	MOAT_DICE_BET:SetPos(22, 267)
-- 	MOAT_DICE_BET:SetSize(180, 30)
-- 	MOAT_DICE_BET:SetFont("moat_GambleTitle")
--     MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
--     MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
--     MOAT_DICE_BET:SetEnterAllowed(true)
--     MOAT_DICE_BET:SetNumeric(true)
--     MOAT_DICE_BET:SetDrawBackground(false)
--     MOAT_DICE_BET:SetMultiline(false)
--     MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
--     MOAT_DICE_BET:SetEditable(true)
--     MOAT_DICE_BET:SetValue("1")
--     MOAT_DICE_BET:SetText("1")
--     MOAT_DICE_BET.MaxChars = 7
--     MOAT_DICE_BET.Think = function(s)
--     	if (not s:IsEditing() and MOAT_GAMBLE.CrashAmount ~= tonumber(s:GetText())) then
--     		s:SetText(MOAT_GAMBLE.CrashAmount)
--     	end
--     end
--     MOAT_DICE_BET.OnGetFocus = function(s)
--         if (tostring(s:GetValue()) == "0") then
--             s:SetValue("")
--             s:SetText("")
--         end
--     end
--     MOAT_DICE_BET.OnTextChanged = function(s)
--         local txt = s:GetValue()
--         local amt = string.len(txt)

--         if (amt > s.MaxChars) then
--             if (s.OldText == nil) then
--                 s:SetText("")
--                 s:SetValue("")
--                 s:SetCaretPos(string.len(""))
--             else
--                 s:SetText(s.OldText)
--                 s:SetValue(s.OldText)
--                 s:SetCaretPos(string.len(s.OldText))
--             end
--         else
--             s.OldText = txt
--         end
--     end
-- 	function MOAT_DICE_BET:CheckNumeric(strValue)
-- 		if (not string.find("1234567890.", strValue, 1, true)) then
-- 			return true
-- 		end

-- 		return false
-- 	end
-- 	MOAT_DICE_BET.OnEnter = function(s)
-- 		if (s:GetText() == "") then s:SetText("0") end
		
-- 		MOAT_GAMBLE.CrashAmount = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 0.05, 5000)
-- 	end
-- 	MOAT_DICE_BET.OnLoseFocus = function(s)
-- 		s:OnEnter()
-- 	end

-- 	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_CRASH)
-- 	MOAT_DICE_BET:SetPos(22, 359)
-- 	MOAT_DICE_BET:SetSize(180, 30)
-- 	MOAT_DICE_BET:SetFont("moat_GambleTitle")
--     MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
--     MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
--     MOAT_DICE_BET:SetEnterAllowed(true)
--     MOAT_DICE_BET:SetNumeric(true)
--     MOAT_DICE_BET:SetDrawBackground(false)
--     MOAT_DICE_BET:SetMultiline(false)
--     MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
--     MOAT_DICE_BET:SetEditable(true)
--     MOAT_DICE_BET:SetValue("1")
--     MOAT_DICE_BET:SetText("1")
--     MOAT_DICE_BET.MaxChars = 7
--     MOAT_DICE_BET.Think = function(s)
--     	if (not s:IsEditing() and MOAT_GAMBLE.AutoCashOut ~= tonumber(s:GetText())) then
--     		s:SetText(MOAT_GAMBLE.AutoCashOut)
--     	end
--     end
--     MOAT_DICE_BET.OnGetFocus = function(s)
--         if (tostring(s:GetValue()) == "0") then
--             s:SetValue("")
--             s:SetText("")
--         end
--     end
--     MOAT_DICE_BET.OnTextChanged = function(s)
--         local txt = s:GetValue()
--         local amt = string.len(txt)

--         if (amt > s.MaxChars) then
--             if (s.OldText == nil) then
--                 s:SetText("")
--                 s:SetValue("")
--                 s:SetCaretPos(string.len(""))
--             else
--                 s:SetText(s.OldText)
--                 s:SetValue(s.OldText)
--                 s:SetCaretPos(string.len(s.OldText))
--             end
--         else
--             s.OldText = txt
--         end
--     end
-- 	function MOAT_DICE_BET:CheckNumeric(strValue)
-- 		if (not string.find("1234567890.", strValue, 1, true)) then
-- 			return true
-- 		end

-- 		return false
-- 	end
-- 	MOAT_DICE_BET.OnEnter = function(s)
-- 		if (s:GetText() == "") then s:SetText("0") end
		
-- 		MOAT_GAMBLE.AutoCashOut = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 0, 5000)
-- 	end
-- 	MOAT_DICE_BET.OnLoseFocus = function(s)
-- 		s:OnEnter()
-- 	end

-- 	MOAT_DICE_ROLL = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
-- 	MOAT_DICE_ROLL:SetPos(5, 460-62)
-- 	MOAT_DICE_ROLL:SetSize(505/2-10, 56)
-- 	MOAT_DICE_ROLL:SetText("")
-- 	MOAT_DICE_ROLL.Rolling = false
-- 	MOAT_DICE_ROLL.Output = false
-- 	MOAT_DICE_ROLL.Won = false
-- 	MOAT_DICE_ROLL.OutputRoll = 0
-- 	MOAT_DICE_ROLL.OutputNum = 0
-- 	MOAT_DICE_ROLL.Paint = function(s, w, h)
-- 	if not crash_load then return end
-- 		local btndown = 0
-- 		local btncolor = Color(64, 165, 71)
-- 		if (s:IsHovered()) then
-- 			btncolor = Color(44, 145, 51)
-- 		end
-- 		if not crash_crashing and crash_nextcrash - CurTime() > (crash_delay - 0.5 ) then
-- 			btncolor = Color(150,0,0)
-- 			draw.RoundedBox(4, 0, 5, w, 51, Color(170,0,0, 255))
-- 			draw.RoundedBox(4, 0, btndown, w, 51, Color(170, 0,0))
-- 			draw.RoundedBox(4, 1, btndown + 1, w-2, 51-2, btncolor)
-- 		else
-- 			if (s:IsDown()) then
-- 				btndown = 2
-- 			end
-- 			draw.RoundedBox(4, 0, 5, w, 51, Color(0, 131, 61, 255))
-- 			draw.RoundedBox(4, 0, btndown, w, 51, Color(170, 170, 170))
-- 			draw.RoundedBox(4, 1, btndown + 1, w-2, 51-2, btncolor)
-- 		end

--     	surface.SetDrawColor(200, 200, 200, 25)
--         surface.SetMaterial(gradient_u)
--         surface.DrawTexturedRect(0, btndown, w, 51)
-- 		if not crash_crashing and not crash_inside then
--     		draw.SimpleText("BET!", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 		elseif not crash_crashing and crash_inside then
-- 			draw.SimpleText("Waiting for round..", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 		elseif crash_crashing and crash_inside then
-- 			local s = crash_number
-- 			if tostring(s):match("%..$") then
-- 				s = s .. "0"
-- 			elseif not tostring(s):match("%...$") then
-- 				s = s .. ".00"
-- 			end
-- 			draw.SimpleText("Cash out @ " .. s .. "x", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 		else
-- 			draw.SimpleText("Waiting for next round..", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
-- 		end
-- 	end
-- 	MOAT_DICE_ROLL.DoClick = function(s)
-- 		if not crash_crashing then
-- 			net.Start("crash.bet")
-- 			net.WriteDouble(MOAT_GAMBLE.CrashAmount)
-- 			net.SendToServer()
-- 		elseif crash_crashing and crash_inside then
-- 			net.Start("crash.getout")
-- 			net.SendToServer()
-- 		end
-- 	end

-- 	 local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
--     BTN2:SetPos(14, 309)
--     BTN2:SetSize(50, 20)
--     BTN2:SetText("")
--     BTN2.Paint = function(s, w, h)
-- 	if not crash_load then return end
--         local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

--         if (s:IsHovered()) then
--             cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
--         end

--         draw.RoundedBox(4, 0, 0, w, h, cols[1])
--         draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

--         draw.SimpleText("2x", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--     end
--     BTN2.DoClick = function(s, w, h)
--         MOAT_GAMBLE.CrashAmount = math.min(MOAT_GAMBLE.CrashAmount * 2, MOAT_GAMBLE.CrashMax)
--     end

--     local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
--     BTN2:SetPos(66, 309)
--     BTN2:SetSize(50, 20)
--     BTN2:SetText("")
--     BTN2.Paint = function(s, w, h)
-- 	if not crash_load then return end
--         local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

--         if (s:IsHovered()) then
--             cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
--         end

--         draw.RoundedBox(4, 0, 0, w, h, cols[1])
--         draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

--         draw.SimpleText("1/2", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--     end
--     BTN2.DoClick = function(s, w, h)
--         MOAT_GAMBLE.CrashAmount = math.max(MOAT_GAMBLE.CrashAmount / 2, 0.05)
--     end

--     local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
--     BTN2:SetPos(118, 309)
--     BTN2:SetSize(47, 20)
--     BTN2:SetText("")
--     BTN2.Paint = function(s, w, h)
-- 	if not crash_load then return end
--         local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

--         if (s:IsHovered()) then
--             cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
--         end

--         draw.RoundedBox(4, 0, 0, w, h, cols[1])
--         draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

--         draw.SimpleText("Min", "Trebuchet18", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--     end
--     BTN2.DoClick = function(s, w, h)
--         MOAT_GAMBLE.CrashAmount = 0.05
--     end

--     local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
--     BTN2:SetPos(168, 309)
--     BTN2:SetSize(47, 20)
--     BTN2:SetText("")
--     BTN2.Paint = function(s, w, h)
-- 	if not crash_load then return end
--         local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

--         if (s:IsHovered()) then
--             cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
--         end

--         draw.RoundedBox(4, 0, 0, w, h, cols[1])
--         draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

--         draw.SimpleText("Max", "Trebuchet18", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--     end
--     BTN2.DoClick = function(s, w, h)
--         MOAT_GAMBLE.CrashAmount = math.Clamp(MOAT_INVENTORY_CREDITS, 0.05, 5000)
--     end

-- end

function m_DrawCrashPanel()
	MOAT_GAMBLE_CRASH = vgui.Create("DPanel", MOAT_GAMBLE_BG)
	MOAT_GAMBLE_CRASH:SetPos(230, 50)
	MOAT_GAMBLE_CRASH:SetSize(505, 460)
	MOAT_GAMBLE_CRASH.Paint = function(s, w, h)
		--[[Background & Outline]]
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawOutlinedRect(0, 0, w, h)

    	--[[Bet Amount]]
    	draw.SimpleText("BET AMOUNT", "moat_GambleTitle", 15, 35, Color(255, 255, 255))

    	if (MOAT_GAMBLE.BlackBetAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.BlackBetAmount < 10)) then
    		surface.SetDrawColor(255, 0, 0)
    	else
    		surface.SetDrawColor(86, 86, 86)
    	end
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyOutline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly)

    	--[[Profit On Win]]
    	surface.SetDrawColor(46, 46, 46)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.DiceProfitPoly)

    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawLine(290, 0, 345, 100)
    	surface.DrawLine(345, 100, 505, 100)
    	surface.DrawLine(0, 115, w, 115)

    	draw.SimpleText("CREDITS ON WIN", "moat_GambleTitle", w-15, 15, Color(0, 150, 0), TEXT_ALIGN_RIGHT)
    	draw.SimpleText(string.Comma((math.Round(MOAT_GAMBLE.BlackBetAmount * 1.5))) .. " IC", "moat_DiceWin", w-85, 40, Color(255,255,102), TEXT_ALIGN_CENTER)

    	--[[Dealer Shit]]

    	local starting_x, card_w, card_h = 15, 32, 32
    	local dealer_total = 0
    	local dealer_or_total = 0

    	for i = 1, #MOAT_GAMBLE.DealerCards do
    		local x_pos, y_pos = ((starting_x + card_w) * i) - card_w, 245

    		draw.RoundedBox(4, x_pos, y_pos, card_w, card_h, Color(146, 146, 146))
    		draw.RoundedBox(4, x_pos + 1, y_pos + 1, card_w - 2, card_h - 2, Color(46, 46, 46))

    		local draw_text = tostring(MOAT_GAMBLE.DealerCards[i])

    		if (draw_text == "0") then
    			draw_text = "XX"
    		end

    		draw.SimpleText(draw_text, "ChatFont", x_pos + (card_w/2), y_pos + (card_h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    		if (MOAT_GAMBLE.DealerCards[i] == "ACE") then
    			dealer_or_total = dealer_or_total + 1

    			dealer_total = dealer_total + 1
    			continue
    		end

    		dealer_total = dealer_total + MOAT_GAMBLE.DealerCards[i]
    	end

    	draw.SimpleText("DEALER'S CARDS", "moat_GambleTitle", 15, 150, Color(255, 255, 255))

    	surface.SetDrawColor(86, 86, 86)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly2Outline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly2)

    	if (dealer_or_total == 0) then
    		draw.SimpleText(dealer_total, "moat_GambleTitle", 25, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	else
    		local or_total = dealer_total - dealer_or_total + (dealer_or_total * 11)

    		draw.SimpleText(dealer_total .. " OR " .. or_total, "moat_GambleTitle", 25, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	end

    	--[[Player Shit]]

    	local starting_x = w-15
    	local player_total = 0
    	local player_or_total = 0

    	for i = 1, #MOAT_GAMBLE.PlayerCards do
    		local x_pos, y_pos = starting_x - ((card_w + 15) * i) + 15, 245

    		draw.RoundedBox(4, x_pos, y_pos, card_w, card_h, Color(146, 146, 146))
    		draw.RoundedBox(4, x_pos + 1, y_pos + 1, card_w - 2, card_h - 2, Color(46, 46, 46))

    		draw.SimpleText(MOAT_GAMBLE.PlayerCards[i], "ChatFont", x_pos + (card_w/2), y_pos + (card_h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    		if (MOAT_GAMBLE.PlayerCards[i] == "ACE") then
    			player_or_total = player_or_total + 1

    			player_total = player_total + 1
    			continue
    		end

    		player_total = player_total + MOAT_GAMBLE.PlayerCards[i]
    	end

    	draw.SimpleText("YOUR CARDS", "moat_GambleTitle", 342, 150, Color(255, 255, 255))

    	surface.SetDrawColor(86, 86, 86)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly3Outline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly3)

    	if (player_or_total == 0) then
    		draw.SimpleText(player_total, "moat_GambleTitle", 352, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	else
    		local or_total = player_total + (player_or_total * 10)

    		draw.SimpleText(player_total .. " OR " .. or_total, "moat_GambleTitle", 352, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	end

		--[[Blackjack info shit things]]
        draw.RoundedBox(0, 1, 300, w-2, 50, Color(20, 20, 20, 255))
        surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.DiceArrowPoly)


    	draw.RoundedBox(4, (w/2)+5, 310, (w-30)/2, 30, Color(65, 65, 70))
    	draw.RoundedBox(4, (w/2)+6, 311, (w-34)/2, 28, Color(35, 35, 40))
    	local text = "BLACKJACK PAYS 2 TO 1"
    	local textpos = (w/2)+5 + (((w-30)/2)/2)
    	local rollpos = m_GetFontWidth("moat_GambleTitle", text)
    	local daw, dah = draw.SimpleText("BLACKJACK PAYS ", "moat_GambleTitle", textpos - (rollpos/2), 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da2w, da2h = draw.SimpleText("2", "moat_GambleTitle", textpos - (rollpos/2) + daw, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da3w, da3h = draw.SimpleText(" TO ", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w, 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	draw.SimpleText("1", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w + da3w, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    	draw.RoundedBox(4, 10, 310, (w-30)/2, 30, Color(65, 65, 70))
    	draw.RoundedBox(4, 11, 311, (w-34)/2, 28, Color(35, 35, 40))

    	local text = "DEALER STANDS ON 17"
    	local textpos = 10 + (((w-30)/2)/2)
    	local rollpos = m_GetFontWidth("moat_GambleTitle", text)
    	local daw, dah = draw.SimpleText("DEALER ", "moat_GambleTitle", textpos - (rollpos/2), 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da2w, da2h = draw.SimpleText("STANDS", "moat_GambleTitle", textpos - (rollpos/2) + daw, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da3w, da3h = draw.SimpleText(" ON ", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w, 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	draw.SimpleText("17", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w + da3w, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_CRASH)
	MOAT_DICE_BET:SetPos(22, 67)
	MOAT_DICE_BET:SetSize(100, 30)
	MOAT_DICE_BET:SetFont("moat_GambleTitle")
    MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetEnterAllowed(true)
    MOAT_DICE_BET:SetNumeric(true)
    MOAT_DICE_BET:SetDrawBackground(false)
    MOAT_DICE_BET:SetMultiline(false)
    MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_BET:SetEditable(true)
    MOAT_DICE_BET:SetValue("1")
    MOAT_DICE_BET:SetText("1")
    MOAT_DICE_BET.MaxChars = 7
    MOAT_DICE_BET.Think = function(s)
    	if (not s:IsEditing() and MOAT_GAMBLE.BlackBetAmount ~= tonumber(s:GetText())) then
    		s:SetText(MOAT_GAMBLE.BlackBetAmount)
    	end
    end
    MOAT_DICE_BET.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_BET.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.EndsWith(tostring(txt), ".") or (string.sub(tostring(txt), 1, 1) == "0" and #tostring(txt) > 1) or string.EndsWith(tostring(txt), "-")) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
	function MOAT_DICE_BET:CheckNumeric(strValue)
		if (not string.find("1234567890.", strValue, 1, true)) then
			return true
		end

		return false
	end
	MOAT_DICE_BET.OnEnter = function(s)
		if (s:GetText() == "") then s:SetText("0") end
		
		MOAT_GAMBLE.BlackBetAmount = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 10, 5000)
	end
	MOAT_DICE_BET.OnLoseFocus = function(s)
		s:OnEnter()
	end

	local BTN1 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
	BTN1:SetPos(178, 15)
	BTN1:SetSize(50, 40)
	BTN1:SetText("")
	BTN1.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("1/2", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN1.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = math.max(MOAT_GAMBLE.BlackBetAmount/2, 10)
	end
	sfx.SoundEffects(BTN1)

	local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
	BTN2:SetPos(178+55, 15)
	BTN2:SetSize(50, 40)
	BTN2:SetText("")
	BTN2.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("2x", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN2.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = math.min(MOAT_GAMBLE.BlackBetAmount * 2, 5000)
	end
	sfx.SoundEffects(BTN2)

	local BTN3 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
	BTN3:SetPos(178, 15+45)
	BTN3:SetSize(50, 40)
	BTN3:SetText("")
	BTN3.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("Min", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN3.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = 10
	end
	sfx.SoundEffects(BTN3)

	local BTN4 = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
	BTN4:SetPos(178+55, 15+45)
	BTN4:SetSize(50, 40)
	BTN4:SetText("")
	BTN4.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("Max", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN4.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = math.Clamp(MOAT_INVENTORY_CREDITS, 10, 5000)
	end
	sfx.SoundEffects(BTN4)

	MOAT_BLACK_HIT = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
	MOAT_BLACK_HIT:SetPos(10, 460-75)
	MOAT_BLACK_HIT:SetSize(237.5, 65)
	MOAT_BLACK_HIT:SetText("")
	MOAT_BLACK_HIT.Think = function(s)
		if (MOAT_GAMBLE.BlackDealing or not MOAT_GAMBLE.BlackGameActive or (IsValid(MOAT_BLACK_DEAL) and MOAT_GAMBLE_BLACKJACK.Output)) then
			s:SetAlpha(0)
			s:SetDisabled(true)
		else
			s:SetAlpha(255)
			s:SetDisabled(false)
		end
	end
	MOAT_BLACK_HIT.Paint = function(s, w, h)
		local btndown = 0
		if (s:IsDown()) then
			btndown = 2
		end
		local btncolor = Color(64, 165, 71)
		if (s:IsHovered()) then
			btncolor = Color(44, 145, 51)
		end
		draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
		draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    	draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 60)

    	draw.SimpleText("HIT", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	MOAT_BLACK_HIT.DoClick = function(s)
		if (MOAT_GAMBLE.BlackDealing) then return end
		
		MOAT_GAMBLE.BlackDealing = true

		net.Start("MOAT_GAMBLE_ACTION")
		net.WriteBool(true)
		net.SendToServer()
	end
	sfx.SoundEffects(MOAT_BLACK_HIT)

	MOAT_BLACK_STAND = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
	MOAT_BLACK_STAND:SetPos(258, 460-75)
	MOAT_BLACK_STAND:SetSize(238, 65)
	MOAT_BLACK_STAND:SetText("")
	MOAT_BLACK_STAND.Think = function(s)
		if (MOAT_GAMBLE.BlackDealing or not MOAT_GAMBLE.BlackGameActive or (IsValid(MOAT_BLACK_DEAL) and MOAT_GAMBLE_BLACKJACK.Output)) then
			s:SetAlpha(0)
			s:SetDisabled(true)
		else
			s:SetAlpha(255)
			s:SetDisabled(false)
		end
	end
	MOAT_BLACK_STAND.Paint = function(s, w, h)
		local btndown = 0
		if (s:IsDown()) then
			btndown = 2
		end
		local btncolor = Color(238, 185, 52)
		if (s:IsHovered()) then
			btncolor = Color(218, 165, 32)
		end
		draw.RoundedBox(4, 0, 5, w, 60, Color(184, 134, 11))
		draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    	draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 60)

    	draw.SimpleText("STAND", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	MOAT_BLACK_STAND.DoClick = function(s)
		if (MOAT_GAMBLE.BlackStand or 0) > CurTime() then return end

		-- MOAT_GAMBLE.BlackDealing = true
		MOAT_GAMBLE.BlackStand = CurTime() + 0.1

		net.Start("MOAT_GAMBLE_ACTION")
		net.WriteBool(false)
		net.SendToServer()
	end
	sfx.SoundEffects(MOAT_BLACK_STAND)

	MOAT_BLACK_DEAL = vgui.Create("DButton", MOAT_GAMBLE_CRASH)
	MOAT_BLACK_DEAL:SetPos(10, 385)
	MOAT_BLACK_DEAL:SetSize(505-20, 65)
	MOAT_BLACK_DEAL:SetText("")
	MOAT_BLACK_DEAL.Dealing = false
	MOAT_BLACK_DEAL.Output = false
	MOAT_BLACK_DEAL.OutputWon = 0
	MOAT_BLACK_DEAL.OutputNum = 0
	MOAT_BLACK_DEAL.Think = function(s)
		if (not MOAT_GAMBLE.BlackDealing and not MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE.BlackGameActive) then
			s:SetAlpha(0)
			s:SetDisabled(true)
			s:SetPos(10, 600)
		else
			s:SetAlpha(255)
			s:SetDisabled(false)
			s:SetPos(10, 385)
		end
	end
	MOAT_BLACK_DEAL.Paint = function(s, w, h)
		if (MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE_BLACKJACK.OutputWon == 2) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(64, 165, 71)
			if (s:IsHovered()) then
				btncolor = Color(44, 145, 51)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("YOU WON " .. string.Comma(math.Round(MOAT_GAMBLE_BLACKJACK.OutputNum, 2)) .. " IC!", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		elseif (MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE_BLACKJACK.OutputWon == 1) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(165, 30, 30)
			if (s:IsHovered()) then
				btncolor = Color(145, 10, 10)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(131, 0, 0, 255))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("You've lost " .. math.Round(MOAT_GAMBLE_BLACKJACK.OutputNum, 2) .. " IC", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		elseif (MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE_BLACKJACK.OutputWon == 3) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(238, 185, 52)
			if (s:IsHovered()) then
				btncolor = Color(218, 165, 32)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(184, 134, 11))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("You've tied with the dealer", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		end

		if (MOAT_GAMBLE.BlackDealing) then
			draw.RoundedBox(4, 0, 5, w, 60, Color(67, 68, 67))
    		draw.RoundedBox(4, 0, 0, w, 60, Color(128, 128, 128))

    		draw.SimpleText("Dealing...", "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		if (MOAT_GAMBLE.BlackBetAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.BlackBetAmount < 10)) then
			draw.RoundedBox(4, 0, 5, w, 60, Color(67, 68, 67))
    		draw.RoundedBox(4, 0, 0, w, 60, Color(128, 128, 128))

    		draw.SimpleText("Not enough IC!", "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
    	end

		local btndown = 0
		if (s:IsDown()) then
			btndown = 2
		end
		local btncolor = Color(64, 165, 71)
		if (s:IsHovered()) then
			btncolor = Color(44, 145, 51)
		end
		draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
		draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    	draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 60)

    	draw.SimpleText("DEAL", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	MOAT_BLACK_DEAL.DoClick = function(s)
		if (MOAT_GAMBLE.BlackBetAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.BlackBetAmount < 10)) then
			if (MOAT_GAMBLE_BLACKJACK.Output) then
				MOAT_GAMBLE_BLACKJACK.Output = false
				MOAT_GAMBLE_BLACKJACK.OutputNum = 0

				MOAT_GAMBLE.BlackStand = false
				MOAT_GAMBLE.BlackDealing = false
				MOAT_GAMBLE.BlackGameActive = false
				MOAT_GAMBLE.PlayerCards = {}
				MOAT_GAMBLE.DealerCards = {}

				return
			end

			MOAT_GAMBLE_BLACKJACK.Output = false
			return
		end
		if (MOAT_GAMBLE.BlackDealing) then
			return
		end

		if (MOAT_GAMBLE_BLACKJACK.Output) then
			MOAT_GAMBLE_BLACKJACK.Output = false
			MOAT_GAMBLE_BLACKJACK.OutputNum = 0

			MOAT_GAMBLE.BlackStand = false
			MOAT_GAMBLE.BlackDealing = false
			MOAT_GAMBLE.BlackGameActive = false
			MOAT_GAMBLE.PlayerCards = {}
			MOAT_GAMBLE.DealerCards = {}

			return
		end

		MOAT_GAMBLE_BLACKJACK.Output = false
		MOAT_GAMBLE.BlackDealing = true

		net.Start("MOAT_GAMBLE_BLACK")
		net.WriteUInt(MOAT_GAMBLE.BlackBetAmount,32)
		net.SendToServer()
	end
	sfx.SoundEffects(MOAT_BLACK_DEAL)
end



function m_RemoveCrashPanel()
	if (IsValid(MOAT_GAMBLE_CRASH)) then
		MOAT_GAMBLE_CRASH:Remove()
		crash_load = false
	end
end

MOAT_GAMBLE.BlackBetAmount = 10
MOAT_GAMBLE.PlayerCards = {}
MOAT_GAMBLE.DealerCards = {}
MOAT_GAMBLE.BlackGameActive = false
MOAT_GAMBLE.BlackDealing = false
MOAT_GAMBLE.BlackStand = false
MOAT_GAMBLE.ShowXXs = false
MOAT_GAMBLE_BLACKJACK = {
	Dealing = false,
	Output = false,
	OutputWon = 0,
	OutputNum = 0
}

function m_jackpotroll(players,winner,MOAT_GAMBLE_BLACK)
	math.randomseed(tonumber(winner))
	jackpot.Rolling = true
	local pp = {}
	for k,v in pairs(players) do
		for i = 1,tonumber(v.money) do
			table.insert(pp,k)
		end
	end
	if not IsValid(MOAT_GAMBLE_BLACK) then return end
	local pnl_x, pnl_y = (MOAT_GAMBLE_BLACK:GetWide() / 2) - (358 / 2), 10
    MOAT_GAMBLE_BLACK.Roll = vgui.Create("DPanel", MOAT_GAMBLE_BLACK)
    MOAT_GAMBLE_BLACK.Roll:SetPos(pnl_x, pnl_y)
    MOAT_GAMBLE_BLACK.Roll:SetSize(358, 73)

    MOAT_GAMBLE_BLACK.Roll.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
    end

    MOAT_GAMBLE_BLACK.Roll.PaintOver = function(s, w, h)

        draw.RoundedBox(0, (w / 2) - 1, 0, 2, h, Color(255, 128, 0))
    end

    local spacing = 3
    local icon_wide = 68
    local contents_wide = (spacing + icon_wide) * 100
    local MOAT_ROLL_CONTENTS = vgui.Create("DPanel", MOAT_GAMBLE_BLACK.Roll)
    MOAT_ROLL_CONTENTS:SetSize(contents_wide, 73)
    MOAT_ROLL_CONTENTS:SetPos(contents_wide * -1, 0)
    MOAT_ROLL_CONTENTS.Paint = function(s, w, h) end
    --draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
    local table_items = table.Copy(global_table_items)
    local item_value = 0
    for i = 1, 100 do
		local Item_Panel = vgui.Create("AvatarImage", MOAT_ROLL_CONTENTS)
        Item_Panel:SetSize(68, 68)
        Item_Panel:SetPos((spacing + icon_wide) * (i - 1), 3)
		if i == 4 then
			Item_Panel:SetSteamID(winner,64)
		else
			if not players then continue end
			local i = table.Random(pp)
			if not players[i] then continue end
			if not players[i].steamid then continue end
			Item_Panel:SetSteamID(players[i].steamid,64)
		end
    
        local m_DPanelP = vgui.Create("DPanel", Item_Panel)
        m_DPanelP:SetSize(68, 68)
        m_DPanelP:SetPos(0, 0)
        m_DPanelP.Paint = nil
    end

    local roll_contents_x, roll_y = MOAT_ROLL_CONTENTS:GetPos()
	--| -34
	--| -100
    local roll_to = math.random(-34,-100)

    MOAT_ROLL_CONTENTS.Think = function(s, w, h)
        if (math.abs(roll_contents_x - roll_to) < 1) then jackpot.Winner = winner MOAT_GAMBLE_BLACK.Roll:Remove() return end
            
            if (math.abs(roll_contents_x - roll_to) > 1500) then
                roll_contents_x = math.Approach(roll_contents_x, roll_to, 1500 * FrameTime())
            else
                roll_contents_x = Lerp(0.9 * FrameTime(), roll_contents_x, roll_to)
            end

        if (math.floor(roll_contents_x / 71) ~= item_value) then
            sfx.Tick()
        end

        s:SetPos(roll_contents_x, roll_y)
        item_value = math.floor(roll_contents_x / 71)

    end
end

surface.CreateFont("moat_JackBig", {
    font = "DermaLarge",
    size = 50,
    weight = 800
})

surface.CreateFont("moat_JackMed", {
    font = "DermaLarge",
    size = 40,
    weight = 800
})

surface.CreateFont("moat_JackVerySmall", {
    font = "DermaLarge",
    size = 15,
    weight = 800
})

jackpot = jackpot or {}
function GetRandomSteamID()
	return "7656119"..tostring( 7960265728+math.random( 1, 200000000 ) )
end
if not jackpot.players then
	jackpot.players = {}
	/*for i =1,50 do
		table.insert(jackpot.players,{steamid = GetRandomSteamID(),money = math.random() * 1000})
		local a = vgui.Create("AvatarImage")
		a:SetSteamID(jackpot.players[i].steamid,64)
		a:SetVisible(false)
	end*/
	--table.insert(jackpot.players,{steamid = LocalPlayer():SteamID64(),money = 13337})
end
/*jackpot.active = true
jackpot.time_end = CurTime() + 120
jackpot.ingame = true
jackpot.counting = false
jackpot.total = 0*/
MOAT_GAMBLE.JackAmount = 0
local synced = false

local function vround(num)
    return tonumber(string.format("%.2f", num))
end
local test = false
local steam_cache = {}
local function GetSteamName(id, cb)
	if (not id) then cb("Someone") return end
	if (steam_cache[id]) then cb(steam_cache[id]) return end

	steamworks.RequestPlayerInfo(id, function(n)
		n = n or "Someone"
		steam_cache[id] = n
		cb(n)
	end)
end


MOAT_GAMBLE.LastJack = 0
function m_DrawBlackjackPanel()
	--if not wlist[LocalPlayer():SteamID64()] then return end
	net.Start("jackpot.info")
	net.SendToServer()
	MOAT_GAMBLE_BLACK = vgui.Create("DPanel", MOAT_GAMBLE_BG)
	MOAT_GAMBLE_BLACK:SetPos(230, 50)
	MOAT_GAMBLE_BLACK:SetSize(505, 460)
	MOAT_GAMBLE_BLACK.Paint = function(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawOutlinedRect(0, 0, w, h)
		surface.DrawLine(0,94,w,94)
		surface.DrawLine(0,134,w,134)
		surface.DrawLine(0,h-20,w,h-20)
		if not test then
			draw.DrawText("Jackpot is cross-server! There are 26 Moat TTT servers connected.","moat_JackVerySmall",w/2,h-18,Color(255,255,255),TEXT_ALIGN_CENTER)
		end
		local t = "Waiting for players"
		jackpot.CanDeposit = true
		if (not jackpot.active) then
			draw.DrawText(t,"moat_JackBig",w/2,20,Color(255,255,255),TEXT_ALIGN_CENTER)
		elseif (not jackpot.Rolling) then
			draw.DrawText(string.Comma(math.Round(jackpot.total or 0)) .. " IC","moat_JackBig",w/2,2,Color(255,255,255),TEXT_ALIGN_CENTER)

			local s = "0"
			local tt = (jackpot.time_end or 0) - CurTime()
			if tt > 0 then
				s = s .. math.floor(tt / 60) .. ":"
				local a = tostring(math.Round(tt % 60))
				if #a < 2 then a = "0" .. a end
				s = s .. a
			else
				s = "Waiting for servers..."
				if jackpot.counting then jackpot.CanDeposit = false end
			end
			if not jackpot.counting then s = "Waiting for second player" end
			draw.DrawText(s,"moat_JackMed",w/2,50,Color(100,100,100),TEXT_ALIGN_CENTER)
		elseif (jackpot.Winner) then
			for k,v in pairs(jackpot.players) do
				if v.steamid == jackpot.Winner then
					draw.DrawText((jackpot.WinnerName or "ForsenBoy"),"moat_JackBig",w/2,2,HSVToColor((SysTime()*100)%360,0.65,0.9),TEXT_ALIGN_CENTER)
					draw.DrawText(string.Comma(math.Round((jackpot.total or 0) * 0.95)) .. " IC @ " .. vround((v.money/(jackpot.total or 0)) * 100 ) .. "%","moat_JackMed",w/2,50,Color(255,255,255),TEXT_ALIGN_CENTER)
					break
				end--s
			end
		end
		if (MOAT_GAMBLE.JackAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.JackAmount < 1)) then
    		surface.SetDrawColor(255, 0, 0)
    	else
    		surface.SetDrawColor(86, 86, 86)--s
    	end
		surface.DrawOutlinedRect(160,99,180,31)
		draw.SimpleText("JOIN AMOUNT:", "moat_GambleTitle", 10, 114, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	end
	/*timer.Simple(5,function() m_jackpotroll(jackpot.players,"76561198154133184",MOAT_GAMBLE_BLACK) end)
	timer.Simple(20,function() MOAT_GAMBLE_BLACK.Roll:Remove() end)*/
	
	local listc = vgui.Create("DPanel",MOAT_GAMBLE_BLACK)
	listc:DockMargin(2, 136, 2, 20)
	listc:Dock(FILL)
	function listc:Paint() end

	local player_list = vgui.Create("DScrollPanel",listc)
	player_list:Dock(FILL)
	player_list:GetVBar():SetWide(3)
	function build_jack_list() 
		if not IsValid(player_list) then return end
		player_list:Clear()
		if not istable(jackpot.players) then return end
		if #jackpot.players < 1 then return end
		table.sort(jackpot.players, function(a,b)
			return tonumber(a.money) > tonumber(b.money)
		end)
		local total = 0
		local players = table.Copy(jackpot.players)
		for k,v in pairs(players) do
			total = total + tonumber(v.money)
			if v.steamid == LocalPlayer():SteamID64() then
				jackpot.ingame = true
				players[0] = {steamid = v.steamid,money = v.money}
				players[k] = nil
			end
		end--s
		jackpot.total = total

		for k,v in pairs(players) do
			if k > 50 then continue end
			local a = vgui.Create("DPanel",player_list)
			a:SetSize(0,50)
			a:DockMargin(2,0,2,2)
			a:Dock(TOP)
			local name = "Someone"
			function a:Paint(w,h)
				draw.DrawText(name,"moat_JackBig",w/2,0,Color(100,100,100,5),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetFont("moat_JackMed")
				local tw,th = surface.GetTextSize(string.Comma(math.Round(v.money)))
				draw.DrawText(string.Comma(math.Round(v.money)),"moat_JackMed",60,2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.DrawText("IC","moat_JackMed",65 + tw,2,Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.DrawText(vround((v.money/total) * 100 ) .. "%","moat_JackMed",w - 5,2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				if v.steamid == LocalPlayer():SteamID64() then
					surface.SetDrawColor(0,255,0)
				else
					surface.SetDrawColor(86, 86, 86)
				end
    			surface.DrawOutlinedRect(0, 0, w, h)
			end
			local av = vgui.Create("AvatarImage",a)
			av:SetPos(3,3)
			av:SetSize(46,44)
			av:SetSteamID(v.steamid,64)
			local butt = vgui.Create("DButton",av)
			sfx.SoundEffects(butt)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.steamid)
			end
			GetSteamName(v.steamid, function(n)
				name = n
				if (IsValid(av)) then av:SetTooltip(n) end
			end)
		end
	end
	build_jack_list()
	net.Receive("jackpot.players",function()
		jackpot.players = net.ReadTable()
		jackpot.active = true
		if #jackpot.players < 2 then jackpot.counting = false else jackpot.counting = true end
		build_jack_list()
	end)

	net.Receive("jackpot.info",function()
		local s = net.ReadBool()
		if s then
			jackpot.time_end = net.ReadInt(32)
			jackpot.counting = true
		else
			jackpot = {}
			-- print("Reset jackpot")
			if MOAT_GAMBLE_BLACK.Roll then
				MOAT_GAMBLE_BLACK.Roll:Remove()
			end
			build_jack_list()
		end
	end)

	net.Receive("jackpot.win",function()
		local w = net.ReadString()
		GetSteamName(w, function(s) jackpot.WinnerName = s end)
		m_jackpotroll(jackpot.players,w,MOAT_GAMBLE_BLACK)
		timer.Simple(20,function()
			jackpot.Winner = w
		end)
	end)

	local make_game = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	make_game:SetPos(348,99)
	make_game:SetSize(148,31)
	make_game:SetText("")
	function make_game:Paint(w,h)
		local a = 255
		if self:IsHovered() then a = 175 end
		local c = Color(10,200,10,a)
		if (MOAT_GAMBLE.JackAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.JackAmount < 1)) or (jackpot.Rolling) or (not jackpot.CanDeposit) or (MOAT_GAMBLE.LastJack > CurTime()) then
			c = Color(86,86,86)
			a = 10
		end
		/*if jackpot.active and ((jackpot.time_end or CurTime()) - CurTime()) < -1) then
			c = Color(86,86,86)
			a = 10
		end*/
		draw.RoundedBox(0,0,0,w,h,c)
		surface.SetDrawColor(0,255,0,a)
		surface.DrawOutlinedRect(0,0,w,h)
		if MOAT_GAMBLE.LastJack < CurTime() then
			draw.SimpleText((jackpot.ingame and "ADD TO GAME") or "JOIN GAME", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(math.floor(MOAT_GAMBLE.LastJack - CurTime()) ..  "s LEFT", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end

	function make_game.DoClick()
		if MOAT_GAMBLE.LastJack > CurTime() then return end
		if (MOAT_GAMBLE.JackAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.JackAmount < 1)) or jackpot.Rolling or (not jackpot.CanDeposit) then return end
		if (make_game.cool or 0) > CurTime() then return end
		if MOAT_GAMBLE.JackAmount > (MOAT_INVENTORY_CREDITS * 0.25) then
			Derma_Query("Are you sure you want to gamble more than 25% of your IC?\nNever gamble anything you can't afford to lose.", "Are you sure?", "Yes", function() 
				MOAT_GAMBLE.LastJack = CurTime() + 1
				net.Start("jackpot.join")
				net.WriteInt(MOAT_GAMBLE.JackAmount,32)
				net.SendToServer()
			end, "No")
		else
			MOAT_GAMBLE.LastJack = CurTime() + 1
			net.Start("jackpot.join")
			net.WriteInt(MOAT_GAMBLE.JackAmount,32)
			net.SendToServer()
		end
		make_game.cool = CurTime() + 1
	end
	sfx.SoundEffects(make_game)

	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_BLACK)
	MOAT_DICE_BET:SetPos(160, 99)
	MOAT_DICE_BET:SetSize(180, 30)
	MOAT_DICE_BET:SetFont("moat_GambleTitle")
    MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetEnterAllowed(true)
    MOAT_DICE_BET:SetNumeric(true)
    MOAT_DICE_BET:SetDrawBackground(false)
    MOAT_DICE_BET:SetMultiline(false)
    MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_BET:SetEditable(true)
    MOAT_DICE_BET:SetValue("1")
    MOAT_DICE_BET:SetText("1")
    MOAT_DICE_BET.MaxChars = 12
    MOAT_DICE_BET.Think = function(s)
    	if (not s:IsEditing() and MOAT_GAMBLE.JackAmount ~= tonumber(s:GetText())) then
    		s:SetText(math.Round(MOAT_GAMBLE.JackAmount))
    	end
    end
    MOAT_DICE_BET.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_BET.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.EndsWith(tostring(txt), ".") or (string.sub(tostring(txt), 1, 1) == "0" and #tostring(txt) > 1) or string.EndsWith(tostring(txt), "-")) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
	function MOAT_DICE_BET:CheckNumeric(strValue)
		if (not string.find("1234567890.", strValue, 1, true)) then
			return true
		end

		return false
	end
	MOAT_DICE_BET.OnEnter = function(s)
		if (s:GetText() == "") then s:SetText("0") end
		
		MOAT_GAMBLE.JackAmount = math.Round(s:GetText())
		-- print(math.Round(tonumber(s:GetText() or 0), 2))
	end
	MOAT_DICE_BET.OnLoseFocus = function(s)
		s:OnEnter()
	end

	/*MOAT_GAMBLE_BLACK = vgui.Create("DPanel", MOAT_GAMBLE_BG)
	MOAT_GAMBLE_BLACK:SetPos(230, 50)
	MOAT_GAMBLE_BLACK:SetSize(505, 460)
	MOAT_GAMBLE_BLACK.Paint = function(s, w, h)
		--[[Background & Outline]]
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawOutlinedRect(0, 0, w, h)

    	--[[Bet Amount]]
    	draw.SimpleText("BET AMOUNT", "moat_GambleTitle", 15, 35, Color(255, 255, 255))

    	if (MOAT_GAMBLE.BlackBetAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.BlackBetAmount < 0.01)) then
    		surface.SetDrawColor(255, 0, 0)
    	else
    		surface.SetDrawColor(86, 86, 86)
    	end
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPolyOutline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly)

    	--[[Profit On Win]]
    	surface.SetDrawColor(46, 46, 46)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.DiceProfitPoly)

    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawLine(290, 0, 345, 100)
    	surface.DrawLine(345, 100, 505, 100)
    	surface.DrawLine(0, 115, w, 115)

    	draw.SimpleText("PROFIT ON WIN", "moat_GambleTitle", w-15, 15, Color(0, 150, 0), TEXT_ALIGN_RIGHT)
    	draw.SimpleText(math.Round(MOAT_GAMBLE.BlackBetAmount * 1.5, 2) - MOAT_GAMBLE.BlackBetAmount, "moat_DiceWin", w-85, 40, Color(255, 255, 255), TEXT_ALIGN_CENTER)

    	--[[Dealer Shit]]

    	local starting_x, card_w, card_h = 15, 32, 32
    	local dealer_total = 0
    	local dealer_or_total = 0

    	for i = 1, #MOAT_GAMBLE.DealerCards do
    		local x_pos, y_pos = ((starting_x + card_w) * i) - card_w, 245

    		draw.RoundedBox(4, x_pos, y_pos, card_w, card_h, Color(146, 146, 146))
    		draw.RoundedBox(4, x_pos + 1, y_pos + 1, card_w - 2, card_h - 2, Color(46, 46, 46))

    		local draw_text = tostring(MOAT_GAMBLE.DealerCards[i])

    		if (draw_text == "0") then
    			draw_text = "XX"
    		end

    		draw.SimpleText(draw_text, "ChatFont", x_pos + (card_w/2), y_pos + (card_h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    		if (MOAT_GAMBLE.DealerCards[i] == "ACE") then
    			dealer_or_total = dealer_or_total + 1

    			dealer_total = dealer_total + 1
    			continue
    		end

    		dealer_total = dealer_total + MOAT_GAMBLE.DealerCards[i]
    	end

    	draw.SimpleText("DEALER", "moat_GambleTitle", 15, 150, Color(255, 255, 255))

    	surface.SetDrawColor(86, 86, 86)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly2Outline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly2)

    	if (dealer_or_total == 0) then
    		draw.SimpleText(dealer_total, "moat_GambleTitle", 25, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	else
    		local or_total = dealer_total - dealer_or_total + (dealer_or_total * 11)

    		draw.SimpleText(dealer_total .. " OR " .. or_total, "moat_GambleTitle", 25, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	end

    	--[[Player Shit]]

    	local starting_x = w-15
    	local player_total = 0
    	local player_or_total = 0

    	for i = 1, #MOAT_GAMBLE.PlayerCards do
    		local x_pos, y_pos = starting_x - ((card_w + 15) * i) + 15, 245

    		draw.RoundedBox(4, x_pos, y_pos, card_w, card_h, Color(146, 146, 146))
    		draw.RoundedBox(4, x_pos + 1, y_pos + 1, card_w - 2, card_h - 2, Color(46, 46, 46))

    		draw.SimpleText(MOAT_GAMBLE.PlayerCards[i], "ChatFont", x_pos + (card_w/2), y_pos + (card_h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    		if (MOAT_GAMBLE.PlayerCards[i] == "ACE") then
    			player_or_total = player_or_total + 1

    			player_total = player_total + 1
    			continue
    		end

    		player_total = player_total + MOAT_GAMBLE.PlayerCards[i]
    	end

    	draw.SimpleText("PLAYER", "moat_GambleTitle", 342, 150, Color(255, 255, 255))

    	surface.SetDrawColor(86, 86, 86)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly3Outline)

    	surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.TextEntryPoly3)

    	if (player_or_total == 0) then
    		draw.SimpleText(player_total, "moat_GambleTitle", 352, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	else
    		local or_total = player_total + (player_or_total * 10)

    		draw.SimpleText(player_total .. " OR " .. or_total, "moat_GambleTitle", 352, 197, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	end

		--[[Blackjack info shit things]]
        draw.RoundedBox(0, 1, 300, w-2, 50, Color(20, 20, 20, 255))
        surface.SetDrawColor(20, 20, 20)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_GAMBLE.DiceArrowPoly)


    	draw.RoundedBox(4, (w/2)+5, 310, (w-30)/2, 30, Color(65, 65, 70))
    	draw.RoundedBox(4, (w/2)+6, 311, (w-34)/2, 28, Color(35, 35, 40))
    	local text = "BLACKJACK PAYS 2 TO 1"
    	local textpos = (w/2)+5 + (((w-30)/2)/2)
    	local rollpos = m_GetFontWidth("moat_GambleTitle", text)
    	local daw, dah = draw.SimpleText("BLACKJACK PAYS ", "moat_GambleTitle", textpos - (rollpos/2), 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da2w, da2h = draw.SimpleText("2", "moat_GambleTitle", textpos - (rollpos/2) + daw, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da3w, da3h = draw.SimpleText(" TO ", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w, 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	draw.SimpleText("1", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w + da3w, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    	draw.RoundedBox(4, 10, 310, (w-30)/2, 30, Color(65, 65, 70))
    	draw.RoundedBox(4, 11, 311, (w-34)/2, 28, Color(35, 35, 40))

    	local text = "DEALER STANDS ON 17"
    	local textpos = 10 + (((w-30)/2)/2)
    	local rollpos = m_GetFontWidth("moat_GambleTitle", text)
    	local daw, dah = draw.SimpleText("DEALER ", "moat_GambleTitle", textpos - (rollpos/2), 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da2w, da2h = draw.SimpleText("STANDS", "moat_GambleTitle", textpos - (rollpos/2) + daw, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	local da3w, da3h = draw.SimpleText(" ON ", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w, 325, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    	draw.SimpleText("17", "moat_GambleTitle", textpos - (rollpos/2) + daw + da2w + da3w, 325, Color(0, 150, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_BLACK)
	MOAT_DICE_BET:SetPos(22, 67)
	MOAT_DICE_BET:SetSize(100, 30)
	MOAT_DICE_BET:SetFont("moat_GambleTitle")
    MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetEnterAllowed(true)
    MOAT_DICE_BET:SetNumeric(true)
    MOAT_DICE_BET:SetDrawBackground(false)
    MOAT_DICE_BET:SetMultiline(false)
    MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_BET:SetEditable(true)
    MOAT_DICE_BET:SetValue("1")
    MOAT_DICE_BET:SetText("1")
    MOAT_DICE_BET.MaxChars = 7
    MOAT_DICE_BET.Think = function(s)
    	if (not s:IsEditing() and MOAT_GAMBLE.BlackBetAmount ~= tonumber(s:GetText())) then
    		s:SetText(MOAT_GAMBLE.BlackBetAmount)
    	end
    end
    MOAT_DICE_BET.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_BET.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
	function MOAT_DICE_BET:CheckNumeric(strValue)
		if (not string.find("1234567890.", strValue, 1, true)) then
			return true
		end

		return false
	end
	MOAT_DICE_BET.OnEnter = function(s)
		if (s:GetText() == "") then s:SetText("0") end
		
		MOAT_GAMBLE.BlackBetAmount = math.Clamp(math.Round(tonumber(s:GetText() or 0), 2), 0.05, 5000)
	end
	MOAT_DICE_BET.OnLoseFocus = function(s)
		s:OnEnter()
	end

	local BTN1 = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	BTN1:SetPos(178, 15)
	BTN1:SetSize(50, 40)
	BTN1:SetText("")
	BTN1.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("1/2", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN1.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = math.max(MOAT_GAMBLE.BlackBetAmount/2, 0.05)
	end

	local BTN2 = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	BTN2:SetPos(178+55, 15)
	BTN2:SetSize(50, 40)
	BTN2:SetText("")
	BTN2.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("2x", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN2.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = math.min(MOAT_GAMBLE.BlackBetAmount * 2, 5000)
	end

	local BTN3 = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	BTN3:SetPos(178, 15+45)
	BTN3:SetSize(50, 40)
	BTN3:SetText("")
	BTN3.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("Min", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN3.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = 0.05
	end

	local BTN4 = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	BTN4:SetPos(178+55, 15+45)
	BTN4:SetSize(50, 40)
	BTN4:SetText("")
	BTN4.Paint = function(s, w, h)
		local cols = {Color(65, 65, 70), Color(35, 35, 40), Color(86, 86, 86)}

		if (s:IsHovered()) then
			cols = {Color(65, 65, 70), Color(45, 45, 50), Color(200, 200, 200)}
		end

		draw.RoundedBox(4, 0, 0, w, h, cols[1])
		draw.RoundedBox(4, 1, 1, w-2, h-2, cols[2])

		draw.SimpleText("Max", "Trebuchet24", w/2, h/2, cols[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	BTN4.DoClick = function(s, w, h)
		MOAT_GAMBLE.BlackBetAmount = math.Clamp(MOAT_INVENTORY_CREDITS, 0.05, 5000)
	end

	MOAT_BLACK_HIT = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	MOAT_BLACK_HIT:SetPos(10, 460-75)
	MOAT_BLACK_HIT:SetSize(237.5, 65)
	MOAT_BLACK_HIT:SetText("")
	MOAT_BLACK_HIT.Think = function(s)
		if (MOAT_GAMBLE.BlackDealing or not MOAT_GAMBLE.BlackGameActive or (IsValid(MOAT_BLACK_DEAL) and MOAT_GAMBLE_BLACKJACK.Output)) then
			s:SetAlpha(0)
			s:SetDisabled(true)
		else
			s:SetAlpha(255)
			s:SetDisabled(false)
		end
	end
	MOAT_BLACK_HIT.Paint = function(s, w, h)
		local btndown = 0
		if (s:IsDown()) then
			btndown = 2
		end
		local btncolor = Color(64, 165, 71)
		if (s:IsHovered()) then
			btncolor = Color(44, 145, 51)
		end
		draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
		draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    	draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 60)

    	draw.SimpleText("HIT", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	MOAT_BLACK_HIT.DoClick = function(s)
		if (MOAT_GAMBLE.BlackDealing) then return end
		
		MOAT_GAMBLE.BlackDealing = true

		net.Start("MOAT_GAMBLE_ACTION")
		net.WriteBool(true)
		net.SendToServer()
	end

	MOAT_BLACK_STAND = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	MOAT_BLACK_STAND:SetPos(258, 460-75)
	MOAT_BLACK_STAND:SetSize(238, 65)
	MOAT_BLACK_STAND:SetText("")
	MOAT_BLACK_STAND.Think = function(s)
		if (MOAT_GAMBLE.BlackDealing or not MOAT_GAMBLE.BlackGameActive or (IsValid(MOAT_BLACK_DEAL) and MOAT_GAMBLE_BLACKJACK.Output)) then
			s:SetAlpha(0)
			s:SetDisabled(true)
		else
			s:SetAlpha(255)
			s:SetDisabled(false)
		end
	end
	MOAT_BLACK_STAND.Paint = function(s, w, h)
		local btndown = 0
		if (s:IsDown()) then
			btndown = 2
		end
		local btncolor = Color(238, 185, 52)
		if (s:IsHovered()) then
			btncolor = Color(218, 165, 32)
		end
		draw.RoundedBox(4, 0, 5, w, 60, Color(184, 134, 11))
		draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    	draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 60)

    	draw.SimpleText("STAND", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	MOAT_BLACK_STAND.DoClick = function(s)
		if (MOAT_GAMBLE.BlackStand) then return end

		MOAT_GAMBLE.BlackDealing = true
		MOAT_GAMBLE.BlackStand = true

		net.Start("MOAT_GAMBLE_ACTION")
		net.WriteBool(false)
		net.SendToServer()
	end

	MOAT_BLACK_DEAL = vgui.Create("DButton", MOAT_GAMBLE_BLACK)
	MOAT_BLACK_DEAL:SetPos(10, 385)
	MOAT_BLACK_DEAL:SetSize(505-20, 65)
	MOAT_BLACK_DEAL:SetText("")
	MOAT_BLACK_DEAL.Dealing = false
	MOAT_BLACK_DEAL.Output = false
	MOAT_BLACK_DEAL.OutputWon = 0
	MOAT_BLACK_DEAL.OutputNum = 0
	MOAT_BLACK_DEAL.Think = function(s)
		if (not MOAT_GAMBLE.BlackDealing and not MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE.BlackGameActive) then
			s:SetAlpha(0)
			s:SetDisabled(true)
			s:SetPos(10, 600)
		else
			s:SetAlpha(255)
			s:SetDisabled(false)
			s:SetPos(10, 385)
		end
	end
	MOAT_BLACK_DEAL.Paint = function(s, w, h)
		if (MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE_BLACKJACK.OutputWon == 2) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(64, 165, 71)
			if (s:IsHovered()) then
				btncolor = Color(44, 145, 51)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("You've WON " .. math.Round(MOAT_GAMBLE_BLACKJACK.OutputNum, 2) .. " IC", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		elseif (MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE_BLACKJACK.OutputWon == 1) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(165, 30, 30)
			if (s:IsHovered()) then
				btncolor = Color(145, 10, 10)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(131, 0, 0, 255))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("You've lost " .. math.Round(MOAT_GAMBLE_BLACKJACK.OutputNum, 2) .. " IC", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		elseif (MOAT_GAMBLE_BLACKJACK.Output and MOAT_GAMBLE_BLACKJACK.OutputWon == 3) then
			local btndown = 0
			if (s:IsDown()) then
				btndown = 2
			end

			local btncolor = Color(238, 185, 52)
			if (s:IsHovered()) then
				btncolor = Color(218, 165, 32)
			end

			draw.RoundedBox(4, 0, 5, w, 60, Color(184, 134, 11))
			draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    		draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    		surface.SetDrawColor(200, 200, 200, 25)
        	surface.SetMaterial(gradient_u)
        	surface.DrawTexturedRect(0, btndown, w, 60)

    		draw.SimpleText("You've tied with the dealer", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			return
		end

		if (MOAT_GAMBLE.BlackDealing) then
			draw.RoundedBox(4, 0, 5, w, 60, Color(67, 68, 67))
    		draw.RoundedBox(4, 0, 0, w, 60, Color(128, 128, 128))

    		draw.SimpleText("Dealing...", "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		local btndown = 0
		if (s:IsDown()) then
			btndown = 2
		end
		local btncolor = Color(64, 165, 71)
		if (s:IsHovered()) then
			btncolor = Color(44, 145, 51)
		end
		draw.RoundedBox(4, 0, 5, w, 60, Color(0, 131, 61, 255))
		draw.RoundedBox(4, 0, btndown, w, 60, Color(170, 170, 170))
    	draw.RoundedBox(4, 1, btndown + 1, w-2, 60-2, btncolor)

    	surface.SetDrawColor(200, 200, 200, 25)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, btndown, w, 60)

    	draw.SimpleText("DEAL", "Trebuchet24", w/2, h/2 + btndown, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	MOAT_BLACK_DEAL.DoClick = function(s)
		if (MOAT_GAMBLE.BlackDealing) then
			return
		end

		if (MOAT_GAMBLE_BLACKJACK.Output) then
			MOAT_GAMBLE_BLACKJACK.Output = false
			MOAT_GAMBLE_BLACKJACK.OutputNum = 0

			MOAT_GAMBLE.BlackStand = false
			MOAT_GAMBLE.BlackDealing = false
			MOAT_GAMBLE.BlackGameActive = false
			MOAT_GAMBLE.PlayerCards = {}
			MOAT_GAMBLE.DealerCards = {}

			return
		end

		MOAT_GAMBLE_BLACKJACK.Output = false
		MOAT_GAMBLE.BlackDealing = true

		net.Start("MOAT_GAMBLE_BLACK")
		net.WriteDouble(MOAT_GAMBLE.BlackBetAmount)
		net.SendToServer()
	end*/
end

local BlackSounds = {
	Place = {
		"https://i.moat.gg/18-12-19-44j.mp3",
		"https://i.moat.gg/18-12-19-n21.mp3",
		"https://i.moat.gg/18-12-19-X1h.mp3",
		"https://i.moat.gg/18-12-19-t87.mp3"
	}
}

net.Receive("MOAT_GAMBLE_BLACK", function(len, ply)
	MOAT_GAMBLE_BLACKJACK.Output = false
	MOAT_GAMBLE.BlackDealing = false
end)

net.Receive("MOAT_GAMBLE_BLACKOVER", function(len, ply)
	local outcome = net.ReadUInt(2)
	if outcome == 2 then
		PlayMinesSound("win")
	elseif outcome == 3 then
		PlayMinesSound("end")
	else
		PlayMinesSound("boom")
	end
	local amt = net.ReadDouble()

	MOAT_GAMBLE.BlackDealing = false

	MOAT_GAMBLE_BLACKJACK.OutputWon = outcome
	MOAT_GAMBLE_BLACKJACK.OutputNum = amt
	MOAT_GAMBLE_BLACKJACK.Output = true
end)

net.Receive("MOAT_BLACK_CARD", function(len, ply)
	local dealer = net.ReadBool()
	local num = net.ReadUInt(4)

	MOAT_GAMBLE.BlackGameActive = true

	if (num == 1) then
		num = "ACE"
	end

	if (dealer) then
		if (#MOAT_GAMBLE.DealerCards == 2 and MOAT_GAMBLE.DealerCards[2] == 0) then
			table.remove(MOAT_GAMBLE.DealerCards, 2)
		end
		table.insert(MOAT_GAMBLE.DealerCards, num)
	else
		table.insert(MOAT_GAMBLE.PlayerCards, num)
	end

	if (not MOAT_GAMBLE.BlackStand and #MOAT_GAMBLE.PlayerCards > 1 and #MOAT_GAMBLE.DealerCards > 1) then
		MOAT_GAMBLE.BlackDealing = false
	end
	cdn.PlayURL(table.Random(BlackSounds.Place))
end)

function m_RemoveBlackjackPanel()
	if (IsValid(MOAT_GAMBLE_BLACK)) then
		MOAT_GAMBLE_BLACK:Remove()
	end
end

--[[
    Versus Panel
]]
local versus_wait = 5
local versus_players = {}
gversus_players = {}
local versus_winners = {}
versus_oldgames = {}

function m_versusroll(owner,other,winner)
	math.randomseed(tonumber(owner + other + gversus_players[owner][2]))-- so everyone sees the same thing no matter what server they are on

	local pp = {owner,other}
    Roll = vgui.Create("DPanel")
    Roll:SetPos(-1000,-1000)
    Roll:SetSize(358, 73)

    Roll.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
    end
	Roll.middle = 0
    Roll.PaintOver = function(s, w, h)
		if not IsValid(Roll) then return end
		if not Roll.middle then Roll.middle = 0 end
        draw.RoundedBox(0, Roll.middle - 1, 0, 2, h, Color(255, 128, 0))
    end

    local spacing = 3
    local icon_wide = 46
    local contents_wide = (spacing + icon_wide) * 100
    local MOAT_ROLL_CONTENTS = vgui.Create("DPanel", Roll)
    MOAT_ROLL_CONTENTS:SetSize(contents_wide, 73)
    MOAT_ROLL_CONTENTS:SetPos(contents_wide * -1, 0)
    MOAT_ROLL_CONTENTS.Paint = function(s, w, h) end
    local item_value = 0
    for i = 1, 100 do
		local Item_Panel = vgui.Create("AvatarImage", MOAT_ROLL_CONTENTS)
        Item_Panel:SetSize(46,40)
        Item_Panel:SetPos((spacing + icon_wide) * (i - 1), 3)
		if i == 4 then
			Roll.middle = Item_Panel:GetPos()
			Item_Panel:SetSteamID(winner,64)
		else
			if not pp then continue end
			local s = table.Random(pp)
			Item_Panel:SetSteamID(s,64)
		end
    end
	-- if not gversus_players[owner].roll_contents then
    -- 	roll_contents_x = MOAT_ROLL_CONTENTS:GetPos()
	-- else
	-- 	roll_contents_x = gversus_players[owner].roll_contents
	-- end
	local roll_y = 0
	if not (gversus_players[owner].roll_contents_x) then
		gversus_players[owner].roll_contents_x = MOAT_ROLL_CONTENTS:GetPos()
	end

    local roll_to = gversus_players[owner].rollto
	-- 203

	-- local to_add = w - 203
	-- roll_to = roll_to - to_add
	-- print(roll_to,to_add)
    MOAT_ROLL_CONTENTS.Think = function(s, w, h)
		if not IsValid(Roll) then return end
        if (math.abs(gversus_players[owner].roll_contents_x - roll_to) < 1) then return end

        if (math.floor(gversus_players[owner].roll_contents_x / 71) ~= item_value) then
			if (IsValid(MOAT_GAMBLE_VS) and ((isstring(other) and LocalPlayer():SteamID64() == other) or (isstring(owner) and LocalPlayer():SteamID64() == owner) or (LocalPlayer() == owner or LocalPlayer() == other))) then
            	sfx.Tick()
			end
        end

        s:SetPos(gversus_players[owner].roll_contents_x, roll_y)
        item_value = math.floor(gversus_players[owner].roll_contents_x / 71)

    end


	return Roll
end

local function versusRebuild()
	if (not IsValid(MOAT_GAMBLE_VS) or not versus_buildlist) then return end
	versus_buildlist()
end

net.Receive("versus.stats",function()
	versus_stats = net.ReadTable()

	versusRebuild()
end)

net.Receive("versus.Sync",function()
	versus_players = net.ReadTable()

	versusRebuild()
end)

net.Receive("versus.last",function()
	versus_logs_games["last"] = net.ReadTable()[1]

	versusRebuild()
end)

net.Receive("gversus.Sync",function()
	gversus_players = net.ReadTable()

	versusRebuild()
end)

net.Receive("versus.CreateGame",function()
	local ply = net.ReadEntity()
	local amt = net.ReadDouble()
	versus_players[ply] = {nil,amt}
	
	versusRebuild()
end)

net.Receive("versus.JoinGame",function()
	local ply = net.ReadEntity()
	local j = net.ReadEntity()
	if (not versus_players[ply]) then return end

	versus_players[ply][1] = j
	versus_players[ply][3] = CurTime() + versus_wait

	versusRebuild()
end)

net.Receive("versus.FinishGame",function()
	local ply = net.ReadEntity()
	local win = net.ReadEntity()
	if (not versus_players[ply] or not versus_players[ply][1]) then
		versus_players[ply] = nil
		return
	end
	versus_players[ply][4] = win

	-- store our information now so we dont have to isvalid check in timer
	local plyid, plynick, otherid, othernick = "404", "John Doe", "404", "John Doe"
	if (IsValid(ply)) then plyid, plynick = ply:SteamID64(), ply:Nick() end
	if (IsValid(versus_players[ply][1])) then otherid, othernick = versus_players[ply][1]:SteamID64(), versus_players[ply][1]:Nick() end

	timer.Simple(3,function()
		table.insert(versus_oldgames,{
			plyid,
			otherid,
			versus_players[ply][2],
			plynick,
			othernick,
			win == ply
		})
		versus_players[ply] = nil

		versusRebuild()
	end)
end)

net.Receive("versus.Cancel",function()
	versus_players[net.ReadEntity()] = nil

	versusRebuild()
end)

net.Receive("gversus.CreateGame",function()
	local ply = net.ReadString()
	local amt = net.ReadDouble()
	gversus_players[ply] = {nil,amt}

	versusRebuild()
end)

net.Receive("gversus.FullGame",function()
	local ply = net.ReadString()
	if (not gversus_players[ply]) then return end
	gversus_players[ply]["fullgame"] = true
end)

net.Receive("gversus.JoinGame",function()
	local ply = net.ReadString()
	local j = net.ReadString()
	local winner = net.ReadString()
	if (not gversus_players[ply]) then return end

	gversus_players[ply][1] = j
	gversus_players[ply][3] = CurTime() + versus_wait

	gversus_players[ply][10] = winner
	
	math.randomseed(tonumber(winner + gversus_players[ply][2] + ply)) -- so everyone sees the same thing no matter what server they are on
	local r = math.random()
	if r > 0.4 then
		if r > 0.7 then
			gversus_players[ply].rollto = math.random(4,-3)
		else
			gversus_players[ply].rollto = math.random(-32,-38)
		end
	else
		gversus_players[ply].rollto = math.random(-3,-32)
	end
	gversus_players[ply].roll_contents_x = -4900

	hook.Add("Think","BackGroundRollVersus." .. ply,function()
		if not gversus_players[ply] then hook.Remove("Think","BackGroundRollVersus." .. ply) return end
		if not gversus_players[ply].roll_contents_x then gversus_players[ply].roll_contents_x = -4900 end
		if not gversus_players[ply].rollto then gversus_players[ply].rollto = 0 end
		local distance = (math.abs(gversus_players[ply].roll_contents_x - gversus_players[ply].rollto))
		if distance > 1500 then
			gversus_players[ply].roll_contents_x = math.Approach(gversus_players[ply].roll_contents_x, gversus_players[ply].rollto, 1500 * FrameTime())
		else
			gversus_players[ply].roll_contents_x = Lerp(FrameTime() * 0.68, gversus_players[ply].roll_contents_x, gversus_players[ply].rollto)
		end
	end)
	-- gversus_players[ply]["roll"] = m_versusroll(ply,j,winner)

	versusRebuild()
end)

net.Receive("gversus.FinishGame",function()
	local ply = net.ReadString()
	local win = net.ReadString()
	hook.Remove("Think","BackGroundRollVersus." .. ply)
	if (not gversus_players[ply] or not gversus_players[ply][1]) then
		gversus_players[ply] = nil
		return
	end
	gversus_players[ply][4] = win

	local plyid, plynick, otherid, othernick = ply, "John Doe", gversus_players[ply][1], "John Doe"

	if (IsValid(LocalPlayer())) then
		local lid = LocalPlayer():SteamID64()
		if (lid == win) then
			PlayVersusSound "versus_win"
		elseif (lid == ply) then
			PlayVersusSound "end"
		end
	end

	GetSteamName(ply, function(n) plynick = n
		if (not gversus_players[ply]) then return end
		GetSteamName(gversus_players[ply][1], function(on) othernick = on
			if (not gversus_players[ply]) then return end
			timer.Simple(3,function()
				if (not gversus_players[ply]) then return end

				table.insert(versus_oldgames,{
					plyid,
					otherid,
					gversus_players[ply][2],
					plynick,
					othernick,
					win == ply
				})
				if IsValid(gversus_players[ply].roll) then
					gversus_players[ply].roll:Remove()
				end
				gversus_players[ply] = nil

				versusRebuild()
			end)
		end)
	end)
end)

net.Receive("gversus.Cancel",function()
	gversus_players[net.ReadString()] = nil

	versusRebuild()
end)

net.Receive("versus.Cancel",function()
	versus_players[net.ReadString()] = nil

	versusRebuild()
end)


MOAT_GAMBLE.VersusAmount = 1

surface.CreateFont("moat_VersusTitle", {
    font = "DermaLarge",
    size = 28,
    weight = 800
})

surface.CreateFont("moat_VersusWinner", {
    font = "DermaLarge",
    size = 22,
    weight = 800
})

function m_DrawVersusPanel()
	local inGame = false
	/*for k,v in pairs(player.GetAll()) do
		versus_players[v] = {Entity(2),10000000}
		timer.Simple(versus_wait,function()
			versus_players[v][4] = v
			print("time")
			PrintTable(versus_players[v])
		end)
	end*/

    MOAT_GAMBLE_VS = vgui.Create("DPanel", MOAT_GAMBLE_BG)
    MOAT_GAMBLE_VS:SetPos(230, 50)
    MOAT_GAMBLE_VS:SetSize(505, 460)
    MOAT_GAMBLE_VS.Paint = function(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
    	surface.SetDrawColor(86, 86, 86)
    	surface.DrawOutlinedRect(0, 0, w, h)

        surface.SetDrawColor(86, 86, 86)
		surface.DrawLine(0,40,505,40)
    	if (MOAT_GAMBLE.VersusAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.VersusAmount < 1)) then
    		surface.SetDrawColor(255, 0, 0)
    	else
    		surface.SetDrawColor(86, 86, 86)
    	end
		surface.DrawOutlinedRect(128,5,100,31)
		draw.SimpleText("VS AMOUNT:", "moat_GambleTitle", 10, 20, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		surface.SetDrawColor(86, 86, 86)
		surface.DrawLine(0,h-20,w,h-20)
		draw.DrawText("Versus is cross-server! There are 26 Moat TTT servers connected.","moat_JackVerySmall",w/2,h-18,Color(255,255,255),TEXT_ALIGN_CENTER)
    end
	local game_panel = vgui.Create("DPanel",MOAT_GAMBLE_VS)
	game_panel:SetSize(495,407)
	game_panel:SetPos(5,47)
	function game_panel:Paint() end

	local game_actual = vgui.Create("DScrollPanel",game_panel)
	game_actual:SetSize(495,385)
	game_actual:GetVBar():SetWide(4)
	function versus_buildlist()
		inGame = false 
		if not IsValid(game_panel) then return end
		game_actual:Clear()

		for k,v in SortedPairsByMemberValue(gversus_players,2,true) do
			if k == LocalPlayer():SteamID64() or v[1] == LocalPlayer():SteamID64() then
				inGame = true
				if not v[2] then v[2] = 0 end
				--for i = 1,5 do--
				local a = vgui.Create("DPanel",game_actual)
				a:SetSize(0,50)
				a:DockMargin(0,0,0,5)
				a:Dock(TOP)

				local av = vgui.Create("AvatarImage",a)
				av:DockMargin(2,3,40,3)
				av:SetSize(46,40)
				av:Dock(LEFT)
				av:SetSteamID(k,64)
				GetSteamName(k, function(n)
					if (IsValid(av)) then av:SetTooltip(n) end
				end)
				local butt = vgui.Create("DButton",av)
				butt:SetText("")
				butt:Dock(FILL) function butt:Paint() end
				function butt:DoClick()
					open_profile_card(k)
				end
				sfx.SoundEffects(butt)

				local op = vgui.Create("AvatarImage",a)
				op:DockMargin(0,3,5,3)
				op:SetSize(46,40)
				op:Dock(LEFT)
				local vnick = "forsenE"
				if (v[1]) then
					op:SetSteamID(v[1], 64)
					GetSteamName(v[1], function(n)
						if (IsValid(op)) then op:SetTooltip(n) end
					end)
				else
					op:SetTooltip("Empty!")
				end
				local butt = vgui.Create("DButton",op)
				butt:SetText("")
				butt:Dock(FILL) function butt:Paint() end
				function butt:DoClick()
					if v[1] then open_profile_card(v[1]) end
				end
				sfx.SoundEffects(butt)
		--a
				local s = true
				local winner
				if not (v[1]) then
					local join = vgui.Create("DButton",a)
					sfx.SoundEffects(join)
					join:SetSize(148,0)
					join:DockMargin(5,5,5,5)
					join:Dock(RIGHT)
					join:SetText("")
					function join:Paint(w,h)
						local a = 255
						if self:IsHovered() then a = 175 end
						local c = Color(10,200,10,a)
						if (v[2] > MOAT_INVENTORY_CREDITS)then
							c = Color(86,86,86)
							a = 10
						end
						if (k == LocalPlayer():SteamID64()) then
							c = Color(200,10,10)
							draw.RoundedBox(0,0,0,w,h,c)
							surface.SetDrawColor(0,255,0,a * 0.7)
							surface.DrawOutlinedRect(0,0,w,h)
							draw.SimpleText("CANCEL GAME", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
						else
							if v["fullgame"] then
								c = Color(255,0,0)
							end
							draw.RoundedBox(0,0,0,w,h,c)
							surface.SetDrawColor(0,255,0,a * 0.7)
							surface.DrawOutlinedRect(0,0,w,h)
							if v["fullgame"] then
								draw.SimpleText("GAME FULL", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
							else
								if not self.double then
									draw.SimpleText("JOIN GAME", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
								else
									draw.SimpleText("CONFIRM JOIN", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
								end
							end
						end
					end
					function join.DoClick()
						if v["fullgame"] then return end
						if k == LocalPlayer():SteamID64() then
							net.Start("gversus.CancelGame")
							net.SendToServer()
						elseif not join.double then
							join.double = true
						else
							if v[2] > (MOAT_INVENTORY_CREDITS * 0.25) then
								Derma_Query("Are you sure you want to gamble more than 25% of your IC?\nNever gamble anything you can't afford to lose.", "Are you sure?", "Yes", function() 
									net.Start("gversus.JoinGame")
									net.WriteString(k)
									net.WriteDouble(v[2])
									net.SendToServer()
									versus_seen_last = true
								end, "No")
							else
								net.Start("gversus.JoinGame")
								net.WriteString(k)
								net.WriteDouble(v[2])
								net.SendToServer()
								versus_seen_last = true
							end
						end
					end
				else --midgame
					surface.SetFont("moat_VersusTitle")
					local w = surface.GetTextSize(string.Comma(round(v[2])) .." IC")
					w = w + 10 + 145
					if not IsValid(v.roll) then
						v.roll = m_versusroll(k,v[1],v[10])
					end
					v.roll:SetParent(a)
					v.roll:SetPos(w,1)
					v.roll:SetWide(493 - w - 2)
					-- winner = vgui.Create("AvatarImage",a)
					-- winner:DockMargin(0,3,20,3)
					-- winner:SetSize(46,40)
					-- winner:Dock(RIGHT)
					-- --winner:SetSteamID(k,64)
					-- gversus_players[k][5] = winner
					-- local sh, sid = true, k
					-- timer.Create("versus_winner:" .. sid,0.25,0,function()
					-- 	if (not (IsValid(winner) and gversus_players[k] and gversus_players[k][1])) then
					-- 		timer.Remove("versus_winner:" .. sid)
					-- 		return
					-- 	end

					-- 	if (gversus_players[k][4]) then
					-- 		winner:SetSteamID(gversus_players[k][4], 64)
					-- 		winner.setwinner = true
					-- 		timer.Remove("versus_winner:" .. sid)
					-- 		return
					-- 	end

					-- 	winner:SetSteamID(sh and v[1] or k, 64)
					-- 	PlayVersusSound(sh and 1 or 2)
					-- 	sh = not sh
					-- end)
				end



				function a:Paint(w,h)
					if not gversus_players[k] then a:Remove() return end
					if not v[2] then v[2] = 0 end
					if not (v[1]) then
						if IsValid(op) then
							op:SetSteamID("BOT",64)
						end
						draw.SimpleText(string.Comma(round(v[2])) .. " IC", "moat_VersusTitle", 240, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
						draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					else
						-- if not v[3] then v[3] = CurTime() + versus_wait end
						-- local t = v[3] - CurTime()
						-- local a = t/versus_wait
						-- --print(a)
						-- draw.RoundedBox(0,0,0,w*a,h,Color(175,175,175))
						draw.SimpleText(string.Comma(round(v[2])) .." IC", "moat_VersusTitle", 145 ,(h/2), Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
						-- local c = Color(255,255,255)
						-- if gversus_players[k][4] then
						-- 	c = HSVToColor((SysTime()*100)%360,0.65,0.9)
						-- 	if (IsValid(winner) and not winner.setwinner) then
						-- 		winner:SetSteamID(gversus_players[k][4], 64)
						-- 		winner.setwinner = true
						-- 	end
						-- end
						-- draw.SimpleText("WINNER:", "moat_VersusWinner", 325, h - (h/3), c,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					end
					draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					surface.SetDrawColor(200, 200, 200, 255)
					if (k == LocalPlayer():SteamID64() or v[1] == LocalPlayer():SteamID64()) then
						surface.SetDrawColor(0,255,0,255)
					end
					surface.DrawOutlinedRect(0,0,w,h)
				end
			end
		end

		for k,v in SortedPairsByMemberValue(gversus_players,2,true) do
			
			if k == LocalPlayer():SteamID64() then continue end
			if v[1] == LocalPlayer():SteamID64() then continue end
			if not v[2] then v[2] = 0 end
			--for i = 1,5 do--
			local a = vgui.Create("DPanel",game_actual)
			a:SetSize(0,50)
			a:DockMargin(0,0,0,5)
			a:Dock(TOP)

			local av = vgui.Create("AvatarImage",a)
			av:DockMargin(2,3,40,3)
			av:SetSize(46,40)
			av:Dock(LEFT)
			av:SetSteamID(k,64)
			GetSteamName(k, function(n)
				if (IsValid(av)) then av:SetTooltip(n) end
			end)
			local butt = vgui.Create("DButton",av)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(k)
			end
			sfx.SoundEffects(butt)

			local op = vgui.Create("AvatarImage",a)
			op:DockMargin(0,3,5,3)
			op:SetSize(46,40)
			op:Dock(LEFT)
			local vnick = "forsenE"
			if (v[1]) then
				op:SetSteamID(v[1], 64)
				GetSteamName(v[1], function(n)
					if (IsValid(op)) then op:SetTooltip(n) end
				end)
			else
				op:SetTooltip("Empty!")
			end
			local butt = vgui.Create("DButton",op)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				if v[1] then open_profile_card(v[1]) end
			end
			sfx.SoundEffects(butt)
	--a
			local s = true
			local winner
			if not (v[1]) then
				local join = vgui.Create("DButton",a)
				sfx.SoundEffects(join)
				join:SetSize(148,0)
				join:DockMargin(5,5,5,5)
				join:Dock(RIGHT)
				join:SetText("")
				function join:Paint(w,h)
					local a = 255
					if self:IsHovered() then a = 175 end
					local c = Color(10,200,10,a)
					if (v[2] > MOAT_INVENTORY_CREDITS)then
						c = Color(86,86,86)
						a = 10
					end
					if (k == LocalPlayer():SteamID64()) then
						c = Color(200,10,10)
						draw.RoundedBox(0,0,0,w,h,c)
						surface.SetDrawColor(0,255,0,a * 0.7)
						surface.DrawOutlinedRect(0,0,w,h)
						draw.SimpleText("CANCEL GAME", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					else
						if v["fullgame"] then
							c = Color(255,0,0)
						end
						draw.RoundedBox(0,0,0,w,h,c)
						surface.SetDrawColor(0,255,0,a * 0.7)
						surface.DrawOutlinedRect(0,0,w,h)
						if v["fullgame"] then
							draw.SimpleText("GAME FULL", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
						else
							if not self.double then
								draw.SimpleText("JOIN GAME", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
							else
								draw.SimpleText("CONFIRM JOIN", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
							end
						end
					end
				end
				function join.DoClick()
					if v["fullgame"] then return end
					if k == LocalPlayer():SteamID64() then
						net.Start("gversus.CancelGame")
						net.SendToServer()
					elseif not join.double then
						join.double = true
					else
						if v[2] > (MOAT_INVENTORY_CREDITS * 0.25) then
							Derma_Query("Are you sure you want to gamble more than 25% of your IC?\nNever gamble anything you can't afford to lose.", "Are you sure?", "Yes", function() 
								net.Start("gversus.JoinGame")
								net.WriteString(k)
								net.WriteDouble(v[2])
								net.SendToServer()
								versus_seen_last = true
							end, "No")
						else
							net.Start("gversus.JoinGame")
							net.WriteString(k)
							net.WriteDouble(v[2])
							net.SendToServer()
							versus_seen_last = true
						end
					end
				end
			else --midgame
				surface.SetFont("moat_VersusTitle")
				local w = surface.GetTextSize(string.Comma(round(v[2])) .." IC")
				w = w + 10 + 145
				if not IsValid(v.roll) then
					v.roll = m_versusroll(k,v[1],v[10])
				end
				v.roll:SetParent(a)
				v.roll:SetPos(w,1)
				v.roll:SetWide(493 - w - 2)
				-- winner = vgui.Create("AvatarImage",a)
				-- winner:DockMargin(0,3,20,3)
				-- winner:SetSize(46,40)
				-- winner:Dock(RIGHT)
				-- --winner:SetSteamID(k,64)
				-- gversus_players[k][5] = winner
				-- local sh, sid = true, k
				-- timer.Create("versus_winner:" .. sid,0.25,0,function()
				-- 	if (not (IsValid(winner) and gversus_players[k] and gversus_players[k][1])) then
				-- 		timer.Remove("versus_winner:" .. sid)
				-- 		return
				-- 	end

				-- 	if (gversus_players[k][4]) then
				-- 		winner:SetSteamID(gversus_players[k][4], 64)
				-- 		winner.setwinner = true
				-- 		timer.Remove("versus_winner:" .. sid)
				-- 		return
				-- 	end

				-- 	winner:SetSteamID(sh and v[1] or k, 64)
				-- 	PlayVersusSound(sh and 1 or 2)
				-- 	sh = not sh
				-- end)
			end



			function a:Paint(w,h)
				if not gversus_players[k] then a:Remove() return end
				if not v[2] then v[2] = 0 end
				if not (v[1]) then
					if IsValid(op) then
						op:SetSteamID("BOT",64)
					end
					draw.SimpleText(string.Comma(round(v[2])) .. " IC", "moat_VersusTitle", 240, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				else
					-- if not v[3] then v[3] = CurTime() + versus_wait end
					-- local t = v[3] - CurTime()
					-- local a = t/versus_wait
					-- --print(a)
					-- draw.RoundedBox(0,0,0,w*a,h,Color(175,175,175))
					draw.SimpleText(string.Comma(round(v[2])) .." IC", "moat_VersusTitle", 145 ,(h/2), Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					-- local c = Color(255,255,255)
					-- if gversus_players[k][4] then
					-- 	c = HSVToColor((SysTime()*100)%360,0.65,0.9)
					-- 	if (IsValid(winner) and not winner.setwinner) then
					-- 		winner:SetSteamID(gversus_players[k][4], 64)
					-- 		winner.setwinner = true
					-- 	end
					-- end
					-- draw.SimpleText("WINNER:", "moat_VersusWinner", 325, h - (h/3), c,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end
				draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetDrawColor(200, 200, 200, 255)
				if (k == LocalPlayer():SteamID64() or v[1] == LocalPlayer():SteamID64()) then
					surface.SetDrawColor(0,255,0,255)
				end
				surface.DrawOutlinedRect(0,0,w,h)
			end


			--end--
		end

		-- last match
		if istable(versus_logs_games["last"]) and (not versus_seen_last) then
			local v = versus_logs_games["last"]
			local a = vgui.Create("DPanel",game_actual)
			a:SetSize(0,50)
			a:DockMargin(0,0,0,5)
			a:Dock(TOP)
			
			local av = vgui.Create("AvatarImage",a)
			av:DockMargin(2,3,40,3)
			av:SetSize(46,40)
			av:Dock(LEFT)
			av:SetSteamID(v.steamid,64)
			steamworks.RequestPlayerInfo(v.steamid,function(name)
				if not IsValid(av) then return end
				av:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",av)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.steamid)
			end
			sfx.SoundEffects(butt)

			local op = vgui.Create("AvatarImage",a)
			op:DockMargin(0,3,5,3)
			op:SetSize(46,40)
			op:Dock(LEFT)
			op:SetSteamID(v.other,64)
			steamworks.RequestPlayerInfo(v.other,function(name)
				if not IsValid(op) then return end
				op:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",op)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.other)
			end
			sfx.SoundEffects(butt)
			winner = vgui.Create("AvatarImage",a)
			winner:DockMargin(0,3,20,3)
			winner:SetSize(46,40)
			winner:Dock(RIGHT)
			winner:SetSteamID(v.winner,64)
			steamworks.RequestPlayerInfo(v.winner,function(name) -- cached internally
				if not IsValid(winner) then return end
				winner:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",winner)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.winner)
			end
			sfx.SoundEffects(butt)
			function a:Paint(w,h)
				draw.SimpleText(string.Comma(round(v.amount)) .. " IC", "moat_VersusTitle", 145,(h/2), Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				local c = Color(255,255,255)
				draw.SimpleText(string.NiceTime(os.time() - v.time) .. " ago", "moat_ItemDesc", 405, 15, c, TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				draw.SimpleText("YOUR LAST MATCH", "moat_ItemDesc", w/2, 10, c, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("WINNER:", "moat_VersusWinner", 325, h - (h/3), c,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetDrawColor(0,255,0, 255)
				surface.DrawOutlinedRect(0,0,w,h)
			end
		end
		
		local streak_name = "Moat"
		steamworks.RequestPlayerInfo(versus_stats.streak.steamid or "0", function(name)
			streak_name = name
		end)
		local a = vgui.Create("DPanel",game_actual)
		a:SetSize(0,50)
		a:DockMargin(0,0,0,5)
		a:Dock(TOP)
		function a:Paint(w,h)
			draw.SimpleText("LUCKIEST PLAYER OF THE HOUR", "moat_GambleTitle", w/2, 13, Color(116,185,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(string.Comma(round(versus_stats.streak.streak or 2)) .. " WINS IN A ROW", "moat_VersusTitle", w * 0.5,(h * 0.7) - 3, Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			local c = Color(255,255,255)
			surface.SetDrawColor(116,185,255, 255)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		for i =1,2 do
			local av = vgui.Create("AvatarImage",a)
			av:DockMargin(2,3,2,3)
			av:SetSize(46,40)
			av:Dock(i == 1 and LEFT or RIGHT)
			av:SetSteamID(versus_stats.streak.steamid or "0",64)
			av:SetTooltip(streak_name)
			local butt = vgui.Create("DButton",av)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(versus_stats.streak.steamid)
			end
			sfx.SoundEffects(butt)
		end

		local totwinner_name = "Moat"
		steamworks.RequestPlayerInfo(versus_stats.top.winner or "0", function(name)
			totwinner_name = name
		end)
		local a = vgui.Create("DPanel",game_actual)
		a:SetSize(0,50)
		a:DockMargin(0,0,0,5)
		a:Dock(TOP)
		function a:Paint(w,h)
			draw.SimpleText("MOST IC WON IN THE PAST HOUR", "moat_GambleTitle", w/2, 13, Color(116,185,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(string.Comma(round(versus_stats.top.total or 1337)) .. " IC", "moat_VersusTitle", w * 0.5,(h * 0.7) - 3, Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			local c = Color(255,255,255)
			surface.SetDrawColor(116,185,255, 255)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		for i =1,2 do
			local av = vgui.Create("AvatarImage",a)
			av:DockMargin(2,3,2,3)
			av:SetSize(46,40)
			av:Dock(i == 1 and LEFT or RIGHT)
			av:SetSteamID(versus_stats.top.winner or "0",64)
			av:SetTooltip(totwinner_name)
			local butt = vgui.Create("DButton",av)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(versus_stats.top.winner)
			end
			sfx.SoundEffects(butt)
		end

		for k,v in pairs(table.Reverse(versus_oldgames)) do
			if k > 15 then 
				continue
			end
			if (not (v[1] and v[2] and v[3] and v[4] and v[5])) then continue end

			local a = vgui.Create("DPanel",game_actual)
			a:SetSize(0,50)
			a:DockMargin(0,0,0,5)
			a:Dock(TOP)
			
			local av = vgui.Create("AvatarImage",a)
			av:DockMargin(2,3,40,3)
			av:SetSize(46,40)
			av:Dock(LEFT)
			av:SetSteamID(v[1],64)
			av:SetTooltip(v[4])
			local butt = vgui.Create("DButton",av)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v[1])
			end
			sfx.SoundEffects(butt)

			local op = vgui.Create("AvatarImage",a)
			op:DockMargin(0,3,5,3)
			op:SetSize(46,40)
			op:Dock(LEFT)
			op:SetSteamID(v[2],64)
			op:SetTooltip(v[5])
			local butt = vgui.Create("DButton",op)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v[2])
			end
			sfx.SoundEffects(butt)
			winner = vgui.Create("AvatarImage",a)
			winner:DockMargin(0,3,20,3)
			winner:SetSize(46,40)
			winner:Dock(RIGHT)
			if v[6] then
				if not v[1] then return end
				winner:SetSteamID(v[1],64)
				if not v[4] then return end
				winner:SetTooltip(v[4])
			else
				if not v[2] then return end
				winner:SetSteamID(v[2],64)
				if not v[5] then return end
				winner:SetTooltip(v[5])
			end

			function a:Paint(w,h)
				draw.SimpleText(string.Comma(round(v[3])) .. " IC", "moat_VersusTitle", 145,(h/2), Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				local c = Color(255,255,255)
				draw.SimpleText("WINNER:", "moat_VersusWinner", 325, h - (h/3), c,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetDrawColor(86,86,86, 255)
				surface.DrawOutlinedRect(0,0,w,h)
			end
		end

	end
	versus_buildlist()

	local make_game = vgui.Create("DButton", MOAT_GAMBLE_VS)
	make_game:SetPos(233,5)
	make_game:SetSize(148,31)
	make_game:SetText("")
	function make_game:Paint(w,h)
		local a = 255
		if self:IsHovered() then a = 175 end
		local c = Color(10,200,10,a)
		if (MOAT_GAMBLE.VersusAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.VersusAmount < 1)) or (versus_players[LocalPlayer()]) or (inGame) then
			c = Color(86,86,86)
			--print("ding",inGame)
			--print("lp",versus_players[LocalPlayer()])
			a = 10
		end
		draw.RoundedBox(0,0,0,w,h,c)
		surface.SetDrawColor(0,255,0,a)
		surface.DrawOutlinedRect(0,0,w,h)
		draw.SimpleText("MAKE GAME", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
	sfx.SoundEffects(make_game)
	local history = vgui.Create("DButton", MOAT_GAMBLE_VS)
	history:SetPos(386,5)
	history:SetSize(113,31)
	history:SetText("")
	function history:Paint(w,h)
		local a = 150
		if self:IsHovered() then a = 50 end
		local c = Color(116,185,255,a)
		draw.RoundedBox(0,0,0,w,h,c)
		surface.SetDrawColor(116,185,255,a)
		surface.DrawOutlinedRect(0,0,w,h)
		draw.SimpleText("YOUR WINS", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
	sfx.SoundEffects(history)
	function history.DoClick() 
		if (historycool or 0) > CurTime() then return end
		historycool = CurTime() + 1
		MOAT_INV_BG:Remove()
		versus_stats_request = true
		net.Start("versus.logs")
		net.WriteInt(0,32)
		net.SendToServer()
		net.Start("versus.total")
		net.SendToServer()
		net.Start("versus.last")
		net.SendToServer()
		
	end

	function make_versus_history(games,last)
		if not IsValid(versus_logs_actual) then
			versus_logs = vgui.Create("DFrame")
			versus_logs:SetSize(495, 550)
			versus_logs:SetTitle("")
			versus_logs:Center()
			versus_logs:MakePopup()
			versus_logs.Title = LocalPlayer():Nick() .. "'s versus wins"
			versus_logs.Paint = function(s, w, h)
				DrawBlur(s, 5)

				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
				draw.RoundedBox(0, 1, 1, w-2, h-2, Color(0, 0, 0, 100))

				surface.SetDrawColor(150, 150, 150, 50)
				surface.DrawRect(0, 0, w, 21)

				draw.SimpleText(s.Title, "GModNotify", 4, 1, Color(255, 255, 255))
			end

			versus_logs_actual = vgui.Create("DScrollPanel",versus_logs)
			versus_logs_actual:Dock(FILL)
			versus_logs_actual:GetVBar():SetWide(10)
		end
		versus_logs_actual:Clear()
		versus_id = nil
		local a = vgui.Create("DPanel",versus_logs_actual)
		a:SetSize(0,50)
		a:DockMargin(0,0,0,5)
		a:Dock(TOP)
		function a:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(18,18,18))
			draw.SimpleText("YOUR TOTAL WINNINGS", "moat_GambleTitle", w/2, 13, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(string.Comma(round(versus_wintotal or 0)) .. " IC", "moat_VersusTitle", w/2,h * 0.7, Color(255,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			local c = Color(255,255,255)
			surface.SetDrawColor(86,86,86, 255)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		local v = games["last"]
		local last_game_id
		if istable(v) then
			local a = vgui.Create("DPanel",versus_logs_actual)
			a:SetSize(0,50)
			a:DockMargin(0,0,0,5)
			a:Dock(TOP)
			
			local av = vgui.Create("AvatarImage",a)
			av:DockMargin(2,3,40,3)
			av:SetSize(46,40)
			av:Dock(LEFT)
			av:SetSteamID(v.steamid,64)
			steamworks.RequestPlayerInfo(v.steamid,function(name)
				av:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",av)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.steamid)
			end
			sfx.SoundEffects(butt)
			local op = vgui.Create("AvatarImage",a)
			op:DockMargin(0,3,5,3)
			op:SetSize(46,40)
			op:Dock(LEFT)
			op:SetSteamID(v.other,64)
			steamworks.RequestPlayerInfo(v.other,function(name)
				op:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",op)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.other)
			end
			sfx.SoundEffects(butt)
			winner = vgui.Create("AvatarImage",a)
			winner:DockMargin(0,3,20,3)
			winner:SetSize(46,40)
			winner:Dock(RIGHT)
			winner:SetSteamID(v.winner,64)
			steamworks.RequestPlayerInfo(v.winner,function(name) -- cached internally
				winner:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",winner)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.winner)
			end
			sfx.SoundEffects(butt)
			function a:Paint(w,h)
				draw.RoundedBox(0,0,0,w,h,Color(18,18,18))
				draw.SimpleText(string.Comma(round(v.amount)) .. " IC", "moat_VersusTitle", 145,(h/2), Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				local c = Color(255,255,255)
				draw.SimpleText(string.NiceTime(os.time() - v.time) .. " ago", "moat_ItemDesc", 405, 15, c, TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				draw.SimpleText("YOUR LAST MATCH", "moat_ItemDesc", w/2, 10, c, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("WINNER:", "moat_VersusWinner", 325, h - (h/3), c,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetDrawColor(0,255,0, 255)
				surface.DrawOutlinedRect(0,0,w,h)
			end
			last_game_id = v.ID
		end
		games["last"] = nil
		for k,v in SortedPairs(games, true) do
			if not versus_id then versus_id = k end
			if k < versus_id then versus_id = k end
			if last_game_id then
				if last_game_id == k then continue end
			end
			local a = vgui.Create("DPanel",versus_logs_actual)
			a:SetSize(0,50)
			a:DockMargin(0,0,0,5)
			a:Dock(TOP)
			
			local av = vgui.Create("AvatarImage",a)
			av:DockMargin(2,3,40,3)
			av:SetSize(46,40)
			av:Dock(LEFT)
			av:SetSteamID(v.steamid,64)
			steamworks.RequestPlayerInfo(v.steamid,function(name)
				av:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",av)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.steamid)
			end
			sfx.SoundEffects(butt)
			local op = vgui.Create("AvatarImage",a)
			op:DockMargin(0,3,5,3)
			op:SetSize(46,40)
			op:Dock(LEFT)
			op:SetSteamID(v.other,64)
			steamworks.RequestPlayerInfo(v.other,function(name)
				op:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",op)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.other)
			end
			sfx.SoundEffects(butt)
			winner = vgui.Create("AvatarImage",a)
			winner:DockMargin(0,3,20,3)
			winner:SetSize(46,40)
			winner:Dock(RIGHT)
			winner:SetSteamID(v.winner,64)
			steamworks.RequestPlayerInfo(v.winner,function(name) -- cached internally
				winner:SetTooltip(name)
			end)
			local butt = vgui.Create("DButton",winner)
			butt:SetText("")
			butt:Dock(FILL) function butt:Paint() end
			function butt:DoClick()
				open_profile_card(v.winner)
			end
			sfx.SoundEffects(butt)
			function a:Paint(w,h)
				draw.RoundedBox(0,0,0,w,h,Color(18,18,18))
				draw.SimpleText(string.Comma(round(v.amount)) .. " IC", "moat_VersusTitle", 145,(h/2), Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				local c = Color(255,255,255)
				draw.SimpleText(string.NiceTime(os.time() - v.time) .. " ago", "moat_ItemDesc", 405, 15, c, TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				draw.SimpleText("WINNER:", "moat_VersusWinner", 325, h - (h/3), c,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("VS", "moat_GambleTitle", 68, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetDrawColor(86,86,86, 255)
				surface.DrawOutlinedRect(0,0,w,h)
			end
		end
		if last then return end
		local a = vgui.Create("DButton",versus_logs_actual)
		a:SetSize(0,50)
		a:DockMargin(0,0,0,5)
		a:Dock(TOP)
		a:SetText("")
		function a:Paint(w,h)
			local a = 255
			if self:IsHovered() then a = 175 end
			local c = Color(10,200,10,a)
			if (historycool or 0) > CurTime() then
				c = Color(86,86,86)
				a = 10
			end
			draw.RoundedBox(0,0,0,w,h,c)
			surface.SetDrawColor(0,255,0,a)
			surface.DrawOutlinedRect(0,0,w,h)
			draw.SimpleText("LOAD MORE GAMES", "moat_GambleTitle", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		function a.DoClick()
			if (historycool or 0) > CurTime() then return end
			historycool = CurTime() + 1
			net.Start("versus.logs")
			net.WriteInt(versus_id,32)
			net.SendToServer()
		end
		sfx.SoundEffects(a)
	end

	net.Receive("versus.total",function()
		local t = net.ReadTable()
		versus_wintotal = t[1].total
	end)

	

	net.Receive("versus.logs",function()
		local last = false
		if net.ReadBool() then
			versus_logs_games = {}
			for k,v in pairs(net.ReadTable()) do
				versus_logs_games[v.ID] = v
			end
		else
			local t = net.ReadTable() 
			if #t < 1 then last = true end
			for k,v in pairs(t) do
				versus_logs_games[v.ID] = v
			end
		end
		make_versus_history(versus_logs_games,last)
	end)

	net.Receive("versus.last",function()
		versus_logs_games["last"] = net.ReadTable()[1]
		if versus_stats_request then
			make_versus_history(versus_logs_games)
		end
	end)
	
	local MOAT_DICE_BET = vgui.Create("DTextEntry", MOAT_GAMBLE_VS)
	MOAT_DICE_BET:SetPos(130, 5)
	MOAT_DICE_BET:SetSize(95, 30)
	MOAT_DICE_BET:SetFont("moat_GambleTitle")
    MOAT_DICE_BET:SetTextColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetCursorColor(Color(255, 255, 255))
    MOAT_DICE_BET:SetEnterAllowed(true)
    MOAT_DICE_BET:SetNumeric(true)
    MOAT_DICE_BET:SetDrawBackground(false)
    MOAT_DICE_BET:SetMultiline(false)
    MOAT_DICE_BET:SetVerticalScrollbarEnabled(false)
    MOAT_DICE_BET:SetEditable(true)
    MOAT_DICE_BET:SetValue("1")
    MOAT_DICE_BET:SetText("1")
    MOAT_DICE_BET.MaxChars = 12

	function make_game.DoClick()
		local num = MOAT_DICE_BET:GetText()
		if (MOAT_DICE_BET:GetText() == "") then MOAT_DICE_BET:SetText("0") num = 0 end
		num = tonumber(num) or 0
		num = math.max(math.Round(num, 2), 1)
		MOAT_GAMBLE.VersusAmount = num
		if (MOAT_GAMBLE.VersusAmount > MOAT_INVENTORY_CREDITS or (MOAT_GAMBLE.VersusAmount < 1)) or (versus_players[LocalPlayer()]) or (inGame) then return end
		if MOAT_GAMBLE.VersusAmount > (MOAT_INVENTORY_CREDITS * 0.25) then
			Derma_Query("Are you sure you want to gamble more than 25% of your IC?\nNever gamble anything you can't afford to lose.", "Are you sure?", "Yes", function() 
				net.Start("gversus.CreateGame")
				net.WriteDouble(MOAT_GAMBLE.VersusAmount)
				net.SendToServer()
				versus_seen_last = true
			end, "No")
		else
			net.Start("gversus.CreateGame")
			net.WriteDouble(MOAT_GAMBLE.VersusAmount)
			net.SendToServer()
			versus_seen_last = true
		end
	end
	
    MOAT_DICE_BET.Think = function(s)
    	if (not s:IsEditing() and MOAT_GAMBLE.VersusAmount ~= tonumber(s:GetText())) then
    		s:SetText(MOAT_GAMBLE.VersusAmount)
    	end
    end
    MOAT_DICE_BET.OnGetFocus = function(s)
        if (tostring(s:GetValue()) == "0") then
            s:SetValue("")
            s:SetText("")
        end
    end
    MOAT_DICE_BET.OnTextChanged = function(s)
        local txt = s:GetValue()
        local amt = string.len(txt)

        if (amt > s.MaxChars or string.EndsWith(tostring(txt), ".") or (string.sub(tostring(txt), 1, 1) == "0" and #tostring(txt) > 1) or string.EndsWith(tostring(txt), "-")) then
            if (s.OldText == nil) then
                s:SetText("")
                s:SetValue("")
                s:SetCaretPos(string.len(""))
            else
                s:SetText(s.OldText)
                s:SetValue(s.OldText)
                s:SetCaretPos(string.len(s.OldText))
            end
        else
            s.OldText = txt
        end
    end
	function MOAT_DICE_BET:CheckNumeric(strValue)
		if #(self:GetText()) + 1 > 9 then return true end
		if (not string.find("1234567890.", strValue, 1, true)) then
			return true
		end

		return false
	end
	MOAT_DICE_BET.OnEnter = function(s)
		local num = s:GetText()
		if (s:GetText() == "") then s:SetText("0") num = 0 end
		num = tonumber(num) or 0
		num = math.max(math.Round(num, 2), 1)

		MOAT_GAMBLE.VersusAmount = num
	end
	MOAT_DICE_BET.OnLoseFocus = function(s)
		s:OnEnter()
	end
end

function m_RemoveVersusPanel()
    if (IsValid(MOAT_GAMBLE_VS)) then
        MOAT_GAMBLE_VS:Remove()
    end
end

--[[
    End of Versus Panel
]]

function m_ChangeGambleCategory()
	local num = net.ReadUInt(4)


	if (num == 1) then
        m_DrawVersusPanel()
    else
        m_RemoveVersusPanel()
    end

	if (num == 2) then
		m_DrawCrashPanel() -- Blackjack
	else
		m_RemoveCrashPanel()
	end

	if (num == 3) then
		m_DrawRoulettePanel()
	else
		m_RemoveRoulettePanel()
	end

	-- if (num == 4) then
	-- 	m_DrawBlackjackPanel() -- Jackpot
	-- else
	-- 	m_RemoveBlackjackPanel()
	-- end

	if (num == 4) then
		m_DrawDicePanel() -- Mines
	else
		m_RemoveDicePanel()
	end

	MOAT_GAMBLE.CurCat = num
end

net.Receive("MOAT_GAMBLE_CAT", m_ChangeGambleCategory)

function m_RemoveGamblePanel()
	if (not IsValid(MOAT_GAMBLE_BG)) then return end

	MOAT_GAMBLE_BG:AlphaTo(0, 0.15, 0, function()
		MOAT_GAMBLE_BG:Remove()
	end)
end


local function safeChatStr(str)
	return str:Replace("\n", "n")
end
function m_AddGambleChatMessage(...)
	if (not IsValid(MOAT_GAMBLE_CHAT)) then return end
	MOAT_GAMBLE_CHAT:AppendText("\n")

	local args = {n = select("#", ...), ...}
	for i = 1, args.n do
		if (IsColor(args[i])) then
			if (args[i+1] == LocalPlayer():Nick()) and args[i].r ~= 255 then
				MOAT_GAMBLE_CHAT:InsertColorChange(255,255,0, 255)
			else
				MOAT_GAMBLE_CHAT:InsertColorChange(args[i].r, args[i].g, args[i].b, 255)
			end
		elseif (isstring(args[i])) then
    		MOAT_GAMBLE_CHAT:AppendText(safeChatStr(args[i]))
    	end
	end

	MOAT_GAMBLE_CHAT:InsertColorChange(255, 255, 255, 255)
end

net.Receive("MOAT_GAMBLE_CHAT", function(len)
	local tbl = net.ReadTable()

	if (#MOAT_GAMBLE.ChatTable >= 250) then
		table.remove(MOAT_GAMBLE.ChatTable, 1)
	end
	table.insert(MOAT_GAMBLE.ChatTable, tbl)
	if isstring(tbl[2]) then
		if tbl[2] ~= "[" then
			m_AddGambleChatMessage(unpack(tbl))
		end
	elseif MOAT_GAMBLE.LocalChat then
		m_AddGambleChatMessage(unpack(tbl))
	end
end)

table.insert(MOAT_GAMBLE.GlobalTable,{Color(255,255,255),"This chat is connected to all 26 Moat TTT servers!"})

table.insert(MOAT_GAMBLE.GlobalTable,{Color(255,0,0), "If you need staff on your server or want to meet players, join our Discord @ moat.chat!"})

net.Receive("MOAT_GAMBLE_GLOBAL",function()
	local time = net.ReadString()
	local name = net.ReadString()
	local msg = net.ReadString()
	if MOAT_GAMBLE.LocalChat then
		GLOBAL_LAST = CurTime()
	end
	if #MOAT_GAMBLE.GlobalTable >= 250 then
		table.remove(MOAT_GAMBLE.GlobalTable, 1)
	end
	local pc = Color(0,255,0)
	if time:match("CL") then
		pc = Color(255,0,0)
		time = time:gsub("CL","")
	end
	local tbl = {pc,name,Color(255,255,255),": ",msg}

	table.insert(MOAT_GAMBLE.GlobalTable,tbl)

	if not MOAT_GAMBLE.LocalChat then
		m_AddGambleChatMessage(unpack(tbl))
	end
end)

net.Receive("Moat.GlobalAnnouncement",function()
	chat.AddText(Color(255,255,255),"[",Color(255,0,0),"GLOBAL ANNOUNCEMENT",Color(255,255,255),"]: ",net.ReadString())
end)

net.Receive("Moat.JackpotWin",function()
	if (not GetConVar("moat_chatjackpot"):GetBool()) then return end

	chat.AddText(Color(255,255,255),"[",Color(255,255,0),"JACKPOT",Color(255,255,255),"] ",Color(255,0,0),net.ReadString(),Color(255,255,255), " just won ",Color(255,255,0),string.Comma(net.ReadInt(32)) .. " IC",Color(255,255,255)," (" .. math.Round(net.ReadDouble(),2) .. "%) in jackpot!")
end)

net.Receive("Moat.PlanetaryDrop",function()
	if (not GetConVar("moat_chatplanetary"):GetBool()) then return end
	local name = net.ReadString()
	local text = net.ReadString()
	local tab = {
		Color(255,255,255) ,"[", Color(0,255,0) ,"PLANETARY", Color(255,255,255), "] ", Color(255,0,0) ,name, Color(255,255,255), " just dropped a Planetary: ",
	}
    
    for i = 1, #text do
        local col = HSVToColor( i * 30 % 360, 1, 1 )
        table.insert( tab, Color(col.r,col.g, col.b) )
        local letter = string.sub( text, i, i )
        table.insert( tab, letter )
    end

	table.insert(tab,Color(255,255,255))
	table.insert(tab,"!")
	chat.AddText(unpack(tab))
end)

net.Receive("Moat.LotteryChat",function()
	local t = net.ReadTable()
	local number = tonumber(t[1])
	local am = tonumber(t[2])
	local winners = tonumber(t[3])
	if winners < 1 then
		chat.AddText(Color(255,255,255),"[",Color(255,255,0),"LOTTERY",Color(255,255,255),"] The lottery number for today was ",Color(255,0,0),number,Color(255,255,255)," with a pot of ",Color(255,255,0),string.Comma(am), " IC",Color(255,255,255),"! There were no winners!")
	else
		chat.AddText(Color(255,255,255),"[",Color(255,255,0),"LOTTERY",Color(255,255,255),"] The lottery number for today was ",Color(255,0,0),number,Color(255,255,255)," with a pot of ",Color(255,255,0),string.Comma(am), " IC",Color(255,255,255),"! There's " .. winners .. " winner" .. (#winners == 1 and "" or "s") .. "!")
	end
end)