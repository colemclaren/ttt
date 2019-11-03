---- Unlike sandbox, we have teams to deal with, so here's an extra panel in the
---- hierarchy that handles a set of player rows belonging to its team.
include("sb_row.lua")
local surface = surface
local draw = draw
local math = math
local string = string
local vgui = vgui
local math = math
local table = table
local draw = draw
local team = team
local IsValid = IsValid
local CurTime = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
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
local surface_SetTextPos = surface.SetTextPos
local surface_SetTextColor = surface.SetTextColor
local surface_DrawText = surface.DrawText
local surface_DrawCircle = surface.DrawCircle
local gradient_r = Material("vgui/gradient-r")
local gradient_l = Material("vgui/gradient-l")
local gradient_u = Material("vgui/gradient-u")
local gradient_d = Material("vgui/gradient-d")

local function CompareScore(pa, pb)
    if not IsValid(pa) then return false end
    if not IsValid(pb) then return true end
    local a = pa:GetPlayer()
    local b = pb:GetPlayer()
    if not IsValid(a) then return false end
    if not IsValid(b) then return true end
    if a:GetNW2Int("MOAT_STATS_LVL", 1) == b:GetNW2Int("MOAT_STATS_LVL", 1) then return a:GetNW2Int("MOAT_STATS_XP", 0) < b:GetNW2Int("MOAT_STATS_XP", 0) end

    return a:GetNW2Int("MOAT_STATS_LVL", 1) > b:GetNW2Int("MOAT_STATS_LVL", 1)
end

local PANEL = {}

function PANEL:Init()
    self.name = "Unnamed"
    self.color = COLOR_WHITE
    self.rows = {}
    self.rowcount = 0
    self.rows_sorted = {}
    self.group = "spec"
end

function PANEL:SetGroupInfo(name, color, group)
    self.name = name
    self.color = color
    self.group = group
end

local bgcolor = Color(20, 20, 20, 150)

function PANEL:Paint()
    -- Darkened background
    draw_RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), bgcolor)
    surface_SetFont("treb_small")
    -- Header bg
    local txt = self.name .. " (" .. self.rowcount .. ")"
    local w, h = surface_GetTextSize(txt)
    draw_RoundedBox(0, 0, 0, w + 24, 20, self.color)
    surface_SetDrawColor(0, 0, 0, 100)
    surface_SetMaterial(gradient_l)
    surface_DrawTexturedRect(0, 0, w + 24, 20)
    -- Shadow
    surface_SetTextPos(11, 11 - h / 2)
    surface_SetTextColor(0, 0, 0, 200)
    surface_DrawText(txt)
    -- Text
    surface_SetTextPos(10, 10 - h / 2)
    surface_SetTextColor(255, 255, 255, 255)
    surface_DrawText(txt)
    -- Alternating row background
    local y = 24

    for i, row in ipairs(self.rows_sorted) do
        if (i % 2) ~= 0 then
            surface_SetDrawColor(0, 0, 0, 100)
            surface_DrawRect(0, y + 1, self:GetWide(), row:GetTall() - 2)
        end

        y = y + row:GetTall() + 1
    end

    -- Column darkening
    local scr = sboard_panel.ply_frame.scroll.Enabled and 16 or 0
    surface_SetDrawColor(0, 0, 0, 80)

    if sboard_panel.cols then
        local cx = self:GetWide() - scr

        for k, v in ipairs(sboard_panel.cols) do
            cx = cx - v.Width

            -- Draw for odd numbered columns
            if k % 2 == 1 then
                if (v:GetText() == "Rank") then
                    surface_DrawRect(50 + cx - v.Width / 2, 0, v.Width, self:GetTall())
                    continue
                end

                surface_DrawRect(cx - v.Width / 2, 0, v.Width, self:GetTall())
            end
        end
    else
        -- If columns are not setup yet, fall back to darkening the areas for the
        -- default columns
        surface_DrawRect(self:GetWide() - 175 - 25 - scr, 0, 50, self:GetTall())
        surface_DrawRect(self:GetWide() - 75 - 25 - scr, 0, 50, self:GetTall())
    end
end

function PANEL:AddPlayerRow(ply)
    if ScoreGroup(ply) == self.group and not self.rows[ply] then
        local row = vgui.Create("TTTScorePlayerRow", self)
        row:SetPlayer(ply)
        self.rows[ply] = row
        self.rowcount = table.Count(self.rows)
        --      row:InvalidateLayout()
        -- must force layout immediately or it takes its sweet time to do so
        self:PerformLayout()
        --self:InvalidateLayout()
    end
end

function PANEL:HasPlayerRow(ply)
    return self.rows[ply] ~= nil
end

function PANEL:HasRows()
    return self.rowcount > 0
end

function PANEL:UpdateSortCache()
    self.rows_sorted = {}

    for k, v in pairs(self.rows) do
        table.insert(self.rows_sorted, v)
    end

    table.sort(self.rows_sorted, CompareScore)
end

function PANEL:UpdatePlayerData()
    local to_remove = {}

    for k, v in pairs(self.rows) do
        -- Player still belongs in this group?
        if IsValid(v) and IsValid(v:GetPlayer()) and ScoreGroup(v:GetPlayer()) == self.group then
            v:UpdatePlayerData()
        else
            -- can't remove now, will break pairs
            table.insert(to_remove, k)
        end
    end

    if #to_remove == 0 then return end

    for k, ply in pairs(to_remove) do
        local pnl = self.rows[ply]

        if IsValid(pnl) then
            pnl:Remove()
        end

        --      print(CurTime(), "Removed player", ply)
        self.rows[ply] = nil
    end

    self.rowcount = table.Count(self.rows)
    self:UpdateSortCache()
    self:InvalidateLayout()
end

function PANEL:PerformLayout()
    if self.rowcount < 1 then
        self:SetVisible(false)

        return
    end

    self:SetSize(self:GetWide(), 30 + self.rowcount + self.rowcount * SB_ROW_HEIGHT)
    -- Sort and layout player rows
    self:UpdateSortCache()
    local y = 24

    for k, v in ipairs(self.rows_sorted) do
        v:SetPos(0, y)
        v:SetSize(self:GetWide(), v:GetTall())
        y = y + v:GetTall() + 1
    end

    self:SetSize(self:GetWide(), 30 + (y - 24))
end

vgui.Register("TTTScoreGroup", PANEL, "Panel")