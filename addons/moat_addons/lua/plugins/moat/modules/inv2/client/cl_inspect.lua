/*MOAT_PAINT = MOAT_PAINT or {}
MOAT_PAINT.Cache = {
	Painted = false,
	Wpn = nil,
	Mats = {},
	Skip = {},
	MatNum = 0
}

local ENTITY = FindMetaTable("Entity")
local IMATERIAL = FindMetaTable("IMaterial")
local vector = Vector
local set_vector = IMATERIAL.SetVector
local mat = Material
local getmats = ENTITY.GetMaterials
local reg = vector(1, 1, 1)

function MOAT_PAINT:UnPaint()
	for i = 1, self.Cache.MatNum do
		if (self.Cache.Skip[i]) then continue end
		if (not self.Cache.Mats[i] or not self.Cache.Mats[i].Mat) then continue end

		set_vector(self.Cache.Mats[i].Mat, "$color2", reg)

		if (self.Cache.Mats[i].Texture) then self.Cache.Mats[i].Mat:SetTexture("$basetexture", self.Cache.Mats[i].Texture) end
		if (self.Cache.Mats[i].EnvMap) then self.Cache.Mats[i].Mat:SetTexture("$envmap", self.Cache.Mats[i].EnvMap) end
		if (self.Cache.Mats[i].EnvMap2) then self.Cache.Mats[i].Mat:SetTexture("$envmapmask", self.Cache.Mats[i].EnvMap2) end
	end

	self.Cache.Mats = {}
	self.Cache.Skip = {}
	self.Cache.MatNum = 0
	self.Cache.Painted = false
	self.Cache.Wpn = nil
end

function MOAT_PAINT.ApplyPaint(vm, pl, wpn)
	if (not MOAT_PAINT) then return end
	if (MOAT_PAINT.Cache.Painted) then
		if (wpn and MOAT_PAINT.Cache.Wpn ~= wpn) then
			MOAT_PAINT:UnPaint()
		end

		return
	end

	if (not wpn or not wpn.ItemStats) then return end
	if (not wpn.ItemStats.p and not wpn.ItemStats.p2 and not wpn.ItemStats.p3) then return end

	local m = getmats(wpn)
	local p = 255


	if (wpn.ItemStats.p2) then
		p = MOAT_PAINT.Colors[(wpn.ItemStats.p2 - #MOAT_PAINT.Colors) - 6000][2]
	elseif (wpn.ItemStats.p) then
		p = MOAT_PAINT.Colors[wpn.ItemStats.p - 6000][2]
	end
	

	local n = #m

	MOAT_PAINT.Cache.MatNum = n
	for i = 1, n do
		MOAT_PAINT.Cache.Mats[i] = {}
		MOAT_PAINT.Cache.Mats[i].Mat = mat(m[i])
		if (m[i]:find("hand") or m[i]:find("scope") or m[i]:find("accessories") or 
			m[i]:find("arrow") or m[i]:find("box") or m[i]:find("belt") or
			m[i]:find("stock") or m[i]:find("shell") or m[i]:find("screen") or m[i]:find("error") or m[i]:find("12gauge")) then MOAT_PAINT.Cache.Skip[i] = true continue end

		MOAT_PAINT.Cache.Mats[i].Texture = MOAT_PAINT.Cache.Mats[i].Mat:GetTexture("$basetexture")
		MOAT_PAINT.Cache.Mats[i].EnvMap = MOAT_PAINT.Cache.Mats[i].Mat:GetTexture("$envmap")
		MOAT_PAINT.Cache.Mats[i].EnvMap2 = MOAT_PAINT.Cache.Mats[i].Mat:GetTexture("$envmapmask")

		if (wpn.ItemStats.p3) then
			local t = MOAT_PAINT.Textures[(wpn.ItemStats.p3 - (#MOAT_PAINT.Colors * 2)) - 6000]
			MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$basetexture", t[2])
			MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmapmask", t[2])
			MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmap", t[2])
		end

		if (wpn.ItemStats.p2) then
			MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$basetexture", "models/debug/debugwhite")
			MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmapmask", "models/debug/debugwhite")
			MOAT_PAINT.Cache.Mats[i].Mat:SetTexture("$envmap", "models/debug/debugwhite")

			set_vector(MOAT_PAINT.Cache.Mats[i].Mat, "$color2", vector(p[1]/255, p[2]/255, p[3]/255))
		elseif (wpn.ItemStats.p) then
			set_vector(MOAT_PAINT.Cache.Mats[i].Mat, "$color2", vector(p[1]/255, p[2]/255, p[3]/255))
		end
	end
	MOAT_PAINT.Cache.Wpn = wpn.Weapon
	MOAT_PAINT.Cache.Painted = true
end
hook.Add("PreDrawViewModel", "MOAT_PAINT.ApplyPaint", MOAT_PAINT.ApplyPaint)*/

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

if (IsValid(MOAT_INSPECT_BG)) then MOAT_INSPECT_BG:Remove() end

-- lua_run_cl vm = LocalPlayer():GetViewModel() for k, v in pairs(vm:GetAttachments()) do print(v.name, v.id) PrintTable(vm:GetAttachment(k)) end
local inspect_attach, att_cache = {1, 2, 3, "muzzle", "muzzle_flash"}
local inspecting_weapon, inspecting_flip, inspecting_stats = false, false
hook.Add("HUDPaint", "Inspect.Paint", function()
	if (inspecting_weapon and inspecting_stats and IsValid(MOAT_ITEM_STATS) and MOAT_ITEM_STATS.StatTbl and MOAT_ITEM_STATS.StatTbl == inspecting_stats) then
		local vm = LocalPlayer():GetViewModel()
		if (not IsValid(vm)) then
			return
		end

		local att = att_cache and vm:GetAttachment(att_cache)
		if (not att) then
			for k, v in ipairs(inspect_attach) do
				local num = isstring(v) and vm:LookupAttachment(v) or v
				if (vm:GetAttachment(num)) then
					att = vm:GetAttachment(num)
					att_cache = num

					break
				end
			end
		end

		if (not att) then
			return
		end

		local pw, ph = MOAT_ITEM_STATS:GetSize()
		local cx, cy = MOAT_ITEM_STATS:GetPos()
		local af, ar, au, p, a = 0, 0, 0, att.Pos, att.Ang

		p = p - (a:Forward() * 0) + (a:Right() * 0) + (a:Up() * 0)
		p = p:ToScreen()
		p.y = p.y - ph

		p.x = math.Clamp(p.x, 0, ScrW())
		p.y = math.Clamp(p.y, 0, ScrH() - ph)

		if (not MOAT_ITEM_STATS.Inspect) then
			MOAT_ITEM_STATS.Inspect = {p.x, p.y, p.x, p.y, 1, 1}
			MOAT_ITEM_STATS:SetPos(p.x, p.y)
			return
		else
			MOAT_ITEM_STATS.Inspect[5] = Lerp(FrameTime() * 5, MOAT_ITEM_STATS.Inspect[5], MOAT_ITEM_STATS.Inspect[1]/p.x)
			MOAT_ITEM_STATS.Inspect[6] = Lerp(FrameTime() * 5, MOAT_ITEM_STATS.Inspect[6], MOAT_ITEM_STATS.Inspect[2]/p.y)
			
			MOAT_ITEM_STATS.Inspect[1] = Lerp(FrameTime() * 5, MOAT_ITEM_STATS.Inspect[1], p.x)
			MOAT_ITEM_STATS.Inspect[2] = Lerp(FrameTime() * 5, MOAT_ITEM_STATS.Inspect[2], p.y)

			MOAT_ITEM_STATS.Inspect[3] = Lerp(FrameTime() * 5, MOAT_ITEM_STATS.Inspect[3], p.x - pw)
			MOAT_ITEM_STATS.Inspect[4] = Lerp(FrameTime() * 5, MOAT_ITEM_STATS.Inspect[4], p.y)
		end

		local sx, sy = MOAT_ITEM_STATS.Inspect[3] - (math.Clamp(1 - MOAT_ITEM_STATS.Inspect[5], -1, 1) * 50), MOAT_ITEM_STATS.Inspect[4] - (math.Clamp(1 - MOAT_ITEM_STATS.Inspect[6], -1, 1) * 50)	
		local sx, sy = sx, p.y

		MOAT_ITEM_STATS:SetPos(sx, sy)
		--print(MOAT_ITEM_STATS.Inspect[1], MOAT_ITEM_STATS.Inspect[2], MOAT_ITEM_STATS.Inspect[3], MOAT_ITEM_STATS.Inspect[4], MOAT_ITEM_STATS.Inspect[5], MOAT_ITEM_STATS.Inspect[6], sx, sy)

		/*
		local p, off = {
			{x = sx, y = sy},
			{x = sx + pw, y = sy},
			{x = px, y = py},
			{x = sx, y = sy + ph},
			a = MOAT_ITEM_STATS:GetAlpha()
		}, 0
		
		surface.SetDrawColor(22, 25, 30, 200 * (p.a/255))
		draw.NoTexture()
		surface.DrawPoly({
			{x = sx + off, y = sy + off},
			{x = sx + pw - off, y = sy + off},
			{x = px - off, y = py - off},
			{x = sx + off, y = sy + ph - off}
		})
		*/
	end
end)

local function create_inspect_bg(tbl)
	MOAT_INSPECT_BG = vgui.Create("DFrame")
	MOAT_INSPECT_BG:SetTitle("")
	MOAT_INSPECT_BG:ShowCloseButton(false)
	MOAT_INSPECT_BG:SetPos(ScrW() - 50 - 275 - 15, 50 - 15)
	MOAT_INSPECT_BG:SetSize(275 + 30, 150 + 30)
	MOAT_INSPECT_BG.Think = function(s, w, h)
		if (IsValid(MOAT_ITEM_STATS) and MOAT_ITEM_STATS.StatTbl and MOAT_ITEM_STATS.StatTbl == tbl) then
			local pw, ph = MOAT_ITEM_STATS:GetSize()
			local sx, sy = MOAT_ITEM_STATS:GetPos()
			local px, py = pw - ScrW(), 50
			local vm = LocalPlayer():GetViewModel()
			s:SetSize(pw + 30, ph + 30)
	
			if (vm) then
				local b = vm:GetAttachment(1) or vm:GetAttachment("1") or vm:GetAttachment(2) or vm:GetAttachment(vm:LookupAttachment "muzzle") or vm:GetAttachment(vm:LookupAttachment "muzzle_flash")
				if (b) then
					local pos, ang = b.Pos, b.Ang
					pos = (pos - (ang:Forward() * 0) + ang:Right() * 0 + ang:Up() * 0)
					pos = pos:ToScreen()

					px = pos.x
					py = pos.y - ph
				end
			end

			if (MOAT_ITEM_STATS:GetAlpha() >= 245) then
				MOAT_ITEM_STATS:SetPos(Lerp(FrameTime() * 10, sx, px), Lerp(FrameTime() * 10, sy, py))
			else
				MOAT_ITEM_STATS:SetPos(Lerp(FrameTime() * 30, sx, px), Lerp(FrameTime() * 30, sy, py))
			end

			s:SetPos(px - 15, py - 15)
		else
			MOAT_INSPECT_BG:Remove()
			return
		end
	end
	MOAT_INSPECT_BG.Paint = function(s, w, h)
		--DrawBlur(s, 5) 32, 34, 37
		surface.SetDrawColor(32, 34, 37, 255)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(47, 49, 54, 255)
		surface.DrawRect(10, 10, w - 20, h - 20)

		DisableClipping(true)

		surface.SetDrawColor(32, 34, 37, 255)
		draw.NoTexture()
		surface.DrawPoly({
			{x = w/8, y = h},
			{x = (w/8) * 7, y = h},
			{x = -25, y = h + 75},
		})

		surface.SetDrawColor(47, 49, 54, 255)
		surface.DrawPoly({
			{x = (w/8) + 30, y = h - 15},
			{x = ((w/8) * 7) + 10, y = h - 15},
			{x = -25 + 32, y = h + 75 - 20},
		})

		DisableClipping(false)
	end
end

concommand.Add("inspect", function()
	inspecting_weapon = not inspecting_weapon

	if (GetConVar("moat_inspect_stats"):GetInt() ~= 1) then
		return
	end

	if (not inspecting_weapon) then
		m_DrawFoundItem({}, "remove_inspect")
		if (IsValid(MOAT_INSPECT_BG)) then MOAT_INSPECT_BG:Remove() end	
		return
	end

	if (not IsValid(LocalPlayer())) then return end
	local wep = LocalPlayer():GetActiveWeapon()
	if (not IsValid(wep) or not wep.ItemStats or not wep.ItemStats.item) then return end

	inspecting_stats = wep.ItemStats
	inspecting_flip = wep.ViewModelFlip

	m_DrawFoundItem(wep.ItemStats, "inspect")
end)

local inspect_vars = {0, 0, 0, 0}
local AnimInfo = {
	Current = {0, 0, 0, 0},
	Step = 1,
	[1] = {
		{-45, 15, -13, -7},
		{45, 10, 10, -5}
	}
}

hook.Add("CalcViewModelView", "Moat.Inspect", function(wep, vm, oldpos, oldang, pos, ang)
	local na, np, flip, lv = ang, pos, wep.ViewModelFlip and 1 or 2, FrameTime() * 5

	if (inspecting_weapon or AnimInfo.Current[1] > 0.001 or AnimInfo.Current[2] > 0.001 or AnimInfo.Current[3] > 0.001 or AnimInfo.Current[4] > 0.001) then
		AnimInfo.Current = {
			Lerp(lv, AnimInfo.Current[1], inspecting_weapon and AnimInfo[AnimInfo.Step][flip][1] or 0),
			Lerp(lv, AnimInfo.Current[2], inspecting_weapon and AnimInfo[AnimInfo.Step][flip][2] or 0),
			Lerp(lv, AnimInfo.Current[3], inspecting_weapon and AnimInfo[AnimInfo.Step][flip][3] or 0),
			Lerp(lv, AnimInfo.Current[4], inspecting_weapon and AnimInfo[AnimInfo.Step][flip][4] or 0)
		}

		na:RotateAroundAxis(na:Up(), AnimInfo.Current[1])
		na:RotateAroundAxis(na:Right(), AnimInfo.Current[2])
		np = np + na:Right() * AnimInfo.Current[3] + na:Forward() * AnimInfo.Current[4]

		return np, na
	end
end)

hook.Add("PlayerSwitchWeapon", "Moat.Inspect.Switch", function(ply, oldw, neww)
	inspecting_weapon = false
	inspect_vars = {0, 0, 0, 0}

	if (GetConVar("moat_inspect_stats"):GetInt() == 1) then
		m_DrawFoundItem({}, "remove_inspect")
	end
end)

local stop_keys = {
	[IN_ATTACK] = true,
	[IN_RELOAD] = true,
	[IN_ATTACK2] = true,
	[IN_GRENADE1] = true,
	[IN_GRENADE2] = true
}

hook.Add("KeyPress", "Moat.Inspect.Cmd", function(ply, key)
	if ((inspecting_weapon or (inspect_vars[1] > 0.001 or inspect_vars[2] > 0.001 or inspect_vars[3] > 0.01 or inspect_vars[4] > 0.001)) and (stop_keys[key])) then
		inspecting_weapon = false
		inspect_vars = {0, 0, 0, 0}

		if (GetConVar("moat_inspect_stats"):GetInt() == 1) then
			m_DrawFoundItem({}, "remove_inspect")
		end
	end
end)


function moat_view_paint_preview(mdl, pm, paint_id, paint_id2, paint_id3)
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Paint Preview")
	frame:SetSize(500, 450)
	frame:MakePopup()
	frame:Center()
	frame:DoModal(true)
	frame:SetBackgroundBlur(true)
	frame.PaintOver = function(s, w, h)
		DisableClipping(true)
			draw.SimpleText("Hold Right Click with [W] [S] [A] [D] to move camera!", "GModNotify", w/2, h + 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			draw.SimpleText("While holding, [SPACE] and [CTRL] move the camera up/down.", "GModNotify", w/2, h + 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		DisableClipping(false)
	end

	local p = vgui.Create("DPanel", frame)
	p:Dock(FILL)

	local m = vgui.Create("DAdjustableModelPanel", p)
	m:Dock(FILL)
	m:SetModel(mdl)
	m:Refresh()

	if (not m.Entity) then -- they don't have the model I guess
		m:SetModel("models/props_junk/PlasticCrate01a.mdl")
		m:Refresh()
	end

	m:SetFirstPerson( true )
	m:SetLookAng(Angle( 45, 0, 0 ))
	m:SetCamPos(Vector( -40, 0, 40 ))

	if (pm and paint_id2) then
		local col = MOAT_PAINT.Paints[paint_id2][2]
		function m.Entity:GetPlayerColor() return Vector(col[1]/255, col[2]/255, col[3]/255) end

		function m:PreDrawModel(e)
            render.SetColorModulation(col[1]/255, col[2]/255, col[3]/255)
        end

        function m:PostDrawModel(e)
            render.SetColorModulation(1, 1, 1)
        end

		m.Entity:SetColor(Color(col[1], col[2], col[3]))

		m:SetLookAng(Angle( 45, 0, 0 ))
		m:SetCamPos(Vector( -100, 0, 100 ))
		return
	end

    local color = nil
    local wep = m.Entity

    if (wep.WElements or wep.Offset) then
        wep.OldDrawWorldModel = wep.DrawWorldModel
    end

    if (paint_id2 and MOAT_PAINT and MOAT_PAINT.Paints) then
        local col, dream = MOAT_PAINT.Paints[paint_id2]
        if (col) then
			if (col.Dream) then
				dream = true
			end

            col = col[2]

            wep:SetColor(Color(col[1], col[2], col[3], 255))
            wep:SetRenderMode(RENDERGROUP_OPAQUE)
            wep:SetMaterial("models/debug/debugwhite")
        end

    	color = Color(col[1], col[2], col[3], 255)
        local mat = "models/debug/debugwhite"

        function m:PreDrawModel(e)
            if (dream) then
				render.SetColorModulation(rarity_names[9][2].r/255, rarity_names[9][2].g/255, rarity_names[9][2].b/255)
			else
				render.SetColorModulation(col[1]/255, col[2]/255, col[3]/255)
			end
        end

        function m:PostDrawModel(e)
            render.SetColorModulation(1, 1, 1)
        end
    elseif (paint_id and MOAT_PAINT and MOAT_PAINT.Tints) then
        local col, dream = MOAT_PAINT.Tints[paint_id]
        if (col) then
			if (col.Dream) then
				dream = true
				col = {rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b}
			else
				col = col[2]
			end

			wep:SetColor(Color(col[1], col[2], col[3]))
        end

        color = Color(col[1], col[2], col[3])

        if (not paint_id3) then
            function m:PreDrawModel(e)
				if (dream) then
					render.SetColorModulation(rarity_names[9][2].r/255, rarity_names[9][2].g/255, rarity_names[9][2].b/255)
				else
					render.SetColorModulation(col[1]/255, col[2]/255, col[3]/255)
				end
			end

        	function m:PostDrawModel(e)
            	render.SetColorModulation(1, 1, 1)
        	end
        end
    end

    if (paint_id3 and MOAT_PAINT and MOAT_PAINT.Skins and MOAT_PAINT.Skins[paint_id3]) then
		local mat_str, name_str, new_mat = MOAT_PAINT.Skins[paint_id3][2], MOAT_PAINT.Skins[paint_id3][1]
		/*if (mat_str:match "^http") then
			new_mat = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
				["$model"] = 1,
                ["$alphatest"] = 1,
                ["$vertexcolor"] = 1,
                ["$basetexture"] = "error"
            })

			local function set(im)
				new_mat:SetTexture("$basetexture", im:GetTexture("$basetexture"))
			end

			local im = cdn.Image(mat_str, set)
			if (im) then
				set(im)
			end
		else
			new_mat = Material(mat_str)
		end*/

		if (mat_str:match "^http") then
			new_mat = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
				["$model"] = 1,
                ["$alphatest"] = 1,
                ["$vertexcolor"] = 1,
                ["$basetexture"] = "error"
            })

			if (mat_str:match "vtf$") then
				local function set(m)
					new_mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
				end

				local m = cdn.Texture(mat_str, set)
				if (m) then
					set(m)
				end
			else
				local function set(m)
					new_mat:SetTexture("$basetexture", (type(m) ~= "string") and m:GetTexture "$basetexture" or m)
				end

				local m = cdn.Image(mat_str, set)
				if (m) then
					set(m)
				end
			end
		else
			new_mat = Material(mat_str)
		end

		function m:PreDrawModel(e)
			PrePaintViewModel(e, paint_id3)
        end

		function m:PostDrawModel(e)
			PostPaintViewModel(e, paint_id3)
        end
	end
end