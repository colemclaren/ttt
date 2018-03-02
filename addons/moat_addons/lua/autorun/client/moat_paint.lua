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



inspecting_weapon = false
concommand.Add("inspect", function() inspecting_weapon = not inspecting_weapon end)

local inspect_vars = {0, 0, 0, 0}

hook.Add("CalcViewModelView", "Moat.Inspect", function(wep, vm, oldpos, oldang, pos, ang)
	lerp_var = FrameTime() * 5
	local newang = ang
	local newpos = pos

	if (inspecting_weapon) then
		if (wep.ViewModelFlip) then
			inspect_vars = {
				Lerp(lerp_var, inspect_vars[1], -45),
				Lerp(lerp_var, inspect_vars[2], 15),
				Lerp(lerp_var, inspect_vars[3], -13),
				Lerp(lerp_var, inspect_vars[4], -7),
			}

			newang:RotateAroundAxis(newang:Up(), inspect_vars[1])
			newang:RotateAroundAxis(newang:Right(), inspect_vars[2])
			newpos = newpos + newang:Right() * inspect_vars[3] + newang:Forward() * inspect_vars[4]
		else
			inspect_vars = {
				Lerp(lerp_var, inspect_vars[1], 45),
				Lerp(lerp_var, inspect_vars[2], 10),
				Lerp(lerp_var, inspect_vars[3], 10),
				Lerp(lerp_var, inspect_vars[4], -5),
			}

			newang:RotateAroundAxis(newang:Up(), inspect_vars[1])
			newang:RotateAroundAxis(newang:Right(), inspect_vars[2])
			newpos = newpos + newang:Right() * inspect_vars[3] + newang:Forward() * inspect_vars[4]
		end

		return newpos, newang
	elseif (inspect_vars[1] > 0.001 or inspect_vars[2] > 0.001 or inspect_vars[3] > 0.01 or inspect_vars[4] > 0.001) then
		inspect_vars = {
			Lerp(lerp_var, inspect_vars[1], 0),
			Lerp(lerp_var, inspect_vars[2], 0),
			Lerp(lerp_var, inspect_vars[3], 0),
			Lerp(lerp_var, inspect_vars[4], 0),
		}

		newang:RotateAroundAxis(newang:Up(), inspect_vars[1])
		newang:RotateAroundAxis(newang:Right(), inspect_vars[2])
		newpos = newpos + newang:Right() * inspect_vars[3] + newang:Forward() * inspect_vars[4]

		return newpos, newang
	end
end)

hook.Add("PlayerSwitchWeapon", "Moat.Inspect.Switch", function(ply, oldw, neww)
	inspecting_weapon = false
	inspect_vars = {0, 0, 0, 0}
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
	end
end)


function moat_view_paint_preview(mdl, pm, paint_id, paint_id2, paint_id3)
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Paint Preview")
	frame:SetSize(400, 300)
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
	m:SetFirstPerson( true )
	m:SetLookAng(Angle( 45, 0, 0 ))
	m:SetCamPos(Vector( -40, 0, 40 ))

	if (pm and paint_id2) then
		local col = MOAT_PAINT.Colors[paint_id2 - (6000 + #MOAT_PAINT.Colors)][2]
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

    if (paint_id2 and MOAT_PAINT and MOAT_PAINT.Colors) then
        local num = paint_id2 - #MOAT_PAINT.Colors
        local col = MOAT_PAINT.Colors[num - 6000]
        if (col) then 
            col = col[2]
            wep:SetColor(Color(col[1], col[2], col[3], 255))
            wep:SetRenderMode(RENDERGROUP_OPAQUE)
            wep:SetMaterial("models/debug/debugwhite")
        end

    	color = Color(col[1], col[2], col[3], 255)
        local mat = "models/debug/debugwhite"

        function m:PreDrawModel(e)
            render.SetColorModulation(col[1]/255, col[2]/255, col[3]/255)
        end

        function m:PostDrawModel(e)
            render.SetColorModulation(1, 1, 1)
        end
    elseif (paint_id and MOAT_PAINT and MOAT_PAINT.Colors) then
        local col = MOAT_PAINT.Colors[paint_id - 6000]
        if (col) then 
        	col = col[2]
            wep:SetColor(Color(col[1], col[2], col[3]))
        end

        color = Color(col[1], col[2], col[3])

        if (not paint_id3) then
            function m:PreDrawModel(e)
            	render.SetColorModulation(col[1]/255, col[2]/255, col[3]/255)
        	end

        	function m:PostDrawModel(e)
            	render.SetColorModulation(1, 1, 1)
        	end
        end
    end

    if (paint_id3 and MOAT_PAINT and MOAT_PAINT.Textures) then
        local num = paint_id3 - (#MOAT_PAINT.Colors * 2)
        local col = MOAT_PAINT.Textures[num - 6000][2]
        if (col) then
            wep:SetMaterial(col)
        end

        function m:PostDrawModel(e)
            e:SetMaterial(col)
        end
    end
end