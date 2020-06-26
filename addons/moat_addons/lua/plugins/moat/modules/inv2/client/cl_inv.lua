MOAT_VERSION = "1.7.1"
MOAT_BG_URL = "https://static.moat.gg/f/7b41d8391eef24d3cba3e36063f91b2a.png"

surface.CreateFont("moat_Medium11", {
    font = "Trebuchet24",
    size = 28,
    weight = 800
})

surface.CreateFont("moat_Trebuchet", {
    font = "DermaLarge",
    additive = false,
    size = 24,
    weight = 600
})

surface.CreateFont("moat_Medium9", {
    font = "Trebuchet24",
    size = 13,
    weight = 800
})

surface.CreateFont("moat_Medium10", {
    font = "Trebuchet24",
    size = 15,
    weight = 800
})

surface.CreateFont("moat_Medium4", {
    font = "Trebuchet24",
    size = 18,
    weight = 800
})

surface.CreateFont("moat_Medium5", {
    font = "Trebuchet24",
    size = 20,
    weight = 800
})

surface.CreateFont("moat_Medium3", {
    font = "Trebuchet18",
    size = 16,
    weight = 700
})

surface.CreateFont("moat_ItemDesc", {
    font = "DermaLarge",
    size = 14,
    weight = 800
})

surface.CreateFont("moat_TradeDesc", {
    font = "DermaLarge",
    size = 12,
    weight = 800
})

surface.CreateFont("moat_ItemDescLarge3", {
    font = "DermaLarge",
    size = 28,
    weight = 800
})

surface.CreateFont("moat_MOTDHead", {
    font = "DermaLarge",
    size = 40,
    weight = 700
})

surface.CreateFont("moat_ItemDescSmall2", {
    font = "DermaLarge",
    size = 10,
    weight = 700
})

surface.CreateFont("moat_Medium2", {
    font = "Trebuchet18",
    size = 12,
    weight = 500,
    italic = true
})

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
local draw_NoTexture = draw.NoTexture
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
moat_inv_cooldown = 0

function m_isUsingInv(inv)
	if (inv) then
		return IsValid(MOAT_INV_BG) and IsValid(M_INV_PNL)
	end

    return IsValid(MOAT_INV_BG)
end

function draw.Circle( x, y, radius, seg )
    local cir = {}

    table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
    for i = 0, seg do
        local a = math.rad( ( i / seg ) * -360 )
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
    end

    local a = math.rad( 0 ) -- This is need for non absolute segment counts
    table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

    surface_DrawPoly( cir )
end

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

		cdn.SmoothImage("https://static.moat.gg/f/snow.png", snowtbl[i][2], snowtbl[i][1] - (snowtbl[i][3]/2), snowtbl[i][3], snowtbl[i][3], Color(230, 230, 250, 200))
    end

	cdn.SmoothImage("https://static.moat.gg/f/snow2.png", 0, h - 256, 256, 256, Color(230, 230, 250, 255))
end

local holiday = CreateClientConVar("moat_holiday_theme_2020", 1, true, true)
local function createFestive(pnl, x, y, w, h)
    pnl.festivepanel = vgui.Create("DPanel",pnl)
    pnl.festivepanel:SetSize(w,h)
    pnl.festivepanel:SetPos(x,y)
    pnl.festivepanel.snowtbl = {}
    pnl.festivepanel.Paint = function(s,w,h)
        if (holiday:GetInt() == 1) then
            DrawSnow(s, w, h, 50)
        end
    end
end

hook("InitPostEntity", "SetFestive", function()
	local pmeta = FindMetaTable("Panel")
	function pmeta:SetFestive(x, y, w, h)
    	-- if (not IsValid(self.festivepanel) and holiday:GetInt() == 1) then
        -- 	createFestive(self, x, y, w, h)
    	-- end
	end
end)

local halloween_bg = "https://static.moat.gg/f/halloween.png"
local spooks = {
    [1] = {"1left.png", 0, 0, 0, url = "https://static.moat.gg/f/1left.png"},
    [2] = {"2left.png", 0, 0, 0, url = "https://static.moat.gg/f/2left.png"},
    [3] = {"3left.png", 0, 0, 0, url = "https://static.moat.gg/f/3left.png"},
    [4] = {"1right.png", 0, 0, 0, url = "https://static.moat.gg/f/1right.png"},
    [5] = {"2right.png", 0, 0, 0, url = "https://static.moat.gg/f/2right.png"},
    [6] = {"3right.png", 0, 0, 0, url = "https://static.moat.gg/f/3right.png"}
}
local next_spook = CurTime()
local current_spook = 1
local currently_spook = false

local function DrawSpooky(s, w, h)
    /*
	cdn.DrawImage(halloween_bg, 0, 0, w, h)

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

        cdn.DrawImage(da_spook.url, da_spook[2], da_spook[3] - (math.sin(RealTime() * 3) * 25), da_spook[4], da_spook[4], Color(255, 255, 255))

        if (da_spook[1]:EndsWith("right.png")) then
            da_spook[2] = da_spook[2] + (FrameTime() * 120)

            if (da_spook[2] > w) then currently_spook = false end
        else
            da_spook[2] = da_spook[2] - (FrameTime() * 120)

            if (da_spook[2] < -100) then currently_spook = false end
        end
    end
	*/
end

local function createSpooky(pnl, x, y, w, h)
    next_spook = CurTime() + 5
    pnl.spookypanel = vgui.Create("DPanel",pnl)
    pnl.spookypanel:SetSize(w,h)
    pnl.spookypanel:SetPos(x,y)
    pnl.spookypanel.Paint = function(s,w,h)
        DrawSpooky(s, w, h)
    end
end




local spring_bg_url = "https://static.moat.gg/f/spring_bg.png"
local springs = {
    [1] = {"butterfly1.png", 0, 0, 0, url = "https://static.moat.gg/f/butterfly1.png"},
    [2] = {"butterfly2.png", 0, 0, 0, url = "https://static.moat.gg/f/butterfly2.png"},
    [3] = {"butterfly3.png", 0, 0, 0, url = "https://static.moat.gg/f/butterfly3.png"},
    [4] = {"butterfly4.png", 0, 0, 0, url = "https://static.moat.gg/f/butterfly4.png"}
}
local next_spring = CurTime()
local current_spring = 1
local left_or_right = 1
local currently_spring = false

local function DrawSpring(s, w, h)
    cdn.DrawImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 225))

    -- if (next_spring <= CurTime()) then
    --     current_spring = math.random(1, 4)
    --     left_or_right = math.random(1, 2)

    --     local da_spring = springs[current_spring]
    --     if (left_or_right == 2) then
    --         da_spring[2] = -100
    --     else
    --         da_spring[2] = w + 100
    --     end

    --     da_spring[3] = math.random(100, h - 200)
    --     da_spring[4] = math.random(50, 100)

    --     currently_spring = true
    --     next_spring = CurTime() + 20
    -- elseif (currently_spring) then
    --     local da_spring = springs[current_spring]
    --     cdn.DrawImage(da_spring.url, da_spring[2], da_spring[3] - (math.sin(RealTime() * 3) * 25), da_spring[4], da_spring[4], Color(255, 255, 255, 50))

    --     if (left_or_right == 2) then
    --         da_spring[2] = da_spring[2] + (FrameTime() * 120)

    --         if (da_spring[2] > w) then currently_spring = false end
    --     else
    --         da_spring[2] = da_spring[2] - (FrameTime() * 120)

    --         if (da_spring[2] < -100) then currently_spring = false end
    --     end
    -- end
end

local moat_spring_theme = CreateClientConVar("moat_spring_theme", 1, true, false)
local function createSpring(pnl, x, y, w, h)

    next_spring = CurTime() + 5
    pnl.springpanel = vgui.Create("DPanel",pnl)
    pnl.springpanel:SetSize(w,h)
    pnl.springpanel:SetPos(x,y)
    pnl.springpanel.Paint = function(s,w,h)
        -- if (moat_spring_theme:GetInt() < 1) then return end
        
        DrawSpring(s, w, h)
    end
end


function m_DrawShadowedText(shadow, text, font, x, y, color, xalign, yalign)
	draw_SimpleText(text, font, x + shadow, y + shadow, Color(0, 0, 0, 255), xalign, yalign)
	draw_SimpleText(text, font, x, y, color, xalign, yalign)
end

function m_GlowCol(Col1, Col2, Am)
    local nr = Col1.r + ((Col2.r - Col1.r) * (Am))
    local ng = Col1.g + ((Col2.g - Col1.g) * (Am))
    local nb = Col1.b + ((Col2.b - Col1.b) * (Am))

    return Color(nr, ng, nb)
end

function m_DrawEnchantedText(text, font, x, y, color, glow_color, xalign, yalign, enable_emoji)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local glow_color = glow_color or Color(127, 0, 255)
    local texte = string.Explode("", text)
    surface_SetFont(font)
    local chars_x = 0

    local TextSize, DrawText = surface_GetTextSize, draw_SimpleText
    if (enable_emoji) then
        TextSize, DrawText = emoji.GetTextSize, emoji.SimpleText
    end

    for i = 1, #texte do
        local char = texte[i]
        local charw, charh = TextSize(char)
        local color_glowing = m_GlowCol(glow_color, color, math.abs(math.sin((RealTime() - (i * 0.08)) * 2)))
        DrawText(char, font, x + chars_x + 1, y + 1, Color(0, 0, 0), xalign, yalign, true)
        DrawText(char, font, x + chars_x, y, color_glowing, xalign, yalign)
        chars_x = chars_x + charw
    end
end

function m_DrawGlowingText(static, text, font, x, y, color, xalign, yalign, enable_emoji, disable_drawing)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local initial_a = 20
    local a_by_i = 5
    surface_SetFont(font)

    local DrawText = draw_SimpleText
    if (enable_emoji) then
        DrawText = emoji.SimpleText
    end

    for i = 1, 2 do
        local alpha_glow = math.abs(math.sin((RealTime() - (i * 0.1)) * 2))

        if (static) then
            alpha_glow = 1
        end

        DrawText(text, font, x, y - i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
        DrawText(text, font, x + i, y - i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
        DrawText(text, font, x + i, y, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
        DrawText(text, font, x + i, y + i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
        DrawText(text, font, x, y + i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
        DrawText(text, font, x - i, y + i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
        DrawText(text, font, x - i, y, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
        DrawText(text, font, x - i, y - i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow), xalign, yalign, true)
    end

    DrawText(text, font, x + 1, y + 1, Color(color.r, color.g, color.b, 10), xalign, yalign, true)
    DrawText(text, font, x, y, color, xalign, yalign, disable_drawing)
end

function DrawFadingText(speed, text, font, x, y, color, fading_color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT

    local yalign = yalign or TEXT_ALIGN_TOP

    local color_fade = GlowColor( color, fading_color, math.abs( math.sin( ( RealTime() - 0.08 ) * speed ) ) )

    draw_SimpleText( text, font, x, y, color_fade, xalign, yalign )
end

function m_DrawBouncingText(text, font, x, y, color, xalign, yalign, enable_emoji)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    surface_SetFont(font)
    local chars_x = 0

    local TextSize, DrawText = surface_GetTextSize, draw_SimpleText
    local codes, tochar = utf8.codes, utf8.char
    if (enable_emoji) then
        TextSize, DrawText = emoji.GetTextSize, emoji.SimpleText
        Split = emoji.Codes
        char = function(a) return a end
    end

    local i = 1
    for _, c in codes(text) do
        local char = tochar(c)
        local charw, charh = TextSize(char)
        local y_pos = 1 - math.abs(math.sin((RealTime() - (i * 0.1)) * 2))
        DrawText(char, font, x + chars_x, y - (5 * y_pos), color, xalign, yalign)
        chars_x = chars_x + charw
        i = i + 1
    end
end

local next_electic_effect = CurTime() + 0
local electric_effect_a = 0

function m_DrawElecticText(text, font, x, y, color, xalign, yalign, enable_emoji)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local texte = string.Explode("", text)

    local TextSize, DrawText = surface_GetTextSize, draw_SimpleText
    if (enable_emoji) then
        TextSize, DrawText = emoji.GetTextSize, emoji.SimpleText
    end

    surface_SetFont(font)
    local charw, charh = TextSize(text)
    DrawText(text, font, x + 1, y + 1, Color(0, 0, 0), xalign, yalign, true)
    DrawText(text, font, x, y, color, xalign, yalign)

    if (electric_effect_a > 0) then
        electric_effect_a = electric_effect_a - (1000 * FrameTime())
    end

    surface_SetDrawColor(102, 255, 255, electric_effect_a)

    for i = 1, math.random(5) do
        line_x = math.random(charw)
        line_y = math.random(charh)
        line_x2 = math.random(charw)
        line_y2 = math.random(charh)
        surface_DrawLine(x + line_x, y + line_y, x + line_x2, y + line_y2)
    end

    if (next_electic_effect <= CurTime()) then
        next_electic_effect = CurTime() + math.Rand(0.5, 1.5)
        electric_effect_a = 255
    end
end

local next_fire_effect = CurTime() + 0.1
local fire_effect_a = 0

function m_DrawFireText(rarity, text, font, x, y, color, xalign, yalign, enable_emoji)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    surface_SetFont(font)
    local TextSize, DrawText = surface_GetTextSize, draw_SimpleText
    if (enable_emoji) then
        TextSize, DrawText = emoji.GetTextSize, emoji.SimpleText
    end

    local charw, charh = TextSize(text)

    for i = 1, charw do
        local line_y = math.random(0, charh)
        local line_x = math.random(-4, 4)
        local line_col = math.random(255)
        surface_SetDrawColor(255, line_col, 0, 150)
        surface_DrawLine(x - 1 + i, y + charh, x - 1 + i + line_x, y + line_y)
    end

    local yellow_col = (math.abs(math.sin((RealTime() - (1 * 0.1)) * 1)) * 255)
    m_DrawGlowingText(true, text, font, x, y, color, xalign, yalign, false, true)
    DrawText(text, font, x + 1, y + 1, Color(0, 0, 0), xalign, yalign, true)
    DrawText(text, font, x, y, color, xalign, yalign)
end

surface.CreateFont("moat_Medium52", {
    font = "Trebuchet24",
    size = 20,
    weight = 800,
    antialias = false
})

function draw_SimpleTextDegree(text, font, x, y, x2, y2, top, bottom, percent, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local font = "moat_Medium52"
    surface_SetFont(font)
    local charw, charh = surface_GetTextSize(text)
    draw_SimpleText(text, font, x, y, Color(0, 255, 255, 255), xalign, yalign)
    local y_pos2 = (math.abs(math.sin((RealTime() - (1 * 0.1)) * 1)) * charw)
    local x_pos2 = x2 + x

    for i = -charw / 2, charw / 2 do
        render.SetScissorRect(x_pos2 + (i * 2) + y_pos2, y2 + y, x_pos2 + (i * 2) + 1 + y_pos2, y2 + y + (charh), true)
        draw_SimpleText(text, font, x, y, Color(174, 0, 255, 220), xalign, yalign)
        render.SetScissorRect(0, 0, 0, 0, false)
    end
    --[[
    render.SetScissorRect( x_pos2 - 40, y2 + y, x_pos2 + 40, y2 + y + ( charh ), true )

        draw_SimpleText( text, font, x, y, Color( 174, 0, 255, 200 ), xalign, yalign )

    render.SetScissorRect( 0, 0, 0, 0, false )

    render.SetScissorRect( x_pos2 - 4, y2 + y, x_pos2 + 4, y2 + y + ( charh ), true )

        draw_SimpleText( text, font, x, y, Color( 174, 255, 255, 200 ), xalign, yalign )

    render.SetScissorRect( 0, 0, 0, 0, false )

    local y_pos2 = ( math.abs( math.sin( ( RealTime() - ( 1 * 0.1 ) ) * 4 ) ) * charw )

    local x_pos2 = x2 + x + y_pos2

    render.SetScissorRect( x_pos2 - 2, y2 + y, x_pos2 + 2, y2 + y + ( charh ), true )

        draw_SimpleText( text, font, x, y, Color( 174, 255, 255, 200 ), xalign, yalign )

    render.SetScissorRect( 0, 0, 0, 0, false )]]
    --draw_SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0 ), xalign, yalign )
end

local blur = Material("pp/blurscreen")
local mat_coins = Material("icon16/coins.png")
local mat_lock = Material("icon16/lock.png")
local mat_paint = Material("icon16/palette.png")

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

local desc_cache, desc_length = {}, {}
local number_col = Color(0, 255, 0, 255)
function m_DrawItemDescLevel(text, font, x, y, w, col)
	if (not desc_cache[text]) then
		desc_cache[text], desc_length[text] = {}, 0
		for str in string.gsub(text, "[%.%!%?]*$", ""):gmatch "([^%s]*%s*)" do
			desc_length[text] = desc_length[text] + 1
			desc_cache[text][desc_length[text]] = str
		end

		desc_length[text] = desc_length[text] + 1
		desc_cache[text][desc_length[text]] = text:match "[%.%!%?]*$"
	end

    surface.SetFont(font)

    local chars_x = 0
    local chars_y = 0

	for k, v in ipairs(desc_cache[text]) do
		if (type(v) == "string") then
			local str = v
			local strw = surface.GetTextSize(str)
			desc_cache[text][k] = {Text = str, Width = strw, Color = string.match(str, "^[%.%-%+]?[%d*%%*]%.?[^%)]*[%s*%d*][%.%-%+%%]?$") and number_col or col}
			v = desc_cache[text][k]
		end

        if (chars_x + (v.Width + 5) >= w) then
            chars_x = 0
            chars_y = chars_y + 15
        end

        m_DrawShadowedText(1, v.Text, font, x + chars_x, y + chars_y, v.Color or col)

        chars_x = chars_x + v.Width
    end
end

function m_DrawItemDesc(text, font, x, y, w, h)
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

        for i = 0, 9 do
            if (string.find(char, tostring(i))) then
                char_col = Color(0, 255, 0, 255)
            end
        end

        -- m_DrawShadowedText(1, char, font, x + chars_x + 1, y + (chars_y * 15) + 1, Color(0, 0, 0))
        m_DrawShadowedText(1, char, font, x + chars_x, y + (chars_y * 15), char_col)
		
        chars_x = chars_x + charw
    end

	return chars_y + 1
end

function m_GetItemDescH(text, font, w)
    if (not desc_cache[text]) then
		desc_cache[text], desc_length[text] = {}, 0
		for str in string.gsub(text, "[%.%!%?]*$", ""):gmatch "([^%s]*%s*)" do
			desc_length[text] = desc_length[text] + 1
			desc_cache[text][desc_length[text]] = str
		end

		desc_length[text] = desc_length[text] + 1
		desc_cache[text][desc_length[text]] = text:match "[%.%!%?]*$"
	end

    surface.SetFont(font)

    local chars_x = 0
    local chars_y = 0

	for k, v in ipairs(desc_cache[text]) do
		if (type(v) == "string") then
			local str = v
			local strw = surface.GetTextSize(str)
			desc_cache[text][k] = {Text = str, Width = strw, Color = string.match(str, "^[%.%-%+]?[%d*%%*]%.?[^%)]*[%s*%d*][%.%-%+%%]?$") and number_col or col}
			v = desc_cache[text][k]
		end

        if (chars_x + (v.Width + 5) >= w) then
            chars_x = 0
            chars_y = chars_y + 1
        end

        chars_x = chars_x + v.Width
    end

    return chars_y + 1
end

function m_GetStatMinMax(key, itemtbl)
    local stat_min, stat_max = 0, 0

    if (tostring(key) == "d") then
        stat_min, stat_max = itemtbl.item.Stats.Damage.min, itemtbl.item.Stats.Damage.max
    elseif (tostring(key) == "a") then
        stat_min, stat_max = itemtbl.item.Stats.Accuracy.min, itemtbl.item.Stats.Accuracy.max
    elseif (tostring(key) == "k") then
        stat_min, stat_max = itemtbl.item.Stats.Kick.min, itemtbl.item.Stats.Kick.max
    elseif (tostring(key) == "f") then
        stat_min, stat_max = itemtbl.item.Stats.Firerate.min, itemtbl.item.Stats.Firerate.max
    elseif (tostring(key) == "m") then
        stat_min, stat_max = itemtbl.item.Stats.Magazine.min, itemtbl.item.Stats.Magazine.max
    elseif (tostring(key) == "r" and itemtbl.item.Stats.Range) then
        stat_min, stat_max = itemtbl.item.Stats.Range.min, itemtbl.item.Stats.Range.max
    elseif (tostring(key) == "w") then
        stat_min, stat_max = itemtbl.item.Stats.Weight.min, itemtbl.item.Stats.Weight.max
    elseif (tostring(key) == "p") then
        stat_min, stat_max = itemtbl.item.Stats.Pushrate.min, itemtbl.item.Stats.Pushrate.max
    elseif (tostring(key) == "v") then
        stat_min, stat_max = itemtbl.item.Stats.Force.min, itemtbl.item.Stats.Force.max
    elseif (tostring(key) == "y") then
        stat_min, stat_max = itemtbl.item.Stats.Reloadrate.min, itemtbl.item.Stats.Reloadrate.max
    elseif (tostring(key) == "z") then
        stat_min, stat_max = itemtbl.item.Stats.Deployrate.min, itemtbl.item.Stats.Deployrate.max
    elseif (tostring(key) == "c") then
        stat_min, stat_max = itemtbl.item.Stats.Chargerate.min, itemtbl.item.Stats.Chargerate.max
    end

    return stat_min, stat_max
end

local stats_full = {}
stats_full["d"] = "DMG"
stats_full["f"] = "RPM"
stats_full["m"] = "MAG"
stats_full["a"] = "Accuracy"
stats_full["k"] = "Kick"
stats_full["r"] = "Range"
stats_full["w"] = "Weight"
stats_full["x"] = "XP"
stats_full["l"] = "Level"
stats_full["p"] = "Push Delay"
stats_full["v"] = "Push Force"
stats_full["y"] = "Reload"
stats_full["z"] = "Draw"
stats_full["c"] = "Charging Speed"

local m_color_green = Color(0, 255, 0)
local m_color_red = Color(255, 40, 40)
local talents_spacer = 25
local appl = "apple_pie"
local stat_anim = 10
local saved_itemtbl = nil
local default_stats = {"DMG", "RPM", "MAG"}
local level_stats = {"XP", "Level"}

local function DrawItemStatsKeyValue(font, x, y, itemtbl, pnl, stats_y_add, k, v, ctrldown)
	local stat_str = stats_full[tostring(k)]
    if (not stat_str) then return stats_y_add end

    local stat_min, stat_max = m_GetStatMinMax(k, itemtbl)
    local stat_num = math.Round(stat_min + ((stat_max - stat_min) * v), 1)
    stat_sign = "+"
    stat_color = m_color_green

    if (string.StartWith(tostring(stat_num), "-")) then
        stat_sign = ""
        stat_color = m_color_red

         if (tostring(k) == "k" or tostring(k) == "w") then
            stat_color = m_color_green
        end
    else
        if (tostring(k) == "k" or tostring(k) == "w") then
            stat_color = m_color_red
        end
    end

    local stat_strw, stat_strh = surface_GetTextSize(stat_str)

    if (not table.HasValue(default_stats, stat_str) and not table.HasValue(level_stats, stat_str)) then
        m_DrawShadowedText(1, stat_str, font, x, y + stats_y_add, Color(255, 255, 255))
        local box_width = pnl:GetWide() - 14
        local stat_width = (v * (box_width)) * (pnl.AnimVal or 1)
        surface_SetDrawColor(0, 0, 0)
        surface_DrawRect(x + 1, y + 16 + 1 + stats_y_add, box_width, 5)
        surface_SetDrawColor(stat_color.r, stat_color.g, stat_color.b, 25)
        surface_DrawRect(x, y + 16 + stats_y_add, box_width, 5)
        surface_SetDrawColor(stat_color.r, stat_color.g, stat_color.b, 25)
        surface_DrawRect(x, y + 16 + stats_y_add, stat_width, 5)
        surface_SetDrawColor(stat_color)
        surface_SetMaterial(gradient_r)
        surface_DrawTexturedRect(x, y + 16 + stats_y_add, stat_width + 1, 5)
        local minmax = ""
        if (ctrldown) then
            minmax = "(" .. stat_min .. " to " .. stat_max .. ") "
        end
        m_DrawShadowedText(1, minmax .. stat_sign .. stat_num .. "%", font, x + pnl:GetWide() - 14, y + stats_y_add, stat_color, TEXT_ALIGN_RIGHT)
        stats_y_add = stats_y_add + 25
    end

	return stats_y_add
end

function m_DrawItemStats(font, x, y, itemtbl, pnl)
    local ctrldown = input.IsKeyDown(KEY_LCONTROL)
    --pnl.AnimVal = Lerp(FrameTime() * stat_anim, pnl.AnimVal, 1)

    if (not pnl.savewide) then pnl.savewide = pnl:GetWide() end

    if (ctrldown and itemtbl.s) then
		local w = math.max(pnl.savewide + ((ctrldown and itemtbl.s) and 0 or 0), ((ctrldown and itemtbl.s) and 310 or 0))
		if (w % 2 ~= 0) then
			w = w + 1
		end

        pnl:SetWide(w)
    else
        pnl:SetWide(pnl.savewide)
    end

    local wpntbl = weapons.Get(itemtbl.w)
    local stat_sign = "+"
    local stat_color = m_color_green
    local x_divide = pnl:GetWide() / 3
    local x1, x2, x3 = x, x + x_divide, x + (x_divide * 2)
    local y_addition = 10
    local font_large = "moat_ItemDescLarge3"
    local font_small = "moat_ItemDescSmall2"
    local wpn_dmg = math.Round(wpntbl.Primary.Damage, 1)
    local wpn_rpm = math.Round(60 * (1 / wpntbl.Primary.Delay))
    local wpn_mag = math.ceil(wpntbl.Primary.ClipSize)
    local wpn_mag_min = 0
    local wpn_mag_max = 0

    if (itemtbl.s) then
        if (itemtbl.s.d) then
            wpn_dmg = math.Round(wpntbl.Primary.Damage * (1 + ((itemtbl.item.Stats.Damage.min + ((itemtbl.item.Stats.Damage.max - itemtbl.item.Stats.Damage.min) * itemtbl.s.d)) / 100)), 1)
        end

        if (itemtbl.s.f) then
            local firerate_mult = 1 - (itemtbl.item.Stats.Firerate.min + (itemtbl.item.Stats.Firerate.max - itemtbl.item.Stats.Firerate.min) * itemtbl.s.f) / 100
            wpn_rpm = math.Round(60 / (firerate_mult * wpntbl.Primary.Delay))
        end

        if (itemtbl.s.m) then
            wpn_mag = math.ceil(wpntbl.Primary.ClipSize * (1 + ((itemtbl.item.Stats.Magazine.min + ((itemtbl.item.Stats.Magazine.max - itemtbl.item.Stats.Magazine.min) * itemtbl.s.m)) / 100)))
            wpn_mag_min = math.floor(wpntbl.Primary.ClipSize * (1 + ((itemtbl.item.Stats.Magazine.min + ((itemtbl.item.Stats.Magazine.max - itemtbl.item.Stats.Magazine.min) * 0)) / 100)))
            wpn_mag_max = math.ceil(wpntbl.Primary.ClipSize * (1 + ((itemtbl.item.Stats.Magazine.min + ((itemtbl.item.Stats.Magazine.max - itemtbl.item.Stats.Magazine.min) * 1)) / 100)))
        end
    end

    local stat_num = 0
    local small_y = 0
    surface_SetFont(font)
    local stats_y_add = 40
    local stats_y_multi = 25

    if (wpntbl.Primary.NumShots and wpntbl.Primary.NumShots > 1) then
        wpn_dmg = wpn_dmg .. "*" .. wpntbl.Primary.NumShots -- ×
    end

    if (wpn_mag < 1) then
        wpn_mag = "∞"
    end

    -- if (itemtbl.item.Rarity == 0 and itemtbl.item.ID and itemtbl.item.ID ~= 7820 and itemtbl.item.ID ~= 7821) then
    --     m_DrawShadowedText(1, "DMG", font, x1, y, Color(255, 255, 255))
    --     m_DrawShadowedText(1, wpn_dmg, font_large, x1, y + y_addition, Color(255, 255, 255))
    --     m_DrawShadowedText(1, "RPM", font, x2, y, Color(255, 255, 255))
    --     m_DrawShadowedText(1, wpn_rpm, font_large, x2, y + y_addition, Color(255, 255, 255))
    --     m_DrawShadowedText(1, "MAG", font, x3, y, Color(255, 255, 255))
    --     m_DrawShadowedText(1, wpn_mag, font_large, x3, y + y_addition, Color(255, 255, 255))
    --     local collection_y = 85
    --     m_DrawShadowedText(1, "From the " .. itemtbl.item.Collection, "moat_Medium2", 6, collection_y, Color(150, 150, 150, 100))
		
	-- 	if (itemtbl.p3) then
    --     	local p3txt = MOAT_PAINT.Skins[itemtbl.p3] and MOAT_PAINT.Skins[itemtbl.p3][1] or "ERROR: Unknown Skin"
	-- 		m_DrawShadowedText(1, p3txt, "moat_Medium2", pnl:GetWide() - 6, collection_y, rarity_names[MOAT_PAINT.Skins[itemtbl.p3][3]][2]:Copy() or Color(91, 98, 109, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    -- 	end

    --     return
    -- end

    for k, v in SortedPairs(default_stats) do
        if (v == "DMG") then
            m_DrawShadowedText(1, v, font, x1, y, Color(255, 255, 255))
            m_DrawShadowedText(1, wpn_dmg, font_large, x1, y + y_addition, Color(255, 255, 255))

            if (itemtbl.s.d) then
                stat_min, stat_max = m_GetStatMinMax("d", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.d), 1)
                stat_sign = "+"
                stat_color = m_color_green

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                    stat_color = m_color_red
                end

                local minmax = ""
                if (ctrldown) then
                    minmax = " (" .. stat_min .. " to " .. stat_max .. ")"
                end

                if (stat_num ~= 0) then
                    m_DrawShadowedText(1, minmax .. " " .. stat_sign .. stat_num .. "%", font_small, x1 + 33, y + small_y, stat_color)
                end
            end
        elseif (v == "RPM") then
            m_DrawShadowedText(1, v, font, x2, y, Color(255, 255, 255))
            m_DrawShadowedText(1, wpn_rpm, font_large, x2, y + y_addition, Color(255, 255, 255))

            if (itemtbl.s.f) then
                stat_min, stat_max = m_GetStatMinMax("f", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.f), 1)
                stat_sign = "+"
                stat_color = m_color_green

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                    stat_color = m_color_red
                end

                local minmax = ""
                if (ctrldown) then
                    minmax = " (" .. stat_min .. " to " .. stat_max .. ")"
                end

                if (stat_num ~= 0) then
                    m_DrawShadowedText(1, minmax .. " " .. stat_sign .. stat_num .. "%", font_small, x2 + 30, y + small_y, stat_color)
                end
            end
        elseif (v == "MAG") then
            m_DrawShadowedText(1, v, font, x3, y, Color(255, 255, 255))
            m_DrawShadowedText(1, wpn_mag, font_large, x3, y + y_addition, Color(255, 255, 255))

            if (itemtbl.s.m and isnumber(wpn_mag)) then
                stat_min, stat_max = m_GetStatMinMax("m", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.m), 1)
                stat_sign = "+"
                stat_color = m_color_green

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                    stat_color = m_color_red
                end

                stat_num = wpn_mag - wpntbl.Primary.ClipSize

                local minmax = ""
                if (ctrldown) then
                    minmax = " (" .. wpn_mag_min .. " to " .. wpn_mag_max .. ")"
                end

                if (stat_num ~= 0) then
                    m_DrawShadowedText(1, minmax .. " " .. stat_sign .. stat_num .. "", font_small, x3 + 32, y + small_y, stat_color)
                end
            end
        end
    end

	local stats_drawn = {}
	if (itemtbl.s and itemtbl.s.c) then
		stats_y_add = DrawItemStatsKeyValue(font, x, y, itemtbl, pnl, stats_y_add, "c", itemtbl.s.c, ctrldown)
		stats_drawn["c"] = true
	end

    for k, v in SortedPairs(itemtbl.s) do
		if (stats_drawn[tostring(k)]) then
			continue
		end

		stats_y_add = DrawItemStatsKeyValue(font, x, y, itemtbl, pnl, stats_y_add, k, v, ctrldown)
		stats_drawn[tostring(k)] = true
    end

    local talents_y_add = 0
    local talents_collection = 0

    if (itemtbl.t) then
        talents_y_add = 15
        talents_collection = 2

		local talents_s = "Talents"

		local num_talents = 0
		for k, v in ipairs(itemtbl.Talents) do
			if (itemtbl.t and itemtbl.t[k] and itemtbl.Talents[k].Description) then
				num_talents = num_talents + 1
			end
		end

		if (num_talents > 0) then
			talents_s = num_talents .. " Talent" .. ((num_talents == 1) and "" or "s")
		end

        local mutated = ""

        if (itemtbl.tr) then mutated = " (Mutated)" end
        m_DrawShadowedText(1, talents_s, font, 6, y + stats_y_add,  Color(0, 128, 255))

        surface_SetDrawColor(100, 100, 100, 50)
        surface_DrawLine(6, y + stats_y_add + 0 + 15, pnl:GetWide() - 6, y + stats_y_add + 0 + 15)
        surface_SetDrawColor(0, 0, 0, 100)
        surface_DrawLine(6, y + stats_y_add + 1 + 15, pnl:GetWide() - 6, y + stats_y_add + 1 + 15)
        local talent_name = ""
        local talent_desc = ""
        local talent_level = 0
        local talent_col = Color(255, 255, 255)
        local talent_col2 = Color(255, 255, 255)
        local talent_alpha = 255

        for k, v in ipairs(itemtbl.t) do
			if (not itemtbl.Talents[k] or not itemtbl.Talents[k].Description) then
				continue
			end

            talent_name = itemtbl.Talents[k].Name
            talent_desc = itemtbl.Talents[k].Description
            talent_col = itemtbl.Talents[k].NameColor
            talent_level = v.l
			talent_col.a = 255
            /*if (itemtbl.Talents[k].NameEffect == "fire") then
                m_DrawFireText(7, talent_name, font, 6, y + stats_y_add + talents_y_add + 2, talent_col)
            else
                m_DrawShadowedText(1, talent_name, font, 6, y + stats_y_add + talents_y_add + 2, talent_col)
            end*/
            local draw_name_x, draw_name_y = 12, y + stats_y_add + talents_y_add + 2
            local name_col = talent_col
            local tfx = itemtbl.Talents[k].NameEffect
            if (tfx == "glow") then
                m_DrawGlowingText(false, talent_name, font, draw_name_x, draw_name_y, name_col, nil, nil, true)
            elseif (tfx == "fire") then
                m_DrawFireText(7, talent_name, font, draw_name_x, draw_name_y, name_col, nil, nil, true)
            elseif (tfx == "bounce") then
                m_DrawBouncingText(talent_name, font, draw_name_x, draw_name_y, name_col, nil, nil, true)
            elseif (tfx == "enchanted") then
                m_DrawEnchantedText(talent_name, font, draw_name_x, draw_name_y, name_col, itemtbl.Talents[k].NameEffectMods and itemtbl.Talents[k].NameEffectMods[1], nil, nil, true)
			elseif (tfx == "threecolors") then
				if (not itemtbl.Talents[k].NameEffectMods[4]) then itemtbl.Talents[k].NameEffectMods[4] = 1 end
				if (not itemtbl.Talents[k].NameEffectMods[5]) then itemtbl.Talents[k].NameEffectMods[5] = RealTime() end
				if (itemtbl.Talents[k].NameEffectMods[5] <= RealTime()) then
					itemtbl.Talents[k].NameEffectMods[4] = itemtbl.Talents[k].NameEffectMods[4] + 1
					if (itemtbl.Talents[k].NameEffectMods[4] > 3) then itemtbl.Talents[k].NameEffectMods[4] = 1 end
					itemtbl.Talents[k].NameEffectMods[5] = RealTime() + (FrameTime() * 5)
				end

                m_DrawEnchantedText(talent_name, font, draw_name_x, draw_name_y, name_col, itemtbl.Talents[k].NameEffectMods[itemtbl.Talents[k].NameEffectMods[4]], nil, nil, true)
                -- m_DrawEnchantedText(talent_name, font, draw_name_x, draw_name_y, name_col, ((RealTime() % 3 == 0) and itemtbl.Talents[k].NameEffectMods[1]) or ((RealTime() % 2 == 0) and itemtbl.Talents[k].NameEffectMods[2]) or itemtbl.Talents[k].NameEffectMods[3], nil, nil, true)
            elseif (tfx == "electric") then
                m_DrawElecticText(talent_name, font, draw_name_x, draw_name_y, name_col, true)
            elseif (tfx == "frost") then
                DrawFrostingText(10, 1.5, talent_name, font, draw_name_x, draw_name_y, Color(100, 100, 255), Color(255, 255, 255))
            else
                m_DrawShadowedText(1, talent_name, font, draw_name_x, draw_name_y, name_col)
            end

            surface_SetFont(font)
            local talent_namew, talent_nameh = surface_GetTextSize(talent_name)
			surface.SetFont "moat_ItemDescSmall2"
            local talent_namew2, talent_nameh2 = surface.GetTextSize("Level " .. talent_level .. "")
            talent_col2 = Color(255, 255, 255)
            talent_alpha = Color(255, 255, 255)

            if (itemtbl.s.l < talent_level) then
                talent_col2 = Color(100, 100, 100)
                talent_alpha = Color(100, 100, 100)

				cdn.DrawImage("https://static.moat.gg/ttt/icon-lock.png", 4 + draw_name_x + talent_namew, y + stats_y_add + talents_y_add + 2 + 3, 10, 10, Color(0, 0, 0, 255))
				cdn.DrawImage("https://static.moat.gg/ttt/icon-lock.png", 3 + draw_name_x + talent_namew, y + stats_y_add + talents_y_add + 2 + 2, 10, 10, Color(100, 100, 100, 255))

				talent_namew = talent_namew + 8 + 4
            else
				local lx, ty = 4 + draw_name_x + talent_namew, y + stats_y_add + talents_y_add + 2 + 2
				cdn.DrawImage("https://static.moat.gg/ttt/icon_star.png", lx, ty, 12, 12, Color(0, 0, 0, 255))
				cdn.DrawImage("https://static.moat.gg/ttt/icon_star.png", lx - 1, ty - 1, 12, 12, Color(255, 255, 255, 255))

				talent_namew = talent_namew + 8 + 6
			end

            m_DrawShadowedText(1, "Level " .. talent_level .. "", "moat_ItemDesc", 3 + draw_name_x + talent_namew, y + stats_y_add + talents_y_add + 2, talent_col2)
            talent_desc = talent_desc or ""
            local talent_desctbl = string.Explode("^", talent_desc)

			if (#v.m > 0) then
            	for i = 1, #v.m do
					if (not itemtbl.Talents[k].Modifications or not itemtbl.Talents[k].Modifications[i]) then
						continue
					end

                	local mod_num = math.Round(itemtbl.Talents[k].Modifications[i].min + ((itemtbl.Talents[k].Modifications[i].max - itemtbl.Talents[k].Modifications[i].min) * math.min(1, v.m[i])), 1)
                
                	if (ctrldown) then
                 	   mod_num = "(" .. itemtbl.Talents[k].Modifications[i].min .. "-" .. itemtbl.Talents[k].Modifications[i].max .. ") " .. math.Round(mod_num, 2)
                	end

                	talent_desctbl[i] = string.format(talent_desctbl[i], tostring(mod_num))
            	end
			end

            talent_desc = string.Implode("", talent_desctbl)
            talent_desc = string.Replace(talent_desc, "_", "%")
            m_DrawItemDescLevel(talent_desc, font, draw_name_x + 6, y + stats_y_add + talents_y_add + 17, pnl:GetWide() - 12 - 6, talent_alpha)
            local talent_desc_h = 17 + (m_GetItemDescH(talent_desc, font, pnl:GetWide() - 12 - 6) * 15)
            local talents_line_space = 3

            if (k ~= num_talents) then
                surface_SetDrawColor(100, 100, 100, 50)
                surface_DrawLine(6, y + stats_y_add + talents_y_add + talent_desc_h + talents_line_space, pnl:GetWide() - 6, y + stats_y_add + talents_y_add + talent_desc_h + talents_line_space)
                surface_SetDrawColor(0, 0, 0, 100)
                surface_DrawLine(6, y + stats_y_add + talents_y_add + talent_desc_h + talents_line_space + 1, pnl:GetWide() - 6, y + stats_y_add + talents_y_add + talent_desc_h + talents_line_space + 1)
            end

            talents_y_add = talents_y_add + talent_desc_h + talents_line_space
        end
    end

    local collection_y = y + stats_y_add + (talents_y_add - 2) - talents_collection
    m_DrawShadowedText(1, "From the " .. itemtbl.item.Collection, "moat_Medium2", 6, collection_y, Color(100, 100, 100, 255))

    if (itemtbl.p3) then
        local p3txt = MOAT_PAINT.Skins[itemtbl.p3] and MOAT_PAINT.Skins[itemtbl.p3][1] or "Glitched Skin"
		m_DrawShadowedText(1, p3txt, "moat_Medium2", pnl:GetWide() - 6, collection_y, MOAT_PAINT.Skins[itemtbl.p3] and rarity_names[MOAT_PAINT.Skins[itemtbl.p3][3]][2]:Copy() or Color(100, 100, 100, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    end

	return collection_y + 14, stats_y_add
end

local handled_send = false
function m_HandleSending()
	if (not handled_send or (handled_send and handled_send < CurTime() - 10)) then
		net.Start("MOAT_SEND_INV_ITEM")
		net.SendToServer()

		handled_send = CurTime()
		return
	end
end

m_Loadout = m_Loadout or {{decon = false}, {decon = false}, {decon = false}, {decon = false}, {decon = false}, {decon = false}, {decon = false}, {decon = false}, {decon = false}, {decon = false}}
m_Inventory = m_Inventory or {}
m_Trade = m_Trade or {}

MOAT_INVENTORY_CREDITS = MOAT_INVENTORY_CREDITS or 0
NUMBER_OF_SLOTS = NUMBER_OF_SLOTS or 0
function m_ClearInventory()
	handled_send = CurTime()

    m_Inventory = {}
    m_Loadout = {}
    m_Trade = {}

	for i = 1, 10 do
		m_Loadout[i] = {decon = false}
	end
end

function m_GetESlots()
    local eslots = 0

    for i = 1, LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") do
        if (m_Inventory[i] and m_Inventory[i].c) then
            continue
        else
            eslots = eslots + 1
        end
    end

    return eslots
end

net.Receive("MOAT_SEND_CREDITS", function(len)
    MOAT_INVENTORY_CREDITS = math.Round(net.ReadDouble(), 2)
end)

if (NUMBER_OF_SLOTS == 0 || #m_Inventory < NUMBER_OF_SLOTS) then
	net.Start "MOAT_SEND_CREDITS"
	net.SendToServer()
end

local function readonly_rarities(tab)
	return setmetatable({}, {
	__index = tab,
	__newindex = function(t, k, v)
		if (k == 9) then
			tab[k] = v
		end
	end,
	__metatable = false
})
end



rgb_rotation = 1

rarity_names = {
	[0] = { "Stock", Color():SetHex "#606e88", { min = 10, max = 20 } }, 
	[1] = { "Worn", Color():SetHex "#ccccff", { min = 10, max = 20 } }, 
	[2] = { "Standard",  Color():SetHex "#3976f4", { min = 20, max = 40 } }, 
	[3] = { "Specialized", Color():SetHex "#ba33ff", { min = 60, max = 120 } }, 
	[4] = { "Superior", Color():SetHex "#ff00e7", { min = 240, max = 480 } }, 
	[5] = { "High-End", Color():SetHex "#fd0b30", { min = 1200, max = 2400 } }, 
	[6] = { "Ascended", Color():SetHex "#ffe300", { min = 7200, max = 14400 } }, 
	[7] = { "Cosmic", Color():SetHex "#01ff1f", { min = 25200, max = 50400 } }, 
	[8] = { "Extinct", Color():SetHex "#ff8a00", { min = 2, max = 5000 } }, 
	[9] = { "Planetary", Color(0, 0, 0, 255), { min = 25200, max = 50400 } }
}

rarity_accents = readonly_rarities {
	[0] = Color():SetHex "#808ba0" :Alpha(255),
	[1] = Color():SetHex "#d6d6ff" :Alpha(255),
	[2] = Color():SetHex "#6191f6" :Alpha(255),
	[3] = Color():SetHex "#c85cff" :Alpha(255),
	[4] = Color():SetHex "#ff33ec" :Alpha(255),
	[5] = Color():SetHex "#fd3c59" :Alpha(255),
    [6] = Color():SetHex "#ffe933" :Alpha(255),
    [7] = Color():SetHex "#34ff4c" :Alpha(255),
    [8] = Color():SetHex "#ffa133" :Alpha(255),
    [9] = Color(0, 0, 0, 255)
}

rarity_gradient = readonly_rarities {
	[0] = Color():SetHex "#4d586d" :Alpha(200),
	[1] = Color():SetHex "#a3a3cc" :Alpha(200),
	[2] = Color():SetHex "#2e5ec3" :Alpha(200),
	[3] = Color():SetHex "#9529cc" :Alpha(200),
	[4] = Color():SetHex "#cc00b9" :Alpha(200),
	[5] = Color():SetHex "#ca0926" :Alpha(255),
    [6] = Color():SetHex "#ccb600" :Alpha(255),
    [7] = Color():SetHex "#01cc19" :Alpha(255),
    [8] = Color():SetHex "#cc6e00" :Alpha(255),
    [9] = Color(0, 0, 0, 255)
}

rarity_shadow = readonly_rarities {
	[0] = {Color():SetHex "#1d2129" :Alpha(150), Color():SetHex "#13161b" :Alpha(75)},
	[1] = {Color():SetHex "#3d3d4c" :Alpha(150), Color():SetHex "#292933" :Alpha(75)},
	[2] = {Color():SetHex "#112349" :Alpha(150), Color():SetHex "#0b1831" :Alpha(75)},
	[3] = {Color():SetHex "#380f4c" :Alpha(150), Color():SetHex "#250a33" :Alpha(75)},
	[4] = {Color():SetHex "#4c0045" :Alpha(150), Color():SetHex "#33002e" :Alpha(75)},
	[5] = {Color():SetHex "#4c030e" :Alpha(150), Color():SetHex "#33020a" :Alpha(75)},
	[6] = {Color():SetHex "#4c4400" :Alpha(150), Color():SetHex "#332d00" :Alpha(75)},
	[7] = {Color():SetHex "#004c09" :Alpha(150), Color():SetHex "#003306" :Alpha(75)},
	[8] = {Color():SetHex "#4c2900" :Alpha(150), Color():SetHex "#331c00" :Alpha(75)},
	[9] = {Color(0, 0, 0, 150), Color(0, 0, 0, 75)}
}

local rgb_rotator = 0
hook.Add("Think", "moat_InventoryHSV", function()
	local hsl = {
		HSVToColor(CurTime() * 70 % 360, 1, 1),
		HSVToColor(CurTime() * 70 % 360, .8, 1),
		HSVToColor(CurTime() * 70 % 360, 1, .8),
		HSVToColor(CurTime() * 70 % 360, 1, .3),
		HSVToColor(CurTime() * 70 % 360, 1, .2)
	}

    local to = rarity_names[9][2]
    to.r, to.g, to.b = hsl[1].r, hsl[1].g, hsl[1].b
	rarity_accents[9] = Color(hsl[2].r, hsl[2].g, hsl[2].b, 255)
	rarity_gradient[9] = Color(hsl[3].r, hsl[3].g, hsl[3].b, 255)
	rarity_shadow[9] = {Color(hsl[4].r, hsl[4].g, hsl[4].b, 150), Color(hsl[5].r, hsl[5].g, hsl[5].b, 75)}

	if (rgb_rotator <= RealTime()) then		
		rgb_rotation = rgb_rotation + 1
		rgb_rotator = RealTime() + 1
	end
end)

local m_LoadoutLabels = {"Primary", "Secondary", "Melee", "Power-Up", "Special", "Head", "Mask", "Body", "Effect", "Model"}
MOAT_INV_CAT = 1

function m_isTrading(ply)
    return ply:GetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
end

MOAT_INV_BG_W = 400 + 350// + 105
MOAT_INV_BG_H = 550 + 5// + 25

MOAT_ITEMS_DECON_MARKED = MOAT_ITEMS_DECON_MARKED or 0
M_TRADE_PLYTBL = M_TRADE_PLYTBL or {}
local light_gradient = Material("sprites/light_ignorez")
local circ_gradient = Material("moat_inv/moat_circle_grad.png")
local mat_info = Material("icon16/information.png")
function surface_DrawTexturedRectRotatedPoint( x, y, w, h, rot, x0, y0 )

    local c = math.cos( math.rad( rot ) )
    local s = math.sin( math.rad( rot ) )

    local newx = y0 * s - x0 * c
    local newy = y0 * c + x0 * s

    surface_DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )

end

M_INV_SLOT = M_INV_SLOT or {}
M_LOAD_SLOT = M_LOAD_SLOT or {}
M_TRADE_SLOT = M_TRADE_SLOT or {}
-- {{"Loadout", 90}, {"Shop", 90}, {"Trading", 90}, {"Gamble", 90}, {"Dailies", 90}, {"Settings", 90}, {"Event", 90}, {"Store", 90}}
local catw = math.floor(MOAT_INV_BG_W/9)
MOAT_INV_CATS = {{"Loadout", catw}, {"Player", catw}, {"Trading", catw}, {"Shop", catw}, {"Gamble", catw}, {"Dailies", catw}, {"Settings", catw}, {"Event", catw}, {"Store", catw}}
function m_PaintVBar(sbar)

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end
    local VBARP = MT[CurTheme].VBAR_PAINT

    local smooth_scrolling = GetConVar("moat_continue_scrolling"):GetInt()

    sbar.LerpTarget = 0

    function sbar:AddScroll(dlta)
        local OldScroll = self.LerpTarget or self:GetScroll()

        if (smooth_scrolling > 0) then
            dlta = dlta * 75
        else
            dlta = dlta * 50
        end

        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())
        return OldScroll != self:GetScroll()
    end

    sbar.Think = function(s)
        local frac = FrameTime() * 5

        if (smooth_scrolling > 0) then
            if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize/10)) then frac = FrameTime() * 2 end
        else
            frac = FrameTime() * 10
        end

        local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
        newpos = math.Clamp(newpos, 0, s.CanvasSize)

        s:SetScroll(newpos)

        if (s.LerpTarget < 0 and s:GetScroll() == 0) then
            s.LerpTarget = 0
        end

        if (s.LerpTarget > s.CanvasSize and s:GetScroll() == s.CanvasSize) then
            s.LerpTarget = s.CanvasSize
        end

		local p = sbar:GetParent()
		if (IsValid(p)) then
			p.Scroll = newpos
		end
    end

    sbar.moving = false

    function sbar:Paint(w, h)
        VBARP.PAINT(self, w, h)
    end

    function sbar.btnGrip:Paint(w, h)
        VBARP.GRIP(self, w, h, sbar)
    end

    if (MT[CurTheme].DisableScrollBtns) then
        sbar.btnUp:SetTall(0)
        sbar.btnDown:SetTall(0)

        sbar:InvalidateLayout(true)
    end

    function sbar.btnUp:Paint(w, h)
        VBARP.UP(self, w, h)
    end

    function sbar.btnDown:Paint(w, h)
        VBARP.DOWN(self, w, h)
    end

end


MOAT_DECONSTRUCT_ITEMS_START = MOAT_DECONSTRUCT_ITEMS_START or 0
MOAT_DECONSTRUCT_ITEMS_END = MOAT_DECONSTRUCT_ITEMS_END or 0
ITEM_EDIT_MODE = ITEM_EDIT_MODE or false
HoveringSlot = HoveringSlot or false
m_HoveredSlot = m_HoveredSlot or 0
INV_SELECT_MODE = INV_SELECT_MODE or false
INV_SELECTED_ITEM = INV_SELECTED_ITEM or nil
MOAT_SKIN_ALPHA = MOAT_SKIN_ALPHA or 15

local disable_freeic = CreateClientConVar("moat_steam_group", 0, true, false)
function m_OpenInventory(ply2, utrade)
    moat_inv_cooldown = CurTime() + 1

    if (#m_Inventory < LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 100)) then
		m_HandleSending()

		if (IsValid(ply2) and utrude) then
			net.Start("MOAT_RESPOND_TRADE")
        	net.WriteBool(false)
        	net.WriteDouble(m_ply2:EntIndex())
        	net.WriteDouble(m_utrade)
        	net.SendToServer()
		end

		local num = math.Round((#m_Inventory / NUMBER_OF_SLOTS) * 100, 2)
		if (NUMBER_OF_SLOTS == 0) then
			num = 1
		end
        -- chat.AddText("Loading... ", moat_green, " Receiving Inventory",  moat_lyanblue, " | ", moat_cyan, num .. "%", moat_lyanblue, " | ", Color(254, 60, 114), net.Line())	

        return
    end

	for i = 1, #m_Inventory do
		if (m_Inventory[i]) then
            m_Inventory[i].decon = false
        end
	end

    MOAT_ITEMS_DECON_MARKED = 0
    MOAT_DECONSTRUCT_ITEMS_START = 0
    MOAT_DECONSTRUCT_ITEMS_END = 0
    m_HoveredSlot = 0
	HoveringSlot = false
    INV_SELECT_MODE = false
    INV_SELECTED_ITEM = nil

    local MAX_SLOTS = LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 0)
    M_INV_DRAG = nil
    m_ply2 = ply2 or nil
    m_utrade = utrade or nil
    M_INV_SLOT = {}
    M_LOAD_SLOT = {}

    if (m_ply2 and m_utrade) then
        MOAT_INV_CAT = 3
    else
        MOAT_INV_CAT = 1
    end

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end
    local MT_TCOL = MT[CurTheme].TextColor
    local MT_TSHADOW = MT[CurTheme].TextShadow

    local m_InventoryButtons = {}
	MOAT_INV_BG = ux.Create("DFrame", function(s)
		s:Setup(ux.CenterX(MOAT_INV_BG_W), -ux.CenterY(MOAT_INV_BG_H), MOAT_INV_BG_W, MOAT_INV_BG_H)
		s:BounceIn()
		-- s:SetAlpha(0)
		s:MakePopup()
		s:SetKeyboardInputEnabled(false)
		s:ShowCloseButton(false)
		s:SetFestive(0, 0, MOAT_INV_BG_W, MOAT_INV_BG_H)
		s.Theme = MT[CurTheme]
	end, {Paint = function(s, w, h)
		if (MT[CurTheme].BG_PAINT) then
			return MT[CurTheme].BG_PAINT(s, w, h)
		end

		/*local num = math.abs(math.sin((RealTime() - (0.08)) * 1))
		DisableClipping(true)
            surface.SetDrawColor(255, 85 * num, 85 * num, 255)
            surface.DrawRect(0, -30, w, 30)
            draw.SimpleTextOutlined("You are on the test server. Items and IC here will not be available on the live servers.", "moat_ItemDesc", w/2, -15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))
        DisableClipping(false)*/
		ux.Blur(s, 4)

		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)

		cdn.DrawImage("https://static.moat.gg/f/413567786280d852aaf0abec6e188865.png", 0, 0, 1024, 1024, Color(255, 255, 255, 250))
	end, Think = function(s)
		if (not input.IsMouseDown(MOUSE_LEFT) and M_INV_DRAG) then
			m_SwapInventorySlots(M_INV_DRAG, m_HoveredSlot, m_utrade)
			sfx.Cut()
			M_INV_DRAG = nil
        end

		if (not IsValid(M_SLOT_D)) then
			return
		end

		if (M_INV_DRAG) then
            local x, y = gui.MousePos()
			local dragx, dragy = M_SLOT_D:GetPos()
			if (dragx ~= x + 1 or dragy ~= y + 1) then
				M_SLOT_D:SetPos(x + 1, y + 1)
			end

			M_SLOT_D:SetModel(M_INV_DRAG.VGUI.WModel, M_INV_DRAG.VGUI.MSkin)
			if (not M_SLOT_D:IsVisible()) then M_SLOT_D:SetVisible(true) end
        else
            M_SLOT_D:SetVisible(false)
        end
	end, OnRemove = function()
        net.Start "moat_OpenInventory"
        	net.WriteBool(false)
        net.SendToServer()
    end, OnClose = function()
        net.Start "moat_OpenInventory"
        	net.WriteBool(false)
        net.SendToServer()
    end})

    --createSpring(MOAT_INV_BG, 0, 0, MOAT_INV_BG_W, MOAT_INV_BG_H)

    function m_TradingPanel()
		if (IsValid(M_TRADING_PNL)) then
			M_TRADING_PNL:Remove()
		end

		M_TRADING_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_TRADING_PNL:SetSize(385, MOAT_INV_BG:GetTall())
		M_TRADING_PNL:SetPos(-385, 0)
		M_TRADING_PNL:SetAlpha(0)

		M_TRADING_PNL.Paint = function(s, w, h)
			local box_x = 5
			local box_y = 30
			local box_w = w - (box_x * 2) - 7
			local box_h = h - box_y - 5
			local box_col = Color(0, 0, 0, 150)
		end

		M_TRADE_PLYLIST = vgui.Create("DScrollPanel", M_TRADING_PNL)
		M_TRADE_PLYLIST:SetPos(6, 35)
		M_TRADE_PLYLIST:SetSize(368, MOAT_INV_BG:GetTall() - 40)
		M_TRADE_PLYLIST.Text = "Click on a player below to send them a trade request."
		M_TRADE_PLYLIST.TextCol = 255
		M_TRADE_PLYLIST.Paint = function(s, w, h) end

		local sbar = M_TRADE_PLYLIST:GetVBar()
		m_PaintVBar(sbar)

		M_TRADE_LBL = vgui.Create("DLabel", M_TRADE_PLYLIST)
		M_TRADE_LBL:SetPos(0, 0)
		M_TRADE_LBL:SetFont("moat_ItemDesc")
		M_TRADE_LBL:SetText("Click on a player below to send them a trade request.")
		M_TRADE_LBL:SetSize(M_TRADE_PLYLIST:GetWide() - 10, 20)
		M_TRADE_LBL:SetTextColor(MT_TCOL)

		function M_TRADE_LBL:TransitionText(new, anim1, anim2, delay1)
			local delay1 = delay1 or 0
			self:AlphaTo(0, anim1, delay1)

			timer.Simple(anim1 + delay1, function()
				if (not IsValid(self)) then return end
				self:SetText(new)
			end)

			self:AlphaTo(255, anim2, anim1 + delay1)
		end

		M_TRADE_PLYS = vgui.Create("DIconLayout", M_TRADE_PLYLIST)
		M_TRADE_PLYS:SetPos(0, 24)
		M_TRADE_PLYS:SetSize(368, MOAT_INV_BG:GetTall() - 54)
		M_TRADE_PLYS:SetSpaceX(0)
		M_TRADE_PLYS:SetSpaceY(3)
		M_TRADE_PLYS.Waiting = false
		M_TRADE_PLYTBL = {}

		function m_AddPlayerTradeList(v)
			for k, pnl in ipairs(M_TRADE_PLYTBL) do
				if (IsValid(pnl) and pnl.Ply == v) then
					return
				end
			end

			local hover_coloral = 0
			local random_color_m = {math.random(255), math.random(255), math.random(255)}
			local M_LINE = M_TRADE_PLYS:Add("DPanel")
			M_LINE:SetSize(M_TRADE_PLYS:GetWide(), 32)
			M_LINE.Ply = v
			M_LINE.Stage = 0
			M_LINE.Timer = 30
			M_LINE.CurTimer = 1
			M_LINE.TimerActive = false
			M_LINE.Paint = function(s, w, h)
				surface_SetDrawColor(0, 0, 0, 150)
				surface_DrawRect(0, 0, w, h)
				surface_SetDrawColor(50, 50, 50, hover_coloral)
				surface_DrawRect(0, 0, w, h)
				surface_SetDrawColor(62, 62, 64, 255)
				surface_DrawOutlinedRect(0, 0, w, h)

				if (s.Stage == 0) then
					surface_DrawOutlinedRect(31, 1, 1, h - 2)
				end

				if (s.Stage == 1) then
					if (M_LINE.TimerActive and M_LINE.CurTimer <= CurTime()) then
						M_LINE.CurTimer = CurTime() + 1

						if (M_LINE.Timer <= 0) then
							M_TRADE_PLYS.Waiting = false
							M_TRADE_PLYS.RequestSent = true
							M_TRADE_PLYS:RebuildList()

							return
						end

						M_LINE.Timer = M_LINE.Timer - 1
					end

					m_DrawShadowedText(1, "Trade request sent to:", "Trebuchet24", w / 2, 243, Color(255, 255, 255), TEXT_ALIGN_CENTER)
					m_DrawShadowedText(1, (IsValid(v) and v:Nick()) or "Disconnected", "Trebuchet24", w / 2, 278, Color(0, 200, 0), TEXT_ALIGN_CENTER)
					local ava_x, ava_y = s:GetChildren()[2]:GetPos()
					local ava_w, ava_h = s:GetChildren()[2]:GetSize()
					--draw_RoundedBox( 0, ava_x - 2, ava_y - 2, ava_w + 4, ava_h + 4, Color( 62, 62, 64, 255 ) )
					local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))

					if (size_change < 0.02) then
						random_color_m = {math.random(255), math.random(255), math.random(255)}
					end

					surface_SetDrawColor(62, 62, 64, 255)
					draw.NoTexture()
					surface_DrawCircle(w / 2, 375, 50 * size_change, random_color_m[1], random_color_m[2], random_color_m[3], 255)
					surface_DrawCircle(w / 2, 375, 34 * size_change, random_color_m[1], random_color_m[2], random_color_m[3], 255)
					surface_DrawCircle(w / 2, 375, 17 * size_change, random_color_m[1], random_color_m[2], random_color_m[3], 255)
					m_DrawShadowedText(1, "Waiting for them to respond... " .. s.Timer, "Trebuchet24", w / 2, 450, Color(255, 255, 255), TEXT_ALIGN_CENTER)
				end
			end

			local M_NAME = vgui.Create("DLabel", M_LINE)
			M_NAME:SetText(v:Nick())
			M_NAME:SetFont("moat_ItemDesc")
			M_NAME:SetPos(37, 2)
			M_NAME:SetSize(M_LINE:GetWide() - 40, 28)
			local M_AVA = vgui.Create("AvatarImage", M_LINE)
			M_AVA:SetPos(1, 1)
			M_AVA:SetSize(30, 30)
			M_AVA:SetPlayer(v, 128)
			local M_LINE_BTN = vgui.Create("DButton", M_LINE)
			M_LINE_BTN:SetText("")
			M_LINE_BTN:SetSize(M_LINE:GetWide(), M_LINE:GetTall())
			M_LINE_BTN.Paint = function(s, w, h) end
			local btn_hovered = 1
			local btn_color_a = false

			M_LINE_BTN.Think = function(s)
				if (not s:IsHovered()) then
					btn_hovered = 0
					btn_color_a = false

					if (hover_coloral > 0) then
						hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
					end
				else
					if (IsValid(M_INV_MENU)) then
						if (M_INV_MENU.Hovered) then
							btn_hovered = 0
							btn_color_a = false

							if (hover_coloral > 0) then
								hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
							end

							return
						end
					end

					--m_HoveredSlot = num

					if (hover_coloral < 154 and btn_hovered == 0) then
						hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
					else
						btn_hovered = 1
					end

					if (btn_hovered == 1) then
						if (btn_color_a) then
							if (hover_coloral >= 154) then
								btn_color_a = false
							else
								hover_coloral = hover_coloral + (100 * FrameTime())
							end
						else
							if (hover_coloral <= 50) then
								btn_color_a = true
							else
								hover_coloral = hover_coloral - (100 * FrameTime())
							end
						end
					end
				end
			end

			M_LINE_BTN.DoClick = function(s)
				if (M_LINE.Stage == 0) then
					M_TRADE_PLYS.Waiting = true

					net.Start("MOAT_SEND_TRADE_REQ")
					net.WriteDouble(v:EntIndex())
					net.SendToServer()
				end
			end

			sfx.SoundEffects(M_LINE_BTN)
			--surface.PlaySound( "UI/buttonrollover.wav" )
			table.insert(M_TRADE_PLYTBL, M_LINE)
		end

		local lp = LocalPlayer()

		function m_CheckNumPlayersList(max)
			if (IsValid(M_TRADE_PLYS) and #M_TRADE_PLYTBL > max) then
				for k, v in pairs(M_TRADE_PLYTBL) do
					if (IsValid(v) and IsValid(M_TRADE_PLYS)) then
						v:SetWide(M_TRADE_PLYS:GetWide() - 23)
					end
				end
			end
		end

		function M_TRADE_PLYS:RebuildList()
			if (IsValid(lp) and lp:IsActive()) then
				M_TRADE_LBL:SetText("Currently unavailable while I'm alive during the round! <3")
			else
				M_TRADE_LBL:SetText("Click on a player below to send them a trade request.")
			end

			if (M_TRADE_PLYS.Waiting) then
				return
			end

			if (M_TRADE_PLYS.RequestSent) then
				for _, pnl in ipairs(M_TRADE_PLYTBL) do
					if (IsValid(pnl)) then
						pnl:Remove()
					end
				end
				
				M_TRADE_PLYS.RequestSent = false
			end

			for k, v in SortedPairs(player.GetAll()) do
				if (v == lp) then continue end
			
				if ((lp:Team() == TEAM_SPEC and v:Team() == TEAM_SPEC) or (GetRoundState() ~= ROUND_ACTIVE)) then
					m_AddPlayerTradeList(v)
					m_CheckNumPlayersList(13)
				else
					local MarkedForRemove

					for _, pnl in ipairs(M_TRADE_PLYTBL) do
						if (IsValid(pnl) and pnl.Ply == v) then
							MarkedForRemove = _
							pnl:Remove()
						end
					end

					if (MarkedForRemove) then
						table.remove(M_TRADE_PLYTBL, MarkedForRemove)
					end

					m_CheckNumPlayersList(13)
				end
			end
		end
		
		M_TRADE_PLYS:RebuildList()

		M_TRADE_PLYS.NextThink = 0
		M_TRADE_PLYS.Think = function(s)
			if ((s.NextThink > CurTime()) or (MOAT_INV_CAT and MOAT_INV_CAT ~= 3) or (IsValid(MOAT_TRADE_BG))) then
				if (IsValid(MOAT_TRADE_BG)) then s:Remove() end
				return
			end

			s:RebuildList()

			s.NextThink = CurTime() + 0.1
		end
	end

    local help_pnl_w = 385 - (5 * 2) - 7
    help_pnl_h = MOAT_INV_BG:GetTall() - 35 - 5

	function m_StatsPanel()
		if (IsValid(M_STATS_PNL)) then
			M_STATS_PNL:Remove()
		end

		M_STATS_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_STATS_PNL:SetSize(385, MOAT_INV_BG:GetTall())
		M_STATS_PNL:SetPos(-385, 0)
		M_STATS_PNL:SetAlpha(0)

		M_STATS_PNL.Paint = function(s, w, h)
			local box_x = 5
			local box_y = 30
			local box_col = Color(0, 0, 0, 150)
		end

		--draw_RoundedBox( 0, 5, 30, w - ( box_x * 2 ) - 7, h - box_y - 5, box_col )
		local M_STATS_PNL1 = vgui.Create("DPanel", M_STATS_PNL)
		M_STATS_PNL1:SetSize(help_pnl_w - 2, help_pnl_h)
		M_STATS_PNL1:SetPos(7, 35)
		M_STATS_PNL1.Paint = nil
		m_PopulateStats(M_STATS_PNL1)
	end

	function m_ShopPanel()
		if (IsValid(M_SHOP_PNL)) then
			M_SHOP_PNL:Remove()
		end

		M_SHOP_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_SHOP_PNL:SetSize(385, MOAT_INV_BG:GetTall())
		M_SHOP_PNL:SetPos(-385, 0)
		M_SHOP_PNL:SetAlpha(0)

		M_SHOP_PNL.Paint = function(s, w, h)
			--local box_x = 5
			--local box_y = 30
			--draw_RoundedBox(0, 5, 30, w - 10, h - 35, Color(0, 0, 0, 150))
		end

		local M_SHOP_PNL1 = vgui.Create("DScrollPanel", M_SHOP_PNL)
		M_SHOP_PNL1:SetSize(help_pnl_w - 2, help_pnl_h)
		M_SHOP_PNL1:SetPos(7, 35)
		M_SHOP_PNL1.Theme = MT[CurTheme]
		m_BuildShop(M_SHOP_PNL1, help_pnl_w - 2, help_pnl_h)

		local sbar = M_SHOP_PNL1:GetVBar()
		m_PaintVBar(sbar)
	end

	function m_UsablePanel()
		if (IsValid(M_USABLE_PNL)) then
			M_USABLE_PNL:Remove()
		end

		M_USABLE_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_USABLE_PNL:SetSize(385, MOAT_INV_BG:GetTall())
		M_USABLE_PNL:SetPos(-385, 0)
		M_USABLE_PNL:SetAlpha(0)

		M_USABLE_PNL.Paint = function(s, w, h)
			local box_x = 5
			local box_y = 35
			local box_col = Color(0, 0, 0, 150)
			surface_SetDrawColor(box_col)
			surface_DrawRect(5, 35, w - (box_x * 2) - 7, h - box_y - 5)
		end
	end

	function m_BountyPanel()
		if (IsValid(M_BOUNTY_PNL)) then
			M_BOUNTY_PNL:Remove()
		end

		M_BOUNTY_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_BOUNTY_PNL:SetSize(MOAT_INV_BG_W, MOAT_INV_BG:GetTall())
		M_BOUNTY_PNL:SetPos(-MOAT_INV_BG_W, 0)
		M_BOUNTY_PNL:SetAlpha(0)
		M_BOUNTY_PNL.Paint = function(s, w, h) end

		local M_BOUNTY_PNL_SCROLL = vgui.Create("DScrollPanel", M_BOUNTY_PNL)
		M_BOUNTY_PNL_SCROLL:SetSize(MOAT_INV_BG_W-10, help_pnl_h)
		M_BOUNTY_PNL_SCROLL:SetPos(5, 35)
		m_PopulateBountiesPanel(M_BOUNTY_PNL_SCROLL)
	end

	function m_SettingsPanel()
		if (IsValid(M_SETTINGS_PNL)) then
			M_SETTINGS_PNL:Remove()
		end

		M_SETTINGS_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_SETTINGS_PNL:SetSize(MOAT_INV_BG_W, MOAT_INV_BG:GetTall())
		M_SETTINGS_PNL:SetPos(-MOAT_INV_BG_W, 0)
		M_SETTINGS_PNL:SetAlpha(0)
		M_SETTINGS_PNL.Paint = function(s, w, h) end

		M_SETTINGS_PNL_SCROLL = vgui.Create("DScrollPanel", M_SETTINGS_PNL)
		M_SETTINGS_PNL_SCROLL:SetSize(MOAT_INV_BG_W-10, help_pnl_h)
		M_SETTINGS_PNL_SCROLL:SetPos(5, 35)
		m_PopulateSettingsPanel(M_SETTINGS_PNL_SCROLL)
	end

	function m_EventPanel()
		if (IsValid(M_EVENT_PNL)) then
			M_EVENT_PNL:Remove()
		end

		M_EVENT_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_EVENT_PNL:SetSize(MOAT_INV_BG_W, MOAT_INV_BG:GetTall())
		M_EVENT_PNL:SetPos(-MOAT_INV_BG_W, 0)
		M_EVENT_PNL:SetAlpha(0)
		M_EVENT_PNL.Paint = function(s, w, h) end

		M_EVENT_PNL_SCROLL = vgui.Create("DScrollPanel", M_EVENT_PNL)
		M_EVENT_PNL_SCROLL:SetSize(MOAT_INV_BG_W-10, help_pnl_h)
		M_EVENT_PNL_SCROLL:SetPos(5, 35)
		m_PopulateEventPanel(M_EVENT_PNL_SCROLL)
	end

    /*M_DONATE_PNL = vgui.Create("DPanel", MOAT_INV_BG)
    M_DONATE_PNL:SetSize(MOAT_INV_BG_W, MOAT_INV_BG:GetTall())
    M_DONATE_PNL:SetPos(-MOAT_INV_BG_W, 0)
    M_DONATE_PNL:SetAlpha(0)
    M_DONATE_PNL.Paint = function(s, w, h) end

    local M_DONATE_PNL_SCROLL = vgui.Create("DPanel", M_DONATE_PNL)
    M_DONATE_PNL_SCROLL:SetSize(MOAT_INV_BG_W-10, help_pnl_h)
    M_DONATE_PNL_SCROLL:SetPos(5, 30)
    m_PopulateDonatePanel(M_DONATE_PNL_SCROLL)*/

    /*if (LocalPlayer():EventMenu()) then
        M_EVENTS_PNL = vgui.Create("DPanel", MOAT_INV_BG)
        M_EVENTS_PNL:SetSize(MOAT_INV_BG_W, MOAT_INV_BG:GetTall())
        M_EVENTS_PNL:SetPos(-MOAT_INV_BG_W, 0)
        M_EVENTS_PNL:SetAlpha(0)

        M_EVENTS_PNL.Paint = function(s, w, h)
        end

        local M_EVENTS_LAYOUT = vgui.Create("DPanel", M_EVENTS_PNL)
        M_EVENTS_LAYOUT:SetSize(MOAT_INV_BG_W-10, help_pnl_h)
        M_EVENTS_LAYOUT:SetPos(5, 30)
        m_PopulateEventsMenu(M_EVENTS_LAYOUT, MOAT_INV_BG_W-10, help_pnl_h)
    end*/

	function m_LoadoutPanel(init)
		if (IsValid(M_LOADOUT_PNL)) then
			M_LOADOUT_PNL:Remove()
		end

		M_LOADOUT_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_LOADOUT_PNL:SetSize(385, MOAT_INV_BG:GetTall())

		if (not m_utrade and not m_ply2 and init) then
			M_LOADOUT_PNL:SetPos(0, 0)
		else
			M_LOADOUT_PNL:SetPos(-M_LOADOUT_PNL:GetWide(), 0)
			M_LOADOUT_PNL:SetAlpha(0)
		end

		M_LOADOUT_PNL.Paint = nil
		M_INV_PMDL_PNL = vgui.Create("DPanel", M_LOADOUT_PNL)
		M_INV_PMDL_PNL:SetPos(93, 70)
		M_INV_PMDL_PNL:SetSize(192, 475)
		M_INV_PMDL_PNL.Paint = nil
		M_INV_PMDL = vgui.Create("MOAT_PlayerPreview", M_INV_PMDL_PNL)
		M_INV_PMDL:SetSize(350, 550)
		M_INV_PMDL:SetPos(-60, 0)
		M_INV_PMDL.ShowParticles = true
		--M_INV_PMDL.ParticleInventory = true
		M_INV_PMDL:SetText("")

		local set_model = false

		if (m_Loadout) then
			for i = 6, 10 do
				if (IsValid(M_INV_PMDL) and m_Loadout[i] and m_Loadout[i].c) then
					if (m_Loadout[i].item and m_Loadout[i].item.Kind and m_CosmeticSlots[m_Loadout[i].item.Kind]) then
						M_INV_PMDL:AddModel(m_Loadout[i].u, m_Loadout[i])
					end

					if (m_Loadout[i].item and m_Loadout[i].item.Kind == "Model") then
						M_INV_PMDL:SetModel(m_Loadout[i].u, m_Loadout[i])
						set_model = true
					end
				end
			end
		end

		if (not set_model) then
			M_INV_PMDL:SetModel(GetGlobal("ttt_default_playermodel") or "models/player/phoenix.mdl")
		end

		local M_INV_NICK = Label(LocalPlayer():Nick(), M_LOADOUT_PNL)
		M_INV_NICK:SetFont("moat_Medium11")
		M_INV_NICK:SetTextColor(MT[CurTheme].TextColor)
		--M_INV_NICK:SetTextColor(Color(255, 255, 255))
		M_INV_NICK:SetPos(4, 24)
		M_INV_NICK:SetSize(370, 40)
		M_INV_NICK:SetContentAlignment(5)
		M_INV_NICK.DoClick = function(s, w, h)
			/*net.Start("MOAT_INV_CAT")
			net.WriteDouble(2)
			net.SendToServer()*/

			m_ChangeInventoryPanel(-1, false)
		end
		M_INV_NICK:SetMouseInputEnabled(true)
		M_INV_NICK:SetCursor("hand")
		
		sfx.HoverSound(M_INV_NICK, sfx.Click2)
		sfx.ClickSound(M_INV_NICK)

		local M_INV_RANK = vgui.Create("DPanel", M_LOADOUT_PNL)
		M_INV_RANK:SetPos(4, 60)
		M_INV_RANK:SetSize(370, 12)

		M_INV_RANK.Paint = function(s, w, h)
			local cur_level = LocalPlayer():GetNW2Int("MOAT_STATS_LVL", 1)
			if (MT_TSHADOW) then
				m_DrawShadowedText(1, cur_level, "moat_Medium3", 24, 5, MT_TCOL, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				m_DrawShadowedText(1, cur_level + 1, "moat_Medium3", 346, 5, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			else
				draw_SimpleText(cur_level, "moat_Medium3", 24, 5, MT_TCOL, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				draw_SimpleText(cur_level + 1, "moat_Medium3", 346, 5, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			surface_SetDrawColor(137, 137, 137, 255)
			surface_DrawOutlinedRect(29, 2, 312, 8)
			surface_SetDrawColor(200, 200, 200, 255)
			surface_SetMaterial(gradient_r)
			surface_DrawTexturedRect(30, 3, 310, 6)
			local bar_width = 310
			local xp_needed = cur_level * 1000
			local cur_xp = LocalPlayer():GetNW2Int("MOAT_STATS_XP", 1)
			local bar_times = (cur_xp / xp_needed)
			bar_width = bar_width * bar_times
			-- surface_SetDrawColor(255 - (255 * bar_times), 255 * bar_times, 0, 255)
			surface_SetDrawColor(255, 255, 255)
			surface_DrawRect(30 + bar_width, 0, 2, h)
		end

		local inv_pnl_x2 = MOAT_INV_BG:GetWide() - (350 + 14) - 18 - 5 - 78
		M_INV_LP = vgui.Create("DPanel", M_LOADOUT_PNL)
		M_INV_LP:SetPos(inv_pnl_x2, MOAT_INV_BG:GetTall() - 452 - 18)
		M_INV_LP:SetSize(74, 460)
		M_INV_LP.Paint = function(s, w, h) end
		M_INV_LL = vgui.Create("DIconLayout", M_INV_LP)
		M_INV_LL:SetPos(0, 0)
		M_INV_LL:SetSize(74, 460)
		M_INV_LL:SetSpaceX(0)
		M_INV_LL:SetSpaceY(8)
		local inv_pnl_x3 = 18
		M_INV_LPA = vgui.Create("DPanel", M_LOADOUT_PNL)
		M_INV_LPA:SetPos(inv_pnl_x3, MOAT_INV_BG:GetTall() - 452 - 18)
		M_INV_LPA:SetSize(74, 460)
		M_INV_LPA.Paint = function(s, w, h) end
		M_INV_LLA = vgui.Create("DIconLayout", M_INV_LPA)
		M_INV_LLA:SetPos(0, 0)
		M_INV_LLA:SetSize(74, 460)
		M_INV_LLA:SetSpaceX(0)
		M_INV_LLA:SetSpaceY(8)

		function m_CreateLoadoutSlot(num)
			local m_ItemExists = false
			if (not m_Loadout[num]) then return end

			if (m_Loadout[num].c) then
				m_ItemExists = true
			end

			local m_WClass = {}

			if (m_ItemExists) then
				if (m_Loadout[num].item.Image) then
					m_WClass.WorldModel = m_Loadout[num].item.Image
				elseif (m_Loadout[num].item.Model) then
					m_WClass.WorldModel = m_Loadout[num].item.Model
					m_WClass.ModelSkin = m_Loadout[num].item.Skin
				else
					m_WClass = weapons.Get(m_Loadout[num].w)
				end
			end

			local hover_coloral = 0
			local panel_to_add = M_INV_LL

			if (num > 5) then
				panel_to_add = M_INV_LLA
			end

			local m_DPanel = panel_to_add:Add("DPanel")
			m_DPanel:SetSize(74, 84)
			local osx = system.IsOSX()
			m_DPanel.Paint = function(s, w, h)
				local y2 = 10
				if (osx) then
					draw.DrawText(m_LoadoutLabels[num], "ux.10", w / 2, 0, MT_TCOL, TEXT_ALIGN_CENTER)
				else
					draw.DrawText(m_LoadoutLabels[num], "moat_Medium9", w / 2, -3, MT_TCOL, TEXT_ALIGN_CENTER)
				end
				surface_SetDrawColor(62, 62, 64, 255)
				surface_DrawOutlinedRect(0, 0 + y2, w, h - y2)
				surface_SetDrawColor(0, 0, 0, 100)
				surface_DrawRect(1, 1 + y2, w - 2, h - 2 - y2)
				local draw_x = 2 + 3
				local draw_y = 2 + y2 + 3
				local draw_w = w - 4 - 6
				local draw_h = h - 4 - y2 - 6
				local draw_y2 = 2 + ((h - 4) / 2) + y2 + 3
				local draw_h2 = (h - 4) - ((h - 4) / 2) - y2 - 6

				if (MT[CurTheme].LSLOT_PAINT) then
					MT[CurTheme].LSLOT_PAINT(s, w, h, hover_coloral, m_Loadout[num])

					return
				end

				surface_SetDrawColor(0, 0, 0, 100)
				surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
				surface_SetDrawColor(50, 50, 50, hover_coloral)
				surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
				if (not m_Inventory[num]) then return end

				if (m_Loadout[num].c) then
					surface_SetDrawColor(150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 100)
					surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
					surface_SetDrawColor(rarity_names[m_Loadout[num].item.Rarity][2].r, rarity_names[m_Loadout[num].item.Rarity][2].g, rarity_names[m_Loadout[num].item.Rarity][2].b, 100 + hover_coloral)
					surface_SetMaterial(gradient_d)
					surface_DrawTexturedRect(draw_x, draw_y2 - (hover_coloral / 7), draw_w, draw_h2 + (hover_coloral / 7) + 1)
				end

				surface_SetDrawColor(62, 62, 64, 255)

				if (m_Loadout[num].c) then
					surface_SetDrawColor(rarity_names[m_Loadout[num].item.Rarity][2])
				end

				surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
				surface_SetDrawColor(62, 62, 64, hover_coloral / 2)

				if (m_Loadout[num].c) then
					surface_SetDrawColor(rarity_names[m_Loadout[num].item.Rarity][2].r, rarity_names[m_Loadout[num].item.Rarity][2].g, rarity_names[m_Loadout[num].item.Rarity][2].b, hover_coloral / 2)
				end

				surface_DrawOutlinedRect(3, y2 + 3, w - 6, h - y2 - 6)

				local triangle = {
					{
						x = 6,
						y = 6 + y2
					},
					{
						x = w - 6,
						y = w - 6 + y2
					},
					{
						x = 6,
						y = w - 6 + y2
					}
				}

				surface_SetDrawColor(50, 50, 50, 10)
				draw.NoTexture()
			end

			--  surface_DrawPoly( triangle )
			local m_DPanelIcon = {}
			m_DPanelIcon.SIcon = vgui.Create("MoatModelIcon", m_DPanel)
			m_DPanelIcon.SIcon:SetPos(3 + 2, 10 + 3 + 2)
			m_DPanelIcon.SIcon:SetSize(64, 64)
			m_DPanelIcon.SIcon:SetTooltip(nil)

			m_DPanelIcon.SIcon.Think = function(s)
				s:SetTooltip(nil)
			end

			m_DPanelIcon.SIcon:SetVisible(false)

			if (m_ItemExists and m_WClass) then
				m_DPanelIcon.SIcon:SetModel(m_WClass.WorldModel, m_WClass.ModelSkin)
				m_DPanelIcon.SIcon:SetVisible(true)
			end

			m_DPanelIcon.WModel = nil
			m_DPanelIcon.Item = nil
			m_DPanelIcon.MSkin = nil

			if (m_ItemExists and m_WClass) then
				if (not string.EndsWith(m_WClass.WorldModel, ".mdl")) then
					if (not IsValid(m_DPanelIcon.SIcon.Icon)) then m_DPanelIcon.SIcon:CreateIcon(true) end
					m_DPanelIcon.SIcon.Icon:SetAlpha(0)
				end

				m_DPanelIcon.WModel = m_WClass.WorldModel
				m_DPanelIcon.Item = m_Loadout[num]
				if (m_WClass.ModelSkin) then
					m_DPanelIcon.MSkin = m_WClass.ModelSkin
				end
			end

			m_DPanelIcon.SIcon.PaintOver = function(s, w, h)
				if (not m_Loadout[num]) then return end

				if (m_Loadout[num].c) then
					if (not string.EndsWith(m_DPanelIcon.WModel, ".mdl")) then
						s.Icon:SetAlpha(0)
						if (m_DPanelIcon.Item and m_DPanelIcon.Item.item and m_DPanelIcon.Item.item.Clr) then
							cdn.DrawImage(m_DPanelIcon.WModel, 1, 1, w, h, {r = m_DPanelIcon.Item.item.Clr[1], g = m_DPanelIcon.Item.item.Clr[2], b = m_DPanelIcon.Item.item.Clr[3], a = 255})
						elseif (m_DPanelIcon.WModel:StartWith("https")) then
							cdn.DrawImage(m_DPanelIcon.WModel, 1, 1, w, h, {r = 255, g = 255, b = 255, a = 100})
							cdn.DrawImage(m_DPanelIcon.WModel, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 255})
						else
							if (m_DPanelIcon.WModel and (not s.MatPath or (s.MatPath and m_DPanelIcon.WModel ~= s.MatPath))) then
								s.MatPath = m_DPanelIcon.WModel
								s.Mat = Material(m_DPanelIcon.WModel)
							end

							if (s.Mat) then
								surface_SetDrawColor(255, 255, 255, 100)
								surface_SetMaterial(s.Mat)
								surface_DrawTexturedRect(1, 1, w, h)
								surface_SetDrawColor(255, 255, 255, 255)
								surface_DrawTexturedRect(0, 0, w, h)
							end
						end
					else
						s.Icon:SetAlpha(255)
					end

					local locked = false

					if (m_Loadout[num].l and m_Loadout[num].l == 1) then
						locked = true
						surface_SetDrawColor(255, 255, 255)
						surface_SetMaterial(mat_lock)
						surface_DrawTexturedRect(1, 1, 16, 16)
					end

					if (m_Loadout[num].p or m_Loadout[num].p2 or m_Loadout[num].p3) then
						surface_SetDrawColor(255, 255, 255)
						surface_SetMaterial(mat_paint)
						surface_DrawTexturedRect(locked and 18 or 1, 1, 16, 16)
					end

					if (m_Loadout[num].decon) then
						surface_SetDrawColor(150, 0, 0, 200)
						surface_DrawRect(0, 0, w, h)
					end
				end
			end

			local m_DPanelBTN = vgui.Create("DButton", m_DPanel)
			m_DPanelBTN:SetPos(3, 10 + 3)
			m_DPanelBTN:SetText("")
			m_DPanelBTN:SetSize(68, 68)
			m_DPanelBTN.Paint = function(s, w, h) end
			--draw.DrawText( m_LoadoutLabels[num], "Trebuchet18", w / 2, h / 2 - 6, Color( 150, 150, 150, 50 ), TEXT_ALIGN_CENTER )
			local btn_hovered = 1
			local btn_color_a = false

			m_DPanelBTN.Think = function(s)
				if (not s:IsHovered()) then
					btn_hovered = 0
					btn_color_a = false

					if (hover_coloral > 0) then
						hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
					end

					if (m_HoveredSlot == (num .. "l")) then
						HoveringSlot = false
					end
				else
					if (IsValid(M_INV_MENU)) then
						if (M_INV_MENU.Hovered) then
							btn_hovered = 0
							btn_color_a = false

							if (hover_coloral > 0) then
								hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
							end

							return
						end
					end

					if (hover_coloral < 154 and btn_hovered == 0) then
						hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
					else
						btn_hovered = 1
					end

					if (btn_hovered == 1) then
						if (btn_color_a) then
							if (hover_coloral >= 154) then
								btn_color_a = false
							else
								hover_coloral = hover_coloral + (100 * FrameTime())
							end
						else
							if (hover_coloral <= 50) then
								btn_color_a = true
							else
								hover_coloral = hover_coloral - (100 * FrameTime())
							end
						end
					end
				end
			end

			m_DPanelBTN.OnMousePressed = function(s, key)
				if (m_DPanelIcon and m_DPanelIcon.SIcon and key == MOUSE_LEFT) then m_DPanelIcon.SIcon:DoClick() end

				if (key == MOUSE_LEFT) then
					if (m_DPanelIcon.Item ~= nil) then
						M_INV_DRAG = M_LOAD_SLOT[num]
						sfx.Click1()
						--m_DPanelIcon.SIcon:SetVisible( false )
					end
				end
				if (key == MOUSE_RIGHT) then
					if (m_DPanelIcon.Item ~= nil) then
						m_CreateItemMenu(num, true)
						sfx.Click2()
					end
				end
			end

			m_DPanelBTN.OnCursorEntered = function()
				m_HoveredSlot = num .. "l"
				HoveringSlot = true 

				if (M_LOAD_SLOT[num].VGUI.Item and M_LOAD_SLOT[num].VGUI.Item.c) then
					sfx.Hover()
				end
			end

			m_DPanelBTN.OnCursorExited = function(s)
				HoveringSlot = false
			end
			--surface.PlaySound( "UI/buttonrollover.wav" )
			--table.insert(m_InventoryButtons, m_DPanelBTN)
			local tbl = {}
			tbl.VGUI = m_DPanelIcon
			tbl.Slot = num .. "l"
			M_LOAD_SLOT[num] = tbl
		end

		M_LOAD_SLOT = {}

		for i = 1, 10 do
        	m_CreateLoadoutSlot(i)
    	end
	end

    M_INV_C = vgui.Create("DButton", MOAT_INV_BG)
    M_INV_C:SetPos(MT[CurTheme].CloseB[1], MT[CurTheme].CloseB[2])
    M_INV_C:SetSize(MT[CurTheme].CloseB[3], MT[CurTheme].CloseB[4])
    M_INV_C:SetText("")
    M_INV_C.Paint = function(s, w, h)
        MT[CurTheme].CLOSE_PAINT(s, w, h)
    end
	sfx.SoundEffects(M_INV_C)
    M_INV_C.DoClick = function(s)
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

		if (IsValid(s)) then MOAT_INV_BG:Remove() return end
    end

	MOAT_INV_BG.Cat = {}
    local CAT_WIDTHS = 0
    for k, v in ipairs(MOAT_INV_CATS) do
        local MOAT_CAT_BTN = vgui.Create("DButton", MOAT_INV_BG)
        MOAT_CAT_BTN:SetText("")

		if (v[1] == "Store") then
			MOAT_CAT_BTN:SetSize(32, MT[CurTheme].CatInfo[3])
			MOAT_CAT_BTN:SetPos(MT[CurTheme].CatSpacing + CAT_WIDTHS, MT[CurTheme].CatInfo[1])
        	--MOAT_CAT_BTN:SetPos(MT[CurTheme].CloseB[1] - MT[CurTheme].CloseB[3] - (MT[CurTheme].CloseB[2] * 2), MT[CurTheme].CatInfo[1])
        else
			MOAT_CAT_BTN:SetSize(v[2] or MT[CurTheme].CatInfo[2], MT[CurTheme].CatInfo[3])
        	MOAT_CAT_BTN:SetPos(MT[CurTheme].CatSpacing + CAT_WIDTHS, MT[CurTheme].CatInfo[1])
		end

        MOAT_CAT_BTN.CatLabel = v[1]
        MOAT_CAT_BTN.CAT_NUM = k
        MOAT_CAT_BTN.btn_hovered = 1
        MOAT_CAT_BTN.hover_coloral = 0
        MOAT_CAT_BTN.btn_color_a = false

        MOAT_CAT_BTN.Paint = function(s, w, h)
			-- if (s.CatLabel == "Store") then
			-- 	cdn.DrawImage("https://ttt.dev/pdaQK.png", (w/2)-8, (h/2)-8, 16, 16, Color(255, 255, 255, 100 + s.hover_coloral))

            --     return
            -- end

            MT[CurTheme].CAT_PAINT(s, w, h, MOAT_INV_CAT)
        end

        local btn_hovered = 1
        local btn_color_a = false

        MOAT_CAT_BTN.Think = function(s)
            if (not s:IsHovered()) then
                s.btn_hovered = 0
                s.btn_color_a = false

                if (s.hover_coloral > 0) then
                    s.hover_coloral = Lerp(2 * FrameTime(), s.hover_coloral, 0)
                end
            else
                if (IsValid(M_INV_MENU)) then
                    if (M_INV_MENU.Hovered) then
                        s.btn_hovered = 0
                        s.btn_color_a = false

                        if (s.hover_coloral > 0) then
                            s.hover_coloral = Lerp(2 * FrameTime(), s.hover_coloral, 0)
                        end

                        return
                    end
                end

                if (s.hover_coloral < 154 and s.btn_hovered == 0) then
                    s.hover_coloral = Lerp(5 * FrameTime(), s.hover_coloral, 155)
                else
                    s.btn_hovered = 1
                end

                if (s.btn_hovered == 1) then
                    if (s.btn_color_a) then
                        if (s.hover_coloral >= 154) then
                            s.btn_color_a = false
                        else
                            s.hover_coloral = s.hover_coloral + (100 * FrameTime())
                        end
                    else
                        if (s.hover_coloral <= 50) then
                            s.btn_color_a = true
                        else
                            s.hover_coloral = s.hover_coloral - (100 * FrameTime())
                        end
                    end
                end
            end
        end

        MOAT_CAT_BTN.DoClick = function(s)
            if (s.CatLabel == "Store") then
                MOAT_DONATE:OpenWindow()
                MOAT_INV_BG:Remove()

                return
            end

			if (IsValid(MOAT_CAT_BAR) and MOAT_CAT_BAR.new_cat == s.CAT_NUM) then
				return
			end

            net.Start("MOAT_INV_CAT")
            net.WriteDouble(s.CAT_NUM)
            net.SendToServer()
        end

        sfx.SoundEffects(MOAT_CAT_BTN)

        CAT_WIDTHS = CAT_WIDTHS + MOAT_CAT_BTN:GetWide() + MT[CurTheme].CatSpacing

		table.insert(MOAT_INV_BG.Cat, MOAT_CAT_BTN)
    end

	function m_InventoryCat()
		for k, v in ipairs(MOAT_INV_BG.Cat) do
			if (IsValid(v)) then
				v:MoveToFront()
			end
		end

		if (IsValid(MOAT_CAT_BAR)) then
			MOAT_CAT_BAR:MoveToFront()
		end

		if (IsValid(M_INV_C)) then
			M_INV_C:MoveToFront()
		end
	end

    MOAT_CAT_BAR = vgui.Create("DPanel", MOAT_INV_BG)
    MOAT_CAT_BAR:SetSize((MOAT_INV_CATS[1][2] or MT[CurTheme].CatInfo[2]) * #MOAT_INV_CATS, 3)
    MOAT_CAT_BAR:SetPos(MT[CurTheme].CatSpacing, 27)
    MOAT_CAT_BAR.cat_num = #MOAT_INV_CATS
    MOAT_CAT_BAR.cur_cat = MOAT_INV_CAT
    MOAT_CAT_BAR.new_cat = MOAT_INV_CAT
    MOAT_CAT_BAR.Paint = function(s, w, h)
        if (MT[CurTheme].CATBAR_PAINT) then
            MT[CurTheme].CATBAR_PAINT(s, w, h)
        end
    end

    local m_slot_w = 68
    local m_slot_h = 68
	if (IsValid(M_SLOT_D)) then
		M_SLOT_D:Remove()
	end

	M_SLOT_D = vgui.Create("MoatModelIcon")
    M_SLOT_D:SetModel("models/props_borealis/bluebarrel001.mdl")
    M_SLOT_D:SetTooltip(nil)

    M_SLOT_D.Think = function(s)
        s:SetTooltip(nil)
    end

    M_SLOT_D:SetSize(64, 64)
    M_SLOT_D:SetDrawOnTop(true)
    M_SLOT_D.Icon:SetAlpha(200)

    M_SLOT_D.PaintOver = function(s, w, h)
        if (not M_INV_DRAG) then return end

        if (M_INV_DRAG.VGUI and M_INV_DRAG.VGUI.WModel and not string.EndsWith(M_INV_DRAG.VGUI.WModel, ".mdl")) then
            s.Icon:SetAlpha(0)
            if (M_INV_DRAG.VGUI.Item and M_INV_DRAG.VGUI.Item.item and M_INV_DRAG.VGUI.Item.item.Clr) then
				cdn.DrawImage(M_INV_DRAG.VGUI.WModel, 0, 0, w, h, {r = M_INV_DRAG.VGUI.Item.item.Clr[1], g = M_INV_DRAG.VGUI.Item.item.Clr[2], b = M_INV_DRAG.VGUI.Item.item.Clr[3], a = 200})
            elseif (M_INV_DRAG.VGUI.WModel:StartWith("https")) then
                cdn.DrawImage(M_INV_DRAG.VGUI.WModel, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 200})
            else
				if (M_INV_DRAG.VGUI.WModel and (not s.MatPath or (s.MatPath and M_INV_DRAG.VGUI.WModel ~= s.MatPath))) then
					s.MatPath = M_INV_DRAG.VGUI.WModel
					s.Mat = Material(M_INV_DRAG.VGUI.WModel)
				end

				if (s.Mat) then
                	surface_SetDrawColor(255, 255, 255, 200)
                	surface_SetMaterial(s.Mat)
                	surface_DrawTexturedRect(0, 0, w, h)
				end
            end
		else
            s.Icon:SetAlpha(200)
        end

		if (s.Item and s.Item.item) then
			local icon = s.Item.item.Image
			if (not icon and s.Item.w) then
				icon = util.GetWeaponModel(s.Item.w)
			elseif (not icon and s.Item.item.Model) then
				icon = s.Item.item.Model
			end

			if (not string.EndsWith(icon, ".mdl")) then
				-- s.Icon:SetAlpha(0)
				if (s.Item.item and s.Item.item.Clr) then
					cdn.DrawImage(icon, 0, 0, w, h, {r = s.Item.item.Clr[1], g = s.Item.item.Clr[2], b = s.Item.item.Clr[3], a = 255})
				elseif (icon:StartWith("https")) then
					cdn.DrawImage(icon, 1, 1, w, h, {r = 255, g = 255, b = 255, a = 100})
					cdn.DrawImage(icon, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 255})
				else
					if (icon and (not s.MatPath or (s.MatPath and icon ~= s.MatPath))) then
						s.MatPath = icon
						s.Mat = Material(icon)
					end

					if (s.Mat) then
						surface_SetDrawColor(255, 255, 255, 100)
						surface_SetMaterial(s.Mat)
						surface_DrawTexturedRect(1, 1, w, h)
						surface_SetDrawColor(255, 255, 255, 255)
						surface_DrawTexturedRect(0, 0, w, h)
					end
				end
			else
				-- s.Icon:SetAlpha(255)
			end

			local locked = false

			if (m_Inventory[num].l and m_Inventory[num].l == 1) then
				locked = true
				surface_SetDrawColor(255, 255, 255)
				surface_SetMaterial(mat_lock)
				surface_DrawTexturedRect(1, 1, 16, 16)
			end

			if (m_Inventory[num].p or m_Inventory[num].p2 or m_Inventory[num].p3) then
				surface_SetDrawColor(255, 255, 255)
				surface_SetMaterial(mat_paint)
				surface_DrawTexturedRect(locked and 18 or 1, 1, 16, 16)
			end

			if (m_Inventory[num].decon) then
				surface_SetDrawColor(150, 0, 0, 200)
				surface_DrawRect(0, 0, w, h)
			end
		end
    end

    M_SLOT_D.Think = function(s)
        if (not IsValid(MOAT_INV_BG)) then
            s:Remove()
        end
    end

    M_SLOT_D:SetVisible(false)
    local inv_pnl_x = MOAT_INV_BG_W - 364 - 5
    local inv_pnl_y = 35

	function m_InventoryPanel(anim_time)
		if (IsValid(M_INV_PNL)) then
			M_INV_PNL:Remove()
		end

		anim_time = anim_time or 0
		M_INV_PNL = vgui.Create("DPanel", MOAT_INV_BG)
		M_INV_PNL:SetSize(364, 515)
		if (anim_time > 0) then
			M_INV_PNL:SetAlpha(0)
			M_INV_PNL:MoveTo(inv_pnl_x, inv_pnl_y, anim_time)
            M_INV_PNL:AlphaTo(255, anim_time, 0)
		end
		M_INV_PNL:SetPos((anim_time > 0) and MOAT_INV_BG_W or inv_pnl_x, 35)
		M_INV_PNL.Theme = MT[CurTheme]
		M_INV_PNL.Paint = function(s, w, h)
			if (MT[CurTheme].INV_PANEL_PAINT) then
				MT[CurTheme].INV_PANEL_PAINT(s, w, h)
			end
		end

		if (disable_freeic:GetInt() == 0) then
			local M_INV_FREE = vgui.Create("DButton", M_INV_PNL)
			M_INV_FREE:SetPos(364 - 130, 0)
			M_INV_FREE:SetSize(130, 13)
			M_INV_FREE:SetText("")
			M_INV_FREE.Paint = function(s, w, h)
				DisableClipping(true)
					draw.SimpleTextOutlined("GET FREE CREDITS!!", "moat_ItemDesc", w, -2, HSVToColor(CurTime() * 70 % 360, 1, 1), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 100))
				DisableClipping(false)
			end
			M_INV_FREE.DoClick = function(s)
				--MOAT_INV_BG:Remove()
				
				MOAT_FORUMS:OpenWindow()
			end
			sfx.SoundEffects(M_INV_FREE)
		end

		M_INV_SP = vgui.Create("DScrollPanel", M_INV_PNL)
		M_INV_SP:SetPos(0, 27)
		M_INV_SP:SetSize(364, 488)
		M_INV_SP.Icons = 0
		M_INV_SP.Paint = function(s, w, h)
			if (s.Icons == 0) then
				surface_SetFont("GModNotify")
				surface_SetTextColor(255, 255, 255)
				surface_SetTextPos(10, 10)
				surface_DrawText("Your inventory is loading friend <3 ..")
			end

			surface_SetDrawColor(62, 62, 64, 255)
			surface_DrawOutlinedRect(0, 0, w, h)
			surface_SetDrawColor(0, 0, 0, 100)
			surface_DrawRect(1, 1, w - 2, h - 2)
		end

		M_INV_SP.PaintOver = function(s, w, h)
			surface_SetDrawColor(62, 62, 64, 255)
			surface_DrawOutlinedRect(0, 0, w, h)
		end

		local sbar = M_INV_SP:GetVBar()
		sbar:SetZPos(50)
		m_PaintVBar(sbar)

		M_INV_SP.Think = function(s)
			/*
			local cx, cy = s:CursorPos()

			if (cx < 0 or cy < 0 or cx > M_INV_SP:GetWide() or cy > 488) then
				return
			end

			if (cy < 50) then
				s.Bounds = true
				sbar:AddScroll(((50 - cy) / 50) * -0.15)
			elseif (cy > (488 - 50)) then
				s.Bounds = true
				sbar:AddScroll(((50 - (488 - cy)) / 50) * 0.15)
			else
				s.Bounds = false
			end
			*/
		end

		M_INV_L = vgui.Create("DIconLayout", M_INV_SP)
		M_INV_L:SetPos(3, 3)
		M_INV_L:SetSize(350, 488)
		M_INV_L:SetSpaceX(1)
		M_INV_L:SetSpaceY(1)
		M_INV_L.OldAdd = M_INV_L.Add
		M_INV_L.Add = function(s, ...)
			M_INV_SP.Icons = M_INV_SP.Icons + 1

			return s.OldAdd(s, ...)
		end

		M_INV_PNL_EXTND = vgui.Create("DButton", M_INV_PNL)
		M_INV_PNL_EXTND:SetPos(0, 0)
		M_INV_PNL_EXTND:SetSize(125, 25)
		M_INV_PNL_EXTND:SetText ""
		M_INV_PNL_EXTND.Extend = 0
		M_INV_PNL_EXTND.Extended = false
		M_INV_PNL_EXTND.Paint = function(s, w, h)
			s.Extend = Lerp(FrameTime() * 8, s.Extend, s:IsHovered() and 1 or 0)

			draw_RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100 * s.Extend))
			draw_SimpleTextOutlined("Inventory", "moat_Trebuchet", 2 + (23 * s.Extend), 0, MT[CurTheme].TextColor or Color(235, 235, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 25))

			surface_SetDrawColor(MT[CurTheme].TextColor.r or 255, MT[CurTheme].TextColor.g or 255, MT[CurTheme].TextColor.b or 255, 255 * s.Extend)
			draw_NoTexture()

			local e = 12 * s.Extend
			surface_DrawLine(e, s.Extended and 12 - 5 or 12, 6 + e, s.Extended and 13 or 12 - 6)
			surface_DrawLine(e, s.Extended and 12 + 5 or 12, 6 + e, s.Extended and 11 or 12 + 6)
		end
		M_INV_PNL_EXTND.DoClick = function(s, w, h)
			m_ChangeInventoryPanel(s.Extended and 1 or 0, IsValid(MOAT_TRADE_BG))
			s.Extended = not s.Extended
		end

		sfx.HoverSound(M_INV_PNL_EXTND, sfx.Click2)
		sfx.ClickSound(M_INV_PNL_EXTND)

		function m_CreateInvSlot(num)
			local m_ItemExists = false

			if (m_Inventory[num].c) then
				m_ItemExists = true
			end

			local m_WClass = {}

			if (m_ItemExists) then
				if (m_Inventory[num].item.Image) then
					m_WClass.WorldModel = m_Inventory[num].item.Image
				elseif (m_Inventory[num].item.Model) then
					m_WClass.WorldModel = m_Inventory[num].item.Model
					m_WClass.ModelSkin = m_Inventory[num].item.Skin
				else
					m_WClass = weapons.Get(m_Inventory[num].w)
				end
			end

			local hover_coloral = 0
			local m_DPanel = M_INV_L:Add("DPanel")
			m_DPanel:SetSize(68, 68)

			m_DPanel.Paint = function(s, w, h)
				local slot_x, slot_y = s:GetPos()

				if ((M_INV_SP.Scroll > (slot_y + h)) or (slot_y > (M_INV_SP.Scroll + 480))) then
					return
				end

				if (MT[CurTheme].SLOT_PAINT) then
					MT[CurTheme].SLOT_PAINT(s, w, h, hover_coloral, m_Inventory[num])

					return
				end

				local draw_x = 2
				local draw_y = 2
				local draw_w = w - 4
				local draw_h = h - 4
				local draw_y2 = 2 + ((h - 4) / 2)
				local draw_h2 = (h - 4) - ((h - 4) / 2)
				surface_SetDrawColor(0, 0, 0, 100)
				surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
				surface_SetDrawColor(50, 50, 50, hover_coloral)
				surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
				if (not m_Inventory[num]) then return end

				if (m_Inventory[num].c and m_Inventory[num].item and m_Inventory[num].item.Rarity) then
					surface_SetDrawColor(150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 100)
					surface_DrawRect(draw_x, draw_y, draw_w, draw_h)

					if (m_Inventory[num].l and m_Inventory[num].l == 1) then
						surface_SetDrawColor(255, 255, 255, 50)
						surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
					end

					surface_SetDrawColor(rarity_names[m_Inventory[num].item.Rarity][2].r, rarity_names[m_Inventory[num].item.Rarity][2].g, rarity_names[m_Inventory[num].item.Rarity][2].b, 100 + hover_coloral)
					surface_SetMaterial(gradient_d)
					surface_DrawTexturedRect(draw_x, draw_y2 - (hover_coloral / 7), draw_w, draw_h2 + (hover_coloral / 7) + 1)
				end

				surface_SetDrawColor(62, 62, 64, 255)

				if (m_Inventory[num].c and m_Inventory[num].item and m_Inventory[num].item.Rarity) then
					surface_SetDrawColor(rarity_names[m_Inventory[num].item.Rarity][2])
				end

				surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
				surface_SetDrawColor(62, 62, 64, hover_coloral / 2)
			end

			--  surface_DrawPoly( triangle )
			local m_DPanelIcon = {}
			m_DPanelIcon.SIcon = vgui.Create("MoatModelIcon", m_DPanel)
			m_DPanelIcon.SIcon:SetPos(2, 2)
			m_DPanelIcon.SIcon:SetSize(64, 64)
			m_DPanelIcon.SIcon:SetTooltip(nil)

			m_DPanelIcon.SIcon.Think = function(s)
				s:SetTooltip(nil)
			end

			m_DPanelIcon.SIcon.PaintOver = function(self, w, h)
				if (not M_INV_SLOT[num]) then
					return
				end

				local s = M_INV_SLOT[num].VGUI
				if (s.Item and s.Item.item) then
					local icon = s.Item.item.Image
					if (not icon and s.Item.w) then
						icon = util.GetWeaponModel(s.Item.w)
					elseif (not icon and s.Item.item.Model) then
						icon = s.Item.item.Model
					end

					if (icon and not string.EndsWith(icon, ".mdl")) then
						-- s.Icon:SetAlpha(0)
						if (s.Item.item and s.Item.item.Clr) then
							cdn.DrawImage(icon, 0, 0, w, h, {r = s.Item.item.Clr[1], g = s.Item.item.Clr[2], b = s.Item.item.Clr[3], a = 255})
						elseif (icon:StartWith("https")) then
							cdn.DrawImage(icon, 1, 1, w, h, {r = 255, g = 255, b = 255, a = 100})
							cdn.DrawImage(icon, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 255})
						else
							if (icon and (not s.MatPath or (s.MatPath and icon ~= s.MatPath))) then
								s.MatPath = icon
								s.Mat = Material(icon)
							end

							if (s.Mat) then
								surface_SetDrawColor(255, 255, 255, 100)
								surface_SetMaterial(s.Mat)
								surface_DrawTexturedRect(1, 1, w, h)
								surface_SetDrawColor(255, 255, 255, 255)
								surface_DrawTexturedRect(0, 0, w, h)
							end
						end
					else
						-- s.Icon:SetAlpha(255)
					end

					local locked = false

					if (m_Inventory[num].l and m_Inventory[num].l == 1) then
						locked = true
						surface_SetDrawColor(255, 255, 255)
						surface_SetMaterial(mat_lock)
						surface_DrawTexturedRect(1, 1, 16, 16)
					end

					if (m_Inventory[num].p or m_Inventory[num].p2 or m_Inventory[num].p3) then
						surface_SetDrawColor(255, 255, 255)
						surface_SetMaterial(mat_paint)
						surface_DrawTexturedRect(locked and 18 or 1, 1, 16, 16)
					end

					if (m_Inventory[num].decon) then
						surface_SetDrawColor(150, 0, 0, 200)
						surface_DrawRect(0, 0, w, h)
					end
				end
			end

			local m_DPanelBTN = vgui.Create("DButton", m_DPanel)
			m_DPanelBTN:SetText("")
			m_DPanelBTN:SetSize(68, 68)
			m_DPanelBTN.Paint = function(s, w, h) end
			local btn_hovered = 1
			local btn_color_a = false

			m_DPanelBTN.Think = function(s)
				if (not s:IsHovered()) then
					btn_hovered = 0
					btn_color_a = false

					if (hover_coloral > 0) then
						hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
					end

					if (m_HoveredSlot == num) then
						HoveringSlot = false
					end
				else
					if (IsValid(M_INV_MENU)) then
						if (M_INV_MENU.Hovered) then
							btn_hovered = 0
							btn_color_a = false

							if (hover_coloral > 0) then
								hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
							end

							return
						end
					end

					--m_HoveredSlot = num

					if (hover_coloral < 154 and btn_hovered == 0) then
						hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
					else
						btn_hovered = 1
					end

					if (btn_hovered == 1) then
						if (btn_color_a) then
							if (hover_coloral >= 154) then
								btn_color_a = false
							else
								hover_coloral = hover_coloral + (100 * FrameTime())
							end
						else
							if (hover_coloral <= 50) then
								btn_color_a = true
							else
								hover_coloral = hover_coloral - (100 * FrameTime())
							end
						end
					end
				end
			end
			
			m_DPanelBTN.OnMousePressed = function(s, key)
				if (crate_wait > CurTime() or IsValid(MOAT_CRATE_BG)) then return end
				if (m_DPanelIcon and m_DPanelIcon.SIcon and key == MOUSE_LEFT) then m_DPanelIcon.SIcon:DoClick() end

				if (INV_SELECT_MODE) then
					if (m_Inventory[num].c and key == MOUSE_LEFT and INV_SELECTED_ITEM ~= num) then
						INV_SELECTED_ITEM = num
					end

					return
				end

				if (key == MOUSE_LEFT and input.IsKeyDown(KEY_LCONTROL) and m_Inventory[num].c) then
					if (m_Inventory[num].l and m_Inventory[num].l == 1) then return end
					if (m_Inventory[num].item and m_Inventory[num].item.Rarity and m_Inventory[num].item.Rarity > 5) then return end
					
					moat_RemoveEditPositionPanel()

					if (m_Inventory[num].decon) then
						m_Inventory[num].decon = false
						MOAT_ITEMS_DECON_MARKED = math.Clamp(MOAT_ITEMS_DECON_MARKED - 1, 0, 1000)
					else
						m_Inventory[num].decon = true
						MOAT_ITEMS_DECON_MARKED = math.Clamp(MOAT_ITEMS_DECON_MARKED + 1, 0, 1000)
						m_DrawDeconButton(MOAT_INV_BG)
					end

					if (input.IsKeyDown(KEY_LSHIFT)) then
						if (MOAT_DECONSTRUCT_ITEMS_START ~= 0) then
							MOAT_DECONSTRUCT_ITEMS_END = num

							for i = MOAT_DECONSTRUCT_ITEMS_START, MOAT_DECONSTRUCT_ITEMS_END do
								if ((m_Inventory[i].l and m_Inventory[i].l == 1) or not m_Inventory[i].c) then continue end

								if (not m_Inventory[i].decon) then
									MOAT_ITEMS_DECON_MARKED = MOAT_ITEMS_DECON_MARKED + 1
								end
								m_Inventory[i].decon = true
							end
						end

						if (MOAT_DECONSTRUCT_ITEMS_START == 0) then
							MOAT_DECONSTRUCT_ITEMS_START = num
						elseif (MOAT_DECONSTRUCT_ITEMS_END ~= 0) then
							MOAT_DECONSTRUCT_ITEMS_START = 0
							MOAT_DECONSTRUCT_ITEMS_END = 0
						end

					end

					return
				end

				if (key == MOUSE_LEFT) then
					if (M_INV_SLOT[num].VGUI.Item and M_INV_SLOT[num].VGUI.Item.c) then
						M_INV_DRAG = M_INV_SLOT[num]
						sfx.Click1()
					end
				end

				if (key == MOUSE_RIGHT) then
					if (M_INV_SLOT[num].VGUI.Item and M_INV_SLOT[num].VGUI.Item.c) then
						m_CreateItemMenu(num, false)
						sfx.Click2()
					end
				end
			end

			m_DPanelBTN.OnCursorEntered = function(s)
				m_HoveredSlot = num
				HoveringSlot = true

				if (input.IsMouseDown(MOUSE_LEFT) and input.IsKeyDown(KEY_LCONTROL) and m_Inventory[num].c and not INV_SELECT_MODE) then
					s.OnMousePressed(s, MOUSE_LEFT)
				end

				if (M_INV_SLOT[num].VGUI.Item and M_INV_SLOT[num].VGUI.Item.c) then
					sfx.Hover()
				end
			end

			m_DPanelBTN.OnCursorExited = function(s)
				HoveringSlot = false
			end
			--surface.PlaySound( "UI/buttonrollover.wav" )
			--table.insert(m_InventoryButtons, m_DPanelBTN)
			local tbl = {}
			tbl.ComfyNest = m_DPanelIcon.SIcon
			tbl.Render = m_DPanelIcon.SIcon.Icon
			tbl.VGUI = m_DPanelIcon
			tbl.Slot = num
			M_INV_SLOT[num] = tbl
		end

		function m_HandleLayoutSpacing(remove)
			if (remove) then
				if (IsValid(M_INV_L.Spacing)) then M_INV_L.Spacing:Remove() end
				return
			end

			if (IsValid(M_INV_L)) then
				M_INV_L.Spacing = M_INV_L:Add("DPanel")
				M_INV_L.Spacing:SetSize(676, 2)
				M_INV_L.Spacing.Paint = nil
			end
		end

		function m_CreateNewInvSlot(num, noscroll)
			m_HandleLayoutSpacing(true)
			m_CreateInvSlot(num)
			m_HandleLayoutSpacing()

			if (not IsValid(M_INV_SP) or noscroll) then return end
			M_INV_SP.VBar.ScrollOnExtend = true
			local s = M_INV_SP.VBar.CanvasSize
			M_INV_SP.VBar.LerpTarget = s
			M_INV_SP.VBar:SetScroll(s)
		end

		function m_CreateInventorySlots(noscroll, start, stop)
			if (not m_isUsingInv(true)) then
				return
			end

			start = start or 1
			stop = stop or LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 0)
			for i = start, stop do
				if (not m_Inventory[i]) then
					MsgC(Color(255, 0, 0), "Couldn't create slot " .. i .. " in your inventory.\n")
					m_Inventory[i] = {decon = false}
				end

				if (not M_INV_SLOT[i]) then
					m_CreateNewInvSlot(i, noscroll)

					if (m_Inventory[i] and not m_Inventory[i].c) then
						M_INV_SLOT[i].ComfyNest:SetVisible(false)
						M_INV_SLOT[i].Render:SetVisible(false)
					end
				elseif (m_isUsingInv(true) and M_INV_SLOT[i] and m_Inventory[i] and m_Inventory[i].c) then
					M_INV_SLOT[i].ComfyNest:SetVisible(true)
					M_INV_SLOT[i].ComfyNest:SetAlpha(255)

					if (M_INV_SLOT[i].ComfyNest:GetModelName() and not MOAT_MODEL_POS[M_INV_SLOT[i].ComfyNest:GetModelName()]) then
						M_INV_SLOT[i].Render:SetVisible(true)
						M_INV_SLOT[i].Render:SetAlpha(0)
					end
				end

				if (M_INV_SLOT[i]) then
					M_INV_SLOT[i].ComfyNest.Item = m_Inventory[i]
					M_INV_SLOT[i].Render.Item = m_Inventory[i]
					M_INV_SLOT[i].VGUI.Item = m_Inventory[i]
				end

				if (not m_Inventory[i].c and m_isUsingInv(true)) then
					M_INV_SLOT[i].ComfyNest:SetVisible(false)
					M_INV_SLOT[i].Render:SetVisible(false)

					continue
				end

				if (m_isUsingInv(true) and m_Inventory[i] and m_Inventory[i].item and m_Inventory[i].item.Image) then
					M_INV_SLOT[i].VGUI.WModel = m_Inventory[i].item.Image
					M_INV_SLOT[i].ComfyNest.WModel = m_Inventory[i].item.Image
					M_INV_SLOT[i].Render.WModel = m_Inventory[i].item.Image
					M_INV_SLOT[i].ComfyNest:SetVisible(true)
					M_INV_SLOT[i].Render:SetVisible(false)
					M_INV_SLOT[i].ComfyNest:SetAlpha(255)
					M_INV_SLOT[i].Render:SetAlpha(0)
				end

				if (m_isUsingInv(true) and m_Inventory[i] and m_Inventory[i].item and m_Inventory[i].item.Model and not m_Inventory[i].item.Image) then
					if (not IsValid(M_INV_SLOT[i].Render)) then
						M_INV_SLOT[i].VGUI.SIcon:CreateIcon(true)
						M_INV_SLOT[i].Render = M_INV_SLOT[i].VGUI.SIcon.Icon
					end

					M_INV_SLOT[i].VGUI.WModel = m_Inventory[i].item.Model
					M_INV_SLOT[i].ComfyNest.WModel = m_Inventory[i].item.Model
					M_INV_SLOT[i].Render.WModel = m_Inventory[i].item.Model
					
					M_INV_SLOT[i].ComfyNest:SetVisible(true)
					M_INV_SLOT[i].ComfyNest:SetAlpha(255)
					M_INV_SLOT[i].VGUI.SIcon:SetModel(m_Inventory[i].item.Model)
					if (M_INV_SLOT[i].ComfyNest:GetModelName() and MOAT_MODEL_POS[M_INV_SLOT[i].ComfyNest:GetModelName()]) then
						M_INV_SLOT[i].Render:SetVisible(false)
						M_INV_SLOT[i].Render:SetAlpha(0)
					else
						M_INV_SLOT[i].Render:SetVisible(true)
						M_INV_SLOT[i].Render:SetAlpha(255)
					end
				elseif (m_isUsingInv(true) and m_Inventory[i] and m_Inventory[i].w and not m_Inventory[i].item.Image) then
					if (not IsValid(M_INV_SLOT[i].Render)) then
						M_INV_SLOT[i].VGUI.SIcon:CreateIcon(true)
						M_INV_SLOT[i].Render = M_INV_SLOT[i].VGUI.SIcon.Icon
					end

					M_INV_SLOT[i].VGUI.WModel = util.GetWeaponModel(m_Inventory[i].w)
					M_INV_SLOT[i].ComfyNest.WModel = util.GetWeaponModel(m_Inventory[i].w)
					M_INV_SLOT[i].Render.WModel = util.GetWeaponModel(m_Inventory[i].w)

					M_INV_SLOT[i].ComfyNest:SetVisible(true)
					M_INV_SLOT[i].ComfyNest:SetAlpha(255)
					M_INV_SLOT[i].VGUI.SIcon:SetModel(util.GetWeaponModel(m_Inventory[i].w))
					if (M_INV_SLOT[i].ComfyNest:GetModelName() and MOAT_MODEL_POS[M_INV_SLOT[i].ComfyNest:GetModelName()]) then
						M_INV_SLOT[i].Render:SetVisible(false)
						M_INV_SLOT[i].Render:SetAlpha(0)
					else
						M_INV_SLOT[i].Render:SetVisible(true)
						M_INV_SLOT[i].Render:SetAlpha(255)
					end
				end
			end
		end

		M_INV_SLOT = {}

		if (m_CreateInventorySlots) then
			m_HandleLayoutSpacing(true)
			m_CreateInventorySlots(true, 1, 35)
		end

		M_INV_L.LoadedSlot = 0
		M_INV_L.LoadingSlot = 35
		M_INV_L.FinishedSlot = LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 0)
		M_INV_L.Think = function(s)
			if (s.LoadingSlot < s.FinishedSlot) then
				s.LoadingSlot = s.LoadingSlot + 1
				m_CreateInventorySlots(true, s.LoadingSlot, s.LoadingSlot + 4)
				s.LoadingSlot = s.LoadingSlot + 4
			end
		end
	end

    /*M_LOADOUT_PNL:MoveTo(-M_LOADOUT_PNL:GetWide(), 0, 0.15, 0, -1)
    M_LOADOUT_PNL:AlphaTo(0, 0.15)

    M_INV_PNL:MoveTo(5, 30, 0.15, 0.15, -1)
    M_INV_PNL:SizeTo(MOAT_INV_BG_W-10, 515, 0.15, 0.15, -1)
    M_INV_SP:SizeTo(MOAT_INV_BG_W-10-31, 488, 0.15, 0.15, -1)
    M_INV_L:SizeTo(MOAT_INV_BG_W-10-31, 488, 0.15, 0.15, -1)*/

    function m_ChangeInventoryPanel(cat, trading, cb)
        if (not IsValid(MOAT_INV_BG)) then return end

        local anim_time, called = 0.15
		local callback = function(anim, pnl)
			if (pnl and IsValid(pnl)) then pnl:Remove() end
			if (cb and not called) then
				called = true
				cb()
			end
		end
	
		moat_RemoveEditPositionPanel()

        if (cat == 3) then
			if (not IsValid(M_TRADING_PNL) and not IsValid(MOAT_TRADE_BG)) then
				m_TradingPanel()
			end

			if (IsValid(MOAT_TRADE_BG) and IsValid(M_TRADING_PNL)) then
				M_TRADING_PNL:MoveTo(-M_TRADING_PNL:GetWide(), 0, anim_time, 0, -1)
				M_TRADING_PNL:AlphaTo(0, anim_time, 0, callback)
			end

            if (trading and IsValid(MOAT_TRADE_BG)) then
                local inv_x, inv_y = MOAT_INV_BG:GetPos()
                MOAT_TRADE_BG:MoveTo(inv_x + 5, inv_y + 35, anim_time, anim_time, -1)
                MOAT_TRADE_BG:AlphaTo(255, anim_time, anim_time)
                MOAT_TRADE_BG:MakePopup()
            elseif (not IsValid(MOAT_TRADE_BG) and IsValid(M_TRADING_PNL)) then
                M_TRADING_PNL:MoveTo(0, 0, anim_time, anim_time, -1)
            	M_TRADING_PNL:AlphaTo(255, anim_time, anim_time)
                M_TRADE_PLYS:RebuildList()
            end
        else
			if (IsValid(M_TRADING_PNL)) then
                M_TRADING_PNL:MoveTo(-M_TRADING_PNL:GetWide(), 0, anim_time, 0, -1)
                M_TRADING_PNL:AlphaTo(0, anim_time, 0, callback)
            end

            if (trading and IsValid(MOAT_TRADE_BG)) then
                local inv_x, inv_y = MOAT_INV_BG:GetPos()
                MOAT_TRADE_BG:MoveTo(inv_x - MOAT_TRADE_BG:GetWide() - 5, inv_y + 35, anim_time, 0, -1)
                MOAT_TRADE_BG:AlphaTo(0, anim_time, 0, function() callback() end)
                MOAT_TRADE_BG:MakePopup()
            end
        end

        if (cat == 0) then
			if (not IsValid(M_INV_PNL)) then
				m_InventoryPanel(anim_time)
			end

            local w_off = 32
            M_INV_PNL:MoveTo(w_off + 5, 35, 0.15)
            M_INV_PNL:SizeTo(MOAT_INV_BG_W-10 - w_off, help_pnl_h, 0)
			M_INV_PNL:AlphaTo(255, anim_time, 0)

            --Inside Inventory
            M_INV_SP:SizeTo(MOAT_INV_BG_W-10 - w_off, 488, 0)
            M_INV_L:SizeTo(MOAT_INV_BG_W-24 - w_off, 488, 0)
		end

        if (cat == 1) then
			m_LoadoutPanel()

            M_LOADOUT_PNL:MoveTo(0, 0, anim_time, anim_time, -1)
            M_LOADOUT_PNL:AlphaTo(255, anim_time, anim_time)
        elseif (IsValid(M_LOADOUT_PNL)) then
            M_LOADOUT_PNL:MoveTo(-M_LOADOUT_PNL:GetWide(), 0, anim_time, 0, -1)
            M_LOADOUT_PNL:AlphaTo(0, anim_time, 0, callback)
        end

		if (cat == 2 or cat == -1) then
			m_StatsPanel()

            M_STATS_PNL:MoveTo(0, 0, anim_time, anim_time, -1)
            M_STATS_PNL:AlphaTo(255, anim_time, anim_time)
            MOAT_XP_LERP = 360
            MOAT_STATS_LERP = 0
        elseif (IsValid(M_STATS_PNL)) then
            M_STATS_PNL:MoveTo(-M_STATS_PNL:GetWide(), 0, anim_time, 0, -1)
            M_STATS_PNL:AlphaTo(0, anim_time, 0, callback)
        end

        if (cat == 4) then
			m_ShopPanel()

            M_SHOP_PNL:MoveTo(0, 0, anim_time, anim_time, -1)
            M_SHOP_PNL:AlphaTo(255, anim_time, anim_time)
        elseif (IsValid(M_SHOP_PNL)) then
            M_SHOP_PNL:MoveTo(-M_SHOP_PNL:GetWide(), 0, anim_time, 0, -1)
            M_SHOP_PNL:AlphaTo(0, anim_time, 0, callback)
        end

		if (cat == 5 or cat == 6 or cat == 7 or cat == 8 or cat == 9) then
			if (IsValid(M_INV_PNL)) then
				M_INV_PNL:MoveTo(MOAT_INV_BG_W, inv_pnl_y, anim_time, 0, -1)
				M_INV_PNL:AlphaTo(0, anim_time, 0, callback)
			end
        elseif (cat ~= 0) then
			if (not IsValid(M_INV_PNL)) then
				m_InventoryPanel(anim_time)
			end

            M_INV_PNL:MoveTo(inv_pnl_x, inv_pnl_y, anim_time)
            M_INV_PNL:AlphaTo(255, anim_time, 0)
            M_INV_PNL:SizeTo(364, 515, anim_time)
            M_INV_SP:SizeTo(364, 488, anim_time)
            M_INV_L:SizeTo(350, 488, anim_time)
        end

		for k, v in pairs(m_Inventory) do
			if (type(v) == "table") then
				v.decon = false
			end
		end

		MOAT_ITEMS_DECON_MARKED = 0

        if (cat == 5) then
            local x, y = MOAT_INV_BG:GetPos()
            m_CreateGamblePanel(x + 5, y + 35, MOAT_INV_BG_W - 10, MOAT_INV_BG_H - 35)
        elseif (IsValid(MOAT_GAMBLE_BG)) then
			MOAT_GAMBLE_BG:MoveTo(-MOAT_GAMBLE_BG:GetWide(), 0, anim_time, 0, -1)
            MOAT_GAMBLE_BG:AlphaTo(0, anim_time, 0, callback)
        end

        -- if (cat == 5) then
        --     local x, y = MOAT_INV_BG:GetPos()
        --     m_CreateBattlePanel(x + 5, y + 30, MOAT_INV_BG_W - 10, MOAT_INV_BG_H - 35)
        -- else
        --     m_RemoveBattlePanel()
        -- end

		if (cat == 6) then
			m_BountyPanel()

            M_BOUNTY_PNL:MoveTo(0, 0, anim_time, 0, -1)
            M_BOUNTY_PNL:AlphaTo(255, anim_time, 0)
        elseif (IsValid(M_BOUNTY_PNL)) then
            M_BOUNTY_PNL:MoveTo(-M_BOUNTY_PNL:GetWide(), 0, anim_time, 0, -1)
            M_BOUNTY_PNL:AlphaTo(0, anim_time, 0, callback)
        end

		if (cat == 7) then
			m_SettingsPanel()

            M_SETTINGS_PNL:MoveTo(0, 0, anim_time, 0, -1)
            M_SETTINGS_PNL:AlphaTo(255, anim_time, 0)
        elseif (IsValid(M_SETTINGS_PNL)) then
            M_SETTINGS_PNL:MoveTo(-M_SETTINGS_PNL:GetWide(), 0, anim_time, 0, -1)
            M_SETTINGS_PNL:AlphaTo(0, anim_time, 0, callback)
        end

        if (cat == 8) then
			m_EventPanel()

            M_EVENT_PNL:MoveTo(0, 0, anim_time, 0, -1)
            M_EVENT_PNL:AlphaTo(255, anim_time, anim_time)
        elseif (IsValid(M_EVENT_PNL)) then
            M_EVENT_PNL:MoveTo(-M_EVENT_PNL:GetWide(), 0, anim_time, 0, -1)
            M_EVENT_PNL:AlphaTo(0, anim_time, 0, callback)
        end

        /*if (cat == 8) then
            M_EVENT_PNL:MoveTo(0, 0, anim_time, anim_time, -1)
            M_EVENT_PNL:AlphaTo(255, anim_time, anim_time)
        else
            M_EVENT_PNL:MoveTo(-M_EVENT_PNL:GetWide(), 0, anim_time, 0, -1)
            M_EVENT_PNL:AlphaTo(0, anim_time)
        end*/

        if (cat == -2) then
			m_UsablePanel()

            M_USABLE_PNL:MoveTo(0, 0, anim_time, 0, -1)
            M_USABLE_PNL:AlphaTo(255, anim_time, 0)
            INV_SELECT_MODE = true
            --return
        elseif (IsValid(M_USABLE_PNL)) then
            M_USABLE_PNL:MoveTo(-M_USABLE_PNL:GetWide(), 0, anim_time, 0, -1)
            M_USABLE_PNL:AlphaTo(0, anim_time, 0, callback)
            INV_SELECT_MODE = false
        end

		m_InventoryCat()

		timer.Simple(anim_time * 2, callback)

        if (cat ~= 0 and IsValid(M_INV_PNL_EXTND)) then M_INV_PNL_EXTND.Extended = false end
        if (cat == 0 or cat == -1 or cat == -2) then if (cat == -1) then MOAT_CAT_BAR.new_cat = 2 end return end

        MOAT_CAT_BAR.new_cat = cat
    end

    local m_LoadoutTypes = {}
    m_LoadoutTypes[0] = "Melee"
    m_LoadoutTypes[1] = "Secondary"
    m_LoadoutTypes[2] = "Primary"
    local gui_frame_off = 5
    MOAT_INV_S = vgui.Create("DPanel")
    MOAT_INV_S:SetPos(gui.MouseX() + gui_frame_off, gui.MouseY() - 150 - gui_frame_off)
    MOAT_INV_S:SetSize(275, 150)
    MOAT_INV_S:SetDrawOnTop(true)
    local drawn_stats = 0
    local draw_stats_x = 7
    local draw_stats_multi = 0
    local draw_xp_lvl = 9
    local draw_stats_y = 26 + 21 + draw_xp_lvl
    MOAT_INV_S.AnimVal = 0
    MOAT_INV_S.Paint = function(s, w, h)
        local ITEM_HOVERED = m_Inventory[m_HoveredSlot]

		if (string.EndsWith(tostring(m_HoveredSlot), "l")) then
            ITEM_HOVERED = m_Loadout[tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))]
        end

		if (string.EndsWith(tostring(m_HoveredSlot), "t")) then
            ITEM_HOVERED = m_Trade[tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))]
        end

		if (string.EndsWith(tostring(m_HoveredSlot), "u")) then
			local num = string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1)
			ITEM_HOVERED = m_Inventory[tonumber(num)]
        end

        --m_DrawFireText( ITEM_HOVERED.item.Rarity, ITEM_HOVERED.item.Name .. " " .. ITEM_NAME, "moat_Medium4", draw_name_x, draw_name_y, rarity_names[ITEM_HOVERED.item.Rarity][2] )
        --m_DrawElecticText( ITEM_HOVERED.item.Name .. " " .. ITEM_NAME, "moat_Medium4", draw_name_x, draw_name_y, rarity_names[ITEM_HOVERED.item.Rarity][2] )
        --m_DrawShadowedText( 1, ITEM_NAME_FULL, "moat_Medium4", draw_name_x, draw_name_y, rarity_names[ITEM_HOVERED.item.Rarity][2] )
        --m_DrawGlowingText( ITEM_HOVERED.item.Name .. " " .. ITEM_NAME, "moat_Medium4", 7, 2, rarity_names[ITEM_HOVERED.item.Rarity][2] )
        --m_DrawBouncingText( ITEM_HOVERED.item.Name .. " " .. ITEM_NAME, "moat_Medium4", 7, 2, rarity_names[ITEM_HOVERED.item.Rarity][2] )
        --m_DrawEnchantedText( ITEM_HOVERED.item.Name .. " " .. ITEM_NAME, "moat_Medium4", 7, 2, rarity_names[ITEM_HOVERED.item.Rarity][2] )
        draw_stats_y = 26 + 21 + draw_xp_lvl

        if (ITEM_HOVERED and ITEM_HOVERED.c) then
            local ITEM_NAME_FULL = GetItemName(ITEM_HOVERED)

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                draw_xp_lvl = 9
            else
                draw_xp_lvl = 3
            end

            if (ITEM_HOVERED.n) then
                -- draw_xp_lvl = draw_xp_lvl + 15
            end

            local namew, nameh = surface_GetTextSize(ITEM_NAME_FULL)
            local num_stats = 0

            if (ITEM_HOVERED.s) then
                num_stats = table.Count(ITEM_HOVERED.s)
            end

            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawOutlinedRect(0, 0, w, h)
            surface_SetDrawColor(15, 15, 15, 250)
            surface_DrawRect(1, 1, w - 2, h - 2)

			if (ITEM_HOVERED.p3 or ItemIsSkin(ITEM_HOVERED.u)) then
				local p3alpha, p3skin = MOAT_SKIN_ALPHA or 15
				if (ItemIsSkin(ITEM_HOVERED.u)) then
					p3skin = MOAT_PAINT.Skins[ITEM_HOVERED.u][2]
					p3alpha = MOAT_PAINT.Skins[ITEM_HOVERED.u][6] or MOAT_SKIN_ALPHA
				elseif (ITEM_HOVERED.p3 and MOAT_PAINT.Skins[ITEM_HOVERED.p3]) then
					p3skin = MOAT_PAINT.Skins[ITEM_HOVERED.p3][2]
					p3alpha = MOAT_PAINT.Skins[ITEM_HOVERED.p3][6] or MOAT_SKIN_ALPHA
				end

				if (p3skin and p3skin:match "vtf$") then
					cdn.DrawTexture(p3skin, 2, 2, w-4, h-4, Color(255, 255, 255, p3alpha))
				elseif (p3skin) then
					cdn.DrawImage(p3skin, 2, 2, w-4, h-4, Color(255, 255, 255, p3alpha))
				end

				surface.SetDrawColor(8, 12, 19, 230)
				surface.DrawRect(1, 1, w - 2, 45 + draw_xp_lvl)
				if (s.StatsHeight and s.SkinHeight) then
					surface.SetMaterial(gradient_d)
					surface.SetDrawColor(8, 12, 19, 230)
					surface.DrawTexturedRect(1, draw_stats_y + s.SkinHeight - 17, w - 2, 30)
					surface.SetDrawColor(8, 12, 19, 230)
					surface.DrawRect(1, draw_stats_y + s.SkinHeight + 13, w - 2, h - 2 - draw_stats_y - s.SkinHeight - 13)
				end
    		end

            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawLine(6, 22 + draw_xp_lvl, w - 6, 22 + draw_xp_lvl)
            surface_DrawLine(6, 43 + draw_xp_lvl, w - 6, 43 + draw_xp_lvl)
            surface_SetDrawColor(0, 0, 0, 100)
            surface_DrawLine(6, 23 + draw_xp_lvl, w - 6, 23 + draw_xp_lvl)
            surface_DrawLine(6, 44 + draw_xp_lvl, w - 6, 44 + draw_xp_lvl)
            surface_SetDrawColor(rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].r, rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].g, rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].b, rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].a)
            local grad_x = 1
            local grad_y = 25 + draw_xp_lvl
            local grad_w = (w - 2) / 2
            local grad_h = 16
            local grad_x2 = 1 + ((w - 2) / 2) + (((w - 2) / 2) / 2)
            local grad_y2 = 25 + (grad_h / 2) + draw_xp_lvl
            surface_SetMaterial(gradient_r)
            surface_DrawTexturedRect(grad_x, grad_y, grad_w, grad_h)
            surface_SetMaterial(gradient_r)
            surface_DrawTexturedRectRotated(grad_x2, grad_y2, grad_w, grad_h, 180)
            surface_SetMaterial(gradient_d)
            surface_SetDrawColor(rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][2].r, rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][2].g, rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][2].b, 100)
            --surface_DrawTexturedRect( 1, 1 + ( h / 2 ), w - 2, ( h / 2 ) - 2 )
            local RARITY_TEXT = ""

            if (ITEM_HOVERED.nt or ITEM_HOVERED.item.NotTradeable) then
                RARITY_TEXT = LocalPlayer():Nick() .. "'s "
            end

            if (ITEM_HOVERED.item.Kind and ITEM_HOVERED.item.Kind ~= "tier") then
                RARITY_TEXT = RARITY_TEXT .. rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][1] .. " " .. ITEM_HOVERED.item.Kind
            elseif (ITEM_HOVERED.w) then
                RARITY_TEXT = RARITY_TEXT .. rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][1] .. " " .. m_LoadoutTypes[util.GetWeaponSlot(ITEM_HOVERED.w)]
            end

			grad_y2 = grad_y2 - 1

            for i = 1, 2 do
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w + i, grad_y2 + i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w - i, grad_y2 - i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w + i, grad_y2 - i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w - i, grad_y2 + i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			draw_SimpleText(RARITY_TEXT, "moat_Medium4", grad_w, grad_y2, rarity_accents[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            local draw_name_x = 7
            local draw_name_y = 3
            local name_col = ITEM_HOVERED.item.NameColor or rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][2]:Copy()
            local name_font = "moat_Medium5"
			name_col.a = 255
            if (ITEM_HOVERED.item.NameEffect) then
                local tfx = ITEM_HOVERED.item.NameEffect

                if (tfx == "glow") then
                    m_DrawGlowingText(false, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
                elseif (tfx == "fire") then
                    m_DrawFireText(ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, true)
                elseif (tfx == "bounce") then
                    m_DrawBouncingText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
                elseif (tfx == "enchanted") then
                    m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, ITEM_HOVERED.item.NameEffectMods[1], nil, nil, true)
				elseif (tfx == "threecolors") then
					if (not ITEM_HOVERED.item.NameEffectMods[4]) then ITEM_HOVERED.item.NameEffectMods[4] = 1 end
					if (not ITEM_HOVERED.item.NameEffectMods[5]) then ITEM_HOVERED.item.NameEffectMods[5] = RealTime() end
					if (ITEM_HOVERED.item.NameEffectMods[5] <= RealTime()) then
						ITEM_HOVERED.item.NameEffectMods[4] = ITEM_HOVERED.item.NameEffectMods[4] + 1
						if (ITEM_HOVERED.item.NameEffectMods[4] > 3) then ITEM_HOVERED.item.NameEffectMods[4] = 1 end
						ITEM_HOVERED.item.NameEffectMods[5] = RealTime() + (FrameTime() * 5)
					end

					m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, ITEM_HOVERED.item.NameEffectMods[itemtbl.item.NameEffectMods[4]], nil, nil, true)
                elseif (tfx == "electric") then
                    m_DrawElecticText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, true)
                elseif (tfx == "frost") then
                    DrawFrostingText(10, 1.5, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, Color(100, 100, 255), Color(255, 255, 255))
                else
                    m_DrawShadowedText(1, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                end
                --local x_p, y_p = s:GetPos()
                --draw_SimpleTextDegree( ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, x_p, y_p, Color(255,0,0), Color(0,0,255), 0.7, TEXT_ALIGN_LEFT )
            else
                m_DrawShadowedText(1, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
            end

            if (ITEM_HOVERED.n) then
                -- emoji.SimpleText("\"" .. ITEM_HOVERED.n:Replace("''", "'") .. "\"", "moat_ItemDesc", draw_name_x, draw_name_y + 21, Color(255, 128, 128))
            end

			drawn_stats = 0

            if (ITEM_HOVERED.s and (ITEM_HOVERED.item.Kind == "tier" or ITEM_HOVERED.item.Kind == "Unique" or ITEM_HOVERED.item.Kind == "Melee")) then
                draw_stats_multi = 25
				s.StatsHeight, s.SkinHeight = m_DrawItemStats("moat_ItemDesc", draw_stats_x, draw_stats_y + (drawn_stats * draw_stats_multi), ITEM_HOVERED, s)
                drawn_stats = 10
            elseif (ITEM_HOVERED.item and ITEM_HOVERED.item.Kind ~= "tier" and ITEM_HOVERED.item.Kind ~= "Unique" and ITEM_HOVERED.item.Kind ~= "Melee" and ITEM_HOVERED.item.Description) then
                local item_desc = ITEM_HOVERED.item.Description
                local item_desctbl = string.Explode("^", item_desc)

                if (ITEM_HOVERED.s and ITEM_HOVERED.item and ITEM_HOVERED.item.Stats) then
                    for i = 1, #item_desctbl do
						if (not ITEM_HOVERED.item.Stats[i]) then
							continue
						end

                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i])), 2)

                        if (s.ctrldown) then
                            item_stat = "(" .. ITEM_HOVERED.item.Stats[i].min .. "-" .. ITEM_HOVERED.item.Stats[i].max .. ") " .. math.Round(item_stat, 2)
                        end

                        item_desctbl[i] = string.format(item_desctbl[i], item_stat)
                    end
                end

                item_desc = string.Implode("", item_desctbl)
                item_desc = string.Replace(item_desc, "_", "%")
                drawn_stats = m_DrawItemDesc(item_desc, "moat_ItemDesc", draw_stats_x, draw_stats_y, w - 12, h - draw_stats_y - 20)
                draw_stats_multi = 15
                local collection_y = draw_stats_y + (drawn_stats * draw_stats_multi) - 1
                m_DrawShadowedText(1, "From the " .. ITEM_HOVERED.item.Collection, "moat_Medium2", 6, collection_y, Color(150, 150, 150, 100))

				if (ITEM_HOVERED.p3) then
        			local p3txt = MOAT_PAINT.Skins[ITEM_HOVERED.p3] and MOAT_PAINT.Skins[ITEM_HOVERED.p3][1] or "Glitched Skin"
					m_DrawShadowedText(1, p3txt, "moat_Medium2", s:GetWide() - 6, collection_y, MOAT_PAINT.Skins[ITEM_HOVERED.p3] and rarity_names[MOAT_PAINT.Skins[ITEM_HOVERED.p3][3]][2]:Copy() or Color(100, 100, 100, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    			end
            end

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                m_DrawShadowedText(1, ITEM_HOVERED.s.l, "moat_ItemDescLarge3", s:GetWide() - 6, 0, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                surface_SetFont("moat_ItemDescLarge3")
                local level_w, level_h = surface_GetTextSize(ITEM_HOVERED.s.l)
                m_DrawShadowedText(1, "LVL", "moat_ItemDesc", s:GetWide() - 6 - level_w, 4, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                m_DrawShadowedText(1, "XP: " .. ITEM_HOVERED.s.x .. "/ " .. (ITEM_HOVERED.s.l * 100), "moat_ItemDescSmall2", s:GetWide() - 6 - level_w - 2, 16, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                
                local nt_ = 0
                -- if (ITEM_HOVERED.n) then nt_ = 15 end

                surface_SetDrawColor(255, 255, 255, 20)
                surface_DrawRect(6, 27 + nt_, w - 12, 2)
                local bar_width = w - 12
                local xp_bar_width = bar_width * (ITEM_HOVERED.s.x / (ITEM_HOVERED.s.l * 100))
                surface_SetDrawColor(200, 200, 200, 255)
                surface_SetMaterial(gradient_r)
                surface_DrawTexturedRect(7, 27 + nt_, math.min(xp_bar_width, w - 12), 2)
            end
        end
    end

    local non_drawn_stats = {"d", "f", "m", "l", "x", "j", "tr"}

    MOAT_INV_S.Think = function(s)
        if (not IsValid(MOAT_INV_BG)) then
            s:Remove()
        end

        s.ctrldown = input.IsKeyDown(KEY_LCONTROL)

        local ITEM_HOVERED = m_Inventory[m_HoveredSlot]

		if (string.EndsWith(tostring(m_HoveredSlot), "l")) then
            ITEM_HOVERED = m_Loadout[tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))]
        end

		if (string.EndsWith(tostring(m_HoveredSlot), "t")) then
            ITEM_HOVERED = m_Trade[tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))]
        end

		if (string.EndsWith(tostring(m_HoveredSlot), "u")) then
			local num = string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1)
			ITEM_HOVERED = m_Inventory[tonumber(num)]
        end

        if (not HoveringSlot or (IsValid(M_INV_MENU) and M_INV_MENU.Hovered)) then
            s:SetAlpha(0)
		
            return
        end

        if (ITEM_HOVERED and ITEM_HOVERED.c) then
            s.AnimVal = Lerp(FrameTime() * stat_anim, s.AnimVal, 1)

            if (not s.SavedItem or (s.SavedItem ~= ITEM_HOVERED)) then
                s.AnimVal = 0
                s.SavedItem = ITEM_HOVERED
            end

            local ITEM_NAME_FULL = GetItemName(ITEM_HOVERED)

            surface_SetFont("moat_Medium5")
            local namew, nameh = surface_GetTextSize(ITEM_NAME_FULL)
            local namew2, nameh2 = 0, 0

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                surface_SetFont("moat_ItemDescLarge3")
                local level_w, level_h = surface_GetTextSize(ITEM_HOVERED.s.l)
                surface_SetFont("moat_ItemDescSmall2")
                namew2, nameh2 = surface_GetTextSize("XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100))
                namew2 = namew2 + level_w
            end

			s.savewide = math.max(namew + namew2 + 32 + 10, 310)
			local w = math.max(s.savewide + ((s.ctrldown and ITEM_HOVERED.s) and 0 or 0), ((s.ctrldown and ITEM_HOVERED.s) and 310 or 0))
			if (w % 2 ~= 0) then
				w = w + 1
			end

			s:SetWide(w)

            -- if (s.ctrldown and ITEM_HOVERED.s) then
            --     s:SetWide(s.savewide + 75)
            -- else
            --     s:SetWide(s.savewide)
            -- end

            local num_stats = 0

            if (ITEM_HOVERED.s) then
                for k, v in pairs(ITEM_HOVERED.s) do
                    if (not table.HasValue(non_drawn_stats, tostring(k))) then
                        num_stats = num_stats + 1
                    end
                end
            end

            local draw_stats_multi = 25
            local default_drawn_stats = 40

            if (ITEM_HOVERED.item and ITEM_HOVERED.item.Kind ~= "tier" and ITEM_HOVERED.item.Kind ~= "Unique" and ITEM_HOVERED.item.Kind ~= "Melee" and ITEM_HOVERED.item.Description) then
                local item_desc = ITEM_HOVERED.item.Description
                local item_desctbl = string.Explode("^", item_desc)

                if (ITEM_HOVERED.s and ITEM_HOVERED.item and ITEM_HOVERED.item.Stats) then
                    for i = 1, #item_desctbl do
						if (not ITEM_HOVERED.item.Stats[i]) then
							continue
						end

                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i])), 2)

                        if (s.ctrldown) then
                            item_stat = "(" .. ITEM_HOVERED.item.Stats[i].min .. "-" .. ITEM_HOVERED.item.Stats[i].max .. ") " .. math.Round(item_stat, 2)
                        end

                        item_desctbl[i] = string.format(item_desctbl[i], item_stat)
                    end
                end

                item_desc = string.Implode("", item_desctbl)
                item_desc = string.Replace(item_desc, "_", "%")
                num_stats = m_GetItemDescH(item_desc, "moat_ItemDesc", s:GetWide() - 12)
                draw_stats_multi = 15
                default_drawn_stats = 0
            end

            local drawn_talents = 0

            if (ITEM_HOVERED.t) then
                drawn_talents = 12

                for k, v in ipairs(ITEM_HOVERED.t) do
					if (not ITEM_HOVERED.Talents[k] or not ITEM_HOVERED.Talents[k].Description) then
						continue
					end

                    local talent_desc2 = ITEM_HOVERED.Talents[k].Description
                    local talent_desctbl2 = string.Explode("^", talent_desc2)

                    for i = 1, #v.m do
						if (not ITEM_HOVERED.Talents[k].Modifications or not ITEM_HOVERED.Talents[k].Modifications[i]) then
							continue
						end

                        local mod_num = math.Round(ITEM_HOVERED.Talents[k].Modifications[i].min + ((ITEM_HOVERED.Talents[k].Modifications[i].max - ITEM_HOVERED.Talents[k].Modifications[i].min) * math.min(1, v.m[i])), 1)

                        if (s.ctrldown) then
                            mod_num = "(" .. ITEM_HOVERED.Talents[k].Modifications[i].min .. "-" .. ITEM_HOVERED.Talents[k].Modifications[i].max .. ") " .. math.Round(mod_num, 2)
                        end

                        talent_desctbl2[i] = string.format(talent_desctbl2[i], tostring(mod_num))
                    end

                    talent_desc2 = string.Implode("", talent_desctbl2)
                    talent_desc2 = string.Replace(talent_desc2, "_", "%")
                    local talent_desc_h = 17 + (m_GetItemDescH(talent_desc2, "moat_ItemDesc", s:GetWide() - 12 - 6) * 15)
                    drawn_talents = drawn_talents + talent_desc_h + 3
                end
            end

            local collection_add = 0

            if (ITEM_HOVERED.item and ITEM_HOVERED.item.Collection) then
				collection_add = 10
            end

            local panel_height = draw_stats_y + default_drawn_stats + drawn_talents + (num_stats * draw_stats_multi) + 4 + collection_add

            if ((ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0) == 0 and ITEM_HOVERED.item.ID and ITEM_HOVERED.item.ID ~= 7820 and ITEM_HOVERED.item.ID ~= 7821) then
                -- panel_height = 100
            end

            s:SetTall(panel_height)

            local w2, h2 = s:GetSize()
            local x2, y2 = 0, 0

            if (gui.MouseX() + w2 + gui_frame_off > ScrW()) then
                x2 = (gui.MouseX() + w2 + gui_frame_off) - ScrW()
            end

            if (gui.MouseY() - panel_height - gui_frame_off < 0) then
                y2 = math.abs((gui.MouseY() - panel_height - gui_frame_off))
            end

			s:SetAlpha(255)

			if (moat_imagehack) then
				return
			end

			s:SetPos(gui.MouseX() - x2 + gui_frame_off, gui.MouseY() - (panel_height) + y2 - gui_frame_off)
        else
            s.AnimVal = 0
            s:SetAlpha(0)
        end
    end

    function m_InitializeTrade(ply_2, u_trade)
        if (ply_2 and u_trade and not IsValid(MOAT_TRADE_BG)) then
            if (IsValid(M_TRADING_PNL)) then M_TRADING_PNL:Remove() end
			if (not IsValid(MOAT_INV_BG)) then
            	net.Start("MOAT_RESPOND_TRADE")
            	net.WriteBool(false)
            	net.WriteDouble(ply_2:EntIndex())
            	net.WriteDouble(u_trade)
            	net.SendToServer()
				return
			end

            local inv_x, inv_y = MOAT_INV_BG:GetPos()
            MOAT_TRADE_BG = vgui.Create("DFrame")
            MOAT_TRADE_BG:SetTitle("")
            MOAT_TRADE_BG:ShowCloseButton(false)
            MOAT_TRADE_BG:SetDraggable(false)
            MOAT_TRADE_BG:SetSize(368, MOAT_INV_BG_H - 35 - 5)

            if (ply2 and utrade) then
                MOAT_TRADE_BG:SetPos(inv_x + 5, inv_y + 35)
            else
                MOAT_TRADE_BG:SetPos(inv_x - MOAT_TRADE_BG:GetWide(), inv_y + 35)
                MOAT_TRADE_BG:SetAlpha(0)
                MOAT_TRADE_BG:MoveTo(inv_x + 5, inv_y + 35, 0.15, 0.15, -1)
                MOAT_TRADE_BG:AlphaTo(255, 0.15, 0.15)
            end

            MOAT_TRADE_BG:MakePopup()
            MOAT_INV_CAT = 3
            local box_height = (68 * 2) + 7
            local x_off = 0
            local y_off = 0
            local y_off2 = -5
            local offer1_x = x_off
            local offer1_y = 28 + y_off
            local offer1_w = MOAT_TRADE_BG:GetWide() - 18
            local offer1_h = box_height
            local offer2_x = offer1_x
            local offer2_y = box_height + (64) + 28 + y_off - 13
            local offer2_w = offer1_w
            local offer2_h = offer1_h
            local M_TRADE_CHAT_LBL_COL = 50
            local inventory_cats = table.Copy(MOAT_INV_CATS)
            inventory_cats[4] = {"Trade", 100}
            MOAT_TRADE_BG.ICOffered = 0
            MOAT_TRADE_BG.OLoc = 3
            MOAT_TRADE_BG.WTimer = 0
            MOAT_TRADE_BG.ConfirmTime = 0
            MOAT_TRADE_BG.ACCEPTED = 0
            MOAT_TRADE_BG.ACCEPTED2 = 0

            MOAT_TRADE_BG.Paint = function(s, w, h)
                if (not IsValid(ply_2)) then
					if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
        			if (IsValid(MOAT_TRADE_BG)) then MOAT_TRADE_BG:Remove() end

                    if (m_ply2 and m_utrade) then
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

                    chat.AddText(mat_info, Color(255, 0, 0), "Trade canceled. Player disconnected?")
                    return
                end

				if (not IsValid(MOAT_INV_BG)) then return end
                local x, y = MOAT_INV_BG:GetPos()
                local invw, invh = MOAT_INV_BG:GetSize()
                render.SetScissorRect(x, y, x + invw, y + invh, true)
                if (MT_TSHADOW) then
                    m_DrawShadowedText(1, "Your offer:", "Trebuchet24", 25 + 2 + 3 + x_off, 1 + y_off - y_off2, MT_TCOL)
                    m_DrawShadowedText(1, "Viewing Trading", "moat_TradeDesc", 25 + 2 + 3 + x_off, 1 + y_off + y_off2 + 2, Color(0, 200, 0, 255))
                    m_DrawShadowedText(1, ply_2:Nick() .. "'s offer:", "Trebuchet24", 25 + 2 + 3 + x_off, offer2_y - 28 + 1 - y_off2, MT_TCOL)
                    m_DrawShadowedText(1, "Viewing " .. inventory_cats[s.OLoc][1], "moat_TradeDesc", 25 + 2 + 3 + x_off, offer2_y - 28 + 1 + y_off2 + 2, Color(0, 200, 0, 255))
                else
                    draw_SimpleText("Your offer:", "moat_Trebuchet", 25 + 2 + 3 + x_off, 1 + y_off - y_off2, MT_TCOL)
                    draw_SimpleText("Viewing Trading", "moat_TradeDesc", 25 + 2 + 3 + x_off, 1 + y_off + y_off2 + 2, Color(0, 200, 0, 255))
                    draw_SimpleText(ply_2:Nick() .. "'s offer:", "moat_Trebuchet", 25 + 2 + 3 + x_off, offer2_y - 28 + 1 - y_off2, MT_TCOL)
                    draw_SimpleText("Viewing " .. inventory_cats[s.OLoc][1], "moat_TradeDesc", 25 + 2 + 3 + x_off, offer2_y - 28 + 1 + y_off2 + 2, Color(0, 200, 0, 255))
                end
                surface_SetDrawColor(62, 62, 64, 255)
                surface_DrawOutlinedRect(offer1_x, offer1_y, offer1_w, offer1_h + 19)
                surface_DrawOutlinedRect(offer2_x, offer2_y, offer2_w, offer2_h + 19)
                surface_SetDrawColor(0, 0, 0, 100)
                surface_DrawRect(offer1_x + 1, offer1_y + 1, offer1_w - 2, offer1_h - 2 + 19)
                surface_DrawRect(offer2_x + 1, offer2_y + 1, offer2_w - 2, offer2_h - 2 + 19)
                surface_SetDrawColor(62, 62, 64, 255)
                surface_DrawOutlinedRect(offer1_x, offer1_y, offer1_w, offer1_h + 19)
                surface_DrawOutlinedRect(offer2_x, offer2_y, offer2_w, offer2_h + 19)
                surface_SetMaterial(mat_coins)
                surface_SetDrawColor(255, 255, 255)
                surface_DrawTexturedRect(offer1_x + 4, offer1_y + offer1_h - 1, 16, 16)
                surface_DrawTexturedRect(offer2_x + 4, offer2_y + offer2_h - 1, 16, 16)
                surface_SetDrawColor(0, 0, 0, 100)
                surface_DrawRect(offer1_x + 4 + 20, offer1_y + offer1_h - 1, offer2_w - 8 - 20, 16)
                surface_DrawRect(offer2_x + 4 + 20, offer2_y + offer2_h - 1, offer2_w - 8 - 20, 16)
                if (MT_TSHADOW) then
                    m_DrawShadowedText(1, "IC Offered: ", "moat_ItemDesc", offer1_x + 24 + 3, offer1_y + offer1_h, Color(255, 255, 255))
                    m_DrawShadowedText(1, "IC Offered: " .. s.ICOffered, "moat_ItemDesc", offer2_x + 24 + 3, offer2_y + offer2_h, Color(255, 255, 255))
                else
                    draw_SimpleText("IC Offered: ", "moat_ItemDesc", offer1_x + 24 + 3, offer1_y + offer1_h, Color(255, 255, 255))
                    draw_SimpleText("IC Offered: " .. s.ICOffered, "moat_ItemDesc", offer2_x + 24 + 3, offer2_y + offer2_h, Color(255, 255, 255))
                end
                surface_SetDrawColor(62, 62, 64, 255)
                surface_DrawOutlinedRect(offer2_x, offer2_y + offer2_h - 1 + 23, s:GetWide(), 96)
                surface_SetDrawColor(0, 0, 0, 100)
                surface_DrawRect(offer2_x + 1, offer2_y + offer2_h + 1 + 23, s:GetWide() - 2, 96 - 2)
                surface_DrawOutlinedRect(offer2_x, offer2_y + offer2_h - 1 + 23, s:GetWide(), 96)
                surface_SetDrawColor(62, 62, 64, 255)
                surface_DrawLine(offer2_x + 1, offer2_y + offer2_h - 2 + 23 + 96 - 16, s:GetWide() - 1, offer2_y + offer2_h - 2 + 23 + 96 - 16)
                surface_DrawLine(offer2_x + 1, offer2_y + offer2_h - 2 + 23 + 96 - 16, s:GetWide() - 1, offer2_y + offer2_h - 2 + 23 + 96 - 16)
                surface_SetDrawColor(0, 0, 0, 100)
                surface_DrawRect(offer2_x + 2, offer2_y + offer2_h - 1 + 23 + 96 - 16 + 1, s:GetWide() - 2 - 2, 14)
                if (MT_TSHADOW) then
                    m_DrawShadowedText(1, "Enter a message here...", "moat_ItemDesc", offer2_x + 4, offer2_y + offer2_h - 1 + 23 + 96 - 16, Color(255, 255, 255, M_TRADE_CHAT_LBL_COL))
                else
                    draw_SimpleText("Enter a message here...", "moat_ItemDesc", offer2_x + 4, offer2_y + offer2_h - 1 + 23 + 96 - 16, Color(255, 255, 255, M_TRADE_CHAT_LBL_COL))
                end
                if (s.ACCEPTED == 1) then
                    surface_SetDrawColor(0, 100, 0, 200)
                elseif (s.ACCEPTED == 2) then
                    surface_SetDrawColor(0, 200, 0, 200)
                else
                    surface_SetDrawColor(0, 0, 0, 200)
                end

                surface_DrawRect(offer1_x + offer1_w + 4, offer1_y, 14, offer1_h + 19)

                if (s.ACCEPTED2 == 1) then
                    surface_SetDrawColor(0, 100, 0, 200)
                elseif (s.ACCEPTED2 == 2) then
                    surface_SetDrawColor(0, 200, 0, 200)
                else
                    surface_SetDrawColor(0, 0, 0, 200)
                end

                surface_DrawRect(offer2_x + offer2_w + 4, offer2_y, 14, offer2_h + 19)
                render.SetScissorRect(0, 0, 0, 0, false)
            end

            local MOAT_TRADE_AVA = vgui.Create("AvatarImage", MOAT_TRADE_BG)
            MOAT_TRADE_AVA:SetSize(25, 25)
            MOAT_TRADE_AVA:SetPos(x_off, y_off)
            MOAT_TRADE_AVA:SetPlayer(LocalPlayer(), 32)
            local ava2_pos_y = offer2_y - 28
            local MOAT_TRADE_AVA2 = vgui.Create("AvatarImage", MOAT_TRADE_BG)
            MOAT_TRADE_AVA2:SetSize(25, 25)
            MOAT_TRADE_AVA2:SetPos(x_off, ava2_pos_y)
            MOAT_TRADE_AVA2:SetPlayer(ply_2, 32)
            MOAT_TRADE_AVA2.Think = function(s)

            end
            local MOAT_TRADE_L1 = vgui.Create("DIconLayout", MOAT_TRADE_BG)
            MOAT_TRADE_L1:SetPos(offer1_x + 3, offer1_y + 3)
            MOAT_TRADE_L1:SetSize(offer1_w, offer1_h)
            MOAT_TRADE_L1:SetSpaceX(1)
            MOAT_TRADE_L1:SetSpaceY(1)
            local MOAT_TRADE_L2 = vgui.Create("DIconLayout", MOAT_TRADE_BG)
            MOAT_TRADE_L2:SetPos(offer2_x + 3, offer2_y + 3)
            MOAT_TRADE_L2:SetSize(offer2_w, offer2_h)
            MOAT_TRADE_L2:SetSpaceX(1)
            MOAT_TRADE_L2:SetSpaceY(1)
            m_Trade = {}
            M_TRADE_SLOT = {}

            function m_CreateTradeSlots(num)
                m_Trade[num] = {}
                local list_to_add = MOAT_TRADE_L1

                if (num > 10) then
                    list_to_add = MOAT_TRADE_L2
                end

                local m_ItemExists = false
                local hover_coloral = 0
                local m_DPanel = list_to_add:Add("DPanel")
                m_DPanel:SetSize(68, 68)

                m_DPanel.Paint = function(s, w, h)
                    if (not m_Trade[num]) then
						if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
        				if (IsValid(MOAT_TRADE_BG)) then MOAT_TRADE_BG:Remove() end

                        if (m_ply2 and m_utrade) then
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

						chat.AddText(mat_info, Color(255, 0, 0), "Trade canceled. Player disconnected?")
                        return
                    end

					if (not IsValid(MOAT_INV_BG)) then return end
                    local x, y = MOAT_INV_BG:GetPos()
                    local invw, invh = MOAT_INV_BG:GetSize()
                    render.SetScissorRect( x, y, x + invw, y + invh, true )

                    local draw_x = 2
                    local draw_y = 2
                    local draw_w = w - 4
                    local draw_h = h - 4
                    local draw_y2 = 2 + ((h - 4) / 2)
                    local draw_h2 = (h - 4) - ((h - 4) / 2)

                    if (MT[CurTheme].SLOT_PAINT) then
                        MT[CurTheme].SLOT_PAINT(s, w, h, hover_coloral, m_Trade[num])

                        return
                    end

                    surface_SetDrawColor(0, 0, 0, 100)
                    surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
                    surface_SetDrawColor(50, 50, 50, hover_coloral)
                    surface_DrawRect(draw_x, draw_y, draw_w, draw_h)

                    if (m_Trade[num].c) then
                        surface_SetDrawColor(150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 150 + (hover_coloral / 2), 100)
                        surface_DrawRect(draw_x, draw_y, draw_w, draw_h)
                        surface_SetDrawColor(rarity_names[m_Trade[num].item.Rarity][2].r, rarity_names[m_Trade[num].item.Rarity][2].g, rarity_names[m_Trade[num].item.Rarity][2].b, 100 + hover_coloral)
                        surface_SetMaterial(gradient_d)
                        surface_DrawTexturedRect(draw_x, draw_y2 - (hover_coloral / 7), draw_w, draw_h2 + (hover_coloral / 7) + 1)
                    end

                    surface_SetDrawColor(62, 62, 64, 255)

                    if (m_Trade[num].c) then
                        surface_SetDrawColor(rarity_names[m_Trade[num].item.Rarity][2])
                    end

                    surface_DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
                    surface_SetDrawColor(62, 62, 64, hover_coloral / 2)

                    if (m_Trade[num].c) then
                        surface_SetDrawColor(rarity_names[m_Trade[num].item.Rarity][2].r, rarity_names[m_Trade[num].item.Rarity][2].g, rarity_names[m_Trade[num].item.Rarity][2].b, hover_coloral / 2)
                    end

                    surface_DrawOutlinedRect(0, 0, w, h)

                    local triangle = {
                        {
                            x = 0,
                            y = 0
                        },
                        {
                            x = w,
                            y = w
                        },
                        {
                            x = 0,
                            y = w
                        }
                    }

                    surface_SetDrawColor(50, 50, 50, 10)
                    draw.NoTexture()
                    render.SetScissorRect(0, 0, 0, 0, false)
                end

                --  surface_DrawPoly( triangle )
                local m_DPanelIcon = {}
                m_DPanelIcon.SIcon = vgui.Create("MoatModelIcon", m_DPanel)
                m_DPanelIcon.SIcon:SetPos(2, 2)
                m_DPanelIcon.SIcon:SetSize(64, 64)
                m_DPanelIcon.SIcon:SetTooltip(nil)

                m_DPanelIcon.SIcon.Think = function(s)
                    s:SetTooltip(nil)
                end

                m_DPanelIcon.SIcon:SetVisible(false)
                m_DPanelIcon.WModel = nil
                m_DPanelIcon.Item = nil
                m_DPanelIcon.MSkin = nil

                m_DPanelIcon.SIcon.PaintOver = function(s, w, h)
					if (not m_Trade[num]) then return end

                    if (m_Trade[num].c) then
                        if (not string.EndsWith(m_DPanelIcon.WModel, ".mdl")) then
							if (not IsValid(MOAT_INV_BG)) then return end
                            local x, y = MOAT_INV_BG:GetPos()
                            local invw, invh = MOAT_INV_BG:GetSize()
                            render.SetScissorRect( x, y, x + invw, y + invh, true )
                            s.Icon:SetAlpha(0)
                            if (m_DPanelIcon.Item and m_DPanelIcon.Item.item and m_DPanelIcon.Item.item.Clr) then
								cdn.DrawImage(m_DPanelIcon.WModel, 1, 1, w, h, {r = m_DPanelIcon.Item.item.Clr[1], g = m_DPanelIcon.Item.item.Clr[2], b = m_DPanelIcon.Item.item.Clr[3], a = 255})
                            elseif (m_DPanelIcon.WModel:StartWith("https")) then
                                cdn.DrawImage(m_DPanelIcon.WModel, 1, 1, w, h, {r = 255, g = 255, b = 255, a = 100})
                                cdn.DrawImage(m_DPanelIcon.WModel, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 255})
                            else
								if (m_DPanelIcon.WModel and (not s.MatPath or (s.MatPath and m_DPanelIcon.WModel ~= s.MatPath))) then
									s.MatPath = m_DPanelIcon.WModel
									s.Mat = Material(m_DPanelIcon.WModel)
								end

								if (s.Mat) then
									surface_SetDrawColor(255, 255, 255, 100)
									surface_SetMaterial(s.Mat)
									surface_DrawTexturedRect(1, 1, w, h)
									surface_SetDrawColor(255, 255, 255, 255)
									surface_DrawTexturedRect(0, 0, w, h)
								end
                            end
                            render.SetScissorRect(0, 0, 0, 0, false)
                        else
                            s.Icon:SetAlpha(255)
                        end

						local locked = false

						if (m_Trade[num].l and m_Trade[num].l == 1) then
							locked = true
							surface_SetDrawColor(255, 255, 255)
							surface_SetMaterial(mat_lock)
							surface_DrawTexturedRect(1, 1, 16, 16)
						end

						if (m_Trade[num].p or m_Trade[num].p2 or m_Trade[num].p3) then
							surface_SetDrawColor(255, 255, 255)
							surface_SetMaterial(mat_paint)
							surface_DrawTexturedRect(locked and 18 or 1, 1, 16, 16)
						end

						if (m_Trade[num].decon) then
							surface_SetDrawColor(150, 0, 0, 200)
							surface_DrawRect(0, 0, w, h)
						end
                    end
                end

                local m_DPanelBTN = vgui.Create("DButton", m_DPanel)
                m_DPanelBTN:SetText("")
                m_DPanelBTN:SetSize(68, 68)
                m_DPanelBTN.Paint = function(s, w, h) end
                local btn_hovered = 1
                local btn_color_a = false

                m_DPanelBTN.Think = function(s)
                    if (not s:IsHovered()) then
                        btn_hovered = 0
                        btn_color_a = false

                        if (hover_coloral > 0) then
                            hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
                        end

						if (m_HoveredSlot == (num .. "t")) then
							HoveringSlot = false
						end
                    else
                        if (IsValid(M_INV_MENU)) then
                            if (M_INV_MENU.Hovered) then
                                btn_hovered = 0
                                btn_color_a = false

                                if (hover_coloral > 0) then
                                    hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
                                end

                                return
                            end
                        end

                        m_HoveredSlot = num .. "t"

                        if (hover_coloral < 154 and btn_hovered == 0) then
                            hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
                        else
                            btn_hovered = 1
                        end

                        if (btn_hovered == 1) then
                            if (btn_color_a) then
                                if (hover_coloral >= 154) then
                                    btn_color_a = false
                                else
                                    hover_coloral = hover_coloral + (100 * FrameTime())
                                end
                            else
                                if (hover_coloral <= 50) then
                                    btn_color_a = true
                                else
                                    hover_coloral = hover_coloral - (100 * FrameTime())
                                end
                            end
                        end
                    end
                end

                m_DPanelBTN.OnMousePressed = function(s, key)
                    if (m_DPanelIcon and m_DPanelIcon.SIcon and key == MOUSE_LEFT) then m_DPanelIcon.SIcon:DoClick() end
                    
                    if (key == MOUSE_LEFT and num < 11) then
                        if (m_DPanelIcon.Item ~= nil) then
                            M_INV_DRAG = M_TRADE_SLOT[num]
                            sfx.Click1()
                        end
                    end

					if (key == MOUSE_RIGHT) then sfx.Click2() end
                end

                m_DPanelBTN.OnCursorEntered = function() 
                    m_HoveredSlot = num .. "t"
					HoveringSlot = true

					if (M_TRADE_SLOT[num].VGUI.Item and M_TRADE_SLOT[num].VGUI.Item.c) then
						sfx.Hover()
					end
                end

                m_DPanelBTN.OnCursorExited = function(s)
                	HoveringSlot = false
                end

                --table.insert(m_InventoryButtons, m_DPanelBTN)
                local tbl = {}
                tbl.VGUI = m_DPanelIcon
                tbl.Slot = num .. "t"
                M_TRADE_SLOT[num] = tbl
            end

            for i = 1, 20 do
                m_CreateTradeSlots(i)
            end

            M_TRADE_IC_ENTRY = vgui.Create("DTextEntry", MOAT_TRADE_BG)
            M_TRADE_IC_ENTRY:SetPos(offer1_x + 24 + 3 + 68, offer1_y + offer1_h)
            M_TRADE_IC_ENTRY:SetSize(250, 14)
            M_TRADE_IC_ENTRY:SetFont("moat_ItemDesc")
            M_TRADE_IC_ENTRY:SetTextColor(Color(255, 255, 255))
            M_TRADE_IC_ENTRY:SetCursorColor(Color(255, 255, 255))
            M_TRADE_IC_ENTRY:SetEnterAllowed(true)
            M_TRADE_IC_ENTRY:SetNumeric(true)
            M_TRADE_IC_ENTRY:SetDrawBackground(false)
            M_TRADE_IC_ENTRY:SetMultiline(false)
            M_TRADE_IC_ENTRY:SetVerticalScrollbarEnabled(false)
            M_TRADE_IC_ENTRY:SetEditable(true)
            M_TRADE_IC_ENTRY:SetValue("0")
            M_TRADE_IC_ENTRY:SetText("0")
            M_TRADE_IC_ENTRY.MaxChars = 7

            M_TRADE_IC_ENTRY.OnGetFocus = function(s)
                if (tostring(s:GetValue()) == "0") then
                    s:SetValue("")
                    s:SetText("")
                end
            end

            M_TRADE_IC_ENTRY.OnTextChanged = function(s)
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

            M_TRADE_IC_ENTRY.OnLoseFocus = function(s)
                if (tostring(s:GetValue()) == "") then
                    s:SetValue("0")
                    s:SetText("0")
                end

                if (MOAT_INVENTORY_CREDITS and tonumber(s:GetValue()) and (tonumber(s:GetValue()) > tonumber(MOAT_INVENTORY_CREDITS))) then
                    s:SetValue(MOAT_INVENTORY_CREDITS)
                    s:SetText(MOAT_INVENTORY_CREDITS)
                end

                net.Start("MOAT_TRADE_CREDITS")
                net.WriteDouble(u_trade)
                net.WriteDouble(tonumber(s:GetValue()))
                net.SendToServer()
            end

            M_TRADE_IC_ENTRY.OnEnter = function(s)
                s:OnLoseFocus()
            end

            local M_TRADE_CHAT_ENTRY = vgui.Create("DTextEntry", MOAT_TRADE_BG)
            M_TRADE_CHAT_ENTRY:SetPos(offer2_x + 1, offer2_y + offer2_h + 102)
            M_TRADE_CHAT_ENTRY:SetSize(MOAT_TRADE_BG:GetWide() - 4, 14)
            M_TRADE_CHAT_ENTRY:SetFont("moat_ItemDesc")
            M_TRADE_CHAT_ENTRY:SetTextColor(Color(255, 255, 255))
            M_TRADE_CHAT_ENTRY:SetCursorColor(Color(255, 255, 255))
            M_TRADE_CHAT_ENTRY:SetHistoryEnabled(true)
            M_TRADE_CHAT_ENTRY:SetEnterAllowed(true)
            M_TRADE_CHAT_ENTRY:SetTabbingDisabled(true)
            M_TRADE_CHAT_ENTRY:SetDrawBackground(false)
            M_TRADE_CHAT_ENTRY:SetMultiline(false)
            M_TRADE_CHAT_ENTRY:SetDrawOnTop(true)
            M_TRADE_CHAT_ENTRY:SetVerticalScrollbarEnabled(false)

            M_TRADE_CHAT_ENTRY.Think = function(s)
                if (s:GetValue() == "") then
                    M_TRADE_CHAT_LBL_COL = 50
                else
                    M_TRADE_CHAT_LBL_COL = 0
                end
            end

            M_TRADE_CHAT_ENTRY.OnEnter = function(s)
                local val = s:GetValue()

                if (#tostring(val) > 0) then
                    s:AddHistory(val)
                    net.Start("MOAT_TRADE_MESSAGE")
                    net.WriteDouble(ply_2:EntIndex())
                    net.WriteDouble(u_trade)
                    net.WriteString(tostring(val))
                    net.SendToServer()
                    s:SetText("")
                    s:SetValue("")
                end
            end

            M_TRADE_CHAT_ENTRY.MaxChars = 192

            M_TRADE_CHAT_ENTRY.OnTextChanged = function(s)
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

            M_TRADE_CHATLIST = vgui.Create("RichText", MOAT_TRADE_BG)
            M_TRADE_CHATLIST:SetPos(offer2_x + 1, offer2_y + offer2_h + 23)
            M_TRADE_CHATLIST:SetSize(MOAT_TRADE_BG:GetWide() - 2, 96 - 18)
            M_TRADE_CHATLIST:SetVerticalScrollbarEnabled(true)

            function M_TRADE_CHATLIST:PerformLayout()
                self:SetFontInternal("moat_ItemDesc")
            end

            M_TRADE_CHATLIST:InsertColorChange(200, 200, 0, 255)
            M_TRADE_CHATLIST:AppendText("You can use this chat to communicate with the person you're trading with.")
            local hover_coloral = 0
            local M_TRADE_A = vgui.Create("DButton", MOAT_TRADE_BG)
            M_TRADE_A:SetSize(125, 30)
            M_TRADE_A:SetPos(MOAT_TRADE_BG:GetWide() - 250 - 3, MOAT_TRADE_BG:GetTall() - 30)
            M_TRADE_A:SetText("")
			sfx.SoundEffects(M_TRADE_A)
            M_TRADE_A.Paint = function(s, w, h)
				if (not IsValid(MOAT_INV_BG)) then return end
                local x, y = MOAT_INV_BG:GetPos()
                local invw, invh = MOAT_INV_BG:GetSize()
                render.SetScissorRect( x, y, x + invw, y + invh, true )
                local green_col = 200

                if (s:GetDisabled()) then
                    green_col = 50
                end

                surface_SetDrawColor(0, 0, 0, 255)
                surface_DrawRect(0, 0, w, h)

                surface_SetDrawColor(50, 50, 50, 100)
                surface_DrawOutlinedRect(0, 0, w, h)
                surface_SetDrawColor(0, green_col, 0, 20 + hover_coloral / 5)
                surface_DrawRect(1, 1, w - 2, h - 2)
                surface_SetDrawColor(0, green_col + 55, 0, 20 + hover_coloral / 5)
                surface_SetMaterial(gradient_d)
                surface_DrawTexturedRect(1, 1, w - 2, h - 2)
                local accept_text = "Confirm"

                if (MOAT_TRADE_BG.ACCEPTED == 1) then
                    accept_text = "Accept"
                elseif (MOAT_TRADE_BG.ACCEPTED == 2) then
                    accept_text = "Cancel"
                end

                m_DrawShadowedText(1, accept_text, "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                render.SetScissorRect(0, 0, 0, 0, false)
            end

            local btn_hovered = 1
            local btn_color_a = false

            M_TRADE_A.Think = function(s)
                if (not s:IsHovered()) then
                    btn_hovered = 0
                    btn_color_a = false

                    if (hover_coloral > 0) then
                        hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
                    end
                else
                    if (hover_coloral < 154 and btn_hovered == 0) then
                        hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
                    else
                        btn_hovered = 1
                    end

                    if (btn_hovered == 1) then
                        if (btn_color_a) then
                            if (hover_coloral >= 154) then
                                btn_color_a = false
                            else
                                hover_coloral = hover_coloral + (100 * FrameTime())
                            end
                        else
                            if (hover_coloral <= 50) then
                                btn_color_a = true
                            else
                                hover_coloral = hover_coloral - (100 * FrameTime())
                            end
                        end
                    end
                end
            end

            local hover_coloral2 = 0
            local M_TRADE_D = vgui.Create("DButton", MOAT_TRADE_BG)
            M_TRADE_D:SetSize(125, 30)
            M_TRADE_D:SetPos(MOAT_TRADE_BG:GetWide() - 125, MOAT_TRADE_BG:GetTall() - 30)
            M_TRADE_D:SetText("")
			sfx.SoundEffects(M_TRADE_D)
            M_TRADE_D.Paint = function(s, w, h)
				if (not IsValid(MOAT_INV_BG)) then return end
                local x, y = MOAT_INV_BG:GetPos()
                local invw, invh = MOAT_INV_BG:GetSize()
                render.SetScissorRect( x, y, x + invw, y + invh, true )
                surface_SetDrawColor(0, 0, 0, 255)
                surface_DrawRect(0, 0, w, h)
                surface_SetDrawColor(50, 50, 50, 100)
                surface_DrawOutlinedRect(0, 0, w, h)
                surface_SetDrawColor(255, 0, 0, 20 + hover_coloral2 / 5)
                surface_DrawRect(1, 1, w - 2, h - 2)
                surface_SetDrawColor(255, 0, 0, 20 + hover_coloral2 / 5)
                surface_SetMaterial(gradient_d)
                surface_DrawTexturedRect(1, 1, w - 2, h - 2)
                m_DrawShadowedText(1, "Decline", "Trebuchet24", w / 2, h / 2, Color(200, 100, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                render.SetScissorRect(0, 0, 0, 0, false)
            end

            local btn_hovered2 = 1
            local btn_color_a2 = false

            M_TRADE_D.Think = function(s)
                if (not s:IsHovered()) then
                    btn_hovered2 = 0
                    btn_color_a2 = false

                    if (hover_coloral2 > 0) then
                        hover_coloral2 = Lerp(2 * FrameTime(), hover_coloral2, 0)
                    end
                else
                    if (hover_coloral2 < 154 and btn_hovered2 == 0) then
                        hover_coloral2 = Lerp(5 * FrameTime(), hover_coloral2, 155)
                    else
                        btn_hovered2 = 1
                    end

                    if (btn_hovered2 == 1) then
                        if (btn_color_a2) then
                            if (hover_coloral2 >= 154) then
                                btn_color_a2 = false
                            else
                                hover_coloral2 = hover_coloral2 + (100 * FrameTime())
                            end
                        else
                            if (hover_coloral <= 50) then
                                btn_color_a2 = true
                            else
                                hover_coloral2 = hover_coloral2 - (100 * FrameTime())
                            end
                        end
                    end
                end
            end

            local accept_nums = {
                [0] = 1,
                [1] = 2,
                [2] = 0
            }

            M_TRADE_A.DoClick = function(s)
                MOAT_TRADE_BG.ACCEPTED = accept_nums[MOAT_TRADE_BG.ACCEPTED]
                net.Start("MOAT_TRADE_STATUS")
                net.WriteDouble(MOAT_TRADE_BG.ACCEPTED)
                net.WriteDouble(m_utrade)
                local eslots = m_GetESlots()
                net.WriteDouble(eslots)
                net.SendToServer()
            end

            M_TRADE_D.DoClick = function(s)
                MOAT_INV_BG:Remove()
                MOAT_TRADE_BG:Remove()

                if (m_ply2 and m_utrade) then
                    moat_inv_cooldown = CurTime() + 5
                    -- m_ClearInventory()
                    -- net.Start("MOAT_SEND_INV_ITEM")
                    -- net.SendToServer()
                    net.Start("MOAT_RESPOND_TRADE")
                    net.WriteBool(false)
                    net.WriteDouble(m_ply2:EntIndex())
                    net.WriteDouble(m_utrade)
                    net.SendToServer()
                end

				sfx.Decline()
            end

            MOAT_TRADE_BG.Think = function(s, w, h)
                if (not gui.IsConsoleVisible()) then
                    s:MoveToFront()
                end
                
                local curx = s:GetPos()
                local invx = ScrW()
				if (IsValid(MOAT_INV_BG)) then invx = MOAT_INV_BG:GetPos() end

                if (curx < invx) then
                    M_TRADE_CHATLIST:SetAlpha(0)
                    MOAT_TRADE_AVA2:SetAlpha(0)
                    MOAT_TRADE_AVA:SetAlpha(0)
                    M_TRADE_CHAT_ENTRY:SetAlpha(0)
                    M_TRADE_IC_ENTRY:SetAlpha(0)
                else
                    M_TRADE_CHATLIST:SetAlpha(255)
                    MOAT_TRADE_AVA2:SetAlpha(255)
                    MOAT_TRADE_AVA:SetAlpha(255)
                    M_TRADE_CHAT_ENTRY:SetAlpha(255)
                    M_TRADE_IC_ENTRY:SetAlpha(255)
                end

                if (s.ConfirmTime > 0) then
                    M_TRADE_A:SetDisabled(true)

                    if (s.WTimer <= CurTime()) then
                        s.WTimer = CurTime() + 1
                        s.ConfirmTime = s.ConfirmTime - 1
                    end
                else
                    M_TRADE_A:SetDisabled(false)
                end
            end
        end
    end

    if (m_ply2 and m_utrade) then
        m_InitializeTrade(m_ply2, m_utrade)
        MOAT_TRADE_BG:MoveTo((ScrW() / 2 - MOAT_INV_BG:GetWide() / 2) + 5, (ScrH() / 2 - MOAT_INV_BG:GetTall() / 2) + 35, 0.4, 0, 1)
		MOAT_TRADE_BG:AlphaTo(255, 0.4, 0)
    end

    -- MOAT_INV_BG:MoveTo(ScrW() / 2 - MOAT_INV_BG:GetWide() / 2, ScrH() / 2 - MOAT_INV_BG:GetTall() / 2, 0.4, 0, 1)
    -- MOAT_INV_BG:AlphaTo(255, 0.4, 0)

    net.Start("moat_OpenInventory")
    net.WriteBool(true)
    net.SendToServer()

	
	m_InventoryPanel()
	m_LoadoutPanel(true)
	m_InventoryCat()

	if (MOAT_THEMING) then
		net.Start("MOAT_INV_CAT")
        net.WriteDouble(7)
        net.SendToServer()
	end
end

function m_AddTradeChatMessage(tmsg, tply)
    if (not IsValid(M_TRADE_CHATLIST)) then return end
    if not IsValid(tply) then return end
    local ply_name = tply:Nick()

    if (string.StartWith(ply_name, "#") and #ply_name > 1) then
        ply_name = string.sub(ply_name, 2, #ply_name)
    end

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end
    local MT_TCOL = MT[CurTheme].TradePlayerColor

    M_TRADE_CHATLIST:InsertColorChange(MT_TCOL[1], MT_TCOL[2], MT_TCOL[3], 255)
    M_TRADE_CHATLIST:AppendText("\n" .. ply_name)
    M_TRADE_CHATLIST:InsertColorChange(200, 200, 200, 255)
    M_TRADE_CHATLIST:AppendText(": " .. tmsg)
end

function m_AddTradeChatFailureMessage(tmsg)
    if (not IsValid(M_TRADE_CHATLIST)) then return end
    M_TRADE_CHATLIST:AppendText("\n")
    M_TRADE_CHATLIST:InsertColorChange(200, 0, 0, 255)
    M_TRADE_CHATLIST:AppendText(tmsg)
end

local chatlinks = {"primary", "secondary", "melee", "powerup", "special", "head", "mask", "body", "effect", "model"}
local equipables = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true, 
    ["power-up"] = true, 
    ["special"] = true, 
    ["hat"] = true, 
    ["mask"] = true, 
    ["body"] = true, 
    ["effect"] = true, 
    ["model"] = true
}

MOAT_CACHED_PICS = {}

local moat_decon = CreateClientConVar("moat_decon_hold", 0, true, false)

function m_CreateItemMenu(num, ldt)
    local itemtbl = m_Inventory[num]
    if (ldt) then
        itemtbl = m_Loadout[num]
    end

    if (IsValid(M_INV_MENU)) then
        M_INV_MENU:Remove()
    end

	if (not itemtbl or not itemtbl.item) then return end

    /*
    local ITEM_NAME_FULL = ""

    if (itemtbl.item.Kind == "tier") then
        local ITEM_NAME = weapons.Get(itemtbl.w).PrintName

        if (string.EndsWith(ITEM_NAME, "_name")) then
            ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
            ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
        end

        ITEM_NAME_FULL = itemtbl.item.Name .. " " .. ITEM_NAME

        if (itemtbl.item.Rarity == 0) then
            ITEM_NAME_FULL = ITEM_NAME
        end
    else
        ITEM_NAME_FULL = itemtbl.item.Name
    end

    surface_SetFont("moat_ItemDesc")
    local namew, nameh = surface_GetTextSize("Remove " .. ITEM_NAME_FULL)*/
    M_INV_MENU = vgui.Create("DMenu")
    --M_INV_MENU:SetSize( namew + 30, 100 )
    M_INV_MENU:SetPos(gui.MouseX(), gui.MouseY())
    M_INV_MENU:MakePopup()
    M_INV_MENU:SetSkin("moat")
    M_INV_MENU.Hovered = false
    M_INV_MENU.MoveDown = false
    M_INV_MENU.Think = function(s)
        if (s:IsHovered()) then
            s.Hovered = true
        else
            s.Hovered = false
        end

        if (input.IsMouseDown(MOUSE_LEFT) and not s.MoveDown) then
            s.MoveDown = true
        elseif (s.MoveDown and not input.IsMouseDown(MOUSE_LEFT)) then
            s.MoveDown = false
            s:Remove()
            return
        end
    end

    if (equipables[string.lower(itemtbl.item.Kind)] and not ldt) then
        M_INV_MENU:AddOption("Equip", function()
            local loadout_slot = m_GetCorrectLoadoutSlot(itemtbl) .. "l"
            m_SwapInventorySlots(M_INV_SLOT[num], loadout_slot, m_utrade)
			sfx.Max()
        end):SetIcon("icon16/add.png")


        M_INV_MENU:AddSpacer()
    end

    if (itemtbl.item.Kind == "Usable" and not ldt) then
        local txt = "Use"
        if (itemtbl and itemtbl.u and itemtbl.u == 7821) then txt = "Open Gift" end
        
        M_INV_MENU:AddOption(txt, function()
            net.Start("MOAT_INIT_USABLE")
            net.WriteDouble(num)
            net.WriteDouble(itemtbl.c)
            net.SendToServer()
			sfx.Subtract()
        end):SetIcon("icon16/accept.png")

        if (itemtbl and itemtbl.u and itemtbl.u == 7821) then
            M_INV_MENU:AddOption("Send to Player", function()
                MOAT_GIFTS.SendGift(itemtbl, num)
            end):SetIcon("icon16/heart.png")
        end

        M_INV_MENU:AddSpacer()
    end

    if (itemtbl.item.Kind == "Crate" and not ldt) then
        if (GetConVar("moat_fast_open"):GetInt() == 1) then
            M_INV_MENU:AddOption("Instant Open", function()
                m_OpenCrate(m_Inventory[num], true)
                crate_wait = CurTime() + 1
            end):SetIcon("icon16/briefcase.png")
        else
            local open_clicked = false
            M_INV_MENU:AddOption("Open", function()
                if (not open_clicked) then
                    m_OpenCrate(m_Inventory[num])
                    crate_wait = CurTime() + 1
                    open_clicked = true
                end
            end):SetIcon("icon16/briefcase.png")
        end


        M_INV_MENU:AddSpacer()
    end

    M_INV_MENU:AddOption("Display in Chat", function()
        net.Start("MOAT_LINK_ITEM")
        net.WriteDouble(num)
        net.WriteBool(ldt)

        local wpn = ""
        if (itemtbl.w) then
            wpn = util.GetWeaponName(itemtbl.w) or ""
        end

        net.WriteString(wpn)
        net.SendToServer()
        sfx.Cut()
    end):SetIcon("icon16/attach.png")

    if (ldt) then
        M_INV_MENU:AddOption("Copy Chat Link", function()
            SetClipboardText("{" .. (ldt and chatlinks[num] or ("slot" .. num)) .. "}")
			sfx.Click2()
        end):SetIcon("icon16/tag_blue.png")

        if (num == 6 or num == 7 or num == 8) then
            M_INV_MENU:AddOption("Change Position", function()
                for i = 1, #m_Inventory do
                    m_Inventory[i].decon = false
                end
                MOAT_ITEMS_DECON_MARKED = 0

                moat_RemoveEditPositionPanel()

                moat_InitializeEditPanel(itemtbl.u, MOAT_INV_BG, MOAT_INV_BG_W, MOAT_INV_BG_H)
				sfx.Click2()
            end):SetIcon("icon16/arrow_out.png")
        end

        return
    end

    local lock_text = "Lock Item"
    local lock_image = ""

    if (itemtbl.l and itemtbl.l == 1) then
        lock_text = "Unlock Item"
        lock_image = "_open"
    end

    M_INV_MENU:AddOption(lock_text, function()
        net.Start("MOAT_LOCK_INV_ITEM")
        net.WriteDouble(num)
        net.WriteDouble(itemtbl.c)
        net.SendToServer()
        sfx.Cut()
    end):SetIcon("icon16/lock" .. lock_image .. ".png")

    local M_INV_MENU2, M_INV_MENU2P = M_INV_MENU:AddSubMenu "More Options" 
    M_INV_MENU2P:SetIcon "icon16/cog.png"

    if not old_inputdown then
        old_inputdown = input.IsKeyDown
    end

    function input.IsKeyDown(key)
        if moat_imagehack and (key == KEY_LCONTROL) then
            return true
        end
        return old_inputdown(key)
    end

    M_INV_MENU2:AddOption("Copy Chat Link", function()
        SetClipboardText("{" .. (ldt and chatlinks[num] or ("slot" .. num)) .. "}")
		sfx.Click2()
    end):SetIcon("icon16/tag_blue.png")

    M_INV_MENU2:AddOption("Share Screenshot",function()
        if (IsValid(MOAT_INV_S)) then
            MOAT_INV_S.AnimVal = 1
        end

        if MOAT_CACHED_PICS[itemtbl.c] then
            local x = 0
            if itemtbl.s then
                x = (itemtbl.s.x or 0)
            end
            if MOAT_CACHED_PICS[itemtbl.c][1] == x then
                local l = MOAT_CACHED_PICS[itemtbl.c][2]
                Derma_Message("Wowzie! Your item stat screenshot's Sharable URL has been copied to your clipboard :D\nTrade chat in Discord to start #buying @ #selling via https://moat.chat/", "Share Screenshot", "Deal (Close)")
                SetClipboardText(l)
                return
            end
        end
        if MOAT_UPLOADING then
            chat.AddText(Color(255,0,0),"Another picture of an item is already uploading!")
            return
        end

        M_INV_MENU:Remove()

        local n = num
        m_HoveredSlot = num
		HoveringSlot = true
        if (IsValid(MOAT_INV_S)) then MOAT_INV_S.ctrldown = true end
        moat_imagehack = true
        hook.Add("HudPaint","Mid Framegg",function()
            m_HoveredSlot = num
			HoveringSlot = true
			if (IsValid(MOAT_INV_S)) then
            	MOAT_INV_S.AnimVal = 1
            	MOAT_INV_S.ctrldown = true
            	MOAT_INV_S:SetAlpha(255)
            	MOAT_INV_S:Think()
			end
            hook.Remove("HudPaint","Mid Framegg")
        end)
        hook.Add("PostRender", "Gay render capture rules", function()
            hook.Remove("PostRender", "Gay render capture rules")
            if (IsValid(MOAT_INV_S)) then MOAT_INV_S:Think() end

            local x, y, w, h = 0, 0, 0, 0
			if (IsValid(MOAT_INV_S)) then
				x, y = MOAT_INV_S:GetPos()
				w, h = MOAT_INV_S:GetSize()
			end
            
            local data = render.Capture({
                format = "jpeg",
                quality = 100,
                h = h,
                w = w,
                x = x,
                y = y,
            })

            moat_imagehack = false
            MOAT_UPLOADING = true
            -- local item_name = (itemtbl.item.Name or "Unknown Item")
            -- if itemtbl.s then
            --     item_name = (itemtbl.item.Name or "Unknown ???? ") .. " " .. (weapons.Get(itemtbl.w).PrintName or "????")
            -- end
            local item_name = m_GetFullItemName(itemtbl)

			HTTP({
                url = "https://api.imgur.com/3/album",
                method = "post",
                headers = {
                    ["Authorization"] = "Client-ID e87dc10099155dd"
                },
                success = function(_,c,_,_)
                    local album = util.JSONToTable(c)
                    if not album.success then
                        Derma_Message("Your upload was not successful (-2)! Please show this to Moat: " .. a, "Imgur failed", "Close")
                        MOAT_UPLOADING = false
                        return
                    end
                    HTTP({
                        url = "https://api.imgur.com/3/image",
                        method = "post",
                        headers = {
                            ["Authorization"] = "Client-ID e87dc10099155dd"
                        },
                        success = function(_,b,_,_)
                            local ob = b
                            b = util.JSONToTable(b)
                            if b.success then
                                local l = "https://imgur.com/a/" .. album.data.id
                                Derma_Message("Your picture of your stats has been uploaded and copied to your clipboard! (" .. l .. ")\nYou can now simply paste it into any text channel like the #wts in our Discord!", "Upload success", "Thanks!")
                                SetClipboardText(l)
                                local x = 0
                                if itemtbl.s then
                                    x = itemtbl.s.x or 0
                                end
                                MOAT_CACHED_PICS[itemtbl.c] = {
                                    x,
                                    l--s
                                }
                            else
                                Derma_Message("Your upload was not successful! Please show this to Moat:\n" .. ob, "Imgur failed", "Close")
                            end
                            MOAT_UPLOADING = false
                        end,
                        failed = function(a) 
                            Derma_Message("Imgur appears to be having some issues, please wait an try again! (" .. a .. ")", "Imgur failed", "Close")
                            MOAT_UPLOADING = false
                        end,
                        parameters = {
                            image = util.Base64Encode(data),
                            album = album.data.deletehash
                        },
                    })
                end,
                failed = function(a) 
                    Derma_Message("Your upload was not successful (-1)! Please show this to Moat: " .. a, "Imgur failed", "Close")
                    MOAT_UPLOADING = false
                end,
                parameters = {
                    -- title = (item_name) .. " \\|| " .. LocalPlayer():Nick() .. " \\|| " .. GetServerName() or "moat.gg",
                    -- description = (item_name) .. "\nOwned by " .. LocalPlayer():Nick() .. " (" .. LocalPlayer():SteamID() .. ") (https://steamcommunity.com/profiles/" .. LocalPlayer():SteamID64() .. ")\nShared via " .. (GetServerName() or "moat.gg") .. "\n\nTrade chat in Discord to start #buying @ #selling via moat.chat"
                },
            })

			HoveringSlot = false
            m_HoveredSlot = nil
        end)
        render.Spin()
    end):SetIcon("icon16/camera_add.png")

    if (itemtbl.l and itemtbl.l == 1) then return end

    M_INV_MENU:AddSpacer()

    if (itemtbl.n) then
        M_INV_MENU:AddOption("Remove Name Mutator", function()
        end):SetIcon("icon16/tag_blue_delete.png")
    end

    local p1txt = nil
    if (itemtbl.p) then
        p1txt = MOAT_PAINT.Tints[itemtbl.p] and MOAT_PAINT.Tints[itemtbl.p][1] or "Glitched Tint"
        M_INV_MENU:AddOption("Remove " .. p1txt, function()
        end):SetIcon("icon16/palette.png")
    end

    local p2txt = nil
    if (itemtbl.p2) then
        p2txt = MOAT_PAINT.Paints[itemtbl.p2] and MOAT_PAINT.Paints[itemtbl.p2][1] or "Glitched Paint"
        M_INV_MENU:AddOption("Remove " .. p2txt, function()
        end):SetIcon("icon16/paintcan.png")
    end

    local p3txt = nil
    if (itemtbl.p3) then
        p3txt = MOAT_PAINT.Skins[itemtbl.p3] and MOAT_PAINT.Skins[itemtbl.p3][1] or "Glitched Skin"
        M_INV_MENU:AddOption("Remove " .. p3txt, function()
			MOAT_SKIN_ALPHA = 15
        end):SetIcon("icon16/paintbrush.png")
    end

    local item_rarity = m_Inventory[num].item.Rarity or 1
    local dec_min = math.Round(rarity_names[item_rarity][3].min)
    local dec_max = math.Round(rarity_names[item_rarity][3].max)
	local multiplier = 1

	if (string.find(string.lower(LocalPlayer():Nick()), "moat.gg")) then
		multiplier = multiplier + .25
	end

    if (table.HasValue(MOAT_VIP, LocalPlayer():GetUserGroup())) then
		multiplier = multiplier + .5
    end

	dec_min = math.floor(dec_min * multiplier)
	dec_max = math.floor(dec_max * multiplier)

    local remove_text = "Deconstruct for " .. dec_min .. " - " .. dec_max .. " IC"
    local deco = moat_decon:GetInt()
    if (deco < 5) then
        remove_text = "HOLD to Deconstruct for " .. dec_min .. " - " .. dec_max .. " IC"
    end

    if (m_Inventory[num].item.Rarity == 0) then
        remove_text = "Deconstruct"
    end

    M_INV_MENU:AddOption(remove_text, function() end):SetIcon("icon16/delete.png")
    --[[net.Start( "MOAT_REM_INV_ITEM" )

        net.WriteDouble( num )

        net.WriteDouble( itemtbl.c )

        net.SendToServer()

        surface.PlaySound( "UI/buttonclick.wav" )]]
    local pnl = nil

    for i = 1, 15 do
        if (M_INV_MENU:GetChild(i) and M_INV_MENU:GetChild(i):GetText() == remove_text) then
            pnl = M_INV_MENU:GetChild(i)
        end
    end

    if (pnl) then
        local pnl_width = 0
        pnl.StopThink = false
        local dec_rate = 1.3
        local deoncstruct_speed = GetConVar("moat_deconstruct_speed_multi"):GetInt()

        if (deoncstruct_speed > 1) then
            dec_rate = dec_rate * deoncstruct_speed
        elseif (ConVarExists("moat_deconstruct_speed") and GetConVar("moat_deconstruct_speed"):GetInt() == 1) then
            dec_rate = 6.5
        end

        if (item_rarity > 5) then
            dec_rate = 1.3
        end

        pnl.Think = function(s)
            if (s.StopThink) then return end

            if (s:IsHovered() and input.IsMouseDown(MOUSE_LEFT)) then
                pnl_width = math.Approach(pnl_width, 1, (dec_rate * 0.35) * FrameTime())
            elseif (input.IsMouseDown(MOUSE_LEFT)) then
                pnl_width = math.Approach(pnl_width, 0, (dec_rate * 0.35) * FrameTime())
            end

            if (pnl_width >= 0.99) then
                s.StopThink = true
                if (itemtbl.item.Rarity > 4) and cookie.GetNumber("moat.deconstruct.highdd", 0) < 16 then
                    Derma_Query("Are you sure you want to deconstruct your high rarity item?\nThis action is PERMANENT and will REMOVE your item\nYou will receive a random amount of IC between ".. dec_min .. " to " .. dec_max .." IC\n\nNOTE: You can probably TRADE your item for a higher amount of IC!\nMake sure to check its price (like in our Discord) first.\n\n(This message will show up " ..(15 - cookie.GetNumber("moat.deconstruct.highdd", 0)) .. " more times)" , "Are you sure?", "Yes", function()
                        net.Start("MOAT_REM_INV_ITEM")
                        net.WriteDouble(num)
                        net.WriteDouble(itemtbl.c)
                        net.SendToServer()
                        M_INV_MENU:Remove()
                        cookie.Set("moat.deconstruct.highdd", cookie.GetNumber("moat.deconstruct.highdd", 0) + 1)
                    end, "Nevermind")
                else
                    net.Start("MOAT_REM_INV_ITEM")
                    net.WriteDouble(num)
                    net.WriteDouble(itemtbl.c)
                    net.SendToServer()
                    M_INV_MENU:Remove()
                end
                if (deco < 5) then moat_decon:SetInt(deco + 1) end
            end
        end

        pnl.Paint = function(s, w, h)
            if (s:IsHovered()) then
				draw.RoundedBox(5, 2, 2, w - 4, h - 4, Color(255, 100, 100, 50))
            end

			draw.RoundedBox(5, 1, 1, (w * pnl_width) - 2, h - 2, Color(255, 150, 0, 225 * pnl_width))
        end
    end


    local pnl = nil

    for i = 1, 15 do
        if (M_INV_MENU:GetChild(i) and M_INV_MENU:GetChild(i):GetText() == "Remove Name Mutator") then
            pnl = M_INV_MENU:GetChild(i)
        end
    end

    if (pnl) then
        local pnl_width = 0
        pnl.StopThink = false
        local dec_rate = 1.3

        pnl.Think = function(s)
            if (s.StopThink) then return end

            if (s:IsHovered() and input.IsMouseDown(MOUSE_LEFT)) then
                pnl_width = math.Approach(pnl_width, 1, (dec_rate * 0.35) * FrameTime())
            elseif (input.IsMouseDown(MOUSE_LEFT)) then
                pnl_width = math.Approach(pnl_width, 0, (dec_rate * 0.35) * FrameTime())
            end

            if (pnl_width >= 0.99) then
                s.StopThink = true
                net.Start("MOAT_REM_NAME_MUTATOR")
                net.WriteDouble(num)
                net.WriteDouble(itemtbl.c)
                net.SendToServer()
                sfx.Dustbin()
                M_INV_MENU:Remove()
            end
        end

        pnl.Paint = function(s, w, h)
            if (s:IsHovered()) then
				draw.RoundedBox(5, 2, 2, w - 4, h - 4, Color(255, 100, 100, 50))
            end

			draw.RoundedBox(5, 1, 1, (w * pnl_width) - 2, h - 2, Color(255, 150, 0, 225 * pnl_width))
        end
    end

    if (p1txt) then
        local pnl = nil

        for i = 1, 15 do
            if (M_INV_MENU:GetChild(i) and M_INV_MENU:GetChild(i):GetText() == "Remove " .. p1txt) then
                pnl = M_INV_MENU:GetChild(i)
            end
        end

        if (pnl) then
            local pnl_width = 0
            pnl.StopThink = false
            local dec_rate = 1.3

            pnl.Think = function(s)
                if (s.StopThink) then return end

                if (s:IsHovered() and input.IsMouseDown(MOUSE_LEFT)) then
                    pnl_width = math.Approach(pnl_width, 1, (dec_rate * 0.35) * FrameTime())
                elseif (input.IsMouseDown(MOUSE_LEFT)) then
                    pnl_width = math.Approach(pnl_width, 0, (dec_rate * 0.35) * FrameTime())
                end

                if (pnl_width >= 0.99) then
                    s.StopThink = true
                    net.Start("MOAT_REM_TINT")
                    net.WriteDouble(num)
                    net.WriteDouble(itemtbl.c)
                    net.SendToServer()
                   	sfx.Dustbin()
                    M_INV_MENU:Remove()
                end
            end

            pnl.Paint = function(s, w, h)
                if (s:IsHovered()) then
					draw.RoundedBox(5, 2, 2, w - 4, h - 4, Color(255, 100, 100, 50))
            	end

				draw.RoundedBox(5, 1, 1, (w * pnl_width) - 2, h - 2, Color(255, 150, 0, 225 * pnl_width))
            end
        end
    end

    if (p2txt) then
        local pnl = nil

        for i = 1, 15 do
            if (M_INV_MENU:GetChild(i) and M_INV_MENU:GetChild(i):GetText() == "Remove " .. p2txt) then
                pnl = M_INV_MENU:GetChild(i)
            end
        end

        if (pnl) then
            local pnl_width = 0
            pnl.StopThink = false
            local dec_rate = 1.3

            pnl.Think = function(s)
                if (s.StopThink) then return end

                if (s:IsHovered() and input.IsMouseDown(MOUSE_LEFT)) then
                    pnl_width = math.Approach(pnl_width, 1, (dec_rate * 0.35) * FrameTime())
                elseif (input.IsMouseDown(MOUSE_LEFT)) then
                    pnl_width = math.Approach(pnl_width, 0, (dec_rate * 0.35) * FrameTime())
                end

                if (pnl_width >= 0.99) then
                    s.StopThink = true
                    net.Start("MOAT_REM_PAINT")
                    net.WriteDouble(num)
                    net.WriteDouble(itemtbl.c)
                    net.SendToServer()
                    sfx.Dustbin()
                    M_INV_MENU:Remove()
                end
            end

            pnl.Paint = function(s, w, h)
				if (s:IsHovered()) then
					draw.RoundedBox(5, 2, 2, w - 4, h - 4, Color(255, 100, 100, 50))
            	end

				draw.RoundedBox(5, 1, 1, (w * pnl_width) - 2, h - 2, Color(255, 150, 0, 225 * pnl_width))
            end
        end
    end

    if (p3txt) then
        local pnl = nil

        for i = 1, 15 do
            if (M_INV_MENU:GetChild(i) and M_INV_MENU:GetChild(i):GetText() == "Remove " .. p3txt) then
                pnl = M_INV_MENU:GetChild(i)
            end
        end

        if (pnl) then
            local pnl_width = 0
            pnl.StopThink = false
            local dec_rate = 1.3

            pnl.Think = function(s)
                if (s.StopThink) then return end

                if (s:IsHovered() and input.IsMouseDown(MOUSE_LEFT)) then
                    pnl_width = math.Approach(pnl_width, 1, (dec_rate * 0.35) * FrameTime())
                elseif (input.IsMouseDown(MOUSE_LEFT)) then
                    pnl_width = math.Approach(pnl_width, 0, (dec_rate * 0.35) * FrameTime())
                end

                if (pnl_width >= 0.99) then
                    s.StopThink = true
                    net.Start("MOAT_REM_TEXTURE")
                    net.WriteDouble(num)
                    net.WriteDouble(itemtbl.c)
                    net.SendToServer()
                    sfx.Dustbin()
                    M_INV_MENU:Remove()
                end
            end

            pnl.Paint = function(s, w, h)
				if (s:IsHovered()) then
					draw.RoundedBox(5, 2, 2, w - 4, h - 4, Color(255, 100, 100, 50))
            	end

				draw.RoundedBox(5, 1, 1, (w * pnl_width) - 2, h - 2, Color(255, 150, 0, 225 * pnl_width))
            end
        end
    end

	if (((itemtbl.item.Kind == "Melee" and itemtbl.s and itemtbl.s.p and not itemtbl.s.w) or (itemtbl.item.Name == "Deep Frying Ban" and itemtbl.s and not itemtbl.s.p)) and not ldt) then
		M_INV_MENU:AddSpacer()

        M_INV_MENU:AddOption("Use FREE Stat Re-Roll (Single Use)", function()
			net.Start "OldMelee.Reset"
				net.WriteDouble(num)
            	net.WriteDouble(itemtbl.c)
            net.SendToServer()
            sfx.Agree()
        end):SetIcon("icon16/arrow_refresh.png")
     end
end

local function urlencode(str)
    if (str) then
        str = string.gsub(str, "\n", "\r\n")
        str = string.gsub(str, "([^%w ])",
        function(c)
            return string.format("%%%02X", string.byte(c))
        end)

        str = string.gsub(str, " ", "+")
    end

    return str    
end

local ITEM_RARITY_TO_NAME = {
	["Stock"] = 0,
    ["Worn"] = 1,
    ["Standard"] = 2,
    ["Specialized"] = 3,
    ["Superior"] = 4,
    ["High-End"] = 5,
    ["Ascended"] = 6,
    ["Cosmic"] = 7,
	["Extinct"] = 8,
	["Planetary"] = 9,
}
/*
    ["moat_auto_deconstruct_primary"] = 0,
    ["moat_auto_deconstruct_secondary"] = 0,
    ["moat_auto_deconstruct_melee"] = 0,
    ["moat_auto_deconstruct_powerup"] = 0,
    ["moat_auto_deconstruct_other"] = 0,
    ["moat_auto_deconstruct_head"] = 0,
    ["moat_auto_deconstruct_mask"] = 0,
    ["moat_auto_deconstruct_body"] = 0,
    ["moat_auto_deconstruct_effect"] = 0,
    ["moat_auto_deconstruct_model"] = 0
*/
local m_SlotToLoadout = {}
m_SlotToLoadout[0] = "Melee"
m_SlotToLoadout[1] = "Secondary"
m_SlotToLoadout[2] = "Primary"

function m_CanAutoDeconstruct(ITEM_TBL)
    if (not ITEM_TBL.c) then return true end

    if (ITEM_TBL.item.Kind == "Power-Up") then return GetConVar("moat_auto_deconstruct_powerup"):GetInt() < 1 end
    if (ITEM_TBL.item.Kind == "Special") then return GetConVar("moat_auto_deconstruct_special"):GetInt() < 1 end
    if (ITEM_TBL.item.Kind == "Hat") then return GetConVar("moat_auto_deconstruct_head"):GetInt() < 1 end
    if (ITEM_TBL.item.Kind == "Mask") then return GetConVar("moat_auto_deconstruct_mask"):GetInt() < 1 end
    if (ITEM_TBL.item.Kind == "Body") then return GetConVar("moat_auto_deconstruct_body"):GetInt() < 1 end
    if (ITEM_TBL.item.Kind == "Effect") then return GetConVar("moat_auto_deconstruct_effect"):GetInt() < 1 end
    if (ITEM_TBL.item.Kind == "Model") then return GetConVar("moat_auto_deconstruct_model"):GetInt() < 1 end
    if (ITEM_TBL.item.Kind == "Usable") then return GetConVar("moat_auto_deconstruct_usable"):GetInt() < 1 end

    local item_kind = m_SlotToLoadout[weapons.Get(ITEM_TBL.w).Slot]

    if (item_kind == "Primary") then return GetConVar("moat_auto_deconstruct_primary"):GetInt() < 1 end
    if (item_kind == "Secondary") then return GetConVar("moat_auto_deconstruct_secondary"):GetInt() < 1 end
    if (item_kind == "Melee") then return GetConVar("moat_auto_deconstruct_melee"):GetInt() < 1 end

    return false
end

OPEN_ON_SEND = false

local function open_inv()
    if (not m_isTrading(LocalPlayer()) and not LocalPlayer():IsTyping() and not IsValid(MOAT_GAMBLE_BG)) then
        if (moat_inv_cooldown < CurTime()) then
            if (m_isUsingInv()) then
                --gui.EnableScreenClicker( false )
                MOAT_INV_BG:BounceOut(BOTTOM)

                timer.Simple(0.4, function()
                    MOAT_INV_BG:Remove()
                end)

                moat_inv_cooldown = CurTime() + 1
                --gui.EnableScreenClicker( true )
            elseif (gui.MouseX() == 0 and gui.MouseY() == 0) then
                m_OpenInventory()
            end
        end
    end
end


concommand.Add("inventory", open_inv)

hook.Add("PlayerButtonDown", "moat_InventoryKey", function(p, k)
    if (k == KEY_I) then
        open_inv()
    end
end)

hook.Remove("SpawniconGenerated", "SpawniconGenerated")
local MOAT_REQ_BG_W = 350
local MOAT_REQ_BG_H = 290

function m_DrawTradeRequest(ply)
	if (not IsValid(ply)) then return end

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end
    local MT_TR = MT[CurTheme].TradeRequest

    MOAT_REQ_BG = vgui.Create("DFrame")
    MOAT_REQ_BG:SetSize(MOAT_REQ_BG_W, MOAT_REQ_BG_H)
    MOAT_REQ_BG:SetTitle("")
    MOAT_REQ_BG.Timer = 30
    MOAT_REQ_BG.CurTimer = 0
    MOAT_REQ_BG.TimerVis = CurTime() + 30
    MOAT_REQ_BG:ShowCloseButton(false)
    MOAT_REQ_BG:AlphaTo(0, 0, 0)
    MOAT_REQ_BG:MakePopup()
    MOAT_REQ_BG:SetPos(ScrW() / 2 - MOAT_REQ_BG:GetWide() / 2, -MOAT_REQ_BG_H)

    MOAT_REQ_BG.Paint = function(s, w, h)
        if (MT_TR and MT_TR.BG) then
            MT_TR.BG(s, w, h)
            return
        end

        surface_SetDrawColor(62, 62, 64, 255)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(34, 35, 38, 250)
        surface_DrawRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(0, 0, 0, 120)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(0, 0, 0, 150)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, 25)
        local line_x = MOAT_REQ_BG:GetWide() - (350 + 14) - 4 - 5
        surface_SetDrawColor(Color(100, 100, 100, 50))
        surface_DrawLine(line_x, 26, line_x, s:GetTall())
        surface_DrawLine(0, 25, s:GetWide(), 25)
        surface_SetDrawColor(Color(0, 0, 0, 100))
        surface_DrawLine(line_x + 1, 26, line_x + 1, s:GetTall())
        surface_DrawLine(0, 26, s:GetWide(), 26)
        local other_cols = (200 / 30) * s.Timer
        m_DrawShadowedText(1, s.Timer, "moat_ItemDesc", w - 40, 6, Color(200, other_cols, other_cols, 255), TEXT_ALIGN_RIGHT)
        draw_SimpleText(1, "has requested to trade with you.", "GModNotify", w / 2, 195, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER)
        local timer_vis = (w - 2) * ((s.TimerVis - CurTime()) / 30)
        surface_SetDrawColor(0, 0, 0, 100)
        surface_DrawRect(1, h - 4, w - 2, 3)
        surface_SetDrawColor(255, 255, 255, 255)
        surface_DrawRect(1, h - 4, timer_vis, 3)
    end

    MOAT_REQ_BG.Think = function(s)
        if (s.CurTimer <= CurTime()) then
            if (s.Timer <= 0) then
                s:Remove()
                net.Start("MOAT_RESPOND_TRADE_REQ")
                net.WriteBool(false)
                net.WriteDouble(ply:EntIndex())
                net.SendToServer()

                return
            end

            s.CurTimer = CurTime() + 1
            s.Timer = s.Timer - 1
        end
    end

    local M_REQ_AVA = vgui.Create("AvatarImage", MOAT_REQ_BG)
    M_REQ_AVA:SetPos((MOAT_REQ_BG_W / 2) - 64, (MOAT_REQ_BG_H / 2) - 64 - 25)
    M_REQ_AVA:SetSize(128, 128)
    M_REQ_AVA:SetPlayer(ply, 128)
    local M_REQ_AVAB = vgui.Create("DButton", MOAT_REQ_BG)
    M_REQ_AVAB:SetPos((MOAT_REQ_BG_W / 2) - 64, (MOAT_REQ_BG_H / 2) - 64 - 25)
    M_REQ_AVAB:SetSize(128, 128)
    M_REQ_AVAB:SetText("")
    M_REQ_AVAB.Paint = nil
	sfx.SoundEffects(M_REQ_AVAB)
    M_REQ_AVAB.DoClick = function(s)
        gui.OpenURL("https://moat.gg/profile/" .. ply:SteamID64())
    end

    local M_REQ_NICK = vgui.Create("DLabel", MOAT_REQ_BG)
    M_REQ_NICK:SetText(ply:Nick())
    M_REQ_NICK:SetFont("GModNotify")

    if (MT_TR and MT_TR.NameColor) then
		MT_TR.NameColor.a = 255
        M_REQ_NICK:SetTextColor(MT_TR.NameColor)
    else
        M_REQ_NICK:SetTextColor(Color(200, 200, 200))
    end
    
    M_REQ_NICK:SetPos(0, 25)
    M_REQ_NICK:SetSize(MOAT_REQ_BG_W, 30)
    M_REQ_NICK:SetContentAlignment(5)
    local hover_coloral = 0
    local M_REQ_A = vgui.Create("DButton", MOAT_REQ_BG)
    M_REQ_A:SetSize(125, 30)
    M_REQ_A:SetPos(35, MOAT_REQ_BG_H - 55)
    M_REQ_A:SetText("")
	sfx.SoundEffects(M_REQ_A)
    M_REQ_A.Paint = function(s, w, h)
        if (MT_TR and MT_TR.Background) then
            surface_SetDrawColor(0, 0, 0, 245)
            surface_DrawRect(0, 0, w, h)
        end

        surface_SetDrawColor(50, 50, 50, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(0, 200, 0, 20 + hover_coloral / 5)
        surface_DrawRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(0, 255, 0, 20 + hover_coloral / 5)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Accept", "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local btn_hovered = 1
    local btn_color_a = false

    M_REQ_A.Think = function(s)
        if (not s:IsHovered()) then
            btn_hovered = 0
            btn_color_a = false

            if (hover_coloral > 0) then
                hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
            end
        else
            if (hover_coloral < 154 and btn_hovered == 0) then
                hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
            else
                btn_hovered = 1
            end

            if (btn_hovered == 1) then
                if (btn_color_a) then
                    if (hover_coloral >= 154) then
                        btn_color_a = false
                    else
                        hover_coloral = hover_coloral + (100 * FrameTime())
                    end
                else
                    if (hover_coloral <= 50) then
                        btn_color_a = true
                    else
                        hover_coloral = hover_coloral - (100 * FrameTime())
                    end
                end
            end
        end
    end

    local hover_coloral2 = 0
    local M_REQ_D = vgui.Create("DButton", MOAT_REQ_BG)
    M_REQ_D:SetSize(125, 30)
    M_REQ_D:SetPos(MOAT_REQ_BG_W - 35 - 125, MOAT_REQ_BG_H - 55)
    M_REQ_D:SetText("")
	sfx.SoundEffects(M_REQ_D)
    M_REQ_D.Paint = function(s, w, h)
        if (MT_TR and MT_TR.Background) then
            surface_SetDrawColor(0, 0, 0, 245)
            surface_DrawRect(0, 0, w, h)
        end

        surface_SetDrawColor(50, 50, 50, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(255, 0, 0, 20 + hover_coloral2 / 5)
        surface_DrawRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(255, 0, 0, 20 + hover_coloral2 / 5)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        m_DrawShadowedText(1, "Decline", "Trebuchet24", w / 2, h / 2, Color(200, 100, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local btn_hovered2 = 1
    local btn_color_a2 = false

    M_REQ_D.Think = function(s)
        if (not s:IsHovered()) then
            btn_hovered2 = 0
            btn_color_a2 = false

            if (hover_coloral2 > 0) then
                hover_coloral2 = Lerp(2 * FrameTime(), hover_coloral2, 0)
            end
        else
            if (hover_coloral2 < 154 and btn_hovered2 == 0) then
                hover_coloral2 = Lerp(5 * FrameTime(), hover_coloral2, 155)
            else
                btn_hovered2 = 1
            end

            if (btn_hovered2 == 1) then
                if (btn_color_a2) then
                    if (hover_coloral2 >= 154) then
                        btn_color_a2 = false
                    else
                        hover_coloral2 = hover_coloral2 + (100 * FrameTime())
                    end
                else
                    if (hover_coloral <= 50) then
                        btn_color_a2 = true
                    else
                        hover_coloral2 = hover_coloral2 - (100 * FrameTime())
                    end
                end
            end
        end
    end

    M_REQ_A.DoClick = function()
        /*if (LocalPlayer():IsActive()) then
            MOAT_REQ_BG:Remove()
            net.Start("MOAT_RESPOND_TRADE_REQ")
            net.WriteBool(false)
            net.WriteDouble(ply:EntIndex())
            net.SendToServer()
			sfx.Agree()

            return
        end*/

        MOAT_REQ_BG:MoveTo(ScrW() / 2 - MOAT_REQ_BG:GetWide() / 2, ScrH() + MOAT_REQ_BG:GetTall(), 0.5, 0, 1)
        MOAT_REQ_BG:AlphaTo(0, 0.5, 0, function(anim, pnl) if (IsValid(pnl)) then pnl:Remove() end end)

        net.Start("MOAT_RESPOND_TRADE_REQ")
        net.WriteBool(true)
        net.WriteDouble(ply:EntIndex())
        net.SendToServer()
		sfx.Agree()

        return
    end

    M_REQ_D.DoClick = function()
        MOAT_REQ_BG:Remove()
        net.Start("MOAT_RESPOND_TRADE_REQ")
        net.WriteBool(false)
        net.WriteDouble(ply:EntIndex())
        net.SendToServer()
		sfx.Decline()

        return
    end

    if (GetConVar("moat_autodecline"):GetInt() == 1 or cookie.GetNumber("moat_block" .. ply:SteamID(), 0) == 1) then
        MOAT_REQ_BG:Remove()
        net.Start("MOAT_RESPOND_TRADE_REQ")
        net.WriteBool(false)
        net.WriteDouble(ply:EntIndex())
        net.SendToServer()

        return
    end

    if (LocalPlayer():Team() ~= TEAM_SPEC and GetRoundState() ~= ROUND_ACTIVE and GetConVar("moat_autodecline_active"):GetInt() == 1) then
        MOAT_REQ_BG:Remove()
        net.Start("MOAT_RESPOND_TRADE_REQ")
        net.WriteBool(false)
        net.WriteDouble(ply:EntIndex())
        net.SendToServer()

        return
    end

    MOAT_REQ_BG:MoveTo(ScrW() / 2 - MOAT_REQ_BG:GetWide() / 2, ScrH() / 2 - MOAT_REQ_BG:GetTall() / 2, 0.5, 0, 1)
    MOAT_REQ_BG:AlphaTo(255, 0.5, 0)

    if (MT_TR and not MT_TR.Close) then
        return
    end

    local M_REQ_C = vgui.Create("DButton", MOAT_REQ_BG)
    M_REQ_C:SetPos(MOAT_REQ_BG:GetWide() - 36, 3)
    M_REQ_C:SetSize(33, 19)
    M_REQ_C:SetText("")
	sfx.SoundEffects(M_REQ_C)
    M_REQ_C.Paint = function(s, w, h)
        draw_RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        surface_SetDrawColor(95, 95, 95)
        surface_DrawRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(137, 137, 137, 255)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        draw_SimpleTextOutlined("r", "marlett", 17, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            surface_SetDrawColor(255, 0, 0, 15)
            surface_DrawRect(1, 1, w - 2, h - 2)
            draw_SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            surface_SetDrawColor(255, 0, 0, 20)
            surface_DrawRect(1, 1, w - 2, h - 2)
            draw_SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end

    M_REQ_C.DoClick = function()
        MOAT_REQ_BG:Remove()
    end
end

net.Receive("MOAT_INV_CAT", function(len)
    local inv_cat = net.ReadDouble()
    local is_trading = net.ReadBool()
    MOAT_INV_CAT = inv_cat
    m_ChangeInventoryPanel(inv_cat, is_trading)
end)

net.Receive("MOAT_RESPOND_TRADE_REQ", function(len)
    local accepted = net.ReadBool()
    local other_ply = net.ReadDouble()
	if (not IsValid(Entity(other_ply))) then
        chat.AddText(Color(255, 0, 0), "The trade request failed because the player left.")
        if (IsValid(M_TRADE_PLYS)) then
			M_TRADE_PLYS.Waiting = false
			M_TRADE_PLYS.RequestSent = true
            M_TRADE_PLYS:RebuildList()
        end

		return
	end

    if (not accepted) then
        chat.AddText(Color(0, 200, 0), Entity(other_ply):Nick(), Color(255, 255, 255), " has ", Color(255, 0, 0), "declined", Color(255, 255, 255), " your trade request.")
        if (IsValid(M_TRADE_PLYS)) then
			M_TRADE_PLYS.Waiting = false
			M_TRADE_PLYS.RequestSent = true
            M_TRADE_PLYS:RebuildList()
        end

        return
    else
        chat.AddText(Color(0, 200, 0), "You ", Color(255, 255, 255), "are now trading with ", Color(0, 255, 0), Entity(other_ply):Nick(), Color(255, 255, 255), ".")
    end
end)

net.Receive("MOAT_SEND_TRADE_REQ", function(len)
    local passed = net.ReadBool()
    local ply_sent = net.ReadBool()
    local ply_index = net.ReadDouble()
    local other_ply = Entity(ply_index)

	if (not IsValid(other_ply)) then
		if (IsValid(M_TRADE_PLYS)) then M_TRADE_PLYS.Waiting = false end
		chat.AddText(Color(255, 0, 0), "The player you sent a trade request to left the server.")
		return
	end

    if (not passed) then
		if (IsValid(M_TRADE_PLYS)) then M_TRADE_PLYS.Waiting = false end
        chat.AddText(Color(0, 200, 0), other_ply:Nick(), Color(255, 255, 255), " is ", Color(255, 0, 0), "busy", Color(255, 255, 255), " at the moment.")
        return
    end

	if (IsValid(M_TRADE_PLYS)) then
		M_TRADE_PLYS.Waiting = true
	end

    if (ply_sent) then
        for k, v in pairs(M_TRADE_PLYTBL) do
            if (v.Ply == other_ply) then
                v:GetChildren()[3]:SetSize(0, 0)
                v.Stage = 1

                for k2, v2 in ipairs(M_TRADE_PLYTBL) do
                    if (v2 ~= v) then
						if (not IsValid(v2)) then continue end
                        v2:AlphaTo(0, 0.1)
                        v2:SizeTo(0, 0, 0.2, 0)

                        timer.Simple(0.3, function()
							if (IsValid(v2)) then v2:Remove() end
                        end)
                    end
                end

                v:GetChildren()[1]:AlphaTo(0, 0, 0.3)
                v:SizeTo(M_TRADE_PLYS:GetWide(), 491, 0.2, 0.3)
                M_TRADE_LBL:TransitionText("Trade request sent to " .. other_ply:Nick() .. ".", 0.4, 0.4)

                timer.Simple(0.4, function()
                    if (v and IsValid(v) and IsValid(v:GetChildren()) and v:GetChildren()[2]) then
                        v:GetChildren()[2]:SetPlayer(other_ply, 128)
                    end
                end)

                v:GetChildren()[2]:SizeTo(128, 128, 0.2, 0.3)
                v:GetChildren()[2]:MoveTo((M_TRADE_PLYS:GetWide() / 2) - 64, 100, 0.2, 0.3)
                v.TimerActive = true
            end
        end
    else
        m_DrawTradeRequest(other_ply)
    end
end)

net.Receive("MOAT_INIT_TRADE", function(len)
    local other_int = net.ReadDouble()
    local other_ply = Entity(other_int)
    local trade_uid = net.ReadDouble()

    if (m_isUsingInv()) then
		if (IsValid(M_TRADING_PNL)) then
			M_TRADING_PNL:AlphaTo(0, 0.15)
        	M_TRADING_PNL:MoveTo(-M_TRADING_PNL:GetWide(), 0, 0.15, 0, -1, function(anim, pnl)
				m_ply2 = other_ply
				m_utrade = trade_uid
				m_InitializeTrade(other_ply, trade_uid)
			end)
		else
            m_ChangeInventoryPanel(11, true, function()
				m_ply2 = other_ply
				m_utrade = trade_uid
				m_InitializeTrade(other_ply, trade_uid)
			end)
        end
    else
        m_OpenInventory(other_ply, trade_uid)

		if (not m_ChangeInventoryPanel) then
			if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
        	if (IsValid(MOAT_TRADE_BG)) then MOAT_TRADE_BG:Remove() end
			chat.AddText(Color(255, 0, 0), "Can't accept trade request because your inventory didn't load? Trying opening it before trading.")

            moat_inv_cooldown = CurTime() + 5
            m_ClearInventory()
            net.Start("MOAT_SEND_INV_ITEM")
            net.SendToServer()

            net.Start("MOAT_RESPOND_TRADE")
            net.WriteBool(false)
            net.WriteDouble(other_int)
            net.WriteDouble(trade_uid)
            net.SendToServer()

			return
		end

		for k, v in ipairs(M_TRADE_PLYTBL) do
			if (not IsValid(v)) then continue end
            v:AlphaTo(0, 0.1)
            v:SizeTo(0, 0, 0.2, 0, -1, function(anim, pnl)
				pnl:Remove()
			end)
        end

		m_ChangeInventoryPanel(3, true, function()
			m_ply2 = other_ply
			m_utrade = trade_uid
			m_InitializeTrade(other_ply, trade_uid)
		end)

		MOAT_INV_CAT = 3
    end

	sfx.Agree()
end)

net.Receive("MOAT_RESPOND_TRADE", function(len)
    local accepted = net.ReadBool()
    local other_ply = Entity(net.ReadDouble())
	if (not IsValid(LocalPlayer())) then
		return
	end

	local name, has = IsValid(other_ply) and other_ply:Nick() or "Player", other_ply == LocalPlayer() and " have " or " has "
	if (other_ply == LocalPlayer()) then
		name = "You"
	else
		sfx.Decline()
	end

    if (not accepted) then
		if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
        if (IsValid(MOAT_TRADE_BG)) then MOAT_TRADE_BG:Remove() end

        moat_inv_cooldown = CurTime() + 5
        m_ClearInventory()
        net.Start("MOAT_SEND_INV_ITEM")
        net.SendToServer()

		if (IsValid(other_ply)) then
			chat.AddText(Color(0, 200, 0), name, Color(255, 255, 255), has, Color(255, 0, 0), "declined", Color(255, 255, 255), " the trade.")
		else
			chat.AddText(Color(0, 200, 0), "You", Color(255, 255, 255), " have ", Color(255, 0, 0), "automatically declined", Color(255, 255, 255), " the trade because something went wrong.")
		end

        if (m_isUsingInv()) then
            MOAT_INV_BG:BounceOut(BOTTOM)

            timer.Simple(0.4, function()
                MOAT_INV_BG:Remove()
            end)
        end
    else
		if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
        if (IsValid(MOAT_TRADE_BG)) then MOAT_TRADE_BG:Remove() end

        moat_inv_cooldown = CurTime() + 5
        m_ClearInventory()
        net.Start("MOAT_SEND_INV_ITEM")
        net.SendToServer()
        chat.AddText(Color(0, 200, 0), name, Color(255, 255, 255), has, Color(0, 255, 0), "accepted", Color(255, 255, 255), " the trade.")

		sfx.Agree()
    end
end)

net.Receive("MOAT_TRADE_MESSAGE", function(len)
    local msg = net.ReadString()
    local tid = net.ReadDouble()
    local plyid = net.ReadDouble()
	if (not IsValid(Entity(plyid))) then return end
	local safe = FamilyFriendly(msg, LocalPlayer())
	if (safe) then
		msg = safe
	elseif (IsValid(LocalPlayer()) and IsValid(Entity(plyid)) and Entity(plyid) == LocalPlayer()) then
		msg = msg
	else
		return
	end

    if (m_utrade == tid) then
        m_AddTradeChatMessage(msg, Entity(plyid))
    end
end)

net.Receive("MOAT_TRADE_CREDITS", function(len)
    local creds = net.ReadDouble()
    local tid = net.ReadDouble()
    local pindex = net.ReadDouble()
    if (not IsValid(M_TRADE_IC_ENTRY) or not IsValid(MOAT_TRADE_BG)) then return end

    if (m_utrade == tid) then
        if (LocalPlayer():EntIndex() == pindex) then
            M_TRADE_IC_ENTRY:SetValue(tostring(creds))
            M_TRADE_IC_ENTRY:SetText(tostring(creds))

            if (m_ply2:EntIndex() == LocalPlayer():EntIndex()) then
                MOAT_TRADE_BG.ICOffered = creds
            end
        else
            MOAT_TRADE_BG.ICOffered = creds
        end

        MOAT_TRADE_BG.ConfirmTime = 5
        MOAT_TRADE_BG.ACCEPTED = 0
        net.Start("MOAT_TRADE_STATUS")
        net.WriteDouble(MOAT_TRADE_BG.ACCEPTED)
        net.WriteDouble(m_utrade)
        local eslots = m_GetESlots()
        net.WriteDouble(eslots)
        net.SendToServer()
    end
end)

net.Receive("MOAT_TRADE_CAT", function(len)
    local tid = net.ReadDouble()
    local cat_num = net.ReadDouble()
    if (not IsValid(MOAT_TRADE_BG)) then return end

    if (m_utrade == tid) then
        MOAT_TRADE_BG.OLoc = cat_num
    end
end)

net.Receive("MOAT_TRADE_FAIL", function(len)
    local tid = net.ReadDouble()
    local msg = net.ReadString()

    if (m_utrade == tid) then
        m_AddTradeChatFailureMessage(msg)
    end
end)

net.Receive("MOAT_TRADE_STATUS", function(len)
    local accept_num = net.ReadDouble()
    if (not IsValid(MOAT_TRADE_BG)) then return end
    MOAT_TRADE_BG.ACCEPTED2 = accept_num
end)

net.Receive("MOAT_UPDATE_EXP", function(len)
    local item_id = net.ReadLong()
    local item_lvl = net.ReadDouble()
    local item_exp = net.ReadDouble()
    local old_level = 0
    local item_tbl = {}

    for i = 1, LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS") do
        if (m_Inventory[i] and m_Inventory[i].c) then
            if (m_Inventory[i].c == item_id) then
                old_level = m_Inventory[i].s.l
                m_Inventory[i].s.l = item_lvl
                m_Inventory[i].s.x = item_exp
                item_tbl = m_Inventory[i]
                break
            end
        end
    end

    for i = 1, 10 do
        if (m_Loadout[i] and m_Loadout[i].c) then
            if (m_Loadout[i].c == item_id) then
                old_level = m_Loadout[i].s.l
                m_Loadout[i].s.l = item_lvl
                m_Loadout[i].s.x = item_exp
                item_tbl = m_Loadout[i]
                break
            end
        end
    end

    if ((item_tbl.s and item_tbl.s.l) and old_level ~= item_tbl.s.l) then
        local ITEM_NAME_FULL = GetItemName(item_tbl)

        chat.AddText(Color(255, 255, 0), "Your " .. ITEM_NAME_FULL .. " is now level " .. item_tbl.s.l .. "!")
    end
end)


MOAT_ITEM_FOUND_QUEUE = MOAT_ITEM_FOUND_QUEUE or {}
local MOAT_ITEM_IS_BEING_DRAWN = false

function m_DrawFoundItem(tbl, s_type, name)
    local itemtbl = tbl
    local m_LoadoutTypes = {}
    m_LoadoutTypes[0] = "Melee"
    m_LoadoutTypes[1] = "Secondary"
    m_LoadoutTypes[2] = "Primary"
    local extra_y_padding = 20

    if (s_type == "chat" or s_type == "remove_chat" or s_type == "inspect" or s_type == "remove_inspect") then
        if (IsValid(MOAT_ITEM_STATS)) then
            MOAT_ITEM_STATS:Remove()
        end

        if (timer.Exists("moat_StatsPanel1")) then
            timer.Remove("moat_StatsPanel1")
        end

        if (timer.Exists("moat_StatsPanel2")) then
            timer.Remove("moat_StatsPanel2")
        end

        MOAT_ITEM_IS_BEING_DRAWN = false
        if (s_type == "remove_chat" or s_type == "remove_inspect") then return end
    end
	

    MOAT_ITEM_IS_BEING_DRAWN = true
    MOAT_ITEM_STATS = vgui.Create("DPanel")
    MOAT_ITEM_STATS:SetDrawOnTop(true)
    MOAT_ITEM_STATS:SetSize(275, 150)
    MOAT_ITEM_STATS.StatTbl = itemtbl
    local drawn_stats = 0
    local draw_stats_x = 7
    local draw_stats_multi = 0
    local draw_xp_lvl = 9
    local draw_stats_y = 26 + 21 + draw_xp_lvl
    MOAT_ITEM_STATS.AnimVal = 1
    MOAT_ITEM_STATS.Paint = function(s, w, h)
        s.ctrldown = input.IsKeyDown(KEY_LCONTROL)

        local ITEM_HOVERED = itemtbl
        draw_stats_y = 26 + 21 + draw_xp_lvl

        if (ITEM_HOVERED and ITEM_HOVERED.c) then
            local ITEM_NAME_FULL = GetItemName(ITEM_HOVERED)

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                draw_xp_lvl = 9
            else
                draw_xp_lvl = 3
            end

            -- if (ITEM_HOVERED.n) then
            --     draw_xp_lvl = draw_xp_lvl + 15
            -- end

            local namew, nameh = surface_GetTextSize(ITEM_NAME_FULL)
            local num_stats = 0

            if (ITEM_HOVERED.s) then
                num_stats = table.Count(ITEM_HOVERED.s)
            end

            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawOutlinedRect(0, 0, w, h)
            surface_SetDrawColor(15, 15, 15, 250)
            surface_DrawRect(1, 1, w - 2, h - 2)

			if (ITEM_HOVERED.p3 or ItemIsSkin(ITEM_HOVERED.u)) then
				local p3alpha, p3skin = MOAT_SKIN_ALPHA or 15
				if (ItemIsSkin(ITEM_HOVERED.u)) then
					p3skin = MOAT_PAINT.Skins[ITEM_HOVERED.u][2]
					p3alpha = MOAT_PAINT.Skins[ITEM_HOVERED.u][6] or MOAT_SKIN_ALPHA
				elseif (ITEM_HOVERED.p3 and MOAT_PAINT.Skins[ITEM_HOVERED.p3]) then
					p3skin = MOAT_PAINT.Skins[ITEM_HOVERED.p3][2]
					p3alpha = MOAT_PAINT.Skins[ITEM_HOVERED.p3][6] or MOAT_SKIN_ALPHA
				end

				if (p3skin and p3skin:match "vtf$") then
					cdn.DrawTexture(p3skin, 2, 2, w-4, h-4, Color(255, 255, 255, p3alpha))
				elseif (p3skin) then
					cdn.DrawImage(p3skin, 2, 2, w-4, h-4, Color(255, 255, 255, p3alpha))
				end

				surface.SetDrawColor(8, 12, 19, 240)
				surface.DrawRect(1, 1, w - 2, 45 + draw_xp_lvl)
				if (s.StatsHeight and s.SkinHeight) then
					surface.SetMaterial(gradient_d)
					surface.SetDrawColor(8, 12, 19, 230)
					surface.DrawTexturedRect(1, draw_stats_y + s.SkinHeight - 17, w - 2, 30)
					surface.SetDrawColor(8, 12, 19, 230)
					surface.DrawRect(1, draw_stats_y + s.SkinHeight + 13, w - 2, h - 2 - draw_stats_y - s.SkinHeight - 13)
				end
    		end

            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawLine(6, 22 + draw_xp_lvl, w - 6, 22 + draw_xp_lvl)
            surface_DrawLine(6, 43 + draw_xp_lvl, w - 6, 43 + draw_xp_lvl)
            surface_SetDrawColor(0, 0, 0, 100)
            surface_DrawLine(6, 23 + draw_xp_lvl, w - 6, 23 + draw_xp_lvl)
            surface_DrawLine(6, 44 + draw_xp_lvl, w - 6, 44 + draw_xp_lvl)
			surface_SetDrawColor(rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].r, rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].g, rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].b, rarity_gradient[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0].a)
            local grad_x = 1
            local grad_y = 25 + draw_xp_lvl
            local grad_w = (w - 2) / 2
            local grad_h = 16
            local grad_x2 = 1 + ((w - 2) / 2) + (((w - 2) / 2) / 2)
            local grad_y2 = 25 + (grad_h / 2) + draw_xp_lvl
            surface_SetMaterial(gradient_r)
            surface_DrawTexturedRect(grad_x, grad_y, grad_w, grad_h)
            surface_SetMaterial(gradient_r)
            surface_DrawTexturedRectRotated(grad_x2, grad_y2, grad_w, grad_h, 180)
            local RARITY_TEXT = ""

            if (name and (ITEM_HOVERED.nt or ITEM_HOVERED.item.NotTradeable)) then
                RARITY_TEXT = name .. "'s "
            end

            if (ITEM_HOVERED.item.Kind and ITEM_HOVERED.item.Kind ~= "tier") then
                RARITY_TEXT = RARITY_TEXT .. rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][1] .. " " .. ITEM_HOVERED.item.Kind
            else
                RARITY_TEXT = RARITY_TEXT .. rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][1] .. " " .. m_LoadoutTypes[util.GetWeaponSlot(ITEM_HOVERED.w)]
            end

			grad_y2 = grad_y2 - 1

            for i = 1, 2 do
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w + i, grad_y2 + i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w - i, grad_y2 - i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w + i, grad_y2 - i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w - i, grad_y2 + i, rarity_shadow[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			draw_SimpleText(RARITY_TEXT, "moat_Medium4", grad_w, grad_y2, rarity_accents[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            local draw_name_x = 7
            local draw_name_y = 3
            local name_col = ITEM_HOVERED.item.NameColor or rarity_names[ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0][2]:Copy()
            local name_font = "moat_Medium5"
			name_col.a = 255
            if (ITEM_HOVERED.item.NameEffect) then
                local tfx = ITEM_HOVERED.item.NameEffect

                if (tfx == "glow") then
                    m_DrawGlowingText(false, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "fire") then
                    m_DrawFireText(ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "bounce") then
                    m_DrawBouncingText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "enchanted") then
                    m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, ITEM_HOVERED.item.NameEffectMods[1])
				elseif (tfx == "threecolors") then
					if (not ITEM_HOVERED.item.NameEffectMods[4]) then ITEM_HOVERED.item.NameEffectMods[4] = 1 end
					if (not ITEM_HOVERED.item.NameEffectMods[5]) then ITEM_HOVERED.item.NameEffectMods[5] = RealTime() end
					if (ITEM_HOVERED.item.NameEffectMods[5] <= RealTime()) then
						ITEM_HOVERED.item.NameEffectMods[4] = ITEM_HOVERED.item.NameEffectMods[4] + 1
						if (ITEM_HOVERED.item.NameEffectMods[4] > 3) then ITEM_HOVERED.item.NameEffectMods[4] = 1 end
						ITEM_HOVERED.item.NameEffectMods[5] = RealTime() + (FrameTime() * 5)
					end

					m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, ITEM_HOVERED.item.NameEffectMods[itemtbl.item.NameEffectMods[4]], nil, nil, true)
                elseif (tfx == "electric") then
                    m_DrawElecticText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "frost") then
                    DrawFrostingText(10, 1.5, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, Color(100, 100, 255), Color(255, 255, 255))
                else
                    m_DrawShadowedText(1, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                end
            else
                m_DrawShadowedText(1, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
            end

            if (ITEM_HOVERED.n) then
                -- emoji.SimpleText("\"" .. ITEM_HOVERED.n:Replace("''", "'") .. "\"", "moat_ItemDesc", draw_name_x, draw_name_y + 21, Color(255, 128, 128))
            end

			drawn_stats = 0

            if (ITEM_HOVERED.s and (ITEM_HOVERED.item.Kind == "tier" or ITEM_HOVERED.item.Kind == "Unique" or ITEM_HOVERED.item.Kind == "Melee")) then
                draw_stats_multi = 25
				s.StatsHeight, s.SkinHeight = m_DrawItemStats("moat_ItemDesc", draw_stats_x, draw_stats_y + (drawn_stats * draw_stats_multi), ITEM_HOVERED, s)
                drawn_stats = 10
            elseif (ITEM_HOVERED.item and ITEM_HOVERED.item.Kind ~= "tier" and ITEM_HOVERED.item.Kind ~= "Unique" and ITEM_HOVERED.item.Kind ~= "Melee" and ITEM_HOVERED.item.Description) then
                local item_desc = ITEM_HOVERED.item.Description
                local item_desctbl = string.Explode("^", item_desc)

                if (ITEM_HOVERED.s and ITEM_HOVERED.item and ITEM_HOVERED.item.Stats) then
                    for i = 1, #item_desctbl do
                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i])), 2)

                        if (MOAT_ITEM_STATS.ctrldown) then
                            item_stat = "(" .. ITEM_HOVERED.item.Stats[i].min .. "-" .. ITEM_HOVERED.item.Stats[i].max .. ") " .. math.Round(item_stat, 2)
                        end

                        item_desctbl[i] = string.format(item_desctbl[i], item_stat)
                    end
                end

                item_desc = string.Implode("", item_desctbl)
                item_desc = string.Replace(item_desc, "_", "%")
                drawn_stats = m_DrawItemDesc(item_desc, "moat_ItemDesc", draw_stats_x, draw_stats_y, w - 12, h - draw_stats_y - 20)
                draw_stats_multi = 15
                local collection_y = draw_stats_y + (drawn_stats * draw_stats_multi) - 1
                m_DrawShadowedText(1, "From the " .. ITEM_HOVERED.item.Collection, "moat_Medium2", 6, collection_y, Color(150, 150, 150, 100))

				 if (ITEM_HOVERED.p3) then
       				local p3txt = MOAT_PAINT.Skins[ITEM_HOVERED.p3] and MOAT_PAINT.Skins[ITEM_HOVERED.p3][1] or "Glitched Skin"
					m_DrawShadowedText(1, p3txt, "moat_Medium2", s:GetWide() - 6, collection_y, MOAT_PAINT.Skins[ITEM_HOVERED.p3] and rarity_names[MOAT_PAINT.Skins[ITEM_HOVERED.p3][3]][2]:Copy() or Color(100, 100, 100, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    			end
            end

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                m_DrawShadowedText(1, ITEM_HOVERED.s.l, "moat_ItemDescLarge3", s:GetWide() - 6, 0, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                surface_SetFont("moat_ItemDescLarge3")
                local level_w, level_h = surface_GetTextSize(ITEM_HOVERED.s.l)
                m_DrawShadowedText(1, "LEVEL", "moat_ItemDesc", s:GetWide() - 6 - level_w, 4, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                m_DrawShadowedText(1, "XP: " .. ITEM_HOVERED.s.x .. "/ " .. (ITEM_HOVERED.s.l * 100), "moat_ItemDescSmall2", s:GetWide() - 6 - level_w - 2, 16, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                
                local nt_ = 0
                -- if (ITEM_HOVERED.n) then nt_ = 15 end

                surface_SetDrawColor(255, 255, 255, 20)
                surface_DrawRect(6, 27 + nt_, w - 12, 2)
                local bar_width = w - 12
                local xp_bar_width = bar_width * (ITEM_HOVERED.s.x / (ITEM_HOVERED.s.l * 100))
                surface_SetDrawColor(200, 200, 200, 255)
                surface_SetMaterial(gradient_r)
                surface_DrawTexturedRect(7, 27 + nt_, math.min(xp_bar_width, w - 12), 2)
            end
        end
    end

    local non_drawn_stats = {"d", "f", "m", "l", "x", "j", "tr"}
    local ITEM_HOVERED = itemtbl
    -- Put your Lua here
    if (ITEM_HOVERED and ITEM_HOVERED.c) then
        local ITEM_NAME_FULL = GetItemName(ITEM_HOVERED)

        surface_SetFont("moat_Medium5")
        local namew, nameh = surface_GetTextSize(ITEM_NAME_FULL)
        local namew2, nameh2 = 0, 0

        if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
            surface_SetFont("moat_ItemDescLarge3")
            local level_w, level_h = surface_GetTextSize(ITEM_HOVERED.s.l)
            surface_SetFont("moat_ItemDescSmall2")
            namew2, nameh2 = surface_GetTextSize("XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100))
            namew2 = namew2 + level_w
        end

        if ((namew + namew2) > 275) then
            MOAT_ITEM_STATS:SetWide(namew + namew2 + 12 + 10)
        end

        local num_stats = 0

        if (ITEM_HOVERED.s) then
            for k, v in pairs(ITEM_HOVERED.s) do
                if (not table.HasValue(non_drawn_stats, tostring(k))) then
                    num_stats = num_stats + 1
                end
            end
        end

        local draw_stats_multi = 25
        local default_drawn_stats = 40

        if (ITEM_HOVERED.item and ITEM_HOVERED.item.Kind ~= "tier" and ITEM_HOVERED.item.Kind ~= "Unique" and ITEM_HOVERED.item.Kind ~= "Melee" and ITEM_HOVERED.item.Description) then
            local item_desc = ITEM_HOVERED.item.Description
            local item_desctbl = string.Explode("^", item_desc)

            if (ITEM_HOVERED.s and ITEM_HOVERED.item and ITEM_HOVERED.item.Stats) then
                for i = 1, #item_desctbl do
                    local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i])), 2)

                    if (MOAT_ITEM_STATS.ctrldown) then
                        item_stat = "(" .. ITEM_HOVERED.item.Stats[i].min .. "-" .. ITEM_HOVERED.item.Stats[i].max .. ") " .. math.Round(item_stat, 2)
                    end

                    item_desctbl[i] = string.format(item_desctbl[i], item_stat)
                end
            end

            item_desc = string.Implode("", item_desctbl)
            item_desc = string.Replace(item_desc, "_", "%")
            num_stats = m_GetItemDescH(item_desc, "moat_ItemDesc", MOAT_ITEM_STATS:GetWide() - 12)
            draw_stats_multi = 15
            default_drawn_stats = 0
        end

        local drawn_talents = 0

        if (ITEM_HOVERED.t) then
            drawn_talents = 12

            for k, v in ipairs(ITEM_HOVERED.t) do
				if (not ITEM_HOVERED.Talents[k] or not ITEM_HOVERED.Talents[k].Modifications or not ITEM_HOVERED.Talents[k].Description) then
					continue
				end
					
                local talent_desc2 = ITEM_HOVERED.Talents[k].Description
                local talent_desctbl2 = string.Explode("^", talent_desc2)

                for i = 1, table.Count(v.m) do
					if (not ITEM_HOVERED.Talents[k].Modifications or not ITEM_HOVERED.Talents[k].Modifications[i]) then
						continue
					end
					
                    local mod_num = math.Round(ITEM_HOVERED.Talents[k].Modifications[i].min + ((ITEM_HOVERED.Talents[k].Modifications[i].max - ITEM_HOVERED.Talents[k].Modifications[i].min) * math.min(1, v.m[i])), 1)

                    if (MOAT_ITEM_STATS.ctrldown) then
                        mod_num = "(" .. ITEM_HOVERED.Talents[k].Modifications[i].min .. "-" .. ITEM_HOVERED.Talents[k].Modifications[i].max .. ") " .. math.Round(mod_num, 2)
                    end

                    talent_desctbl2[i] = string.format(talent_desctbl2[i], tostring(mod_num))
                end

                talent_desc2 = string.Implode("", talent_desctbl2)
                talent_desc2 = string.Replace(talent_desc2, "_", "%")
                local talent_desc_h = 17 + (m_GetItemDescH(talent_desc2, "moat_ItemDesc", MOAT_ITEM_STATS:GetWide() - 12 - 6) * 15)
                drawn_talents = drawn_talents + talent_desc_h + 3
            end
        end

        local collection_add = 0

        if (ITEM_HOVERED.item) then
            if (ITEM_HOVERED.item.Collection) then
                collection_add = 10
            end
        end

        local panel_height = draw_stats_y + default_drawn_stats + drawn_talents + (num_stats * draw_stats_multi) + 4 + collection_add

        if ((ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0) == 0 and ITEM_HOVERED.item.ID and ITEM_HOVERED.item.ID ~= 7820 and ITEM_HOVERED.item.ID ~= 7821) then
            -- panel_height = 100
        end

        MOAT_ITEM_STATS:SetTall(panel_height)
    end

    MOAT_ITEM_STATS.Think = function(s, w, h)
        if (ITEM_HOVERED and ITEM_HOVERED.c) then
            local ITEM_NAME_FULL = GetItemName(ITEM_HOVERED)

            surface_SetFont("moat_Medium5")
            local namew, nameh = surface_GetTextSize(ITEM_NAME_FULL)
            local namew2, nameh2 = 0, 0

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                surface_SetFont("moat_ItemDescLarge3")
                local level_w, level_h = surface_GetTextSize(ITEM_HOVERED.s.l)
                surface_SetFont("moat_ItemDescSmall2")
                namew2, nameh2 = surface_GetTextSize("XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100))
                namew2 = namew2 + level_w
            end

            if ((namew + namew2) > 275) then
                MOAT_ITEM_STATS:SetWide(namew + namew2 + 12 + 10)
            end

            local num_stats = 0

            if (ITEM_HOVERED.s) then
                for k, v in pairs(ITEM_HOVERED.s) do
                    if (not table.HasValue(non_drawn_stats, tostring(k))) then
                        num_stats = num_stats + 1
                    end
                end
            end

            local draw_stats_multi = 25
            local default_drawn_stats = 40

            if (ITEM_HOVERED.item and ITEM_HOVERED.item.Kind ~= "tier" and ITEM_HOVERED.item.Kind ~= "Unique" and ITEM_HOVERED.item.Kind ~= "Melee" and ITEM_HOVERED.item.Description) then
                local item_desc = ITEM_HOVERED.item.Description
                local item_desctbl = string.Explode("^", item_desc)

                if (ITEM_HOVERED.s and ITEM_HOVERED.item and ITEM_HOVERED.item.Stats) then
                    
                    for i = 1, #item_desctbl do
                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i])), 2)

                        if (s.ctrldown) then
                            item_stat = "(" .. ITEM_HOVERED.item.Stats[i].min .. "-" .. ITEM_HOVERED.item.Stats[i].max .. ") " .. math.Round(item_stat, 2)
                        end

                        item_desctbl[i] = string.format(item_desctbl[i], item_stat)
                    end
                end

                item_desc = string.Implode("", item_desctbl)
                item_desc = string.Replace(item_desc, "_", "%")
                num_stats = m_GetItemDescH(item_desc, "moat_ItemDesc", MOAT_ITEM_STATS:GetWide() - 12)
                draw_stats_multi = 15
                default_drawn_stats = 0
            end

            local drawn_talents = 0

            if (ITEM_HOVERED.t) then
                drawn_talents = 12

                for k, v in ipairs(ITEM_HOVERED.t) do
					if (not ITEM_HOVERED.Talents[k] or not ITEM_HOVERED.Talents[k].Modifications or not ITEM_HOVERED.Talents[k].Description) then
						continue
					end

                    local talent_desc2 = ITEM_HOVERED.Talents[k].Description
                    local talent_desctbl2 = string.Explode("^", talent_desc2)

                    for i = 1, table.Count(v.m) do
						if (not ITEM_HOVERED.Talents[k].Modifications or not ITEM_HOVERED.Talents[k].Modifications[i]) then
							continue
						end

                        local mod_num = math.Round(ITEM_HOVERED.Talents[k].Modifications[i].min + ((ITEM_HOVERED.Talents[k].Modifications[i].max - ITEM_HOVERED.Talents[k].Modifications[i].min) * math.min(1, v.m[i])), 1)

                        if (MOAT_ITEM_STATS.ctrldown) then
                            mod_num = "(" .. ITEM_HOVERED.Talents[k].Modifications[i].min .. "-" .. ITEM_HOVERED.Talents[k].Modifications[i].max .. ") " .. math.Round(mod_num, 2)
                        end

                        talent_desctbl2[i] = string.format(talent_desctbl2[i], tostring(mod_num))
                    end

                    talent_desc2 = string.Implode("", talent_desctbl2)
                    talent_desc2 = string.Replace(talent_desc2, "_", "%")
                    local talent_desc_h = 17 + (m_GetItemDescH(talent_desc2, "moat_ItemDesc", MOAT_ITEM_STATS:GetWide() - 12 - 6) * 15)
                    drawn_talents = drawn_talents + talent_desc_h + 3
                end
            end

            local collection_add = 0

            if (ITEM_HOVERED.item) then
                if (ITEM_HOVERED.item.Collection) then
                    collection_add = 10
                end
            end

            local panel_height = draw_stats_y + default_drawn_stats + drawn_talents + (num_stats * draw_stats_multi) + 4 + collection_add

            if ((ITEM_HOVERED.item and ITEM_HOVERED.item.Rarity or 0) == 0 and ITEM_HOVERED.item.ID and ITEM_HOVERED.item.ID ~= 7820 and ITEM_HOVERED.item.ID ~= 7821) then
                -- panel_height = 100
            end

            MOAT_ITEM_STATS:SetTall(panel_height)
        end
    end

    if (s_type == "inspect") then
		local vm = LocalPlayer():GetViewModel()
		if (not vm) then
			return
		end

		local inspect_attach, att_cache = {1, 2, 3, "muzzle", "muzzle_flash"}
		for k, v in ipairs(inspect_attach) do
			local num = isstring(v) and vm:LookupAttachment(v) or v
			if (vm:GetAttachment(num)) then
				att = vm:GetAttachment(num)
				att_cache = num

				break
			end
		end

		if (not att_cache) then
			return
		end

		local pw, ph = MOAT_ITEM_STATS:GetSize()
		local p, a = att.Pos, att.Ang

		p = p - (a:Forward() * 0) + (a:Right() * 0) + (a:Up() * 0)
		p = p:ToScreen()
		p.x = math.Clamp(p.x, 0, ScrW())
		p.y = math.Clamp(p.y - ph, 0, ScrH())

		MOAT_ITEM_STATS:SetPos(p.x - pw, p.y - ph)
        MOAT_ITEM_STATS:SetAlpha(0)
        MOAT_ITEM_STATS:AlphaTo(255, 1, 0)

        return
    end

    if (s_type == "chat") then
        local mx, my = gui.MousePos()
        MOAT_ITEM_STATS:SetPos(mx + 5, my - MOAT_ITEM_STATS:GetTall() - 5)
        local px, py = MOAT_ITEM_STATS:GetPos()

        if (py < 0) then
            MOAT_ITEM_STATS:SetPos(px, 0)
        end

        MOAT_ITEM_STATS:SetAlpha(0)
        MOAT_ITEM_STATS:AlphaTo(255, 0.5, 0)

        timer.Create("moat_StatsPanel1", 5, 1, function()
            if (IsValid(MOAT_ITEM_STATS)) then
                MOAT_ITEM_STATS:AlphaTo(0, 0.5, 0)
            end
        end)

        timer.Create("moat_StatsPanel2", 5.5, 1, function()
            if (IsValid(MOAT_ITEM_STATS)) then
                MOAT_ITEM_STATS:Remove()
                MOAT_ITEM_IS_BEING_DRAWN = false
            end
        end)

        return
    end

    MOAT_ITEM_STATS:SetPos((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall())
    MOAT_ITEM_STATS:SetAlpha(0)
    local label_y_padding = 30
    MOAT_ITEM_STATS_LBL = vgui.Create("DPanel")
    MOAT_ITEM_STATS_LBL:SetSize(MOAT_ITEM_STATS:GetWide(), 30)
    MOAT_ITEM_STATS_LBL:SetPos((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall() - label_y_padding)
    MOAT_ITEM_STATS_LBL:SetAlpha(0)

    MOAT_ITEM_STATS_LBL.Paint = function(s, w, h)
        --m_DrawShadowedText( 1, "Item Obtained!", "moat_ItemDescLarge3", w / 2, 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
        if (not MOAT_ITEM_FOUND_QUEUE[1]) then return end

        if (s_type ~= "pickup") then
            draw_SimpleTextOutlined("Item Obtained!", "moat_ItemDescLarge3", w / 2, 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0.5, Color(10, 10, 10, 255))
        end
    end

    -- Entering
    if (IsValid(MOAT_ITEM_STATS)) then
        MOAT_ITEM_STATS:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), 50, 0.5, 0)
        MOAT_ITEM_STATS:AlphaTo(255, 0.5, 0)
    end

    if (IsValid(MOAT_ITEM_STATS_LBL)) then
        MOAT_ITEM_STATS_LBL:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), 50 - label_y_padding, 0.5, 0)
        MOAT_ITEM_STATS_LBL:AlphaTo(255, 0.5, 0)
    end

    -- Leaving - Tried setting the delay for the animations, but there were different results ( sometimes had delay, sometimes didn't, specificly for moveto )
    timer.Simple(2, function()
        if (IsValid(MOAT_ITEM_STATS)) then
            MOAT_ITEM_STATS:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall(), 0.5, 0)
            MOAT_ITEM_STATS:AlphaTo(0, 0.5, 0)
        end

        if (IsValid(MOAT_ITEM_STATS_LBL)) then
            MOAT_ITEM_STATS_LBL:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall() - label_y_padding, 0.5, 0)
            MOAT_ITEM_STATS_LBL:AlphaTo(0, 0.5, 0)
        end
    end)

    -- Removing
    timer.Simple(3, function()
        if (IsValid(MOAT_ITEM_STATS)) then
            MOAT_ITEM_STATS:Remove()
        end

        if (IsValid(MOAT_ITEM_STATS_LBL)) then
            MOAT_ITEM_STATS_LBL:Remove()
        end

        table.remove(MOAT_ITEM_FOUND_QUEUE, 1)
        MOAT_ITEM_IS_BEING_DRAWN = false
    end)
end

hook.Add("Think", "moat_DrawItemsFound", function()
    if (#MOAT_ITEM_FOUND_QUEUE > 0 and not MOAT_ITEM_IS_BEING_DRAWN) then
        local draw_type = "default"

        if (MOAT_ITEM_FOUND_QUEUE[1].ItemStatType) then
            draw_type = MOAT_ITEM_FOUND_QUEUE[1].ItemStatType
        end

        m_DrawFoundItem(MOAT_ITEM_FOUND_QUEUE[1], draw_type)
    end
end)

function m_DrawFoundItemAdd(item_tbl, draw_type)
    local item_tbl = item_tbl
    item_tbl.ItemStatType = draw_type
    table.insert(MOAT_ITEM_FOUND_QUEUE, item_tbl)
end

local last_played = 0
net.Receive("MOAT_ITEM_OBTAINED", function(len)
    -- local tbl = net.ReadTable()
	local tbl = m_ReadWeaponFromNet()
	-- if (tbl.u) then
	-- 	tbl.item = GetItemFromEnum(tbl.u)
	-- end

	-- if (tbl.t) then
	-- 	tbl.Talents = GetItemTalents(tbl)
	-- end

    table.insert(MOAT_ITEM_FOUND_QUEUE, tbl)

	if (last_played <= CurTime() - .5) then
		if (tbl.item and tbl.item.Rarity == 2) then
			cdn.PlayURL("https://static.moat.gg/ttt/Stinger_loot_01.wav", .2)
		elseif (tbl.item and tbl.item.Rarity == 3) then
			cdn.PlayURL("https://static.moat.gg/ttt/Stinger_loot_02.wav", .2)
		elseif (tbl.item and tbl.item.Rarity == 4) then
			cdn.PlayURL("https://static.moat.gg/ttt/Stinger_loot_06.wav", .2)
		elseif (tbl.item and tbl.item.Rarity == 5) then
			cdn.PlayURL("https://static.moat.gg/ttt/Stinger_loot_05.wav", .2)
		elseif (tbl.item and tbl.item.Name and string.EndsWith(tbl.item.Name, "Mutator")) then
			cdn.PlayURL("https://static.moat.gg/ttt/borderlands_3_legend.mp3", .2)
		end

		last_played = CurTime()
	end
end)

net.Receive("MOAT_INIT_USABLE", function()
    local cl = net.ReadDouble()
    local num = 0

    for i = 1, #m_Inventory do
        if (m_Inventory[i] and m_Inventory[i].c and m_Inventory[i].c == cl) then
            num = i
            break
        end
    end
    if (num == 0) then return end

    local itemtbl = m_Inventory[num]

    if (itemtbl.item.ItemCheck) then
        m_IniateUsableItem(num, itemtbl)
    else
        if (itemtbl.item.ID == 10 or itemtbl.item.ID == 13) and (GetRoundState() ~= 2 or #player.GetAll() < 8) then 
            Derma_Message("This must be used while the round is preparing, and there must be 8 players on.", "Unusable at the moment", "Ok")
            return 
        end
        if (itemtbl.item.ID == 17 and LocalPlayer():GetUserGroup() ~= "user") then
            Derma_Message("You are already VIP or higher!", "Unusable at the moment", "Ok")
            return
        end
        net.Start("MOAT_USE_USABLE")
        net.WriteDouble(num)
        net.WriteDouble(itemtbl.c)
        net.SendToServer()
    end
end)

net.Receive("MOAT_MAX_SLOTS", function(len)
    local max_slots = net.ReadDouble()
    local max_slots_old = max_slots - 4
	NUMBER_OF_SLOTS = max_slots

    if (max_slots > 350) then
		-- HTTP({
		-- 	url = "https://discord.moat.gg/api/webhooks/638353224796995584/r5ciN3MS-xit0iJokWb3Gd-iwkJ0kxw28JBtdFk45NhJnkXObF3O4P7qhWhO1YguO8pF",
		-- 	method = 'POST',
		-- 	headers = {
		-- 		['Content-Type'] = 'application/json'
		-- 	},
		-- 	body = util.TableToJSON {
		-- 		content = "🆓 Free Upgrade to __" .. max_slots .. "__ Slots • ``[" .. util.UTCTime() .. "]`` • " .. LocalPlayer():NameID() .. " • **" .. net.ReadString() .. "** • ``" .. GetServerName():Trim() .. "``",
		-- 		username = "Member Loggers | Inventory Slots",
		-- 		avatar_url = avatar
		-- 	},
		-- 	success = function()end,
		-- 	failed = function()end
		-- })

        for i = 1, 10 do
        --    chat.AddText(Color(255, 0, 0), "Warning! Your inventory is taking a lot of time to save! Consider deconstructing items or risk losing some!")
        end
    end
	
	-- print("max", max_slots)

    for i = max_slots_old, max_slots do
        m_Inventory[i] = {decon = false}

        if (m_isUsingInv(true)) then
            m_CreateInvSlot(i)
        end
    end
end)

net.Receive("MOAT_SEND_SLOTS", function(len)
    NUMBER_OF_SLOTS = net.ReadDouble()
end)

MOAT_NOT_SPAWNING = true

net.Receive("MOAT_NET_SPAWN", function()
    MOAT_NOT_SPAWNING = false

    timer.Simple(5, function() MOAT_NOT_SPAWNING = true end)
end)

function m_DrawDeconButton()
    if (IsValid(MOAT_INV_MASS_DECON)) then return end
    MOAT_INV_BG:SetSize(MOAT_INV_BG_W, MOAT_INV_BG_H + 40)

    MOAT_INV_MASS_DECON = vgui.Create("DButton", MOAT_INV_BG)
    MOAT_INV_MASS_DECON:SetPos(MOAT_INV_BG_W - 364 - 5, MOAT_INV_BG_H)
    MOAT_INV_MASS_DECON:SetSize(364, 35)
    MOAT_INV_MASS_DECON:SetText("")
	sfx.SoundEffects(MOAT_INV_MASS_DECON)
    local hover_coloral = 1
    MOAT_INV_MASS_DECON.Paint = function(s, w, h)
        surface_SetDrawColor(0, 0, 0, 255)
        surface_DrawRect(0, 0, w, h)
        surface_SetDrawColor(50, 50, 50, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(255, 0, 0, 20 + hover_coloral / 5)
        surface_DrawRect(1, 1, w - 2, h - 2)
        surface_SetDrawColor(255, 0, 0, 20 + hover_coloral / 5)
        surface_SetMaterial(gradient_d)
        surface_DrawTexturedRect(1, 1, w - 2, h - 2)
        local the_s = ""
        if (MOAT_ITEMS_DECON_MARKED > 1) then
            the_s = "s"
        end
        m_DrawShadowedText(1, "Deconstruct " .. MOAT_ITEMS_DECON_MARKED .. " Marked Item" .. the_s, "Trebuchet24", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local btn_hovered = 1
    local btn_color_a = false

    MOAT_INV_MASS_DECON.Think = function(s)
        if (MOAT_ITEMS_DECON_MARKED < 1) then
            s:Remove()
            MOAT_INV_BG:SetSize(MOAT_INV_BG_W, MOAT_INV_BG_H)

            return
        end

        if (not s:IsHovered()) then
            btn_hovered = 0
            btn_color_a = false

            if (hover_coloral > 0) then
                hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
            end
        else
            if (hover_coloral < 154 and btn_hovered == 0) then
                hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
            else
                btn_hovered = 1
            end

            if (btn_hovered == 1) then
                if (btn_color_a) then
                    if (hover_coloral >= 154) then
                        btn_color_a = false
                    else
                        hover_coloral = hover_coloral + (100 * FrameTime())
                    end
                else
                    if (hover_coloral <= 50) then
                        btn_color_a = true
                    else
                        hover_coloral = hover_coloral - (100 * FrameTime())
                    end
                end
            end
        end
    end

    MOAT_INV_MASS_DECON.DoClick = function()
		local items_decon = 0

        for i = 1, #m_Inventory do
            if (m_Inventory[i] and m_Inventory[i].decon) then
                items_decon = items_decon + 1
            end
        end

		net.Start "MOAT_REM_INV_ITEMS"
		net.WriteUInt(items_decon, 16)

		local items_sent = 0
        for i = 1, #m_Inventory do
            if (m_Inventory[i] and m_Inventory[i].decon) then
				items_sent = items_sent + 1

                net.WriteDouble(i)
                net.WriteDouble(m_Inventory[i].c)

                if (items_sent == MOAT_ITEMS_DECON_MARKED) then
                    net.WriteDouble(2)
                else
                    net.WriteDouble(3)
                end

                m_Inventory[i].decon = false
            end
        end

		net.SendToServer()

        MOAT_ITEMS_DECON_MARKED = 0
    end
end

local decon_last_played = 0
net.Receive("MOAT_DECON_NOTIFY", function()
    local amt = net.ReadUInt(32)
    local mul = net.ReadBool()

    local s = mul == true and "s" or ""

	if (decon_last_played <= CurTime() - .5) then
		cdn.PlayURL "https://static.moat.gg/ttt/2533282972.mp3"

		decon_last_played = CurTime()
	end

    chat.AddText(mat_info, Color(255, 255, 0), "You received ", Color(0, 255, 0), string.Comma(amt), Color(255, 255, 0), " IC from deconstructing your item" .. s .. "!")
end)

net.Receive("MOAT_DECON_MUTATOR", function()
    cdn.PlayURL "https://static.moat.gg/ttt/borderlands_3_legend.mp3"
end)

hook("InitPostEntity", function()
	if (not MOAT_CLIENTINV_REQUESTED and not handled_send) then
		-- moat_inv_cooldown = CurTime() + 10
        net.Start("MOAT_SEND_INV_ITEM")
		net.SendToServer()

		MOAT_CLIENTINV_REQUESTED = true
		handled_send = CurTime()
	end
end)