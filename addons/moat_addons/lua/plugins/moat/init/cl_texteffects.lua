local function m_AlignText(text, font, x, y, xalign, yalign)
    surface.SetFont(font)
    local textw, texth = surface.GetTextSize(text)

    if (xalign == TEXT_ALIGN_CENTER) then
        x = x - (textw / 2)
    elseif (xalign == TEXT_ALIGN_RIGHT) then
        x = x - textw
    end

    if (yalign == TEXT_ALIGN_BOTTOM) then
        y = y - texth
    end

    return x, y
end

function DrawShadowedText(shadow, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    draw.SimpleText(text, font, x + shadow, y + shadow, Color(0, 0, 0, color.a or 255), xalign, yalign)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function GlowColor(col1, col2, mod)
    local newr = col1.r + ((col2.r - col1.r) * (mod))
    local newg = col1.g + ((col2.g - col1.g) * (mod))
    local newb = col1.b + ((col2.b - col1.b) * (mod))

    return Color(newr, newg, newb)
end

function DrawEnchantedText(speed, text, font, x, y, color, glow_color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local glow_color = glow_color or Color(127, 0, 255)
    local texte = string.Explode("", text)
    local x, y = m_AlignText(text, font, x, y, xalign, yalign)
    surface.SetFont(font)
    local chars_x = 0

    for i = 1, #texte do
        local char = texte[i]
        local charw, charh = surface.GetTextSize(char)
        local color_glowing = GlowColor(glow_color, color, math.abs(math.sin((RealTime() - (i * 0.08)) * speed)))
        draw.SimpleText(char, font, x + chars_x, y, color_glowing, xalign, yalign)
        chars_x = chars_x + charw
    end
end

function DrawFadingText(speed, text, font, x, y, color, fading_color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local color_fade = GlowColor(color, fading_color, math.abs(math.sin((RealTime() - 0.08) * speed)))
    draw.SimpleText(text, font, x, y, color_fade, xalign, yalign)
end

local col1 = Color(0, 0, 0)
local col2 = Color(255, 255, 255)
local next_col = 0

function DrawRainbowText(speed, text, font, x, y, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    next_col = next_col + 1 / (100 / speed)

    if (next_col >= 1) then
        next_col = 0
        col1 = col2
        col2 = ColorRand()
    end

    draw.SimpleText(text, font, x, y, GlowColor(col1, col2, next_col), xalign, yalign)
end

function DrawGlowingText(static, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local initial_a = 20
    local a_by_i = 5
    local alpha_glow = math.abs(math.sin((RealTime() - 0.1) * 2))

    if (static) then
        alpha_glow = 1
    end

    for i = 1, 2 do
        draw.SimpleTextOutlined(text, font, x, y, color, xalign, yalign, i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow))
    end

    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function DrawBouncingText(style, intesity, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local texte = string.Explode("", text)
    surface.SetFont(font)
    local chars_x = 0
    local x, y = m_AlignText(text, font, x, y, xalign, yalign)

    for i = 1, #texte do
        local char = texte[i]
        local charw, charh = surface.GetTextSize(char)
        local y_pos = 1
        local mod = math.sin((RealTime() - (i * 0.1)) * (2 * intesity))

        if (style == 1) then
            y_pos = y_pos - math.abs(mod)
        elseif (style == 2) then
            y_pos = y_pos + math.abs(mod)
        else
            y_pos = y_pos - mod
        end

        draw.SimpleText(char, font, x + chars_x, y - (5 * y_pos), color, xalign, yalign)
        chars_x = chars_x + charw
    end
end

local next_electric_effect = CurTime() + 0
local electric_effect_a = 0

function DrawElectricText(intensity, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local charw, charh = surface.GetTextSize(text)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)

    if (electric_effect_a > 0) then
        electric_effect_a = electric_effect_a - (1000 * FrameTime())
    end

    surface.SetDrawColor(102, 255, 255, electric_effect_a)

    for i = 1, math.random(5) do
        line_x = math.random(charw)
        line_y = math.random(charh)
        line_x2 = math.random(charw)
        line_y2 = math.random(charh)
        surface.DrawLine(x + line_x, y + line_y, x + line_x2, y + line_y2)
    end

    local effect_min = 0.5 + (1 - intensity)
    local effect_max = 1.5 + (1 - intensity)

    if (next_electric_effect <= CurTime()) then
        next_electric_effect = CurTime() + math.Rand(effect_min, effect_max)
        electric_effect_a = 255
    end
end

function DrawFireText(intensity, text, font, x, y, color, xalign, yalign, glow, shadow)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    surface.SetFont(font)
    local charw, charh = surface.GetTextSize(text)
    local fire_height = charh * intensity

    for i = 1, charw do
        local line_y = math.random(fire_height, charh)
        local line_x = math.random(-4, 4)
        local line_col = math.random(255)
        surface.SetDrawColor(255, line_col, 0, 150)
        surface.DrawLine(x - 1 + i, y + charh, x - 1 + i + line_x, y + line_y)
    end

    if (glow) then
        DrawGlowingText(true, text, font, x, y, color, xalign, yalign)
    end

    if (shadow) then
        draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0), xalign, yalign)
    end

    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function DrawSnowingText(intensity, text, font, x, y, color, color2, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local color2 = color2 or Color(255, 255, 255)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)
    surface.SetFont(font)
    local textw, texth = surface.GetTextSize(text)
    surface.SetDrawColor(color2.r, color2.g, color2.b, 255)

    for i = 1, intensity do
        local line_y = math.random(0, texth)
        local line_x = math.random(0, textw)
        surface.DrawLine(x + line_x, y + line_y, x + line_x, y + line_y + 1)
    end
end

function DrawGlowingTextControlled(control, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local initial_a = 20
    local a_by_i = 5
    local alpha_glow = control

    for i = 1, 2 do
        draw.SimpleTextOutlined(text, font, x, y, color, xalign, yalign, i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow))
    end

    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

local shake_var2 = 0 -- controls the actual positioning

function DrawFrostingText(intensity, shake_var, text, font, x, y, color, color2, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local color2 = color2 or Color(255, 255, 255)
    local time_var = math.abs(math.sin((RealTime() - 0.08) * 0.2))
    shake_var2 = shake_var * time_var
    snow_amt = intensity * time_var

    local pos1, pos2 = shake_var * shake_var2, shake_var * shake_var2

    DrawGlowingTextControlled(1-time_var, text, font, x+math.Rand(-pos1, pos1), y+math.Rand(-pos2, pos2), GlowColor(color2, color, time_var), xalign, yalign)

    surface.SetFont(font)
    local textw, texth = surface.GetTextSize(text)
    surface.SetDrawColor(color2.r, color2.g, color2.b, 255)

    for i = 1, snow_amt do
        local line_y = math.random(0, texth)
        local line_x = math.random(0, textw)
        surface.DrawLine(x + line_x, y + line_y, x + line_x, y + line_y + 1)
    end
end

/*
MOAT_SHOW_EFFECT_EXAMPLES1 = false

function moat_DrawEffectExamples()
    if (not MOAT_SHOW_EFFECT_EXAMPLES1) then return end
    local font = "DermaLarge"
    draw.RoundedBox(0, 50, 50, 700, 500, Color(0, 0, 0, 200))
    local x = 100
    local y = 100
    DrawGlowingText(false, "GLOWING TEXT", font, x, y, Color(255, 0, 0, 255))
    y = y + 50
    DrawFadingText(1, "FADING COLORS TEXT", font, x, y, Color(255, 0, 0), Color(0, 0, 255))
    y = y + 50
    DrawRainbowText(1, "RAINBOW TEXT", font, x, y)
    y = y + 50
    DrawEnchantedText(2, "ENCHANTED TEXT", font, x, y, Color(255, 0, 0), Color(0, 0, 255))
    y = y + 50
    DrawFireText(0.5, "INFERNO TEXT", font, x, y, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, true, true)
    y = y + 50
    DrawElectricText(1, "ELECTRIC TEXT", font, x, y, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    y = y + 50
    DrawBouncingText(3, 3, "BOUNCING AND WAVING TEXT", font, x, y, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    y = y + 50
    DrawSnowingText(10, "SPARKLING/SNOWING TEXT", font, x, y, Color(255, 0, 0), Color(255, 255, 255))
    y = y + 50
    DrawFrostingText(10, 1.5, "FROSTING TEXT", font, x, y, Color(100, 100, 255), Color(255, 255, 255))
end

hook.Add("HUDPaint", "moat_TextEffectsExample", moat_DrawEffectExamples)
*/