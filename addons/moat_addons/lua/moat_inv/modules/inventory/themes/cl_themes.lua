MOAT_THEME = MOAT_THEME or {}
MOAT_THEME.Cooldown = CurTime()
MOAT_THEME.FrameSize = {750, 550}
MOAT_THEME.Themes = {}


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
local surface_SetTextColor = surface.SetTextColor
local surface_SetTextPos = surface.SetTextPos
local surface_DrawText = surface.DrawText
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

local function DrawSnow(pnl, w, h, amt)
    local snowtbl = pnl.snowtbl
    for i = 1, amt do
        snowtbl[i] = snowtbl[i] or {}
        if (not snowtbl[i][1]) then snowtbl[i][1] = math.random(-h*1.5, 0) end
        if (snowtbl[i][1] >= h) then
            snowtbl[i][5] = snowtbl[i][5] - (70 * FrameTime())
            snowtbl[i][3] = Lerp(1 * FrameTime(), snowtbl[i][3], 0)
            if (snowtbl[i][5] <= 0) then
                snowtbl[i][1] = math.random(-h*1.5, 0)
                snowtbl[i][2] = math.random(w)
                snowtbl[i][3] = math.random(2,5)
                snowtbl[i][4] = math.random(6,9)
                snowtbl[i][5] = 100
            end
        else
            snowtbl[i][1] = math.Approach(snowtbl[i][1], h, 80 * FrameTime())
            snowtbl[i][2] = snowtbl[i][2] or math.random(w)
            snowtbl[i][3] = snowtbl[i][3] or math.random(3,5)
            snowtbl[i][4] = snowtbl[i][4] or math.random(5,8)
            snowtbl[i][5] = snowtbl[i][5] or 100
        end
        surface_SetDrawColor(230, 230, 250, 200)
        draw.NoTexture()
        draw.Circle( snowtbl[i][2], snowtbl[i][1], snowtbl[i][3], snowtbl[i][4] )
    end
    surface_SetDrawColor(230, 230, 250, 200)
    draw.NoTexture()
    draw.Circle( 0, h + (w / 2) - 35, w / 2, 20 )
end

local function createFestive(pnl, x, y, w, h)
    pnl.festivepanel = vgui.Create("DPanel",pnl)
    pnl.festivepanel:SetSize(w,h)
    pnl.festivepanel:SetPos(x,y)
    pnl.festivepanel.snowtbl = {}
    pnl.festivepanel.Paint = function(s,w,h)
        if (tobool(GetConVar("moat_EnableChristmasTheme"):GetInt())) then
            DrawSnow(s, w, h, 50)
        end
    end
end

local spooky_url = "https://i.moat.gg/servers/images/halloween/"
local spooks = {
    [1] = {"1left.png", 0, 0, 0},
    [2] = {"2left.png", 0, 0, 0},
    [3] = {"3left.png", 0, 0, 0},
    [4] = {"1right.png", 0, 0, 0},
    [5] = {"2right.png", 0, 0, 0},
    [6] = {"3right.png", 0, 0, 0}
}
local next_spook = CurTime()
local current_spook = 1
local currently_spook = false

local function DrawSpooky(s, w, h)
    draw.WebImage(spooky_url .. "halloween3.png", 0, 0, w, h, Color(255, 255, 255))

    if (next_spook <= CurTime()) then
        current_spook = math.random(1, 6)

        local da_spook = spooks[current_spook]
        if (da_spook[1]:EndsWith("right.png")) then
            da_spook[2] = -100
        else
            da_spook[2] = w + 100
        end

        da_spook[3] = math.random(100, h - 200)
        da_spook[4] = math.random(50, 100)

        currently_spook = true
        next_spook = CurTime() + 20
    elseif (currently_spook) then
        local da_spook = spooks[current_spook]

        draw.WebImage(spooky_url .. da_spook[1], da_spook[2], da_spook[3] - (math.sin(RealTime() * 3) * 25), da_spook[4], da_spook[4], Color(255, 255, 255))

        if (da_spook[1]:EndsWith("right.png")) then
            da_spook[2] = da_spook[2] + (FrameTime() * 120)

            if (da_spook[2] > w) then currently_spook = false end
        else
            da_spook[2] = da_spook[2] - (FrameTime() * 120)

            if (da_spook[2] < -100) then currently_spook = false end
        end
    end
end

local function createSpooky(pnl, x, y, w, h)
    if (true) then return end
    
    next_spook = CurTime() + 5
    pnl.spookypanel = vgui.Create("DPanel",pnl)
    pnl.spookypanel:SetSize(w,h)
    pnl.spookypanel:SetPos(x,y)
    pnl.spookypanel.Paint = function(s,w,h)
        DrawSpooky(s, w, h)
    end
end


local pmeta = FindMetaTable("Panel")

function pmeta:SetFestive(x, y, w, h)
    /*if (not IsValid(self.festivepanel) and tobool(GetConVar("moat_EnableChristmasTheme"):GetInt())) then
        createFestive(self, x, y, w, h)
    end*/
end

local blur = Material("pp/blurscreen")
local mat_coins = Material("icon16/coins.png")

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

local circ_gradient = "https://i.moat.gg/8WkHz.png"
