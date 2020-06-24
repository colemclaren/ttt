/*MOAT_DISABLE_HUD = GetConVar("moat_DisableCustomHUD"):GetInt() == 1

local disabled_elements = {
	["TTTInfoPanel"] = true
}

hook.Add("HUDShouldDraw", "moat_DisableDefaultElements", function(element)
	if (MOAT_DISABLE_HUD) then return end

	if (disabled_elements[element]) then return false end
end)*/

local MenuColors = {
	Text = Color(154, 156, 160, 255),
	Disabled = Color(128, 128, 128, 255),
	Border = Color(42, 43, 46, 255),
	Menu = Color(24, 25, 28, 255),
	Hover = Color(4, 4, 5, 255),
	TextHover = Color(246, 246, 246, 255)
}

local surface = surface
local draw = draw
local math = math
--local string = string
local vgui = vgui
local math              = math
local table             = table
local draw              = draw
local team              = team
local IsValid           = IsValid
local CurTime           = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = emoji.SimpleTextOutlined
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
local gradient_u = Material("vgui/gradient-u")

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

MOAT_EDITING_HUD = false

local roundstate_string = {
	[1] = "round_wait",
	[2] = "round_prep",
	[3] = "round_active",
	[4] = "round_post"
}

local bg_colors = {
	background_main = Color(0, 0, 10, 200),
	noround = Color(100, 100, 100, 200),
	traitor = Color(200, 25, 25, 200),
	innocent = Color(25, 200, 25, 200),
	detective = Color(25, 25, 200, 200),
}

local moat_HUDConvars = {
	["HUD_WeaponFrame"] = {false, false, false, false},
	["HUD_HealthBox"] = {false, false, false, false},
	["HUD_RoleBox"] = {false, false, false, false}
}

local moving_frame = ""

function moat_AddMovableBox(convarname, x, y, w, h, paint)
	-- Create x, y, w, h values for convar saving
	if (not ConVarExists(convarname .. "x")) then
		CreateClientConVar(convarname .. "x", x, true)
	end

	if (not ConVarExists(convarname .. "y")) then
		CreateClientConVar(convarname .. "y", y, true)
	end

	if (not ConVarExists(convarname .. "w")) then
		CreateClientConVar(convarname .. "w", w, true)
	end

	if (not ConVarExists(convarname .. "h")) then
		CreateClientConVar(convarname .. "h", h, true)
	end

	local x, y, w, h = GetConVar(convarname .. "x"):GetInt(), GetConVar(convarname .. "y"):GetInt(), GetConVar(convarname .. "w"):GetInt(), GetConVar(convarname .. "h"):GetInt()

	if (MOAT_EDITING_HUD) then
		local mx, my = gui.MousePos()
		local mouse_down = input.IsMouseDown(MOUSE_LEFT)
		local shift_down = input.IsShiftDown()
		surface_SetDrawColor(Color(255, 0, 0))

		if (mx >= x - 10 and mx <= x + 10 and my >= y - 10 and my <= y + 10) then
			surface_DrawLine(x - 20, y, x + 20, y)
			surface_DrawLine(x, y - 20, x, y + 20)

			if (mouse_down) then
				moving_frame = convarname
				moat_HUDConvars[convarname][1] = true
			end
		elseif (mx >= x + w - 10 and mx <= x + w + 10 and my >= y + h - 10 and my <= y + h + 10) then
			surface_DrawLine(x + w - 20, y + h, x + w + 20, y + h)
			surface_DrawLine(x + w, y + h - 20, x + w, y + h + 20)

			if (mouse_down) then
				moving_frame = convarname
				moat_HUDConvars[convarname][2] = true
			end
		end

		if (mouse_down and moving_frame == convarname) then
			if (moat_HUDConvars[convarname][1]) then
				GetConVar(convarname .. "x"):SetInt(mx)
				GetConVar(convarname .. "y"):SetInt(my)
			elseif (moat_HUDConvars[convarname][2]) then
				GetConVar(convarname .. "w"):SetInt(mx - x)
				GetConVar(convarname .. "h"):SetInt(my - y)
			end
		else
			if (moat_HUDConvars[convarname][1]) then
				moat_HUDConvars[convarname][1] = false
			end

			if (moat_HUDConvars[convarname][2]) then
				moat_HUDConvars[convarname][2] = false
			end
		end
	end

	return GetConVar(convarname .. "x"):GetInt(), GetConVar(convarname .. "y"):GetInt(), GetConVar(convarname .. "w"):GetInt(), GetConVar(convarname .. "h"):GetInt()
end

local moat_HUDConvarStrings = {}

function moat_HUDConvarsCreate(convarname, default)
	if (not ConVarExists(convarname)) then
		CreateClientConVar(convarname, default, true)
	end

	table.insert(moat_HUDConvarStrings, {convarname, default})
end

moat_HUDConvarsCreate("moat_HUDHealth", "TimeLeft")
moat_HUDConvarsCreate("moat_HUDHealthShowString", "true")
moat_HUDConvarsCreate("moat_HUDWeaponCollapse", "false")
moat_HUDConvarsCreate("moat_HUDWeaponRarity", "true")
moat_HUDConvarsCreate("moat_HUDRoleSnap", "true")
moat_HUDConvarsCreate("moat_HUDHealthSnapToAmmo", "true")
moat_HUDConvarsCreate("moat_HUDRoleColor", "false")

function moat_HUDMenuBar()
	if (IsValid(MOAT_HUDMENU)) then
		MOAT_HUDMENU:Remove()

		return
	end

	MOAT_HUDMENU = vgui.Create("DMenuBar")
	MOAT_HUDMENU:SetPos(0, 0)
	MOAT_HUDMENU:SetSize(ScrW(), 25)
	local RESETHUD = MOAT_HUDMENU:AddMenu("Reset HUD")
	RESETHUD:AddOption("No", function() end)

	RESETHUD:AddOption("Yes", function()
		RunConsoleCommand("moat_resethud")
	end)

	local AMMOE = MOAT_HUDMENU:AddMenu("Weapon Element")

	AMMOE:AddOption("Toggle Collapse Upwards", function()
		local convar = GetConVar("moat_HUDWeaponCollapse")

		if (convar:GetString() == "true") then
			convar:SetString("false")
		else
			convar:SetString("true")
		end
	end)

	AMMOE:AddOption("Toggle Show Weapon Rarity", function()
		local convar = GetConVar("moat_HUDWeaponRarity")

		if (convar:GetString() == "true") then
			convar:SetString("false")
		else
			convar:SetString("true")
		end
	end)

	local HEALTHE = MOAT_HUDMENU:AddMenu("Health Element")

	HEALTHE:AddOption("Toggle Snap to Weapon Element", function()
		local convar = GetConVar("moat_HUDHealthSnapToAmmo")

		if (convar:GetString() == "true") then
			convar:SetString("false")
		else
			convar:SetString("true")
		end
	end)

	HEALTHE:AddOption("Font: Default", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("TimeLeft")
	end)

	HEALTHE:AddOption("Font: DermaLarge", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("DermaLarge")
	end)

	HEALTHE:AddOption("Font: Trebuchet24", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("Trebuchet24")
	end)

	HEALTHE:AddOption("Font: Trebuchet22", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("Trebuchet22")
	end)

	HEALTHE:AddOption("Font: Trebuchet18", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("Trebuchet18")
	end)

	HEALTHE:AddOption("Font: ChatFont", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("ChatFont")
	end)

	HEALTHE:AddOption("Font: CloseCaption_Normal", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("CloseCaption_Normal")
	end)

	HEALTHE:AddOption("Font: CloseCaption_Bold", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("CloseCaption_Bold")
	end)

	HEALTHE:AddOption("Font: HudHintTextLarge", function()
		local convar = GetConVar("moat_HUDHealth")
		convar:SetString("HudHintTextLarge")
	end)

	HEALTHE:AddOption("Toggle Health: String", function()
		local convar = GetConVar("moat_HUDHealthShowString")

		if (convar:GetString() == "true") then
			convar:SetString("false")
		else
			convar:SetString("true")
		end
	end)

	local ROLEE = MOAT_HUDMENU:AddMenu("Role Element")

	ROLEE:AddOption("Toggle Snap to Weapon Element", function()
		local convar = GetConVar("moat_HUDRoleSnap")

		if (convar:GetString() == "true") then
			convar:SetString("false")
		else
			convar:SetString("true")
		end
	end)

	ROLEE:AddOption("Set text color of role to role color", function()
		local convar = GetConVar("moat_HUDRoleColor")

		if (convar:GetString() == "true") then
			convar:SetString("false")
		else
			convar:SetString("true")
		end
	end)
end


local PanelMeta = FindMetaTable("Panel")

-- for buttons
function PanelMeta:ApplyMGTheme(btn_col)
	self.StoredText = self:GetText()
	self:SetText("")
	self.LerpNum = 0

	self.Paint = function(s, w, h)
		if (s:IsHovered() and not s:GetDisabled()) then
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
		else
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
		end

		surface_SetDrawColor((btn_col and btn_col.r or 51) * s.LerpNum, (btn_col and btn_col.g or 153) * s.LerpNum, (btn_col and btn_col.b or 255) * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

		surface_SetDrawColor((s:GetDisabled() and 150) or (btn_col and btn_col.r) or 51, (s:GetDisabled() and 150) or  (btn_col and btn_col.g) or 153, (s:GetDisabled() and 150) or (btn_col and btn_col.b) or 255, (s:GetDisabled() and 150) or 255)
		surface_DrawOutlinedRect(0, 0, w, h)

		draw_SimpleTextOutlined(self.StoredText, "DermaLargeSmall", w/2, (h/2) - 1, s:GetDisabled() and Color(255, 255, 255, 50) or MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MGA.Colors.Shadow)
	end

	self.OnCursorEntered = function(s)
		if (not s:GetDisabled()) then surface.PlaySound("ui/buttonrollover.wav") end
	end

	local doclick = self.DoClick

	self.DoClick = function(s)
		doclick(s)
		surface.PlaySound("ui/buttonclickrelease.wav")
	end
end

-- for sheets
function PanelMeta:ApplyMGThemeSheet(btn_col)
	self.LerpNum = 0

	self.Paint = function(s, w, h)
		surface_SetDrawColor((btn_col and btn_col.r or 51) * s.LerpNum, (btn_col and btn_col.g or 153) * s.LerpNum, (btn_col and btn_col.b or 255) * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

		surface_SetDrawColor((btn_col and btn_col.r) or 51, (btn_col and btn_col.g) or 153, (btn_col and btn_col.b) or 255, 255)
		surface_DrawOutlinedRect(0, 0, w, h)
	end

	for k, v in pairs(self.Items) do
		if (!v.Tab) then continue end
	
		v.Tab.Paint = function(s, w, h)
			draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))

			if (self:GetActiveTab() == v.Tab) then
				draw_RoundedBox(0, 0, 20, w, 1, Color(51, 153, 255, 255))
			end
		end
	end
end

function PanelMeta:ApplyMGThemePanel(btn_col)
	self.LerpNum = 0

	self.Paint = function(s, w, h)
		surface_SetDrawColor((btn_col and btn_col.r or 51) * s.LerpNum, (btn_col and btn_col.g or 153) * s.LerpNum, (btn_col and btn_col.b or 255) * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)
	end

	self.PaintOver = function(s, w, h)
		surface_SetDrawColor(51, 153, 255, 255)
		surface_DrawOutlinedRect(0, 0, w, h)
	end
end

function PanelMeta:ApplyMGThemeSheetCustom(btn_col)
	self.LerpNum = 0

	self.Paint = function(s, w, h)
		surface_SetDrawColor((btn_col and btn_col.r or 51) * s.LerpNum, (btn_col and btn_col.g or 153) * s.LerpNum, (btn_col and btn_col.b or 255) * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

		surface_SetDrawColor(183, 183, 183, 255)
		surface_DrawRect(1, 21, w - 2, h - 22)

		surface_SetDrawColor((btn_col and btn_col.r) or 51, (btn_col and btn_col.g) or 153, (btn_col and btn_col.b) or 255, 255)
		surface_DrawOutlinedRect(0, 0, w, h)
	end

	for k, v in pairs(self.Items) do
		if (!v.Tab) then continue end
	
		v.Tab.Paint = function(s, w, h)
			draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))

			if (self:GetActiveTab() == v.Tab) then
				draw_RoundedBox(0, 0, 20, w, 1, Color(51, 153, 255, 255))
			end
		end
	end
end

-- for frames
function PanelMeta:ApplyMGThemeFrame()
	self.StoredTitle = self.lblTitle:GetText()/*:GetText()*/

	self:ShowCloseButton(false)
	self:SetTitle("")
	self.Paint = function(s, w, h)
	  surface_SetDrawColor(0, 0, 0, 50)
	  surface_DrawRect(0, 0, w, h)

	  DrawBlur(s, 3)

	  surface_SetDrawColor(183, 183, 183)
	  surface_DrawLine(0, 1, w, 1)
	  surface_DrawLine(0, h - 1, w, h - 1)

	  draw_SimpleTextOutlined(self.StoredTitle, "moat_ChatFont", 5, 5, MGA.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA.Colors.Shadow)
   end

	local dframec = vgui.Create("DButton", self)
   dframec:SetPos(self:GetWide() - 20, 0)
   dframec:SetSize(20, 20)
   dframec:SetText("")
   dframec.Paint = function(s, w, h)
	  draw_SimpleTextOutlined("r", "marlett", w/2, h/2, s:IsHovered() and Color(255, 100, 100) or MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA.Colors.Shadow)
   end
   dframec.DoClick = function(s)
	  self:Close()
   end
end

local m_LoadoutTypes = {}
m_LoadoutTypes[0] = "Melee"
m_LoadoutTypes[1] = "Secondary"
m_LoadoutTypes[2] = "Primary"

-- Default GetAmmo function in TTT
local function GetAmmo(ply)
	local weap = ply:GetActiveWeapon()
	if not weap or not ply:Alive() then return -1 end
	local ammo_inv = weap:Ammo1() or 0
	local ammo_clip = weap:Clip1() or 0
	local ammo_max = weap.Primary.ClipSize or 0

	return ammo_clip, ammo_max, ammo_inv
end

local TryTranslation = nil
local GetLang = nil

function moat_LoadLanguage()
	if (LANG and LANG.TryTranslation and LANG.GetUnsafeLanguageTable) then
		TryTranslation = LANG.TryTranslation
		GetLang = LANG.GetUnsafeLanguageTable
	else
		timer.Simple(1, function()
			TryTranslation = LANG.TryTranslation
			GetLang = LANG.GetUnsafeLanguageTable
		end)
	end
end

moat_LoadLanguage()
local ammo_width = 150 - 12
local health_width = 0
local LP

local gradient_d = Material("vgui/gradient-d")
local function moat_CustomHUD()
	LP = LocalPlayer()
	if (GetConVar("moat_DisableCustomHUD"):GetInt() ~= 0) then return end

	--if (false) then moat_hud2.DrawHUD(LP) return end
	if ((not LP:Alive()) or LP:Team() == TEAM_SPEC) then return end

	if (MOAT_EDITING_HUD) then
		local m_GridSize = ScrH() / 100
		surface_SetDrawColor(255, 255, 255, 50)

		for i = m_GridSize, ScrW(), m_GridSize do
			surface_DrawLine(i, 0, i, ScrH())
			surface_DrawLine(0, i, ScrW(), i)
		end

		surface_SetDrawColor(255, 0, 0, 200)
		surface_DrawLine(ScrW() / 2, 0, ScrW() / 2, ScrH())
		surface_DrawLine(0, ScrH() / 2, ScrW(), ScrH() / 2)

		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(40, 40, 800, 135)

		draw_SimpleTextOutlined("You are in the HUD edit mode :ok_hand:. You can only edit your HUD while you are alive.", "moat_Medium4", 50, 50, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		draw_SimpleTextOutlined("You can leave this mode by pressing F6.", "moat_Medium4", 50, 70, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		draw_SimpleTextOutlined("You can move HUD objects by clicking a dragging the TOP LEFT of the object.", "moat_Medium4", 50, 90, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		draw_SimpleTextOutlined("You can size HUD objects by clicking and dragging the BOTTOM RIGHT of the object.", "moat_Medium4", 50, 110, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		draw_SimpleTextOutlined("You can RESET the HUD by clicking the menu bar at the top left and selecting the reset button.", "moat_Medium4", 50, 130, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		draw_SimpleTextOutlined("Some objects are snapped to other objects, in which case you have to unsnap them using the menu bar!", "moat_Medium4", 50, 150, Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
	end

	-- Ammo Panel
	local FRAME_INFO = {
		x = 20,
		h = 100,
		w = 310,
		y = ScrH() - 20
	}

	FRAME_INFO.y = FRAME_INFO.y - FRAME_INFO.h
	local x = FRAME_INFO.x
	local y = FRAME_INFO.y
	local w = FRAME_INFO.w
	local h = FRAME_INFO.h
	local x, y, w, h = moat_AddMovableBox("HUD_WeaponFrame", x, y, w, h)
	local wpn = LP:GetActiveWeapon()

	if (not IsValid(wpn) and LP:HasWeapon("weapon_ttt_unarmed")) then
		RunConsoleCommand("use", "weapon_ttt_unarmed")
	end

	if (wpn) then
		if (wpn.Primary) then
			local ammo_clip, ammo_max, ammo_inv = GetAmmo(LP)

			if (ammo_clip == -1) then
				h = h - 46

				if (GetConVar("moat_HUDWeaponCollapse"):GetString() == "false") then
					y = y + 46
				end
			end
		end

		local ammo_yoff = y

		if (wpn.ItemStats and wpn.ItemStats.item) then
			local wpn_stats = wpn.ItemStats
			local ITEM_NAME_FULL = GetItemName(wpn.ItemStats) or "Holstered"
			
			surface.SetFont "moat_Medium5"
			local namew = surface.GetTextSize(ITEM_NAME_FULL)
			local namesize = 0

			if (wpn_stats.s and wpn_stats.s.l) then
                surface_SetFont("moat_ItemDescLarge3")
                local level_w, level_h = surface_GetTextSize(wpn_stats.s.l)
                surface_SetFont("moat_ItemDescSmall2")
                local namew2, nameh2 = surface_GetTextSize("XP: " .. wpn_stats.s.x .. "/" .. (wpn_stats.s.l * 100))
                namesize = namew2 + level_w
            end
			
			w = math.max(namew + namesize + 32 + 10, 310, w)

			if (w % 2 ~= 0) then
				w = w + 1
			end

			local num_stats = 0

			if (wpn_stats.s) then
				num_stats = table.Count(wpn_stats.s)
			end

			if (wpn_stats.s and wpn_stats.s.l) then
				draw_xp_lvl = 9
			else
				draw_xp_lvl = 3
			end

			ammo_yoff = y + 44 + draw_xp_lvl

			if (GetConVar("moat_HUDWeaponRarity"):GetString() == "false") then
				h = h - 25
				y = y + 25
				ammo_yoff = y + 22 + draw_xp_lvl
			end

			surface_SetDrawColor(100, 100, 100, 50)
			surface_DrawOutlinedRect(x, y, math.max(namew + draw_xp_lvl + 32 + 10, w), h)
			draw_RoundedBox(0, x + 1, y + 1, w - 2, h - 2, Color(15, 15, 15, 250))

			if (GetConVar("moat_HUDWeaponRarity"):GetString() == "true") then
				surface_SetDrawColor(Color(100, 100, 100, 50))
				surface_DrawLine(x + 6, y + 22 + draw_xp_lvl, x + w - 6, y + 22 + draw_xp_lvl)
				surface_DrawLine(x + 6, y + 43 + draw_xp_lvl, x + w - 6, y + 43 + draw_xp_lvl)
				surface_SetDrawColor(Color(0, 0, 0, 100))
				surface_DrawLine(x + 6, y + 23 + draw_xp_lvl, x + w - 6, y + 23 + draw_xp_lvl)
				surface_DrawLine(x + 6, y + 44 + draw_xp_lvl, x + w - 6, y + 44 + draw_xp_lvl)
				surface_SetDrawColor(rarity_gradient[wpn_stats.item.Rarity].r, rarity_gradient[wpn_stats.item.Rarity].g, rarity_gradient[wpn_stats.item.Rarity].b, rarity_gradient[wpn_stats.item.Rarity].a)
				local grad_x = x + 1
				local grad_y = y + 25 + draw_xp_lvl
				local grad_w = (w - 2) / 2
				local grad_h = 16
				local grad_x2 = x + 1 + ((w - 2) / 2) + (((w - 2) / 2) / 2)
				local grad_y2 = y + 25 + (grad_h / 2) + draw_xp_lvl
				surface_SetMaterial(gradient_r)
				surface_DrawTexturedRect(grad_x, grad_y, grad_w, grad_h)
				surface_SetMaterial(gradient_r)
				surface_DrawTexturedRectRotated(grad_x2, grad_y2, grad_w, grad_h, 180)
				surface_SetMaterial(gradient_d)
				surface_SetDrawColor(Color(rarity_names[wpn_stats.item.Rarity][2].r, rarity_names[wpn_stats.item.Rarity][2].g, rarity_names[wpn_stats.item.Rarity][2].b, 100))
				--surface_DrawTexturedRect( 1, 1 + ( h / 2 ), w - 2, ( h / 2 ) - 2 )
				local RARITY_TEXT = ""

				if (wpn_stats.item.Kind ~= "tier") then
					RARITY_TEXT = rarity_names[wpn_stats.item.Rarity][1] .. " " .. wpn_stats.item.Kind
				elseif (wpn_stats and wpn_stats.item and wpn_stats.item.Rarity and rarity_names[wpn_stats.item.Rarity][1] and wpn.Slot and m_LoadoutTypes[wpn.Slot]) then
					RARITY_TEXT = rarity_names[wpn_stats.item.Rarity][1] .. " " .. m_LoadoutTypes[wpn.Slot]
				end

				grad_y2 = grad_y2 - 1

            	for i = 1, 2 do
					draw_SimpleText(RARITY_TEXT, "moat_Medium4s", x + grad_w + i, grad_y2 + i, rarity_shadow[wpn_stats.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, true)
					draw_SimpleText(RARITY_TEXT, "moat_Medium4s", x + grad_w - i, grad_y2 - i, rarity_shadow[wpn_stats.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, true)
					draw_SimpleText(RARITY_TEXT, "moat_Medium4s", x + grad_w + i, grad_y2 - i, rarity_shadow[wpn_stats.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, true)
					draw_SimpleText(RARITY_TEXT, "moat_Medium4s", x + grad_w - i, grad_y2 + i, rarity_shadow[wpn_stats.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, true)
				end

				emoji.SimpleText(RARITY_TEXT, "moat_Medium4", x + grad_w, grad_y2, rarity_accents[wpn_stats.item.Rarity], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			local draw_name_x = x + 7
			local draw_name_y = y + 3
			local name_col = wpn_stats.item.NameColor or rarity_names[wpn_stats.item.Rarity][2]:Copy()
			local name_font = "moat_Medium5"
			name_col.a = 255
			if (wpn_stats.item.NameEffect) then
				local tfx = wpn_stats.item.NameEffect

				if (tfx == "glow") then
					m_DrawGlowingText(false, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
				elseif (tfx == "fire") then
					m_DrawFireText(wpn_stats.item.Rarity, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
				elseif (tfx == "bounce") then
					m_DrawBouncingText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
				elseif (tfx == "enchanted") then
					m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, wpn_stats.item.NameEffectMods[1], nil, nil, true)
				elseif (tfx == "threecolors") then
					if (not wpn_stats.item.NameEffectMods[4]) then wpn_stats.item.NameEffectMods[4] = 1 end
					if (not wpn_stats.item.NameEffectMods[5]) then wpn_stats.item.NameEffectMods[5] = RealTime() end
					if (wpn_stats.item.NameEffectMods[5] <= RealTime()) then
						wpn_stats.item.NameEffectMods[4] = wpn_stats.item.NameEffectMods[4] + 1
						if (wpn_stats.item.NameEffectMods[4] > 3) then wpn_stats.item.NameEffectMods[4] = 1 end
						wpn_stats.item.NameEffectMods[5] = RealTime() + (FrameTime() * 5)
					end

					m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, wpn_stats.item.NameEffectMods[wpn_stats.item.NameEffectMods[4]], nil, nil, true)
				elseif (tfx == "electric") then
					m_DrawElecticText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, true)
				else
					emoji.SimpleText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
				end
			else
				emoji.SimpleText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
			end

			if (wpn_stats.s and wpn_stats.s.l) then
				m_DrawShadowedText(1, wpn_stats.s.l, "moat_ItemDescLarge3", x + w - 6, y, Color(240, 245, 253), TEXT_ALIGN_RIGHT)
				surface_SetFont("moat_ItemDescLarge3")
				local level_w, level_h = surface_GetTextSize(wpn_stats.s.l)
				m_DrawShadowedText(1, "LEVEL", "moat_ItemDesc", x + w - 6 - level_w, y + 4, Color(240, 245, 253), TEXT_ALIGN_RIGHT)
				m_DrawShadowedText(1, wpn_stats.s.x .. "/ " .. (wpn_stats.s.l * 100) .. " XP", "moat_ItemDescSmall2", x + w - 6 - level_w - 2, y + 16, Color(240, 245, 253), TEXT_ALIGN_RIGHT)
				draw_RoundedBox(0, x + 6, y + 27, w - 12, 2, Color(255, 255, 255, 20))
				local bar_width = w - 12
				local xp_bar_width = bar_width * (wpn_stats.s.x / (wpn_stats.s.l * 100))
				surface_SetDrawColor(Color(200, 200, 200, 255))
				surface_SetMaterial(gradient_r)
				surface_DrawTexturedRect(x + 7, y + 27, xp_bar_width, 2)
			end
		elseif (wpn.ItemName or wpn.PrintName) then
			h = h - 26

			if (GetConVar("moat_HUDWeaponCollapse"):GetString() == "false") then
				y = y + 26
			end

			surface_SetDrawColor(100, 100, 100, 50)
			surface_DrawOutlinedRect(x, y, w, h)
			draw_RoundedBox(0, x + 1, y + 1, w - 2, h - 2, Color(15, 15, 15, 250))
			local draw_name_x = x + 7
			local draw_name_y = y + 3
			local name_col = Color(240, 245, 253)
			local name_font = "moat_Medium5"
			local name = TryTranslation(wpn.ItemName or wpn.PrintName or "Holstered")
			m_DrawShadowedText(1, name, name_font, draw_name_x, draw_name_y, name_col)
		else
			return
		end

		if (wpn.Primary) then
			local ammo_clip, ammo_max, ammo_inv = GetAmmo(LP)

			if (ammo_clip ~= -1) then
				local ammo_y = ammo_yoff + 6
				local ammo_h = ammo_yoff - y

				if (wpn.ItemStats) then
					local wpn_stats = wpn.ItemStats

					if (wpn_stats.s and wpn_stats.s.l) then
						ammo_h = ammo_h
					else
						ammo_h = ammo_h + 12

						if (GetConVar("moat_HUDWeaponRarity"):GetString() == "false") then
							ammo_y = ammo_y - 5
							ammo_h = ammo_h + 5
						end
					end

					if (GetConVar("moat_HUDWeaponRarity"):GetString() == "true") then
						ammo_h = ammo_h - 18
					end
				else
					ammo_yoff = y + 22
					ammo_y = ammo_yoff + 6
					ammo_h = ammo_yoff - y + 18
				end

				draw_RoundedBox(0, x + 6, ammo_y, w - 12, ammo_h, Color(205, 155, 0, 20))
				local target = math.Clamp((ammo_clip / ammo_max) * (w - 12), 0, w - 12)
				ammo_width = Lerp(FrameTime() * 10, ammo_width, target)
				surface_SetDrawColor(Color(205, 155, 0, 255))
				surface_SetMaterial(gradient_r)
				surface_DrawTexturedRect(x + 6, ammo_y, ammo_width, ammo_h)
				local text = string.format("%i + %02i", ammo_clip, ammo_inv)
				draw_SimpleTextOutlined(text, "moat_ItemDescLarge3", x + 6 + w - 12 - 10, ammo_y + (ammo_h / 2) - 1, Color(240, 245, 253), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
			end
		end
	end

	local weapon_info = {
		x = x,
		y = y,
		w = w,
		h = h
	}

	-- Health Panel
	local FRAME_INFO2 = {
		x = (ScrW() / 2) - 310,
		h = 30,
		w = 600,
		y = ScrH() - 20
	}

	FRAME_INFO2.y = FRAME_INFO2.y - FRAME_INFO2.h
	local x = FRAME_INFO2.x
	local y = FRAME_INFO2.y
	local w = FRAME_INFO2.w
	local h = FRAME_INFO2.h
	local x, y, w, h = moat_AddMovableBox("HUD_HealthBox", x, y, w, h)

	if (GetConVar("moat_HUDHealthSnapToAmmo"):GetString() == "true") then
		FRAME_INFO2 = {
			x = weapon_info.x,
			h = 30,
			w = weapon_info.w,
			y = weapon_info.y
		}

		FRAME_INFO2.y = FRAME_INFO2.y - FRAME_INFO2.h
		x, y, w, h = FRAME_INFO2.x, FRAME_INFO2.y, FRAME_INFO2.w, FRAME_INFO2.h
	end

	local health_ratio = LP:Health() / LP:GetMaxHealth()
	health_ratio = math.Clamp(health_ratio, 0, 1)
	health_width = Lerp(FrameTime() * 10, health_width, (health_ratio) * (w - 2))
	local health_green = 255 * health_ratio
	local health_red = 255 - (255 * health_ratio)
	surface_SetDrawColor(50, 50, 50, 150)
	surface_DrawOutlinedRect(x, y, w, h)
	surface_SetDrawColor(0, 0, 0, 255)
	surface_DrawRect(x + 1, y + 1, w - 2, h - 2)
	surface_SetDrawColor(health_red / 5, health_green / 5, 0, 255)
	surface_DrawRect(x + 1, y + 1, w - 2, h - 2)
	surface_SetDrawColor(health_red, health_green, 0, 60)
	surface_SetMaterial(gradient_u)
	surface_DrawTexturedRect(x + 1, y + 1, health_width, h - 2)
	local font = GetConVar("moat_HUDHealth"):GetString()

	if (font == "Trebuchet24" or font == "CloseCaption_Normal" or font == "CloseCaption_Bold") then
		y = y - 2
	end

	if (font == "HudHintTextLarge" or font == "TimeLeft") then
		y = y - 1
	end

	local health_string = ""

	if (GetConVar("moat_HUDHealthShowString"):GetString() == "true") then
		health_string = "Health: "
	end

	local health_text = math.max(0, LP:Health())
	draw_SimpleTextOutlined(health_string .. health_text, font, x + (w / 2), y + (h / 2), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

	-- Role Panel
	local FRAME_INFO3 = {
		x = weapon_info.x,
		h = 30,
		w = weapon_info.w,
		y = weapon_info.y
	}

	FRAME_INFO3.y = FRAME_INFO3.y - FRAME_INFO3.h
	local x = FRAME_INFO3.x
	local y = FRAME_INFO3.y
	local w = FRAME_INFO3.w
	local h = FRAME_INFO3.h
	local x, y, w, h = moat_AddMovableBox("HUD_RoleBox", x, y, w, h)

	if (GetConVar("moat_HUDRoleSnap"):GetString() == "true") then
		if (GetConVar("moat_HUDHealthSnapToAmmo"):GetString() == "true") then
			x, y, w, h = FRAME_INFO3.x, FRAME_INFO3.y - 30, FRAME_INFO3.w, FRAME_INFO3.h
		else
			x, y, w, h = FRAME_INFO3.x, FRAME_INFO3.y, FRAME_INFO3.w, FRAME_INFO3.h
		end
	end

	local role_color = GetRoleColor(LP:GetRole()) or bg_colors.noround

	if (GAMEMODE.round_state ~= ROUND_ACTIVE) then
		role_color = bg_colors.noround
	end

	local L = GetLang()
	local role_text = ""

	if (GAMEMODE.round_state == ROUND_ACTIVE) then
		role_text = L[LP:GetRoleStringRaw()]
	else
		role_text = L[roundstate_string[GAMEMODE.round_state]]
	end

	surface_SetDrawColor(50, 50, 50, 150)
	surface_DrawOutlinedRect(x, y, w, h)
	surface_SetDrawColor(0, 0, 0, 255)
	surface_DrawRect(x + 1, y + 1, w - 2, h - 2)
	surface_SetDrawColor(role_color.r - 100, role_color.g - 100, role_color.b - 100, 60)
	surface_DrawRect(x + 1, y + 1, w - 2, h - 2)
	surface_SetDrawColor(role_color.r, role_color.g, role_color.b, 60)
	surface_SetMaterial(gradient_u)
	surface_DrawTexturedRect(x + 1, y + 1, w - 2, h - 2)
	local font = GetConVar("moat_HUDHealth"):GetString()

	if (font == "Trebuchet24" or font == "CloseCaption_Normal" or font == "CloseCaption_Bold") then
		y = y - 2
	end

	if (font == "HudHintTextLarge" or font == "TimeLeft") then
		y = y - 1
	end

	local roletext_color = Color(240, 245, 253)

	if (GetConVar("moat_HUDRoleColor"):GetString() == "true") then
		roletext_color = Color(role_color.r, role_color.g, role_color.b, 255)
	end

	draw.SimpleText(role_text, "TimeLeft", x + 10, y + (h / 2), roletext_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	local is_haste = HasteMode() and GAMEMODE.round_state == ROUND_ACTIVE
	local is_traitor = LP:IsActiveTraitor()
	local endtime = (GetRoundEnd and GetRoundEnd() or GetGlobal("ttt_round_end")) - CurTime()
	local text
	local font = "TimeLeft"
	local color =  Color(240, 245, 253)

	if (is_haste) then
		local hastetime = (GetHasteEnd and GetHasteEnd() or GetGlobal("ttt_haste_end", 0)) - CurTime()

		if (hastetime < 0) then
			if ((not is_traitor) or (math.ceil(CurTime()) % 7 <= 2)) then
				-- innocent or blinking "overtime"
				text = "OVERTIME"
				-- need to hack the position a little because of the font switch
				-- traitor and not blinking "overtime" right now, so standard endtime display
			else
				text = util.SimpleTime(math.max(0, endtime), "%02i:%02i")
				color = Color(255, 0, 0)
			end
			-- still in starting period
		else
			local t = hastetime

			if (is_traitor and math.ceil(CurTime()) % 6 < 2) then
				t = endtime
				color = Color(255, 0, 0)
			end

			text = util.SimpleTime(math.max(0, t), "%02i:%02i")
		end
		-- bog standard time when haste mode is off (or round not active)
	else
		text = util.SimpleTime(math.max(0, endtime), "%02i:%02i")
	end

	draw.SimpleText(text, "TimeLeft", x + w - 10, y + (h / 2), color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

hook.Add("HUDPaint", "moat_DrawCustomHUD", moat_CustomHUD)

concommand.Add("moat_edithud", function()
	if (GetConVar("moat_DisableCustomHUD"):GetInt() ~= 0) then return end

	if (MOAT_EDITING_HUD) then
		MOAT_EDITING_HUD = false
		moat_HUDMenuBar()
	else
		MOAT_EDITING_HUD = true
		moat_HUDMenuBar()
	end
end)

concommand.Add("moat_resethud", function()
	if (GetConVar("moat_DisableCustomHUD"):GetInt() ~= 0) then return end
	local panel_values = {"x", "y", "w", "h"}

	local FRAME_INFO = {
		["x"] = 20,
		["h"] = 100,
		["w"] = 310,
		["y"] = ScrH() - 20
	}

	FRAME_INFO["y"] = FRAME_INFO["y"] - FRAME_INFO["h"]

	local FRAME_INFO2 = {
		["x"] = (ScrW() / 2) - 310,
		["h"] = 30,
		["w"] = 600,
		["y"] = ScrH() - 20
	}

	FRAME_INFO2["y"] = FRAME_INFO2["y"] - FRAME_INFO2["h"]

	local FRAME_INFO3 = {
		["x"] = 20,
		["h"] = 30,
		["w"] = 310,
		["y"] = FRAME_INFO.y
	}

	FRAME_INFO3["y"] = FRAME_INFO3["y"] - FRAME_INFO3["h"]

	for k, v in pairs(moat_HUDConvars) do
		local tbl = FRAME_INFO

		if (k == "HUD_HealthBox") then
			tbl = FRAME_INFO2
		elseif (k == "HUD_RoleBox") then
			tbl = FRAME_INFO3
		end

		for k2, v2 in pairs(panel_values) do
			local convar = GetConVar(k .. v2)
			if (not convar) then
				CreateClientConVar(k .. v2, tbl[v2], true)
				continue
			end

			convar:SetInt(tbl[v2])
		end
	end

	for k, v in pairs(moat_HUDConvarStrings) do
		local convar = GetConVar(v[1])
		if (not convar) then
			CreateClientConVar(v[1], v[2], true)
			continue
		end

		convar:SetString(v[2])
	end

	if (IsValid(MOAT_HUDMENU)) then
		if (not MOAT_EDITING_HUD) then
			MOAT_HUDMENU:Remove()
		end
	end
end)

local moat_hud_cooldown = CurTime()

hook.Add("Think", "moat_EditHudHook", function()
	if (GetConVar("moat_DisableCustomHUD"):GetInt() ~= 0) then return end

	if (input.IsKeyDown(KEY_F6) and moat_hud_cooldown <= CurTime()) then
		MOAT_EDITING_HUD = not MOAT_EDITING_HUD
		gui.EnableScreenClicker(MOAT_EDITING_HUD)
		moat_HUDMenuBar()
		moat_hud_cooldown = CurTime() + 1
	end
end)



local moat_DrawHalos = CurTime() + 5

hook.Add("TTTBeginRound", "TOutLine", function()
	moat_DrawHalos = CurTime() + 4
end)


local player_GetAll = player.GetAll
local think_check = 0
local curtime = CurTime
local traitorColor = Color(137, 101, 224)
local jesterColor = Color(255, 0, 0)
local modJesterColor = Color(jesterColor.r / 255, jesterColor.g / 255, jesterColor.b / 255)
local modTraitorColor = Color(traitorColor.r / 255, traitorColor.g / 255, traitorColor.b / 255)
local function Moat_HUD_AddTHalos()
	if (not IsValid(LP) or not LP:GetTraitor()) then
		return
	end

	if (CurTime() > moat_DrawHalos and GetRoundState() == ROUND_ACTIVE and not GetGlobal("MOAT_MINIGAME_ACTIVE")) then
		local jesters_for_halo, players_for_halo, pc, jc = {}, {}, 0, 0

		for k, v in ipairs(player_GetAll()) do
			if (not IsValid(v) or (v == LP) or (not v:IsActiveTraitor() and not v:IsActiveRole(ROLE_JESTER))) then
				continue
			end

			
			if (v:IsActiveRole(ROLE_JESTER)) then
				jc = jc + 1
				jesters_for_halo[jc] = v

				continue
			end
	
			pc = pc + 1
			players_for_halo[pc] = v
		end
		
		if (pc > 0) then
			halo.Add(players_for_halo, traitorColor, 1, 1, 1, true, true)
		end

		if (jc > 0) then
			halo.Add(jesters_for_halo, jesterColor, 1, 1, 1, true, true)
		end
	end
end

local function complementColor(color, add)
	return color + add <= 255 and color + add or color + add - 255
end

local mat = CreateMaterial("Moat.HUD.Mat", "VertexLitGeneric", {["$basetexture"] = "models/debug/debugwhite", ["$model"] = 1, ["$ignorez"] = 1})
local function Moat_HUD_AddTChams()
	if (not IsValid(LP) or not LP:GetTraitor()) then
		return
	end
	
	if (GetRoundState() == ROUND_ACTIVE and not GetGlobal("MOAT_MINIGAME_ACTIVE")) then
		cam.Start3D()
			for k, v in pairs(player_GetAll()) do
				if (not IsValid(v) or (v == LP) or (not v:IsActiveTraitor() and not v:IsActiveRole(ROLE_JESTER))) then
					continue
				end

				if (v:IsActiveRole(ROLE_JESTER)) then
					render.SuppressEngineLighting(true)

					render.SetColorModulation(modJesterColor.r, modJesterColor.g, modJesterColor.b)
					render.MaterialOverride(mat)
					v:DrawModel()

					if (IsValid(v:GetActiveWeapon())) then
						render.SetColorModulation(complementColor(jesterColor.r, 150) / 255, complementColor(jesterColor.g, 150) / 255, complementColor(jesterColor.b, 150) / 255)
						v:GetActiveWeapon():DrawModel()
					end
					
					render.SetColorModulation(modJesterColor.r, modJesterColor.g, modJesterColor.b)
					render.MaterialOverride()
					render.SetModelLighting(BOX_TOP, modJesterColor.r, modJesterColor.g, modJesterColor.b)
					v:DrawModel()

					render.SuppressEngineLighting(false)
				
					continue
				end

				render.SuppressEngineLighting(true)

				render.SetColorModulation(modTraitorColor.r, modTraitorColor.g, modTraitorColor.b)
				render.MaterialOverride(mat)
				v:DrawModel()

				if (IsValid(v:GetActiveWeapon())) then
					render.SetColorModulation(complementColor(traitorColor.r, 150) / 255, complementColor(traitorColor.g, 150) / 255, complementColor(traitorColor.b, 150) / 255)
					v:GetActiveWeapon():DrawModel()
				end
				
				render.SetColorModulation(modTraitorColor.r, modTraitorColor.g, modTraitorColor.b)
				render.MaterialOverride()
				render.SetModelLighting(BOX_TOP, modTraitorColor.r, modTraitorColor.g, modTraitorColor.b)
				v:DrawModel()

				render.SuppressEngineLighting(false)
			end
		cam.End3D()
	end
end


local function Moat_DrawPreDrawHalos()
	Moat_HUD_AddTHalos()
	Moat_Talents_PreDrawHalos()
	
	if (MOAT_CONTAGION_ROUND_ACTIVE) then
		MG_CG.InfectedHalos()
	end
end

local function Moat_DrawRenderScreenspaceEffects()
	Moat_HUD_AddTChams()
	Moat_Talents_RenderScreenspaceEffects()
	
	if (MOAT_CONTAGION_ROUND_ACTIVE) then
		MG_CG.InfectedChams()
	end
end


local function Moat_DrawOutline(new)
	hook.Remove("PreDrawHalos", "Moat_DrawOutline")
	hook.Remove("RenderScreenspaceEffects", "Moat_DrawOutline")
	
	if (new == "Halos") then
		hook.Add("PreDrawHalos", "Moat_DrawOutline", Moat_DrawPreDrawHalos)
	elseif (new == "Chams") then
		hook.Add("RenderScreenspaceEffects", "Moat_DrawOutline", Moat_DrawRenderScreenspaceEffects)
	end
end

cvars.AddChangeCallback("moat_OutlineTBuddies", function(cvar, old, new)
	Moat_DrawOutline(new)
end)
-- idk if this is needed but just to be sure
timer.Simple(5, function()
	local c = GetConVar("moat_OutlineTBuddies")
	if (IsValid(c)) then
		if (c:GetString() == "0" or c:GetString() == "1") then
			c:SetString("Halos")
		end
	end
end)



hook.Add("Think", "PlayerSightCheck", function()
	if (curtime() > think_check) then
		for k, v in ipairs(player_GetAll()) do
			if (not IsValid(v) or (v == LP) or (not v:Alive())) then continue end
		
			local cansee = v:CanView() and v:CanSee()
			v.PlayerVisible = cansee
		end

		think_check = curtime() + 0.1
	end
end)

local frozen_players = 0

net.Receive("FrozenPlayer", function()
	frozen_players = net.ReadUInt(8)
end)

local debugMaterial = Material('models/debug/debugwhite')
hook.Add('RenderScreenspaceEffects', 'moatFrostEffect', function()
	if (frozen_players < 1) then return end

	local self = LP
		
	cam.Start3D(EyePos(), EyeAngles())
	render.ClearStencil()
	render.SetStencilEnable(true)
			
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
	render.SetStencilReferenceValue(1)
			
	for _, ply in pairs(player_GetAll()) do
		if (ply:canBeMoatFrozen()) && (ply:GetNW2Bool('moatFrozen')) then
			render.SetBlend(0.2)
			render.SetColorModulation(0.85, 0.85, 1)
			render.MaterialOverride(debugMaterial)
			ply:DrawModel()
		end
	end
			
	render.MaterialOverride()
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilReferenceValue(1)          
	render.SetStencilEnable(false)
	cam.End3D()
end)