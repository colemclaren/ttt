surface.CreateFont("moat_NotifyTest2", {
    font = "GModNotify",
    size = 32,
    weight = 800
})

surface.CreateFont("moat_NotifyTestBonus", {
    font = "GModNotify",
    size = 26,
    weight = 800
})

for i = 1, 10 do
    surface.CreateFont("moat_Derma" .. i, {
        font = "DermaLarge",
        size = 16 + i,
        weight = 700
    })
end

-- ahh
local circ_gradient = Material("moat_inv/moat_circle_grad.png")
local gradient_u = Material("vgui/gradient-u")
local gradient_d = Material("vgui/gradient-d")
local gradient_r = Material("vgui/gradient-r")
local gradient_l = Material("vgui/gradient-l")
local heart_icon = Material("icon16/heart.png")
MOAT_DONATE = MOAT_DONATE or {}
MOAT_DONATE.FrameW = 800
MOAT_DONATE.FrameH = 400
MOAT_DONATE.BackgroundURL = "https://static.moat.gg/f/7b41d8391eef24d3cba3e36063f91b2a.png"

MOAT_DONATE.TitlePoly = {
    {
        x = 1,
        y = 1
    },
    {
        x = 140,
        y = 1
    },
    {
        x = 170,
        y = 45
    },
    {
        x = 1,
        y = 45
    }
}
-- Every player will receive a Holiday Crate when this item is used
MOAT_DONATE.CurCat = 0
MOAT_DONATE.Packages = {
	{"General Information", Material("icon16/information.png"), 1, 0, ""}, 
	{"Free Rewards", Material("icon16/star.png"), 0, 0, ""}, 
	{"Permanent VIP", Material("icon16/user.png"), 2, 1500, "", {{Color(255, 255, 0), "17,000", "Total Inventory Credits", ""}, {Color(255, 255, 0), "", "Earn 50% more IC when Deconstructing Items	", ""}, {Color(255, 255, 255), "VIP", "Rank In-Game & Forums", ""}, {Color(255, 255, 255), "", "Votekick Starting Access (Revokable)", ""}, {Color(255, 255, 255), "", "Access to closed beta(s)", ""}, {Color(255, 0, 0), "", "+ Whatever is Added to VIP in the Future!", ""}, {Color(255, 0, 125), "", "", ""}}}, 
	{"4,000 IC", Material("icon16/coins.png"), 3, 400, "", {{Color(255, 255, 0), "4,000", "Total Inventory Credits", ""}, {Color(255, 0, 125), "", "", ""}}},
	{"10,000 IC", Material("icon16/coins.png"), 4, 1000, "", {{Color(255, 255, 0), "10,000", "Total Inventory Credits", ""}, {Color(255, 0, 255), "15", "Random Crates from the Market", ""}, {Color(255, 0, 0), "[LIMITED TIME]", "1 Independence Crate!", ""}, {Color(255, 0, 125), "", "", ""}}},
	{"25,000 IC", Material("icon16/coins.png"), 5, 2500, "3,000 Bonus", {{Color(255, 255, 0), "28,000", "Total Inventory Credits", ""}, {Color(0, 125, 255), "1", "Event Credit", ""}, {Color(255, 205, 0), "1", "Ascended Talent Mutator", ""}, {Color(255, 0, 0), "[LIMITED TIME]", "2 Independence Crates!", ""}, {Color(255, 0, 125), "", "", ""}}}, 
	{"40,000 IC", Material("icon16/coins.png"), 6, 4000, "10,000 Bonus", {{Color(255, 255, 0), "50,000", "Total Inventory Credits", ""}, {Color(0, 125, 255), "3", "Event Credits", ""}, {Color(255, 125, 0), "1", "Name Mutator", ""}, {Color(255, 205, 0), "1", "Ascended Stat Mutator", ""}, {Color(255, 0, 0), "[LIMITED TIME]", "6 Independence Crates!", ""}, {Color(255, 0, 125), "", "", ""}}}, 
	{"100,000 IC", Material("icon16/coins.png"), 7, 10000, "35,000 Bonus", {{Color(255, 255, 0), "135,000", "Total Inventory Credits", ""}, {Color(0, 125, 255), "7", "Event Credits", ""}, {Color(255, 125, 0), "2", "Name Mutators", ""}, {Color(255, 205, 0), "1", "Ascended Talent Mutator", ""}, {Color(0, 255, 0), "1", "Cosmic Stat Mutator", ""}, {Color(255, 0, 0), "[LIMITED TIME]", "15 Independence Crates!", ""}, {Color(255, 0, 125), "", "", ""}}},
	{"Dola Drop Event", Material("icon16/heart.png"), 8, 3750, "", {{Color(0, 255, 0), "", "Server Dola Effect Drop", ""}, {Color(255, 125, 0), "", "Every player will receive the Dola Effect Item", ""}, {Color(255, 0, 125), "", "Drops for everybody on the server!", ""}, {Color(255, 255, 0), "", "(this is tradable)", ""}}},
	{"+300% XP Event", Material("icon16/heart.png"), 9, 250, "", {{Color(0, 255, 0), "", "Server +300% XP Event", ""}, {Color(255, 125, 0), "", "Every player earns +300% more Boosted XP", ""}, {Color(255, 0, 125), "", "Boosts XP for 120 rounds!", ""}, {Color(255, 255, 0), "", "(this is stackable)", ""}}},{"Vape Drop Event", Material("icon16/heart.png"), 10, 4420, "", {{Color(0, 255, 0), "", "Server Random Vape Drop", ""}, {Color(255, 125, 0), "", "Every player will receive a Random Vape Item", ""}, {Color(255, 0, 125), "", "Drops for everybody on the server!", ""}, {Color(255, 255, 0), "", "(this is tradable)", ""}}}} --{"30 Day Star Player", Material("icon16/user_green.png"), 2000, "Stuff"}, ??? --{"1 Year Star Player", Material("icon16/user_red.png"), 20000, "Stuff"}, ??? -- MAke sure you don't take event out of name cause it's used to check if its a map event
MOAT_SUPPORT_CREDITS = 5000
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

function MOAT_DONATE:DrawInfo(pnl, pkg, clr)
    pnl.Paint = function(s, w, h)
        local txtw = draw.SimpleText("Welcome to the Supporter Shop!", "moat_NotifyTest2", w / 2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 10)
        surface.DrawRect(0, 0, w, 45)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 35)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, 0, w, 45)
        surface.DrawOutlinedRect(0, 0, w, 45)
        cdn.DrawImage("https://ttt.dev/4uKQJ.png", (w / 2) - (235 / 2), 30, 256, 256, Color(255, 255, 255, 225))
    end

    local lbl = vgui.Create("DLabel", pnl)
    lbl:SetPos(10, 145)
    lbl:SetText("Here at the supporter shop, you can redeem Support Credits for supporting the community and automatically receive your rewards!\n\nClick any of the packages on the left to view your available rewards.\n\nYou can click the button at the top right of this menu to purchase support credits. Every contribution is greatly appreciated!\n\nDid something go wrong? Feel free to message any of us on Discord or hit up cole#1999 directly for assistance!\n\n")
    lbl:SetWide(pnl:GetWide() - 20)
    lbl:SetWrap(true)
    lbl:SetAutoStretchVertical(true)
    lbl:SetTextColor(Color(255, 255, 255))
    lbl:SetFont("GModNotify")
end

MOAT_REWARDS = {
    IC = 0,
    SC = 0
}

net.Receive("NameRewards.Amount", function()
    MOAT_REWARDS.IC = net.ReadInt(32)
    MOAT_REWARDS.SC = net.ReadInt(32)

    if MOAT_REWARDS.IC > 0 or MOAT_REWARDS.SC > 0 then
        timer.Simple(10, function()
            chat.AddText(Material("icon16/star.png"), Color(255, 255, 255), "You have pending daily rewards! Type ", Color(255, 255, 0), "!rewards ", Color(255, 255, 255), "to collect them!")
        end)
    end
end)

local hastag = false

net.Receive("NameRewards.Time", function()
    hastag = net.ReadInt(32)
end)

MG_cur_event = false

net.Receive("MapEvent", function()
    local event = net.ReadString()
    local name = net.ReadString()

    if (event and string.len(event) > 1) then
        MG_cur_event = event
    else
        MG_cur_event = false
    end

    if name:len() > 1 then
        chat.AddText(Material("icon16/star.png"), Color(255, 255, 255), name, " added 20 rounds of ", Color(255, 255, 0), MG_cur_event, Color(255, 255, 255), "!")
    else
        chat.AddText(Material("icon16/star.png"), Color(255, 255, 255), "Map event active: ", Color(255, 255, 0), MG_cur_event, Color(255, 255, 255), "!")
    end
end)

function MOAT_DONATE:DrawRewardsInfo(pnl, pkg, clr)
    RunConsoleCommand("moat_steam_group", "1")

    --cdn.DrawImage( v , edge, edge, w - edge * 2, w - edge * 2, nil, s.Hovered and math.sin(CurTime())*15 or 0, true )
    pnl.Paint = function(s, w, h)
        local txtw = draw.SimpleText("Get free credits!", "moat_NotifyTest2", w / 2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 10)
        surface.DrawRect(0, 0, w, 45)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 35)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, 0, w, 45)
        surface.DrawOutlinedRect(0, 0, w, 45)
    end

    --cdn.DrawImage("https://static.moat.gg/f/cWeit2ZL5WhFze49xX7jV76mFvOG.png", (w/2) - (235/2), 55, 254, 235)
    local lbl = vgui.Create("DPanel", pnl)
    lbl:SetPos(5, 50)
    lbl:SetWide(pnl:GetWide() - 10)
    lbl:SetTall(pnl:GetTall() - 55)

    function lbl:Paint()
    end

    local top = vgui.Create("DPanel", lbl)

    function top:Paint(w, h)
        local txtw = draw.SimpleText("Click to find out more about the following things:", "moat_Derma5", w / 2, h / 2 - 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    top:Dock(TOP)
    top:DockMargin(0, 0, 0, 5)
    local steam = vgui.Create("DButton", lbl)
    sfx.SoundEffects(steam)
    steam:SetText("")
    local clr = HSVToColor(math.random(1, 200) * 1000 % 360, 1, 1)

    function steam:Paint(w, h)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 30)
        surface.SetMaterial(gradient_r)
        surface.DrawTexturedRect(0, 0, w, 45)
        surface.DrawOutlinedRect(0, 0, w, 45)
        cdn.DrawImageRotated("https://static.moat.gg/f/c2bcd70c9d30a6e54fe5d9d1d837dc7f.png", 10, 4, 35, 35, nil, math.sin(CurTime()) * 15, true)
        local txtw = draw.SimpleText("Joining the steam group", "moat_NotifyTestBonus", 50, h / 2 - 5, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("(Get 2,500 IC!)", "moat_Derma5", w - 5, h - 20, HSVToColor((CurTime() + 100) * 25 % 360, 1, 1), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    function steam:DoClick()
        OpenRewards()
    end

    steam:Dock(TOP)
    steam:SetSize(0, 50)
    --MOAT_FORUMS:OpenWindow()
    local steam = vgui.Create("DButton", lbl)
    sfx.SoundEffects(steam)
    steam:SetText("")
    local clr = HSVToColor(math.random(1, 200) * 1000 % 360, 1, 1)

    function steam:Paint(w, h)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 30)
        surface.SetMaterial(gradient_r)
        surface.DrawTexturedRect(0, 0, w, 45)
        surface.DrawOutlinedRect(0, 0, w, 45)
        cdn.DrawImageRotated("https://static.moat.gg/f/96a5bf04d72376b51cae473b2d051f54.png", 10, 4, 35, 35, nil, math.sin(CurTime() + 10) * 15, true)
        local txtw = draw.SimpleText("Joining the forums", "moat_NotifyTestBonus", 50, h / 2 - 5, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("(Get 2,500 IC!)", "moat_Derma5", w - 5, h - 20, HSVToColor((CurTime() + 50) * 25 % 360, 1, 1), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    function steam:DoClick()
        MOAT_FORUMS:OpenWindow()
    end

    steam:Dock(TOP)
    steam:SetSize(0, 50)
    local top = vgui.Create("DPanel", lbl)

    function top:Paint(w, h)
        local txtw = draw.SimpleText("Or check down below for free daily rewards!", "moat_Derma5", w / 2, h / 2 - 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    top:Dock(TOP)
    local rewards = vgui.Create("DPanel", lbl)
    local clr = HSVToColor(math.random(1, 200) * 1000 % 360, 1, 1)

    function rewards:Paint(w, h)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 10)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(0, 0, w, h)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    rewards:Dock(FILL)
    local lb = vgui.Create("DLabel", rewards)

    if not hastag then
        lb:SetText("NOTE: You can only get daily rewards by adding moat.gg to your name! Capitalization doesn't matter")
    else
        lb:SetText("You have moat.gg in your name and are currently receiving daily rewards!")
    end

    lb:SetWrap(true)
    lb:SetAutoStretchVertical(true)
    lb:SetTextColor(Color(255, 255, 255))
    lb:SetFont("GModNotify")
    lb:DockMargin(5, 5, 0, 5)
    lb:Dock(TOP)
    local collect = vgui.Create("DButton", rewards)
    --collect:Dock(BOTTOM)
    collect.Label = "Click to edit Steam Name"
    collect:SetSize(450, 42)
    collect:SetText("")
    sfx.SoundEffects(collect)

    function collect:DoClick()
        if not hastag then
            gui.OpenURL("http://steamcommunity.com/id/me/edit")
        end
    end

    collect:Dock(TOP)
    collect:DockMargin(10, 5, 10, 0)

    if not hastag then
        MOAT_FORUMS.ButtonPaint(collect, {51, 153, 255})
    else
        function collect:Paint(w, h)
            local txtw = draw.SimpleText("Receiving rewards in: ", "moat_NotifyTestBonus", 0, 15, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            local t = (hastag + 86400) - os.time()
            local s = string.NiceTime((hastag + 86400) - os.time())

            if t < 0 then
                s = "next server join!"
            end

            draw.SimpleText(s, "moat_NotifyTestBonus", txtw + 5, 15, Color(255, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
    end

    local bot = vgui.Create("DPanel", rewards)
    bot:DockMargin(5, 5, 5, 5)
    bot:Dock(FILL)

    function bot:Paint(w, h)
        local txtw = draw.SimpleText("Pending rewards: ", "moat_NotifyTestBonus", 5, 15, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        txtw = txtw + draw.SimpleText(string.Comma(MOAT_REWARDS.IC) .. " IC", "moat_Derma4", txtw + 5, 17, Color(255, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        txtw = txtw + draw.SimpleText(" & ", "moat_Derma4", txtw + 5, 17, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        txtw = txtw + draw.SimpleText(string.Comma(MOAT_REWARDS.SC) .. " SC", "moat_Derma4", txtw + 5, 17, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    --458
    local collect = vgui.Create("DButton", bot)
    --collect:Dock(BOTTOM)fuckmoat
    collect.Label = "COLLECT REWARDS!"
    collect:SetPos(5, 40)
    collect:SetSize(450, 42)
    collect:SetText("")

    function collect:DoClick()
        if MOAT_REWARDS.IC < 1 and MOAT_REWARDS.SC < 1 then return end
        net.Start("NameRewards.Collect")
        net.SendToServer()

        MOAT_REWARDS = {
            IC = 0,
            SC = 0
        }

        sfx.Agree()
    end

    MOAT_FORUMS.ButtonPaint(collect, {46, 204, 113})
    sfx.SoundEffects(collect)
    --top:DockMargin(0, 0, 0, 5)
end

function MOAT_DONATE:RebuildSelection(num)
    if (IsValid(self.info)) then
        self.info:Remove()
        self.info = vgui.Create("DPanel", self.bg)
        self.info:SetSize(self.bg:GetWide() - 172, self.bg:GetTall() - 48)
        self.info:SetPos(170, 46)
    end

    local pnl = self.info
    local pkg = self.Packages[num]
    local clr = HSVToColor(pkg[3] * 55 % 360, 1, 1)

    if (pkg[3] == 1) then
        MOAT_DONATE:DrawInfo(pnl, pkg, clr)

        return
    elseif (pkg[3] == 0) then
        MOAT_DONATE:DrawRewardsInfo(pnl, pkg, clr)

        return
    end

    pnl.Paint = function(s, w, h)
        local txtw = draw.SimpleText(pkg[1] .. " Pack", "moat_NotifyTest2", w / 2, 5, clr, TEXT_ALIGN_CENTER)

        if (pkg[5] ~= "") then
            local bnc = math.abs(math.sin((RealTime() - 0.08) * 5))
            DrawBouncingText(3, 2.1, "+ " .. pkg[5], pkg[5] == "25,000 Bonus" and "moat_Derma8" or "moat_Derma6", (w / 2) + (txtw / 2) - 40, 45, rarity_names[9][2], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        surface.SetDrawColor(clr.r, clr.g, clr.b, 10)
        surface.DrawRect(0, 0, w, 45)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 35)
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, 0, w, 45)
        surface.DrawOutlinedRect(0, 0, w, 45)

        if (pkg[6]) then
            if (pkg[3] == 2 and LocalPlayer():GetUserGroup() ~= "user") then
                draw.SimpleText("This Tradeable VIP Token Includes:", "moat_Derma7", w / 2, 85, Color(0, 255, 255), TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("This Package Includes:", "moat_Derma7", w / 2, 85, Color(0, 255, 255), TEXT_ALIGN_CENTER)
            end

            local y = 130

            for i = 1, #pkg[6] do
                surface.SetFont("moat_Derma7")
                local tw = surface.GetTextSize(pkg[6][i][4] .. pkg[6][i][2] .. " " .. pkg[6][i][3])
                local tw1 = draw.SimpleText(pkg[6][i][4], "moat_Derma7", (w / 2) - (tw / 2), y, Color(255, 0, 0))
                local tw2 = draw.SimpleText(pkg[6][i][2] .. " ", "moat_Derma7", (w / 2) - (tw / 2) + tw1, y, pkg[6][i][1])
                draw.SimpleText(pkg[6][i][3], "moat_Derma7", (w / 2) - (tw / 2) + tw2 + tw1, y, pkg[6][i][3] == "Total Inventory Credits" and Color(255, 255, 255) or pkg[6][i][1])
                y = y + 30
            end
        end
    end

    --[[surface.SetDrawColor(clr.r, clr.g, clr.b, 35)
		surface.SetMaterial(gradient_d)
		surface.DrawTexturedRect(0, 0, w, h)]]
    --[[surface.SetDrawColor(clr.r, clr.g, clr.b, 50)
		surface.SetMaterial(gradient_r)
		surface.DrawTexturedRect(w - 100, 0, 100, h)

		surface.SetDrawColor(clr.r, clr.g, clr.b, 50)
		surface.SetMaterial(gradient_l)
		surface.DrawTexturedRect(0, 0, 100, h)]]
    local btnw = pnl:GetWide() / 1.5
    pnl.r = vgui.Create("DButton", pnl)
    pnl.r:SetSize(btnw, 30)
    pnl.r:SetPos((pnl:GetWide() / 2) - (btnw / 2), pnl:GetTall() - 45)
    pnl.r:SetText("")
    pnl.r.LerpNum = 0
    sfx.SoundEffects(pnl.r)

    pnl.r.Paint = function(s, w, h)
        if (not s.LerpNum) then
            s.LerpNum = 0
        end

        if (s:IsHovered() or s:IsDown()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        if ((LocalPlayer():GetDataVar("SC") or 0) < pkg[4]) then
            s.LerpNum = 0
        end

        surface.SetDrawColor(clr.r, clr.g, clr.b, 10)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(clr.r, clr.g, clr.b, 35 + (s.LerpNum * 100))
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, 0, w, h)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.SimpleText("Redeem " .. string.Comma(pkg[4]) .. " Support Credits", "GModNotify", w / 2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)

        if ((LocalPlayer():GetDataVar("SC") or 0) < pkg[4]) then
            draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 215))
        end
    end

    pnl.r.DoClick = function(s)
        if ((LocalPlayer():GetDataVar("SC") or 0) < pkg[4]) then
            chat.AddText(Material("icon16/cancel.png"), Color(255, 80, 80), "You don't have enough Support Credits to redeem that package! Try re-joining if you just purchased some.")
            surface.PlaySound("buttons/button10.wav")

            return
        end

        if (pkg[1]):lower():match("event") and (MG_cur_event and MG_cur_event ~= "+300% XP") then
            chat.AddText(Material("icon16/cancel.png"), Color(255, 80, 80), "There's currently a map event going on! Wait until the next map.")
            surface.PlaySound("buttons/button10.wav")

            return
        end

        if (pkg[3] == 2 and LocalPlayer():GetUserGroup() ~= "user") then
            Derma_Query("Are you sure you want to purchase a VIP Token that you cannot redeem?\n(Can be traded/gifted to other players to give them VIP)", "Are you sure?", "Yes", function()
                if (IsValid(self.bg)) then
                    self.bg:Remove()
                end

                net.Start("moat.donate.purchase")
                net.WriteUInt(pkg[3], 8)
                net.SendToServer()

                if (IsValid(MOAT_INV_BG)) then
                    MOAT_INV_BG:Remove()
                end

                moat_inv_cooldown = CurTime() + 10
            end, "No")
            -- m_ClearInventory()
            -- net.Start("MOAT_SEND_INV_ITEM")
            -- net.SendToServer()
        else
            if (IsValid(self.bg)) then
                self.bg:Remove()
            end

            net.Start("moat.donate.purchase")
            net.WriteUInt(pkg[3], 8)
            net.SendToServer()

            if (IsValid(MOAT_INV_BG)) then
                MOAT_INV_BG:Remove()
            end

            moat_inv_cooldown = CurTime() + 10
            -- m_ClearInventory()
            -- net.Start("MOAT_SEND_INV_ITEM")
            -- net.SendToServer()
        end

        surface.PlaySound("buttons/button3.wav")
    end
end

function MOAT_DONATE:OpenWindow()
    if LocalPlayer():GetUserGroup() ~= "user" then
        MOAT_DONATE.Packages[3][1] = "VIP Token"
    end

    self.FrameW = 650
    self.FrameH = 450
    self.CurCat = 1

    if (IsValid(self.bg)) then
        self.bg:Remove()
    end

    self.bg = vgui.Create("DFrame")
    self.bg:SetSize(self.FrameW, self.FrameH)
    self.bg:SetPos((ScrW() / 2) - (self.FrameW / 2), -self.FrameH)

    self.bg:MoveTo((ScrW() / 2) - (self.FrameW / 2), (ScrH() / 2) - (self.FrameH / 2) + 10, 0.2, 0, -1, function(a, p)
        p:MoveTo((ScrW() / 2) - (self.FrameW / 2), (ScrH() / 2) - (self.FrameH / 2), 0.1, 0, -1, function(a, p) end)
    end)

    self.bg:ShowCloseButton(false)
    self.bg:SetTitle("")
    self.bg:MakePopup()
    self.bg.Think = function(s) end

    self.bg.Paint = function(s, w, h)
        surface.SetDrawColor(21, 28, 35, 150)
        surface.DrawRect(0, 0, w, h)
        DrawBlur(s, 3)
        cdn.DrawImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 225))
        --[[Header Stuff]]
        --
        --[[draw.RoundedBox(0, 0, 0, w, 45, Color(56, 56, 56, 255))
    	draw.RoundedBox(0, 0, 45, w, 1, Color(86, 86, 86, 255))]]
        MOAT_DONATE.TitlePoly[2].x = Lerp(FrameTime() * 10, MOAT_DONATE.TitlePoly[2].x, 140)
        MOAT_DONATE.TitlePoly[3].x = Lerp(FrameTime() * 10, MOAT_DONATE.TitlePoly[3].x, 170)
        surface.SetDrawColor(118, 122, 126, 15)
        surface.DrawRect(0, 0, w, 46)
        surface.SetDrawColor(21, 28, 35, 150)
        draw.NoTexture()
        surface.DrawPoly(MOAT_DONATE.TitlePoly)
        --draw.SimpleText("Moat", "moat_GambleTitle", 5, 1, Color(0, 25, 50))
        --draw.SimpleText("Gaming", "moat_GambleTitle", 55, 1, Color(50, 50, 50))
		local w2, h2 = draw.SimpleText("Moat", "moat_GambleTitle", 4, 0, Color(0, 198, 255))
        draw.SimpleText(" Gaming", "moat_GambleTitle", 4 + w2, 0, Color(255, 255, 255))
        --draw.SimpleText("Supporter Shop", "moat_GambleTitle", 6, 21, Color(50, 50, 0))
        draw.SimpleText("Supporter Shop", "moat_GambleTitle", 5, 20, Color(255, 255, 0))
        --draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 194, 6, Color(0, 0, 0))
        draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 193, 5, Color(255, 255, 255))
        --draw.SimpleText(string.Comma(MOAT_SUPPORT_CREDITS) .. " Support Credits", "moat_ItemDesc", 208, 27, Color(0, 0, 0))
        draw.SimpleText(string.Comma(LocalPlayer():GetDataVar("SC") or 0) .. " Support Credits", "moat_ItemDesc", 207, 26, Color(255, 255, 255))
        surface.SetMaterial(heart_icon)
        surface.SetDrawColor(Color(255, 255, 255))
        surface.DrawTexturedRect(185, 26, 16, 16)
        draw.SimpleTextOutlined("Available Packages", "moat_ItemDesc", 84.5, 122, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 25))
        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(170, 46, w - 172, h - 48)
        --surface.SetDrawColor(15, 15, 15, 150)
        --surface.DrawRect(1, 46, 169, h - 47)
        --[[surface.SetMaterial(circ_gradient)
        surface.SetDrawColor(Color(0, 0, 0))
        surface.DrawTexturedRect(1, 46, w-2, h - 47)]]
        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        DisableClipping(true)
        surface.SetDrawColor(255, 85, 85, 255)
        surface.DrawRect(0, h, w, 25)
        draw.SimpleTextOutlined("You must reconnect after purchasing support credits to receive them.", "moat_ItemDesc", w / 2, h + 12, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 25))
        DisableClipping(false)
    end

    self.info = vgui.Create("DPanel", self.bg)
    self.info:SetSize(self.bg:GetWide() - 172, self.bg:GetTall() - 48)
    self.info:SetPos(170, 46)
    local ava = vgui.Create("AvatarImage", self.bg)
    ava:SetPos(170, 4)
    ava:SetSize(17, 17)
    ava:SetPlayer(LocalPlayer(), 32)
    local cl = vgui.Create("DButton", self.bg)
    cl:SetPos(self.FrameW - 22, 5)
    cl:SetSize(system.IsOSX() and 18 or 17, 17)
    cl:SetText("")
    cl.LerpNum = 0

    cl.Paint = function(s, w, h)
        if (not s.LerpNum) then
            s.LerpNum = 0
        end

        if (s:IsHovered() or s:IsDown()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

		if (system.IsOSX()) then
			draw.RoundedBox(4, 0, 0, w, h, Color(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum)))
			draw.SimpleText("r", "marlett", 7, 8, Color(255 - (55 * s.LerpNum), 50 + (150 * s.LerpNum), 50 + (150 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.RoundedBox(4, 0, 0, w, h, Color(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum)))
        	draw.SimpleText("r", "marlett", 8 + 1, 8, Color(255 - (55 * s.LerpNum), 50 + (150 * s.LerpNum), 50 + (150 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
    end

    sfx.SoundEffects(cl)

    cl.DoClick = function()
        --gui.EnableScreenClicker( false )
        self.bg:Remove()
    end

    local btnw = 150
    local g = vgui.Create("DButton", self.bg)
    g:SetSize(btnw, 17)
    g:SetPos(self.FrameW - 22 - btnw - 5, 5)
    g:SetText("")
    g.LerpNum = 0

    g.Paint = function(s, w, h)
        if (not s.LerpNum) then
            s.LerpNum = 0
        end

        if (s:IsHovered() or s:IsDown()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        draw.RoundedBox(4, 0, 0, w, h, Color(rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b, 50))
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b, 50 + (s.LerpNum * 220)))

		if (os.date("!*t", os.time() - 14400).wday == 1) then
			draw.SimpleTextOutlined("Closed on Sunday", "moat_ItemDesc", w / 2, 8, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
		else
			draw.SimpleTextOutlined("Buy Support Credits", "moat_ItemDesc", w / 2, 8, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
		end
    end

    g.DoClick = function(s)
        gui.OpenURL("https://moat.gg/store/" .. LocalPlayer():SteamID64())
    end

    sfx.SoundEffects(g)

    for i = 1, #MOAT_DONATE.Packages do
        local caty = (31 * (i - 1)) + 46

        if (i > 2) then
            caty = caty + 30
        end

        local cat_btn = vgui.Create("DButton", self.bg)
        cat_btn:SetPos(0, caty)
        cat_btn:SetSize(170, 30)
        cat_btn:SetText("")
        cat_btn.HoveredWidth = 0

        cat_btn.Paint = function(s, w, h)
            local col = HSVToColor(i * 55 % 360, 1, 1)
            surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
            surface.SetMaterial(gradient_l)
            surface.DrawTexturedRect(0, 0, (w - 1) * s.HoveredWidth, h)
            surface.DrawTexturedRect(0, 0, (w - 1) * s.HoveredWidth, 2)
            surface.DrawTexturedRect(0, h - 2, (w - 1) * s.HoveredWidth, 2)
            draw.RoundedBox(0, 0, 0, MOAT_DONATE.CurCat == i and w or w - 1, h, Color(0, 0, 0, 150))
            surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
            surface.SetMaterial(gradient_l)
            surface.DrawTexturedRect(0, 0, (w - 1) * s.HoveredWidth, h)

            if (MOAT_DONATE.CurCat == i) then
                draw.RoundedBox(0, 0, 0, 4, h, HSVToColor(i * 55 % 360, 1, 1))
                surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
                surface.SetMaterial(gradient_l)
                surface.DrawTexturedRect(0, 0, (w) * 1, h)
                surface.DrawTexturedRect(0, 0, (w) * 1, 2)
                surface.DrawTexturedRect(0, h - 2, (w) * 1, 2)
            elseif (s:IsHovered()) then
                s.HoveredWidth = Lerp(10 * FrameTime(), s.HoveredWidth, 1)
            elseif (not s:IsHovered()) then
                s.HoveredWidth = Lerp(10 * FrameTime(), s.HoveredWidth, 0)
            end

            draw.RoundedBox(0, 0, 0, 4 * s.HoveredWidth, h, HSVToColor(i * 55 % 360, 1, 1))
            surface.SetDrawColor(Color(255, 255, 255))
            surface.SetMaterial(MOAT_DONATE.Packages[i][2])
            surface.DrawTexturedRect(10 + (s.HoveredWidth * 4), (h / 2) - 8, 16, 16)
            draw.SimpleTextOutlined(MOAT_DONATE.Packages[i][1], "moat_ItemDesc", 10 + (s.HoveredWidth * 4) + 21, h / 2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 25))
        end

        cat_btn.DoClick = function(s)
            MOAT_DONATE.CurCat = i
            MOAT_DONATE:RebuildSelection(i)
        end

        sfx.SoundEffects(cat_btn)
    end

    MOAT_DONATE:RebuildSelection(1)
end

concommand.Add("donate", function()
    MOAT_DONATE:OpenWindow()
end)