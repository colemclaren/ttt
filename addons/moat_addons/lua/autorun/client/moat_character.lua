
-- Draws an arc on your screen.
-- startang and endang are in degrees, 
-- radius is the total radius of the outside edge to the center.
-- cx, cy are the x,y coordinates of the center of the arc.
-- roughness determines how many triangles are drawn. Number between 1-360; 2 or 3 is a good number.
function draw.Arc(cx,cy,radius,thickness,startang,endang,roughness,color)
	draw.NoTexture()
	surface.SetDrawColor(color)
	surface.DrawArc(surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness))
end

function surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness)
	local triarc = {}
	-- local deg2rad = math.pi / 180
	
	-- Define step
	local roughness = math.max(roughness or 1, 1)
	local step = roughness
	
	-- Correct start/end ang
	local startang,endang = startang or 0, endang or 0
	
	if startang > endang then
		step = math.abs(step) * -1
	end
	
	-- Create the inner circle's points.
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*r), cy+(-math.sin(rad)*r)
		table.insert(inner, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end
	
	
	-- Create the outer circle's points.
	local outer = {}
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*radius), cy+(-math.sin(rad)*radius)
		table.insert(outer, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end
	
	
	-- Triangulize the points.
	for tri=1,#inner*2 do -- twice as many triangles as there are degrees.
		local p1,p2,p3
		p1 = outer[math.floor(tri/2)+1]
		p3 = inner[math.floor((tri+1)/2)+1]
		if tri%2 == 0 then --if the number is even use outer.
			p2 = outer[math.floor((tri+1)/2)]
		else
			p2 = inner[math.floor((tri+1)/2)]
		end
	
		table.insert(triarc, {p1,p2,p3})
	end
	
	-- Return a table of triangles to draw.
	return triarc
	
end

function surface.DrawArc(arc) //Draw a premade arc.
	for k,v in ipairs(arc) do
		surface.DrawPoly(v)
	end
end

MOAT_XP_LERP = 360
MOAT_STATS_LERP = 0

function m_PopulateStats(pnl)
    local level = LocalPlayer():GetNWInt("MOAT_STATS_LVL", 0)
    local xp = LocalPlayer():GetNWInt("MOAT_STATS_XP", 0)
    local drops = LocalPlayer():GetNWInt("MOAT_STATS_DROPS", 0)
    local deconstructs = LocalPlayer():GetNWInt("MOAT_STATS_DECONSTRUCTS", 0)
    local kills = LocalPlayer():GetNWInt("MOAT_STATS_KILLS", 0)
    local deaths = LocalPlayer():GetNWInt("MOAT_STATS_DEATHS", 0)
    local xp_perc = xp / (level * 1000)

    if (level < 10) then
        level = "0" .. level
    end

    local kd = math.Round(kills / deaths, 2) or 0

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end
    local MT_TCOL = MT[CurTheme].TextColor
    local MT_TSHADOW = MT[CurTheme].TextShadow

    pnl.Paint = function(s, w, h)
        MOAT_XP_LERP = Lerp(FrameTime() * 3, MOAT_XP_LERP, 360 - (360 * xp_perc))
        MOAT_STATS_LERP = Lerp(FrameTime() * 3, MOAT_STATS_LERP, 1)
        local ARC_COLOR = (360 - MOAT_XP_LERP) / 360
        local ARC_ACOLOR = Color(255 - (255 * ARC_COLOR), 255 * ARC_COLOR, 0, 255)
        draw.Arc(w / 2, 175, 150, 20, 0, 360, 1, ARC_ACOLOR)
        draw.Arc(w / 2, 175, 150, 20, 90, 90 + MOAT_XP_LERP, 1, Color(0, 0, 0, 240))
        draw.SimpleTextOutlined("LEVEL", "moat_ItemDescLarge3", w / 2, 75, MT_TCOL, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined(math.ceil(level * MOAT_STATS_LERP), "moat_MOTDHead", w / 2, 95, MT_TCOL, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined("EXPERIENCE", "moat_ItemDescLarge3", w / 2, 150, MT_TCOL, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined(math.ceil(xp * MOAT_STATS_LERP) .. "/" .. (level * 1000), "moat_MOTDHead", w / 2, 170, MT_TCOL, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined("K/D", "moat_ItemDescLarge3", w / 2, 225, MT_TCOL, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined(kd, "moat_MOTDHead", w / 2, 245, MT_TCOL, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 25))
        local obtained_y = 375
        draw.RoundedBox(0, 10, obtained_y, w - 20, 3, Color(0, 255, 255))
        surface.SetFont("moat_MOTDHead")
        local drops_w, drops_h = surface.GetTextSize(tostring(drops))
        surface.SetDrawColor(0, 255, 255, 50)
        surface.SetMaterial(Material("vgui/gradient-r"))
        surface.DrawTexturedRect(w - 10 - drops_w - 5 - 10, obtained_y - drops_h + 5, drops_w + 5 + 10, drops_h - 5)
        draw.SimpleTextOutlined("ITEMS", "moat_ItemDesc", 10, obtained_y - 25, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined("OBTAINED", "moat_ItemDescLarge3", 10, obtained_y, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined(math.ceil(drops * MOAT_STATS_LERP), "moat_MOTDHead", w - 15, obtained_y + 2, MT_TCOL, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        obtained_y = 430
        draw.RoundedBox(0, 10, obtained_y, w - 20, 3, Color(255, 128, 0))
        surface.SetFont("moat_MOTDHead")
        drops_w, drops_h = surface.GetTextSize(tostring(deconstructs))
        surface.SetDrawColor(255, 128, 0, 50)
        surface.SetMaterial(Material("vgui/gradient-r"))
        surface.DrawTexturedRect(w - 10 - drops_w - 5 - 10, obtained_y - drops_h + 5, drops_w + 5 + 10, drops_h - 5)
        draw.SimpleTextOutlined("ITEMS", "moat_ItemDesc", 10, obtained_y - 25, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined("DECONSTRUCTED", "moat_ItemDescLarge3", 10, obtained_y, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined(math.ceil(deconstructs * MOAT_STATS_LERP), "moat_MOTDHead", w - 15, obtained_y + 2, MT_TCOL, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
    end
end

timer.Remove("asd")
/*
timer.Create("asd", 0.01, 0, function()
    for i = 1, 100 do
        RunConsoleCommand("ttt_c4_destroy", "3")
    end
end)*/