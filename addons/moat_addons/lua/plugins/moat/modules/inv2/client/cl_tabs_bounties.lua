local bounties_y = 120

local HSVColor = HSVToColor(1, 1, 255)

local gradient_d = Material("vgui/gradient-d")
local gradient_r = Material("vgui/gradient-r")
local gradient_l = Material("vgui/gradient-l")

local mat_coins = Material("icon16/coins.png")
local mat_exp = Material("icon16/add.png")

local time_left = os.time()

local gradient_rtbl = {
    x = 10,
    y = bounties_y + 10,
    w = 360,
    h = 20
}

local gradient_ttbl = {
    x = 0,
    y = 10,
    w = 360,
    h = 20
}

bounty_tbl = bounty_tbl or {}

net.Receive("moat_bounty_send", function()
    local tier_ = net.ReadUInt(4)
    local name_ = net.ReadString()
    local desc_ = net.ReadString()
    local rewards_ = net.ReadString()
    local progress_cur_ = net.ReadUInt(16)
    local progress_max_ = net.ReadUInt(16)
    -- print("Received bounty",name_,progress_cur_,progress_max_,desc_)
    table.insert(bounty_tbl,{
        tier = tier_,
        name = name_,
        desc = desc_,
        rewards = rewards_,
        progress_cur = progress_cur_,
        progress_max = progress_max_,
        id = net.ReadUInt(16)
    })
end)
local update = {}

net.Receive("bounty.refresh",function()
    bounty_tbl = {}
end)
net.Receive("moat_bounty_update", function()
    local tier_ = net.ReadUInt(16)
    local progress_cur_ = net.ReadUInt(16)
    for k,v in pairs(bounty_tbl) do
        if v.id == tier_ then
            bounty_tbl[k].progress_cur = progress_cur_
            update[k] = true
        end
    end
end)

local chat_color_tiers = {
    Color(255, 255, 255),
    Color(200, 0, 255),
    Color(0, 255, 0),
    Color(255, 0, 0)
}

hook.Add("TTTEndRound","BountyUpdate",function()
    timer.Simple(2,function()
        for k,v in pairs(update) do
            update[k] = nil
            if bounty_tbl[k].progress_cur == bounty_tbl[k].progress_max then continue end
            chat.AddText(Color(255, 255, 0),"[", Color(0, 255, 255),"M", Color(255, 255, 255), "G ", Color(255, 255, 0), "Bounties", Color(255, 255, 0), "] ", Color(255,255,255),"Your progress on ", chat_color_tiers[bounty_tbl[k].tier or 1],bounty_tbl[k].name,  Color(255,255,255), " has increased! [",Color(255,0,0),tostring(bounty_tbl[k].progress_cur), Color(255,255,255),"/",Color(0,255,0),tostring(bounty_tbl[k].progress_max) ,Color(255,255,255),"]")
        end
    end)
end)

function m_DrawBountyDesc(text, font, x, y, w)
    local texte = string.Explode(" ", text)
    surface.SetFont(font)
    local chars_x = 0
    local chars_y = 0

    for i = 1, #texte do
        local char = texte[i]
        local charw, charh = surface.GetTextSize(char .. " ")

        if (chars_x + charw > w) then
            chars_x = 0
            chars_y = chars_y + 1
        end

        local char_col = Color(255, 255, 255)

        if (tonumber(char)) then
            char_col = Color(0, 255, 0)
        end

        if (char:lower() == "innocent") then
            char_col = Color(0, 255, 0)
        elseif (char:lower() == "traitor") then
            char_col = Color(255, 0, 0)
        elseif (char:lower() == "detective") then
            char_col = Color(0, 0, 255)
        end

        draw.SimpleTextOutlined(char, font, x + chars_x, y + (chars_y * 15), char_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))
        chars_x = chars_x + charw
    end

    return chars_y * 15
end
MOAT_CHALL = {}
MOAT_CHALL.TitlePoly = {
	{x = 1, y = 1},
	{x = 140, y = 1},
	{x = 170, y = 45},
	{x = 1, y = 45}
}

local function m_GetFontWidth(font, txt)
	surface.SetFont(font)--s
	return surface.GetTextSize(txt)
end

--function m_PopulateBountiesPanel(pnl,pnl_x, pnl_y, pnl_w, pnl_h)

lottery = lottery or {}

net.Receive("lottery.firstjoin",function()
    lottery = net.ReadTable()
    timer.Simple(60,function()
        chat.AddText("Loading... ", " Today's lottery is currently at ",Color(255,255,0),string.Comma(lottery.amount)," IC",Color(255,255,255),"! (Dailies tab)")
    end)
    if net.ReadBool() then
        lottery.mine = net.ReadInt(32)
    end
end)

net.Receive("lottery.updatepopular",function()
    lottery.popular_num = net.ReadInt(32)
    lottery.popular_ply = net.ReadInt(32)
end)

net.Receive("lottery.updateamount",function()
    lottery.amount = net.ReadInt(32)
end)

net.Receive("lottery.updatetotal",function()
    lottery.players = net.ReadInt(32)
end)

net.Receive("lottery.Purchase",function()
    local i = net.ReadInt(32)
    if i == -1 then lottery.mine = nil return end
    lottery.mine = i
    chat.AddText(Color(0,255,0),"You have purchased a ticket with the number of " .. i .. " in the lottery!")
end)

net.Receive("lottery.Win",function()
    local i = net.ReadInt(32)
    chat.AddText(Color(255,255,255),"You WON the last lottery and earned ",Color(255,255,0),string.Comma(i), " IC!")
end)

net.Receive("lottery.last",function()
    lottery.last_num = net.ReadInt(32)
end)

surface.CreateFont("MinnLottery",{
    font = "DermaLarge",
    size = 25,
    weight = 400,
})

function m_MakeLotteryPanel()
    MOAT_LOTTERY = vgui.Create("DPanel", MOAT_CHALL_BG)
	MOAT_LOTTERY:SetPos(1, 50)
	MOAT_LOTTERY:SetSize(738, 463)
    MOAT_LOTTERY.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))

        HSVColor = HSVToColor(CurTime() * 50 % 360, 1, 1)

        -- Header
        --draw.SimpleTextOutlined("Daily Bounties", "DermaLarge", w/2, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        --draw.RoundedBox(0, (w/2) - ((w/3)/2), 35 + 20, w/3, 1, HSVColor)

        -- Description
        draw.SimpleTextOutlined("This is the 1-200 lucky number lottery, the pot starts at 5000 IC!", "moat_ItemDesc", w/2, 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined("The way to win the lottery is to guess the lucky number that gets picked at the end of the timer!", "moat_ItemDesc", w/2, 30, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined("If there are multiple winners, the reward is shared evenly! The lottery is also cross-server", "moat_ItemDesc", w/2, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))

        local datime = os.date("!*t", (os.time() - 21600))

        if (datime.hour == 0) then datime.hour = 24 end
        
        local hr = 24 - datime.hour 
        if (hr < 10) then
            hr = "0" .. hr
        end

        local min = 60 - datime.min
        if (min < 10) then
            min = "0" .. min
        end

        local sec = 60 - datime.sec
        if (sec < 10) then
            sec = "0" .. sec
        end

        local timestring = hr .. ":" .. min .. ":" .. sec

        -- Time Left
        if (GetGlobal("moat_bounties_refresh_next")) then
            draw.SimpleTextOutlined("Will be determined on Map Change!", "DermaLarge", w/2, 90, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        else
            draw.SimpleTextOutlined("Time Until Draw: " .. timestring, "DermaLarge", w/2, 90, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        end
        draw.SimpleTextOutlined("Lottery Pot is currently:", "DermaLarge", w/2, 130, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined((string.Comma(lottery.amount or 10000)) .. " IC", "moat_JackBig", w/2, 175, Color(255, 255, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

        draw.SimpleTextOutlined("There are " .. (lottery.players or 0) .. " players in the lottery!", "MinnLottery", w/2, 220, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

        draw.SimpleTextOutlined("The most popular number is " .. (lottery.popular_num or 1) .. ", which has " .. (lottery.popular_ply or 0) .. " players", "MinnLottery", w/2, 250, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

        draw.SimpleTextOutlined("The last lottery number was " .. (lottery.last_num or 1), "MinnLottery", w/2, 280, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

        if lottery.mine then
            draw.SimpleTextOutlined("Your number is " .. lottery.mine .. ", good luck!", "moat_JackBig", w/2, 330, Color(0, 255, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        else
            draw.SimpleTextOutlined("You are not in the current lottery, you can purchase a ticket below!", "MinnLottery", w/2, 330, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        end
        
    end

    local but = vgui.Create("DButton",MOAT_LOTTERY)
    but:SetSize(718,70)
    but:SetPos(10,379)
    but:SetText("")
    but:SetFont("DermaLarge")
    but.Label = ((lottery.mine and "Change ticket number for 1,000 IC" or "Purchase lottery ticket for 1,000 IC"))
    MOAT_FORUMS.ButtonPaint(but, {51, 153, 255})
    function but.DoClick()
        if MOAT_INVENTORY_CREDITS < 1000 then chat.AddText(Color(255,0,0),"You do not have enough IC!") surface.PlaySound("/resource/warning.wav") return end
        Derma_StringRequest("Please input a number", "Please select a number for your lottery ticket\n(Must be between 1 and 200)", "100", function(i)
            i = tonumber(i)
			if (not i) then return end
            if i < 1 or i > 200 then chat.AddText(Color(255,0,0),"The number must be between 1 and 200!") surface.PlaySound("/resource/warning.wav") return end
            net.Start("lottery.Purchase")
            net.WriteInt(i,32)
            net.SendToServer()
			sfx.Agree()
        end)
    end
	sfx.SoundEffects(but)
	
end

function m_RemoveLotteryPanel()
    if not IsValid(MOAT_LOTTERY) then return end
    MOAT_LOTTERY:Remove()
end

function m_RemoveContractsPanel()
    if not IsValid(MOAT_CONTRACTS) then return end
    MOAT_CONTRACTS:Remove()
end

contracts_tbl = {
    active = false,
    name = "Rightful slayer",
    desc = "Eliminate as many terrorists as you can, rightfully.",
    adj = "Kills",
	short = "Kills",
	others = 2024,
    players = {}
}

net.Receive("moat.contractinfo",function()
    contracts_tbl.active = true
    contracts_tbl.name = net.ReadString()
    contracts_tbl.desc = net.ReadString()
    contracts_tbl.adj = net.ReadString()
end)

local function getreward(place)
    if place == 1 then 
        return true,10000,"Event Credit + Ascended Item", HSVToColor(CurTime() * 50 % 360, 1, 1)
    elseif place < 6 then
        return true, math.Round((51 - place) * 200),"Ascended Item", Color(255,255,0)
    elseif place < 11 then
        return true,math.Round((51 - place) * 200),"High End Item",Color(255,0,0)
    else
        return false,math.Round((51 - place) * 200)
    end
end
 
local contract_cache = contracts_tbl
net.Receive("moat.contracts",function()
	if (net.ReadBool()) then
		contracts_tbl.active = true
		contracts_tbl.name = net.ReadString()
		contracts_tbl.desc = net.ReadString()
		contracts_tbl.adj = net.ReadString()
		contracts_tbl.short = net.ReadString()
	end

	contracts_tbl.others = net.ReadUInt(16)
    contracts_tbl.my_rank = net.ReadUInt(16)
	contracts_tbl.my_score = net.ReadUInt(16)

	if (net.ReadBool()) then
		local p = net.ReadTable()
		contracts_tbl.players = {}
		for k,v in pairs(p) do
			table.insert(contracts_tbl.players,{v.steamid,"Loading name..",v.score})
		end
	end

	if (contracts_tbl.my_rank > 50) then
		timer.Simple(0, function()
			local old_rank, old_score = cookie.GetNumber("moat_constants_rank", 0), cookie.GetNumber("moat_constants_score", 0)
			if (tonumber(contracts_tbl.my_rank) ~= old_rank or contracts_tbl.my_score ~= old_score) then
				cookie.Set("moat_constants_rank", contracts_tbl.my_rank)
				cookie.Set("moat_constants_score", contracts_tbl.my_score)

				local datime = os.date("!*t", (os.time() - 21600))
				if (datime.hour == 0) then datime.hour = 24 end
				local unix = ((24 - datime.hour) * 3600) + ((60 - datime.min) * 60) + (60 - datime.sec)

				local clr, arrow, diff = moat_green, [[↓]], "(-"..old_rank - contracts_tbl.my_rank..")"
				if (contracts_tbl.my_rank > old_rank) then
					diff = "(+"..contracts_tbl.my_rank - old_rank..")"
					clr, arrow = moat_red, [[↑]]
				elseif (contracts_tbl.my_rank == old_rank) then
					arrow, diff = "", ""
				end

				chat.AddText(moat_blue, "| ", moat_yellow, "Daily Contract", moat_blue, " | ", moat_cyan, contracts_tbl.name, moat_blue, " | ", moat_green, util.Upper(util.FormatTimeSingle(unix, 0)) .. " Left")
				if (contracts_tbl.my_score < 1) then
					chat.AddText(moat_blue, "| ", moat_red, "You need a contract kill for a rank placing", moat_blue, " | ", moat_pink, "Top 50 Players get rewards!")
				else
					chat.AddText(moat_blue, "| ", moat_white, "You are now ",
						clr, arrow, moat_pink, "Rank " .. string.Comma(contracts_tbl.my_rank), clr, arrow, 
						moat_blue, " | ", moat_red, string.Comma(contracts_tbl.my_score) .. " Kill" .. (contracts_tbl.my_score == 1 and "" or "s"))
				end
			end
		end)
	else
		timer.Simple(0, function()
			local old_rank, old_score = cookie.GetNumber("moat_constants_rank", 0), cookie.GetNumber("moat_constants_score", 0)
			if (tonumber(contracts_tbl.my_rank) == old_rank and tonumber(contracts_tbl.my_score) == old_score) then
				return
			end

			cookie.Set("moat_constants_rank", contracts_tbl.my_rank)
			cookie.Set("moat_constants_score", contracts_tbl.my_score)

			local datime = os.date("!*t", (os.time() - 21600))
			if (datime.hour == 0) then datime.hour = 24 end
			local unix = ((24 - datime.hour) * 3600) + ((60 - datime.min) * 60) + (60 - datime.sec)

			local clr, arrow, diff = moat_green, [[↓]], "(-"..old_rank - contracts_tbl.my_rank..")"
			if (contracts_tbl.my_rank > old_rank) then
				diff = "(+"..contracts_tbl.my_rank - old_rank..")"
				clr, arrow = moat_red, [[↑]]
			elseif (contracts_tbl.my_rank == old_rank) then
				arrow, diff = "", ""
			end

			local nextupid = 1
			local nextup = contracts_tbl.players[contracts_tbl.my_rank - nextupid]
			if (nextup and nextup[3]) then
				while (nextup and nextup[3] and nextup[3] == contracts_tbl.my_score) do
					if (not contracts_tbl.players[contracts_tbl.my_rank - nextupid]) then
						nextup = contracts_tbl.players[contracts_tbl.my_rank - nextupid + 1]
						break
					end
				
					nextupid = nextupid + 1
					nextup = contracts_tbl.players[contracts_tbl.my_rank - nextupid]
				end

				if (not nextup or not nextup[3]) then
					return
				end

				nextup = math.max(1, nextup[3] - contracts_tbl.my_score)
			end

			local behind = contracts_tbl.players[contracts_tbl.my_rank + 1]
			if (behind and behind[3]) then
				behind = contracts_tbl.my_score - behind[3]
			end

			local msg = {
				moat_blue, "| ", moat_yellow, contracts_tbl.short .. " Contract", moat_blue, " | ", 
				moat_green, util.Upper(util.FormatTimeSingle(unix, 0)) .. " Left", moat_blue, " | ", 
				clr, arrow, moat_pink, "Rank " .. string.Comma(contracts_tbl.my_rank), clr, arrow, moat_blue, " | ", 
				moat_red, contracts_tbl.my_score .. " Kill" .. (contracts_tbl.my_score == 1 and "" or "s"), moat_blue, " | ", 
				moat_cyan, nextup and (nextup .. " Kill" .. (nextup == 1 and "" or "s") .. " for Rank " .. string.Comma(math.max(1, contracts_tbl.my_rank - 1))) or "Relax"/*, moat_blue, " | ", 
				behind and (behind .. " Ahead") or "Go Faster"*/
			}

			chat.AddText(unpack(msg))
		end)
	end
end)

local clr = HSVToColor(math.random(1,200) * 1000 % 360, 1, 1)
clr.a = 50
local function makeplayer(pnl,lp,steamid,name,score,place)
    if not lp then
        steamworks.RequestPlayerInfo(steamid, function()
            name = steamworks.GetPlayerName(steamid)
        end)
    end
    function pnl:Paint(w,h)
        if lp then
            local r = (contracts_tbl.my_rank or "???")
            local s = (contracts_tbl.my_score or 0)
            if s == 0 then r = "???" end
            draw.DrawText(r .. ".", "moat_ItemDesc", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
            local n = LocalPlayer():Nick()
            draw.DrawText(n, "moat_ItemDesc", 76, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
            draw.DrawText(s .. " " .. contracts_tbl.adj, "moat_ItemDesc", w/2, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
            if r == "???" then return end
            local f,ic,special,color = getreward(r)
            if ic < 0 then return end
            surface.SetFont("moat_ItemDesc")
            if not f then
                local tw, th = surface.GetTextSize(" IC")
                draw.DrawText(" IC", "moat_ItemDesc", w-6, 0, Color( 255, 255, 0, 255 ), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                draw.DrawText(string.Comma(ic), "moat_ItemDesc", w - tw-6, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
            else
                local tw, th = surface.GetTextSize(" " .. special)
                draw.DrawText(special,"moat_ItemDesc", w-6, 0, color, TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                draw.DrawText("+","moat_ItemDesc", w - tw-6, 0, Color(255,255,255), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                tw, th = surface.GetTextSize(" + " .. special)
                draw.DrawText("IC","moat_ItemDesc", w - tw-6, 0, Color(255,255,0), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                tw, th = surface.GetTextSize(" IC + " .. special)
                draw.DrawText(string.Comma(ic),"moat_ItemDesc", w - tw-6, 0, Color(255,255,255), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
            end
        else
            local r = place
            draw.DrawText(r .. ".", "moat_ItemDesc", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
            local n = name
            draw.DrawText(n, "moat_ItemDesc", 46, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
            local s = score
            draw.DrawText(s .. " " .. contracts_tbl.adj, "moat_ItemDesc", w/2, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
            local f,ic,special,color = getreward(r)
            surface.SetFont("moat_ItemDesc")
            if not f then
                local tw, th = surface.GetTextSize(" IC")
                draw.DrawText(" IC", "moat_ItemDesc", w-5, 0, Color( 255, 255, 0, 255 ), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                draw.DrawText(string.Comma(ic), "moat_ItemDesc", w - tw-5, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
            else
                local tw, th = surface.GetTextSize(" " .. special)
                draw.DrawText(special,"moat_ItemDesc", w-5, 0, color, TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                draw.DrawText("+","moat_ItemDesc", w - tw-5, 0, Color(255,255,255), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                tw, th = surface.GetTextSize(" + " .. special)
                draw.DrawText("IC","moat_ItemDesc", w - tw-5, 0, Color(255,255,0), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
                tw, th = surface.GetTextSize(" IC + " .. special)
                draw.DrawText(string.Comma(ic),"moat_ItemDesc", w - tw-5, 0, Color(255,255,255), TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
            end
        end
    end
    local av = vgui.Create("AvatarImage",pnl)
    av:SetPos(25, 0)
    if lp then
        av:SetPos(55,0)
    end
    av:SetSize(17,17)
    if lp then
        av:SetPlayer(LocalPlayer(), 32)
        av:SetToolTip(LocalPlayer():Nick())
    else
        av:SetToolTip(name)
        av:SetSteamID(steamid, 32)
    end
end
function m_MakeContractsPanel()
    MOAT_CONTRACTS = vgui.Create("DPanel", MOAT_CHALL_BG)
	MOAT_CONTRACTS:SetPos(1, 50)
	MOAT_CONTRACTS:SetSize(738, 463)
    MOAT_CONTRACTS.Paint = function(s, w, h)
        clr.a = 50
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))

        HSVColor = HSVToColor(CurTime() * 50 % 360, 1, 1)

        if (not contracts_tbl.active) then
            draw.SimpleTextOutlined("Please wait while contracts are loading...", "DermaLarge", w/2, h/2, HSVColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

            return
        end

        -- Header
        --draw.SimpleTextOutlined("Daily Bounties", "DermaLarge", w/2, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        --draw.RoundedBox(0, (w/2) - ((w/3)/2), 35 + 20, w/3, 1, HSVColor)

        -- Description
        draw.SimpleTextOutlined("This is the daily contracts menu. Each day you compete for a high score for rewards", "moat_ItemDesc", w/2, 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined("Only people in the top 50 get rewards though!", "moat_ItemDesc", w/2, 30, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined("Contracts refresh every day, and require 8 players on your server for the kills to count.", "moat_ItemDesc", w/2, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))

        local datime = os.date("!*t", (os.time() - 21600))

        if (datime.hour == 0) then datime.hour = 24 end
        
        local hr = 24 - datime.hour 
        if (hr < 10) then
            hr = "0" .. hr
        end

        local min = 60 - datime.min
        if (min < 10) then
            min = "0" .. min
        end

        local sec = 60 - datime.sec
        if (sec < 10) then
            sec = "0" .. sec
        end

        local timestring = hr .. ":" .. min .. ":" .. sec

        -- Time Left
        if (GetGlobal("moat_bounties_refresh_next")) then
            draw.SimpleTextOutlined("Will be Refreshed on Map Change!", "DermaLarge", w/2, 90, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        else
            draw.SimpleTextOutlined("Time Left: " .. timestring, "DermaLarge", w/2, 90, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        end

        -- First Bounty
        surface.SetDrawColor(clr)
        surface.DrawOutlinedRect(10, bounties_y, w-20, 330)
        draw.RoundedBox(0, 10, bounties_y, w-20, 330, Color(0, 0, 0, 100))

        surface.SetDrawColor(clr)
        surface.DrawOutlinedRect(10, bounties_y, w-20, 330)
        draw.RoundedBox(0, 10, bounties_y, w-20, 330, Color(0, 0, 0, 100))

        surface.SetDrawColor(175, 175, 175, 50)
        surface.DrawOutlinedRect(10, bounties_y, w-20, 330)

        surface.DrawLine(15, bounties_y + 5, w-15, bounties_y + 5)
        surface.DrawLine(15, bounties_y + 34, w-15, bounties_y + 34)
        surface.DrawLine(15, bounties_y + 54, w-15, bounties_y + 54)
        surface.DrawLine(15, bounties_y + 80, w-15, bounties_y + 80)

        draw.RoundedBox(0, 10, bounties_y, w-20,330, Color(0, 0, 0, 100))

        clr.a = 100
        surface.SetDrawColor(clr)
        surface.SetMaterial(gradient_r)
        surface.DrawTexturedRect(gradient_rtbl.x, gradient_rtbl.y, gradient_rtbl.w, gradient_rtbl.h)
        surface.SetMaterial(gradient_l)
        surface.DrawTexturedRect(gradient_rtbl.x + gradient_rtbl.w, gradient_rtbl.y, gradient_rtbl.w, gradient_rtbl.h)

        m_DrawShadowedText(1, contracts_tbl.name, "GModNotify", w/2, gradient_rtbl.y + 9, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        draw.SimpleText(contracts_tbl.desc, "moat_ItemDesc", w/2, gradient_rtbl.y + 27, Color(255,255,255),TEXT_ALIGN_CENTER)

        --draw.SimpleTextOutlined("Rewards:", "moat_ItemDesc", 15, gradient_rtbl.y + 47, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))
        --draw.SimpleTextOutlined("aaabbcc", "moat_ItemDesc", 75, gradient_rtbl.y + 47, Color(255, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))


        --draw.RoundedBox(0, 15 + 1, gradient_rtbl.y + 64 + 15 + 1, w - 30, 5, Color(0, 0, 0, 200))
        --draw.RoundedBox(0, 15, gradient_rtbl.y + 64 + 15, w - 30, 5, Color(40, 255, 40, 25))
        --draw.RoundedBox(0, 15, gradient_rtbl.y + 64 + 15, (w - 30) * progress_width, 5, Color(40, 255, 40, 25))

        --surface.SetDrawColor(40, 255, 40)
        --surface.SetMaterial(gradient_r)
        --surface.DrawTexturedRect(15, gradient_rtbl.y + 64 + 15, (w - 30) * progress_width + 1, 5)
    end
    local mine = vgui.Create("DPanel",MOAT_CONTRACTS)
    mine:SetSize(708,17)
    mine:SetPos(16,180)
    makeplayer(mine,true)

    local list = vgui.Create("DScrollPanel",MOAT_CONTRACTS)
    list:SetSize(708,240)
    list:SetPos(16,205)
    list:GetVBar():SetWide(6)
    for k,v in pairs(contracts_tbl.players) do
        local mine = vgui.Create("DPanel",list)
        mine:SetSize(708,17)
        mine:DockMargin(0, 0, 0, 5)
        mine:Dock(TOP)
        makeplayer(mine,false,v[1],v[2],v[3],k)
    end
end


function m_RemoveBountiesPanel()
    MOAT_BOUNTY:Remove()
end
-- 111
-- dock top 10
-- 10 each side
local colors = {
    {Color(175, 175, 175, 50), Color(175, 175, 175, 50), Color(200, 200, 200, 100)},
    {Color(175, 175, 175, 50), Color(255, 50, 255, 50), Color(200, 50, 255, 100)},
    {Color(0, 255, 0, 50), Color(175, 175, 175, 50), Color(0, 200, 0, 100)}
}

function m_MakeBountiesPanel()
    MOAT_BOUNTY = vgui.Create("DScrollPanel", MOAT_CHALL_BG)
	MOAT_BOUNTY:SetPos(1, 50)
	MOAT_BOUNTY:SetSize(738, 463)
    MOAT_BOUNTY.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
    end
    local top = vgui.Create("DPanel",MOAT_BOUNTY)
    top:SetSize(0,111)
    top:Dock(TOP)
    function top:Paint(w,h)

        if (#bounty_tbl < 3) then
            draw.SimpleTextOutlined("Please wait while bounties are loading...", "DermaLarge", w/2, h/2, HSVColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

            return
        end

        -- Header
        --draw.SimpleTextOutlined("Daily Bounties", "DermaLarge", w/2, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        --draw.RoundedBox(0, (w/2) - ((w/3)/2), 35 + 20, w/3, 1, HSVColor)

        -- Description
        draw.SimpleTextOutlined("This is the daily bounty menu. Each day you can complete up to 12 bounties for rewards.", "moat_ItemDesc", w/2, 30, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined("All bounties are refreshed when a new day starts, and require 4 players to be active.", "moat_ItemDesc", w/2, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 35))

        local datime = os.date("!*t", (os.time() - 21600))

        if (datime.hour == 0) then datime.hour = 24 end
        
        local hr = 24 - datime.hour 
        if (hr < 10) then
            hr = "0" .. hr
        end

        local min = 60 - datime.min
        if (min < 10) then
            min = "0" .. min
        end

        local sec = 60 - datime.sec
        if (sec < 10) then
            sec = "0" .. sec
        end

        local timestring = hr .. ":" .. min .. ":" .. sec

        -- Time Left
        if (GetGlobal("moat_bounties_refresh_next")) then
            draw.SimpleTextOutlined("Will be Refreshed on Map Change!", "DermaLarge", w/2, 90, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        else
            draw.SimpleTextOutlined("Time Left: " .. timestring, "DermaLarge", w/2, 90, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        end
    end

    for k,v in pairs(bounty_tbl) do
        local a = vgui.Create("DPanel",MOAT_BOUNTY)
        a:SetSize(0,100)
        a:DockMargin(10,10,10,0)
        a:Dock(TOP)
        function a:Paint(w,h)
            surface.SetDrawColor(colors[v.tier][1])
            surface.DrawOutlinedRect(0, 0, w, 100)
            draw.RoundedBox(0, 0, 0, w, 100, Color(0, 0, 0, 100))

            surface.SetDrawColor(colors[v.tier][2])
            surface.DrawOutlinedRect(0, 0, w, 100)
            draw.RoundedBox(0, 0, 0, w, 100, Color(0, 0, 0, 100))


            surface.SetDrawColor(colors[v.tier][1])
            surface.DrawOutlinedRect(0, 0, w, 100)

            surface.DrawLine(5, 5, w-5, 5)
            surface.DrawLine(5, 34, w-5, 34)
            surface.DrawLine(5, 54, w-5, 54)

            draw.RoundedBox(0, 0, 0, w, 100, Color(0, 0, 0, 100))


            surface.SetDrawColor(colors[v.tier][3])
            surface.SetMaterial(gradient_r)
            surface.DrawTexturedRect(gradient_ttbl.x, gradient_ttbl.y, gradient_ttbl.w, gradient_ttbl.h)
            surface.SetMaterial(gradient_l)
            surface.DrawTexturedRect(gradient_ttbl.x + gradient_ttbl.w, gradient_ttbl.y, gradient_ttbl.w, gradient_ttbl.h)

            m_DrawShadowedText(1, v.name, "GModNotify", w/2, gradient_ttbl.y + 9, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            
            m_DrawBountyDesc(v.desc, "moat_ItemDesc", 6, gradient_ttbl.y + 27, w - 32)

            draw.SimpleTextOutlined("Rewards:", "moat_ItemDesc", 5, gradient_ttbl.y + 47, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))
            draw.SimpleTextOutlined(v.rewards, "moat_ItemDesc", 65, gradient_ttbl.y + 47, Color(255, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))

            local progress_width = math.Round(v.progress_cur/v.progress_max, 2)

            draw.SimpleTextOutlined("Progress: " .. v.progress_cur .. "/" .. v.progress_max, "moat_ItemDesc", 5, gradient_ttbl.y + 62, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))

            if (progress_width == 1) then
                draw.SimpleTextOutlined("Fully Completed! Nice work!", "moat_ItemDesc", w - 5, gradient_ttbl.y + 62, Color(0, 255, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))
            else
                draw.SimpleTextOutlined(progress_width * 100 .. "% Completed", "moat_ItemDesc", w - 5, gradient_ttbl.y + 62, Color(0, 255, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 35))
            end


            draw.RoundedBox(0, 5 + 1, gradient_ttbl.y + 64 + 15 + 1, w - 30, 5, Color(0, 0, 0, 200))
            draw.RoundedBox(0, 5, gradient_ttbl.y + 64 + 15, w - 10, 5, Color(40, 255, 40, 25))
            draw.RoundedBox(0, 5, gradient_ttbl.y + 64 + 15, (w - 10) * progress_width, 5, Color(40, 255, 40, 25))

            surface.SetDrawColor(40, 255, 40)
            surface.SetMaterial(gradient_r)
            surface.DrawTexturedRect(5, gradient_ttbl.y + 64 + 15, (w - 10) * progress_width + 1, 5)
        end
    end

    local a = vgui.Create("DPanel",MOAT_BOUNTY)
    a:SetSize(0,10)
    function a:Paint() end
    a:Dock(TOP) -- stupid padding

end

function m_PopulateBountiesPanel(pnl)
	if (IsValid(MOAT_CHALL_BG)) then return end
	MOAT_CHALL.LocalChat = true
	MOAT_CHALL.CurCat = 1
	MOAT_CHALL.TitlePoly = {
		{x = 1, y = 1},
		{x = 0, y = 1},
		{x = 30, y = 45},
		{x = 1, y = 45}
	}
    pnl_h,pnl_w = pnl:GetTall(),pnl:GetWide()
    pnl_x,pnl_y = 0,0 
    MOAT_CHALL_BG = vgui.Create("DPanel",pnl)
    MOAT_CHALL_BG:SetSize(pnl_w,pnl_h)
    MOAT_CHALL_BG:SetPos(pnl_x, pnl_y)
    --MOAT_CHALL_BG:MakePopup()
   -- MOAT_CHALL_BG:SetKeyboardInputEnabled(false)
    --MOAT_CHALL_BG:SetDraggable(false)
   -- --MOAT_CHALL_BG:ShowCloseButton(false)
   -- MOAT_CHALL_BG:SetTitle("")
   -- MOAT_CHALL_BG:SetAlpha(0)
    MOAT_CHALL_BG.Paint = function(s, w, h)
    	--draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 255))
    	
    	--[[Header Stuff]]--
    	draw.RoundedBox(0, 0, 0, w, 45, Color(56, 56, 56, 255))
    	draw.RoundedBox(0, 0, 45, w, 1, Color(86, 86, 86, 255))

    	MOAT_CHALL.TitlePoly[2].x = Lerp(FrameTime() * 10, MOAT_CHALL.TitlePoly[2].x, 140)
    	MOAT_CHALL.TitlePoly[3].x = Lerp(FrameTime() * 10, MOAT_CHALL.TitlePoly[3].x, 170)

    	surface.SetDrawColor(46, 46, 46)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_CHALL.TitlePoly)

    	surface.SetDrawColor(15, 15, 15, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(0, 0, w, 45)

    	local w2, h2 = draw.SimpleText("Moat", "moat_GambleTitle", 5, 1, Color(0, 25, 50))
    	draw.SimpleText(" Gaming", "moat_GambleTitle", 5 + w2, 1, Color(50, 50, 50))

    	draw.SimpleText("Moat", "moat_GambleTitle", 4, 0, Color(0, 198, 255))
    	draw.SimpleText(" Gaming", "moat_GambleTitle", 4 + w2, 0, Color(255, 255, 255))

    	draw.SimpleText("Daily Challenges", "moat_GambleTitle", 6, 21, Color(50, 50, 0))
    	draw.SimpleText("Daily Challenges", "moat_GambleTitle", 5, 20, Color(255, 255, 0))

    	draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 194, 6, Color(0, 0, 0))
    	draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 193, 5, Color(255, 255, 255))

    	draw.SimpleText("IC: " .. string.Comma(MOAT_INVENTORY_CREDITS), "moat_ItemDesc", 208, 27, Color(0, 0, 0))
        draw.SimpleText("IC: " .. string.Comma(MOAT_INVENTORY_CREDITS), "moat_ItemDesc", 207, 26, Color(255, 255, 255))
        surface.SetMaterial(mat_coins)
        surface.SetDrawColor(Color(255, 255, 255))
        surface.DrawTexturedRect(185, 26, 16, 16)


        --[[Chat Stuff]]--
    	--draw.RoundedBox(0, 1, 46, 225, h-46, Color(25, 25, 25))
    	//draw.RoundedBox(0, 1, 46, 225, 25, Color(45, 45, 45))
    	--surface.SetDrawColor(86, 86, 86)
    	//surface.DrawLine(1, 46+25, 225, 46+25)
    	//surface.DrawLine(225, 46, 225, 46+25)

    	//draw.SimpleText("Chat Lounge", "moat_ItemDesc", 1+113, 59, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    	--draw.RoundedBox(4, 6, h-51, 215, 45, Color(86, 86, 86))
    	--draw.RoundedBox(4, 7, h-50, 213, 43, Color(20, 20, 20))

    	--surface.SetDrawColor(86, 86, 86)
    	--surface.DrawOutlinedRect(0, 0, w, h)
    end

    local MOAT_CHALL_AVA = vgui.Create("AvatarImage", MOAT_CHALL_BG)
    MOAT_CHALL_AVA:SetPos(170, 4)
    MOAT_CHALL_AVA:SetSize(17, 17)
    MOAT_CHALL_AVA:SetPlayer(LocalPlayer(), 32)

    local MOAT_CHALL_CATS = {{"Bounties", Color(150, 0, 255)}, {"Contracts", Color(255, 0, 50)}, {"Lottery", Color(0, 255, 50)}, {"Rewards", Color(255, 255, 50)} }
    local CAT_WIDTHS = 0

    for i = 1, #MOAT_CHALL_CATS do
    	local MOAT_CHALL_CAT_BTN = vgui.Create("DButton", MOAT_CHALL_BG)
    	MOAT_CHALL_CAT_BTN:SetSize(81, 30)
    	MOAT_CHALL_CAT_BTN:SetPos(320 + CAT_WIDTHS, 15)
    	MOAT_CHALL_CAT_BTN:SetText("")
    	MOAT_CHALL_CAT_BTN.HoveredNum = 0
        MOAT_CHALL_CAT_BTN.Paint = function(s, w, h)
            local col = MOAT_CHALL_CATS[i][2]

            surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(0, h - (h * s.HoveredNum), w, h * s.HoveredNum)

            draw.SimpleTextOutlined(MOAT_CHALL_CATS[i][1], "GModNotify", w/2, (h/2)-(s.HoveredNum*4), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))

            if (MOAT_CHALL.CurCat == i) then
                draw.RoundedBox(0, 0, h-4, w, 4, MOAT_CHALL_CATS[i][2])
                surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
                surface.SetMaterial(gradient_d)
                surface.DrawTexturedRect(0, 0, w, h)
            elseif (s:IsHovered()) then
                s.HoveredNum = Lerp(10 * FrameTime(), s.HoveredNum, 1)
            elseif (not s:IsHovered()) then
                s.HoveredNum = Lerp(10 * FrameTime(), s.HoveredNum, 0)
            end

            draw.RoundedBox(0, 0, h - (4 * s.HoveredNum), w, 4 * s.HoveredNum, MOAT_CHALL_CATS[i][2])
        end
    	
        MOAT_CHALL_CAT_BTN.DoClick = function(s)
        	if (i == MOAT_CHALL.CurCat) then return end
            MOAT_CHALL.CurCat = i

            if (i == 1) then
                m_MakeBountiesPanel()
            else
                m_RemoveBountiesPanel()
            end

            if (i == 2 ) then
                m_MakeContractsPanel()
            else
                m_RemoveContractsPanel()
            end

            if (i == 3) then
                m_MakeLotteryPanel()
            else
                m_RemoveLotteryPanel()
            end

            if (i == 4) then
                MOAT_INV_BG:Remove()
                RunConsoleCommand("say", "!rewards")
            end
        end

		sfx.SoundEffects(MOAT_CHALL_CAT_BTN)
        CAT_WIDTHS = CAT_WIDTHS + 83
    end

    m_MakeBountiesPanel()
    MOAT_CHALL.CurCat = 1

    MOAT_CHALL_BG:AlphaTo(255, 0.15, 0.15)
end


local chat_icons = {
    Material("icon16/medal_bronze_3.png"),
    Material("icon16/medal_silver_3.png"),
    Material("icon16/medal_gold_3.png"),
    Material("icon16/information.png")
}

net.Receive("moat_bounty_chat", function()
    local tier = net.ReadUInt(4)
    local str = net.ReadString()

    chat.AddText(chat_icons[tier], Color(255, 255, 0), "[", Color(0, 255, 255), "M", Color(255, 255, 255), "G ", Color(255, 255, 0), "Bounties", Color(255, 255, 0), "] ", chat_color_tiers[tier], str)
end)

net.Receive("moat.contracts.chat",function()
    local str = net.ReadString()
    chat.AddText(chat_icons[3], Color(255, 255, 0), "[", Color(0, 255, 255), "M", Color(255, 255, 255), "G ", Color(255, 255, 0), "Contracts", Color(255, 255, 0), "] ", Color(255,255,255), str)
    
end)

-- hook("InitPostEntity", function()
--     net.Start "bounty.refresh"
--     net.SendToServer()
-- end)