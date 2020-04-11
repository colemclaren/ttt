local math              = math
local table             = table
local draw              = draw
local team              = team
local IsValid           = IsValid
local CurTime           = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
local draw_DrawText = draw.DrawText
local surface_SetFont = surface.SetFont
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_GetTextSize = surface.GetTextSize
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawPoly = surface.DrawPoly
local surface_DrawCircle = surface.DrawCircle
local gradient_u = Material("vgui/gradient-u")
local gradient_d = Material("vgui/gradient-d")
local gradient_r = Material("vgui/gradient-r")

local blur = Material("pp/blurscreen")

local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface_SetDrawColor(255, 255, 255)
    surface_SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface_DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

MOAT_LOGS = MOAT_LOGS or {}
MOAT_LOGS.Background = Color(0, 0, 0, 50)
MOAT_LOGS.OLogs = {}
MOAT_LOGS.SLogs = {}
MOAT_LOGS.NoMatches = CurTime() - 10


local staffgroups = {
	["moderator"] = true,
	["admin"] = true,
	["senioradmin"] = true,
	["headadmin"] = true,
	["communitylead"] = true,
	["owner"] = true,
	["techartist"] = true,
	["audioengineer"] = true,
	["softwareengineer"] = true,
	["gamedesigner"] = true,
	["creativedirector"] = true
}

function MOAT_LOGS:ViewLog(id)
    if (IsValid(self.sr)) then self.sr:Remove() end
    
    self.sr = vgui.Create("DScrollPanel", self.bg)
    self.sr:SetPos(5, 57)
    self.sr:SetSize(740, 488)

    self.l = vgui.Create("DTextEntry", self.sr)
    self.l:Dock(FILL)
    self.l:SetText("")
    self.l:SetMultiline(true)
    self.l:SetKeyboardInputEnabled(false)


    
    self.l.CurLog = id

    local stored = self.SLogs[id]

    if (not stored) then
        stored = cookie.GetString("moat_trades" .. id)
    end

    if (stored) then
        self.l:SetText(stored)
        self.l:SetHeight((#string.Explode("\n", stored) * 14.5))
    else
        net.Start("moat.logs.opent")
        net.WriteUInt(id, 32)
        net.SendToServer()
    end

    self:CreateBack()
end

function MOAT_LOGS:CreateBack()
    if (IsValid(self.b)) then self.b:Remove() end
    
    self.b = vgui.Create("DButton", self.btns)
    self.b:SetSize(100, 26)
    self.b:SetPos(0, 0)
    self.b:SetText("")
    self.b.LerpNum = 0
    self.b.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 225)
        surface_DrawRect(1, 1, w-2, h-2)

        draw_SimpleText("Back", "GModNotify", (w/2), (h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.b.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    self.b.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")

        if (self.Search) then
            self:UpdateTitle("Trade Logs - Search Results")
        else
            self:UpdateTitle("Trade Logs - My Logs")
        end

        if (IsValid(self.sr)) then self.sr:Remove() end
        if (IsValid(self.b)) then self.b:Remove() end
    end
end

function MOAT_LOGS:TradeLog()
    if (IsValid(MOAT_LOGS.bg)) then MOAT_LOGS.bg:Remove() end

    local pl = LocalPlayer()
    local staff = false
    if (staffgroups[pl:GetUserGroup()]) then staff = true end

    self.InvalidSearch = CurTime()
    self.NoMatches = CurTime()
    self.Search = false

    self.bg = vgui.Create("DFrame")
    self.bg:SetSize(750, 550)
    self.bg:SetTitle("")
    self.bg:Center()
    self.bg:MakePopup()
    self.bg:ShowCloseButton(false)
    self.bg.Title = "Trade Logs - Loading..."
    self.bg.Paint = function(s, w, h)
        DrawBlur(s, 5)

        draw_RoundedBox(0, 0, 0, w, h, self.Background)
        draw_RoundedBox(0, 1, 1, w-2, h-2, self.Background)

        surface_SetDrawColor(150, 150, 150, 50)
        surface_DrawRect(0, 0, w, 21)

        draw_SimpleText(s.Title, "GModNotify", 4, 1, Color(255, 255, 255))
        draw_SimpleText("Only Mods+ can view all trades.", "GModNotify", w - 30, 1, Color(255, 255, 255), TEXT_ALIGN_RIGHT)

        if (self.Searching) then
            draw_SimpleText("Searching...", "GModNotify", 330, 30, Color(0, 200, 200), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        elseif (self.NoMatches > CurTime()) then
            draw_SimpleText("No Matches", "GModNotify", 330, 30, Color(255, 0, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        elseif (self.InvalidSearch > CurTime()) then
            draw_SimpleText("Invalid Search Term (4 min)", "GModNotify", 330, 30, Color(255, 0, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        elseif (not IsValid(self.b)) then
            draw_SimpleText("Click an entry to view a log.", "GModNotify", 9, 30, Color(255, 255, 255))
        end
    end

    self.cl = vgui.Create("DButton", self.bg)
    self.cl:SetPos(727, 1)
    self.cl:SetSize(20, 20)
    self.cl:SetText("")
    self.cl.Paint = function(s, w, h)
        draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw_SimpleTextOutlined("r", "marlett", 10, 9, Color(255, 255, 255, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end
    self.cl.DoClick = function()
        self.bg:Remove()
    end

    --[[-------------------------------------------------------------------------
    Buttons Bar
    ---------------------------------------------------------------------------]]

    self.btns = vgui.Create("DPanel", self.bg)
    self.btns:SetSize(740, 26)
    self.btns:SetPos(5, 26)
    self.btns.Paint = function(s, w, h)
    end

    self.o = vgui.Create("DButton", self.btns)
    self.o:SetSize(100, 26)
    self.o:SetPos(640, 0)
    self.o:SetText("")
    self.o.LerpNum = 0
    self.o.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 225)
        surface_DrawRect(1, 1, w-2, h-2)

        draw_SimpleText("My Logs", "GModNotify", (w/2), (h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.o.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    self.o.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")

        MOAT_LOGS.Search = false
        MOAT_LOGS:UpdateTitle("Trade Logs - My Logs")

        if (IsValid(MOAT_LOGS.c)) then
            net.Start("moat.logs.open")
            net.SendToServer()
        end
    end

    self.s = vgui.Create("DButton", self.btns)
    self.s:SetSize(100, 26)
    self.s:SetPos(535, 0)
    self.s:SetText("")
    self.s.LerpNum = 0
    self.s.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 225)
        surface_DrawRect(1, 1, w-2, h-2)

        draw_SimpleText("Search", "GModNotify", (w/2), (h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.s.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    self.s.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")

        local str = self.t:GetText()

        if (not str or #str < 4) then
            self.InvalidSearch = CurTime() + 3

            return
        end

        self.Searching = true

        net.Start("moat.logs.search")
        net.WriteString(str)
        net.SendToServer()
    end

    self.t = vgui.Create("DTextEntry", self.btns)
    self.t:SetSize(195, 26)
    self.t:SetPos(335, 0)
    self.t:SetFont("GModNotify")
    self.t.Paint = function(s, w, h)
        surface_SetDrawColor(0, 0, 0, 50)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(0, 0, 0, 100)
        surface_DrawRect(1, 1, w-2, h-2)

        s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))

        draw_SimpleText("Search Name/SteamID...", "GModNotify", 2, 4, Color(255, 255, 255, s.st))
    end
    self.t.OnEnter = function(s)
        self.s.DoClick()
    end
    self.t.Think = function(s) s.st = s:GetValue() ~= "" and 0 or 50 end

    --[[-------------------------------------------------------------------------
    DListView
    ---------------------------------------------------------------------------]]

    self.p = vgui.Create("DPanel", self.bg)
    self.p:SetPos(5, 57)
    self.p:SetSize(740, 488)
    self.p.Paint = function(s, w, h)
        surface_SetDrawColor(150, 150, 150, 50)
        surface_DrawRect(0, 0, w, h)
    end

    self.c = vgui.Create("DListView", self.p)
    self.c:Dock(FILL)
    self.c:SetMultiSelect(false)
    self.c:AddColumn("Date"):SetFixedWidth(150)
    self.c:AddColumn("User"):SetFixedWidth(590)
    self.c:AddColumn("ID"):SetFixedWidth(0)
    self.c.OnRowSelected = function(s, r, p)
        self:ViewLog(p:GetColumnText(3))

        self:UpdateTitle("Trade Logs - ID: " .. p:GetColumnText(3))
    end

    if (#self.OLogs < 1) then
        net.Start("moat.logs.open")
        net.SendToServer()
    else
        for i = 1, #self.OLogs do
            if (IsValid(MOAT_LOGS.c)) then
                MOAT_LOGS.c:AddLine(os.date("%H:%M:%S - %d/%m/%Y", self.OLogs[i][1]), self.OLogs[i][2], self.OLogs[i][3])
            end
        end

        self:UpdateTitle("Trade Logs - My Logs")
    end
end

function MOAT_LOGS:UpdateTitle(str)
    if (IsValid(MOAT_LOGS.bg) and str) then MOAT_LOGS.bg.Title = str end
end

function MOAT_LOGS.Open()
    local tbl = net.ReadTable()
    MOAT_LOGS.OLogs = tbl

    if (IsValid(MOAT_LOGS.c)) then
        MOAT_LOGS.c:Clear()
    end

    for i = 1, #tbl do
        if (IsValid(MOAT_LOGS.c)) then
            MOAT_LOGS.c:AddLine(os.date("%m/%d/%Y - %H:%M:%S", tbl[i][1]), tbl[i][2], tbl[i][3])
        end
    end

    MOAT_LOGS:UpdateTitle("Trade Logs - My Logs")
end
net.Receive("moat.logs.open", MOAT_LOGS.Open)

function MOAT_LOGS.Text()
    local a = net.ReadInt(32)
    local b = util.Decompress(net.ReadData(a))
    local n = net.ReadUInt(32)

    MOAT_LOGS.SLogs[n] = b
    cookie.Set("moat_trades" .. n, b)

    if (IsValid(MOAT_LOGS.l) and MOAT_LOGS.l.CurLog and MOAT_LOGS.l.CurLog == n) then
        MOAT_LOGS:ViewLog(n)
    end
end
net.Receive("moat.logs.opent", MOAT_LOGS.Text)

function MOAT_LOGS.OpenSearch()
	local found = net.ReadBool()
	if (not found) then MOAT_LOGS.NoMatches = CurTime() + 5 return end

    local logs = net.ReadTable()
    MOAT_LOGS.Searching = false
    if (not logs or #logs < 1) then MOAT_LOGS.NoMatches = CurTime() + 5 return end


    MOAT_LOGS.Search = true

    if (IsValid(MOAT_LOGS.sr)) then MOAT_LOGS.sr:Remove() end
    if (IsValid(MOAT_LOGS.b)) then MOAT_LOGS.b:Remove() end

    if (IsValid(MOAT_LOGS.c)) then
        MOAT_LOGS.c:Clear()
    end

    for i = 1, #logs do
        if (IsValid(MOAT_LOGS.c)) then
            MOAT_LOGS.c:AddLine(os.date("%m/%d/%Y - %H:%M:%S", logs[i][1]), logs[i][2], logs[i][3])
        end
    end

    MOAT_LOGS:UpdateTitle("Trade Logs - Search Result")
end

net.Receive("moat.logs.search", MOAT_LOGS.OpenSearch)

concommand.Add("moat_trades", function()
    MOAT_LOGS:TradeLog()
end)