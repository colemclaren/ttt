
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

local Loadout = {
	CurLoadout = "Default",
	Loadouts = {
		["Default"] = {}
	}
}
local loaded = false



function m_SwitchLoadout(name)
	if name == Loadout.CurLoadout then return end
	if not Loadout.Loadouts[name] then return end
	Loadout.CurLoadout = name
	local t = {}
	LOAD_BLOCK = CurTime() + 0.25
	for k,v in ipairs(m_Loadout) do
		if v.c then
			local i = M_LOAD_SLOT[k]
			for _,o in ipairs(m_Inventory) do
				if (not o.c) and (not t[_]) and (not t[v.c]) then
					m_SwapInventorySlots(i,_,nil)
					t[_] = true
					t[v.c] = true
				end
			end
		end
	end

	for k,v in ipairs(m_Inventory) do
		if v.c then
			for i,o in pairs(Loadout.Loadouts[name]) do
				if v.c == o then
					 m_SwapInventorySlots(M_INV_SLOT[k], i .. "l", nil)
				end
			end
		end
	end
end

function m_SaveLoadout()
	Loadout.Loadouts[Loadout.CurLoadout] = {}
	for k,v in pairs(m_Loadout) do
		if v.c then
			Loadout.Loadouts[Loadout.CurLoadout][k] = v.c
		end
	end
	file.Write("moat_loadouts.txt",util.TableToJSON(Loadout))
end

function m_RenameLoadout(cur,new)
	if cur == "Default" then return "You cannot rename the Default loadout!" end
	if Loadout.Loadouts[new] then return "A loadout with that name already exists!" end
	if cur == Loadout.CurLoadout then
		Loadout.CurLoadout = cur
	end
	Loadout.Loadouts[new] = table.Copy(Loadout.Loadouts[cur])
	Loadout.Loadouts[cur] = nil
	m_SaveLoadout()
end

function m_NewLoadout(name)
	if Loadout.Loadouts[name] then return "A loadout with that name already exists!" end
	Loadout.Loadouts[name] = {}
end

function m_DeleteLoadout(name)
	if name == "Default" then
		return "You cannot delete the default loadout!"
	end
	m_SwitchLoadout("Default")
	Loadout.Loadouts[name] = nil
	timer.Simple(0.1,function()
		m_SaveLoadout()
	end)
end

local function LoadFromLoadout()
	Loadout = {
		CurLoadout = "Default",
		Loadouts = {
			["Default"] = {}
		}
	}
	for k,v in pairs(m_Loadout) do
		if v.c then
			Loadout.Loadouts["Default"][k] = v.c
		end
	end
end

local gradient_r = Material("vgui/gradient-r")
function m_PopulateStats(pnl)
	if not loaded then
		if file.Exists("moat_loadouts.txt", "DATA") then
			local saved = util.JSONToTable(file.Read("moat_loadouts.txt","DATA"))
			if (saved) then
				Loadout = saved
			else
				file.Delete("moat_loadouts.txt") // Corrupted or something???
				LoadFromLoadout()
			end
		else
			LoadFromLoadout()
		end

		loaded = true
	end

    local level = LocalPlayer():GetNW2Int("MOAT_STATS_LVL", 0)
    local xp = LocalPlayer():GetNW2Int("MOAT_STATS_XP", 0)
    local drops = LocalPlayer():GetNW2Int("MOAT_STATS_DROPS", 0)
    local deconstructs = LocalPlayer():GetNW2Int("MOAT_STATS_DECONSTRUCTS", 0)
    local kills = LocalPlayer():GetNW2Int("MOAT_STATS_KILLS", 0)
    local deaths = LocalPlayer():GetNW2Int("MOAT_STATS_DEATHS", 0)
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
        surface.SetMaterial(gradient_r)
        surface.DrawTexturedRect(w - 10 - drops_w - 5 - 10, obtained_y - drops_h + 5, drops_w + 5 + 10, drops_h - 5)
        draw.SimpleTextOutlined("ITEMS", "moat_ItemDesc", 10, obtained_y - 25, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined("OBTAINED", "moat_ItemDescLarge3", 10, obtained_y, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined(math.ceil(drops * MOAT_STATS_LERP), "moat_MOTDHead", w - 15, obtained_y + 2, MT_TCOL, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        obtained_y = 430
        draw.RoundedBox(0, 10, obtained_y, w - 20, 3, Color(255, 128, 0))
        surface.SetFont("moat_MOTDHead")
        drops_w, drops_h = surface.GetTextSize(tostring(deconstructs))
        surface.SetDrawColor(255, 128, 0, 50)
        surface.SetMaterial(gradient_r)
        surface.DrawTexturedRect(w - 10 - drops_w - 5 - 10, obtained_y - drops_h + 5, drops_w + 5 + 10, drops_h - 5)
        draw.SimpleTextOutlined("ITEMS", "moat_ItemDesc", 10, obtained_y - 25, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined("DECONSTRUCTED", "moat_ItemDescLarge3", 10, obtained_y, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
		draw.SimpleTextOutlined("LOADOUT", "moat_ItemDescLarge3", 10, obtained_y + 35, MT_TCOL, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
        draw.SimpleTextOutlined(math.ceil(deconstructs * MOAT_STATS_LERP), "moat_MOTDHead", w - 15, obtained_y + 2, MT_TCOL, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 25))
    end

	local load = vgui.Create("DComboBox",pnl)
	load:SetPos(10,465)
	load:SetSize(352,25)
	local function refresh()
		load:Clear()
		if (not Loadout or not Loadout.Loadouts) then return end
		
		for k,v in pairs(Loadout.Loadouts) do
			load:AddChoice(k,k,(Loadout.CurLoadout == k))
		end
	end
	refresh()
	load.OnSelect = function( panel, index, value )
		m_SwitchLoadout(value)
	end

	local delete = vgui.Create("DButton",pnl)
	delete:SetPos(10,493)
	delete:SetSize(170,20)
	delete:SetText("Delete Loadout")
	function delete.DoClick()
		Derma_Query("Are you sure you want to delete the '" .. Loadout.CurLoadout .. "' loadout?", "Confirm", "Yes", function()
			local t = m_DeleteLoadout(Loadout.CurLoadout)
			if t then
				chat.AddText(Color(255,0,0),t)
			end
			timer.Simple(0.1,function()
				refresh()
			end)
		end, "No")
	end

	local delete = vgui.Create("DButton",pnl)
	delete:SetPos(191,493)
	delete:SetSize(170,20)
	delete:SetText("New Loadout")
	function delete.DoClick()
		Derma_StringRequest("Name required", "What would you like to name the new loadout?", "Default", function(s)
			local t = m_NewLoadout(s)
			if t then
				chat.AddText(Color(255,0,0),t)
			end
			timer.Simple(0.1,function()
				refresh()
			end)
		end)
	end
end

timer.Remove("asd")
/*
timer.Create("asd", 0.01, 0, function()
    for i = 1, 100 do
        RunConsoleCommand("ttt_c4_destroy", "3")
    end
end)*/