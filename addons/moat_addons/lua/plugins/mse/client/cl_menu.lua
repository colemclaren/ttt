local math 				= math
local table 			= table
local draw 				= draw
local IsValid 			= IsValid
local CurTime 			= CurTime
local player = player
local player_GetBySteamID = player.GetBySteamID
local math_min = math.min
local draw_SimpleText = draw.SimpleText
local surface_DrawRect = surface.DrawRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local render_UpdateScreenEffectTexture = render.UpdateScreenEffectTexture
local ScrW = ScrW
local ScrH = ScrH

MSE.Menu = MSE.Menu or {}
MSE.Menu.Config = {
	FrameW = 275
}

local blur = Material("pp/blurscreen")
function MSE.Menu:Blur(panel, amount) -- Thanks nutscript
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface_SetDrawColor(255, 255, 255)
	surface_SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render_UpdateScreenEffectTexture()
		surface_DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

function MSE.Menu:ButtonThink(s, k)
	if (s:IsHovered() or (k and self.SelectedCommand == k)) then s.hl = Lerp(FrameTime() * 8, s.hl, 1) else s.hl = Lerp(FrameTime() * 8, s.hl, 0) end
end

function MSE.Menu:BuildStartButton(n)
	self.s = vgui.Create("DButton", self.f)
	self.s:SetTall(40)
	self.s:Dock(TOP)
	self.s:SetText("")
	self.s.hl = 0
	self.s.Paint = function(s, w, h)
		if (s:GetDisabled()) then
			surface_SetDrawColor(50 * s.hl, 255 * s.hl, 50 * s.hl, 150 + (50 * s.hl), 50)
			surface_DrawRect(0, 0, w, h)
			surface_SetDrawColor(50, 255, 50, 50)
        	surface_DrawOutlinedRect(0, 0, w, h)
		else
			surface_SetDrawColor(50 * s.hl, 255 * s.hl, 50 * s.hl, 150 + (50 * s.hl))
			surface_DrawRect(0, 0, w, h)
			surface_SetDrawColor(50, 255, 50)
        	surface_DrawOutlinedRect(0, 0, w, h)
       	end
       	
		draw_SimpleText("Start Event", "Trebuchet24", w/2, h/2, Color(50 + (205 * s.hl), 255, 50 + (205 * s.hl), s:GetDisabled() and 50 or 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	self.s.Think = function(s) self:ButtonThink(s) /*local ec = LocalPlayer():GetDataVar("EC") or 0 if (ec < 1 and not MSE.Config.Staff[LocalPlayer():GetUserGroup()]) then s.hl = 0 s:SetDisabled(true) else s:SetDisabled(false) end*/ end
    self.s.DoClick = function(s)
    	net.Start("MSE.Start")
		net.WriteString(n)

		local strs = {}
		for i = 1, #self.SelectedArgs do
			local str, d = self.SelectedArgs[i]:GetSelected()
			if (str == "self") then str = LocalPlayer():SteamID() end
			if (d and d:StartWith("STEAM_0:")) then str = d end
			if (not str or (str and (str == "" or #str < 2))) then continue end
			
			table.insert(strs, str)
		end

		net.WriteUInt(#strs, 4)
		for i = 1, #strs do
			net.WriteString(strs[i])
		end
		net.SendToServer()

    	self.f:SizeTo(0, ScrH(), 0.1, 0, -1, function(a, f) f:Remove() end)
    end
end

function MSE.Menu:BuildEventOptions(n)
	if (IsValid(self.s)) then self.s:Remove() end
	if (IsValid(self.d)) then self.d:Remove() end
	if (IsValid(self.l)) then self.l:Remove() end

	for i = 1, #self.o do
		if (IsValid(self.o[i])) then self.o[i]:Remove() end
	end
	
	local cmd_tbl = MSE.Commands.Stored[n]

	self.d = vgui.Create("DLabel", self.f)
	self.d:SetText(cmd_tbl.Desc or "")
	self.d:SetFont("Trebuchet18")
	self.d:SetTextColor(Color(255, 255, 255, 255))
	self.d:SetWrap(true)
	self.d:SetAutoStretchVertical(true)
	self.d:Dock(TOP)
	self.d:DockMargin(0, 0, 0, 10)

	if (not cmd_tbl.Arguments) then self:BuildStartButton(n) return end
	
	for i = 1, #cmd_tbl.Arguments do
		local lbl, nec, tbl = cmd_tbl.Arguments[i](LocalPlayer())

		self.o[i] = vgui.Create("DPanel", self.f)
		self.o[i]:Dock(TOP)
		self.o[i]:SetTall(70)
		self.o[i]:DockMargin(0, 0, 0, 10)
		self.o[i].Paint = function(s, w, h)
			surface_SetDrawColor(51, 153, 255)
        	surface_DrawOutlinedRect(0, 0, w, h)

        	draw_SimpleText(lbl, "Trebuchet24", 10, 5, Color(255, 255, 255, 255))
        	draw_SimpleText(nec and "Required Argument" or "Not Required", "Trebuchet18", 10, 25, nec and Color(255, 50, 50, 255) or Color(255, 255, 255, 255))
		end

		self.cs = vgui.Create("DComboBox", self.o[i])
		self.cs:Dock(BOTTOM)

		for _ = 1, #tbl do
			-- automatically parse steamid's
			local pl, d = player_GetBySteamID(tbl[_])
			if (pl) then d = tbl[_] tbl[_] = pl:Nick() end
			
			self.cs:AddChoice(tbl[_], d)

			if (_ == 1 and nec) then
				self.cs:ChooseOption(tbl[_], 1)
			end
		end

		table.insert(self.SelectedArgs, self.cs)
	end

	self:BuildStartButton(n)

	self.l = vgui.Create("DLabel", self.f)
	self.l:SetText("You can only start an event during the preparing phase!")
	self.l:SetFont("Trebuchet18")
	self.l:SetTextColor(Color(255, 50, 50, 255))
	self.l:SetWrap(true)
	self.l:SetAutoStretchVertical(true)
	self.l:Dock(TOP)
	self.l:DockMargin(0, 10, 0, 10)
end

function MSE.Menu:EventSelected(n)
	self.SelectedArgs = {}

	if (self.SelectedCommand ~= n and self.SelectedCommand ~= "") then
		--self.f:SizeTo(self.Config.FrameW, ScrH(), 0.1, 0, -1, function(a, p)
		--	self.f:SizeTo(self.Config.FrameW * 2, ScrH(), 0.1)
			self:BuildEventOptions(n)
		--end)
	else
		self.f:SizeTo(self.Config.FrameW * 2, ScrH(), 0.1)
		self:BuildEventOptions(n)
	end

	self.SelectedCommand = n
end

function MSE.Menu:Open()
	if (IsValid(self.f)) then self.f:Remove() return end
	
	self.SelectedCommand = ""
	self.SelectedArgs = {}
	self.o = {}

	if (ScrH() < 900) then self.tiny = true else self.tiny = false end

	self.f = vgui.Create("DFrame")
	self.f:SetPos(0, 0)
	self.f:SetSize(0, ScrH())
	self.f:MakePopup()
	self.f:SetTitle ""
	self.f:DockPadding(self.Config.FrameW + 25, 135, 25, 25)
	self.f:ShowCloseButton(false)
	self.f:SetKeyboardInputEnabled(false)
	self.f.Think = function(s) end -- lets it go out bounds
	self.f.Paint = function(s, w, h)
		self:Blur(s, 3)

		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)
	end

	self.f:SizeTo(self.Config.FrameW, ScrH(), 0.1)

	self.p = vgui.Create("DPanel", self.f)
	self.p:SetPos(0, 0)
	self.p:DockPadding(25, 165, 25, 25)
	self.p:SetSize(self.Config.FrameW, ScrH())
	self.p.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)

		draw_SimpleText("Event Menu", "DermaLarge", math_min(w, self.Config.FrameW)/2, 50, Color(MSE.Colors.Blue.r, MSE.Colors.Blue.g, MSE.Colors.Blue.b, 255), TEXT_ALIGN_CENTER)
		draw_SimpleText("Select an Event", "DermaLarge", math_min(w, self.Config.FrameW)/2, 90, Color(MSE.Colors.White.r, MSE.Colors.White.g, MSE.Colors.White.b, 255), TEXT_ALIGN_CENTER)

		local ec = LocalPlayer():GetDataVar("EC") or "0"

		draw_SimpleText("Event Credits: " .. ec, "Trebuchet24", math_min(w, self.Config.FrameW)/2, 128, Color(MSE.Colors.White.r, MSE.Colors.White.g, MSE.Colors.White.b, 255), TEXT_ALIGN_CENTER)
	end

	self.n = vgui.Create("DLabel", self.p)
	self.n:SetText("You can purchase event credits on our credit store. Interns can also start events after their cooldown is over.")
	self.n:SetFont("Trebuchet18")
	self.n:SetTextColor(Color(50, 255, 50, 255))
	self.n:SetWrap(true)
	self.n:SetAutoStretchVertical(true)
	self.n:SetContentAlignment(5)
	self.n:Dock(TOP)
	self.n:DockMargin(0, 0, 0, 10)

	self.c = vgui.Create("DButton", self.p)
	self.c:SetTall(self.tiny and 24 or 40)
	self.c:Dock(BOTTOM)
	self.c:SetText("")
	self.c.hl = 0
	self.c.Paint = function(s, w, h)
		surface_SetDrawColor(255 * s.hl, 50 * s.hl, 50 * s.hl, 150 + (50 * s.hl))
		surface_DrawRect(0, 0, w, h)
		surface_SetDrawColor(255, 50, 50)
        surface_DrawOutlinedRect(0, 0, w, h)

		draw_SimpleText("Close", self.tiny and "Trebuchet18" or "Trebuchet24", w/2, h/2, Color(255, 50 + (205 * s.hl), 50 + (205 * s.hl)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	self.c.Think = function(s) self:ButtonThink(s) end
    self.c.DoClick = function(s)
    	self.f:SizeTo(0, ScrH(), 0.1, 0, -1, function(a, f) f:Remove() end)
    end

    for k, v in pairs(MSE.Commands.Stored) do
    	self.b = vgui.Create("DButton", self.p)
		self.b:SetTall(self.tiny and 24 or 40)
		self.b:DockMargin(0, 0, 0, self.tiny and 5 or 10)
		self.b:Dock(TOP)
		self.b:SetText("")
		self.b.hl = 0
		self.b.Paint = function(s, w, h)
			surface_SetDrawColor(51 * s.hl, 153 * s.hl, 255 * s.hl, 150 + (50 * s.hl))
			surface_DrawRect(0, 0, w, h)
			surface_SetDrawColor(51, 153, 255)
        	surface_DrawOutlinedRect(0, 0, w, h)

			draw_SimpleText(k, self.tiny and "Trebuchet18" or "Trebuchet24", w/2, h/2, Color(51 + (204 * s.hl), 153 + (102 * s.hl), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		self.b.Think = function(s) self:ButtonThink(s, k) end
    	self.b.DoClick = function(s)
    		self:EventSelected(k)
    	end
    end
end

net.Receive("MSE.Menu", function() MSE.Menu:Open() end)