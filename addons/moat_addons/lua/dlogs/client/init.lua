CreateClientConVar("ttt_dmglogs_language", "english", FCVAR_ARCHIVE)
GetDMGLogLang = GetConVar("ttt_dmglogs_language"):GetString()

cvars.AddChangeCallback("ttt_dmglogs_language", function(convar_name, value_old, value_new)
	GetDMGLogLang = value_new
	net.Start("dlogs.SendLang")
	net.WriteString(value_new)
	net.SendToServer()
end)

local color_lightyellow = Color(255, 245, 148)
local color_red = Color(255, 62, 62)
local color_lightblue = Color(98, 176, 255)

local outdated = false

hook.Add("InitPostEntity", "dlogs_InitPostHTTP", function()
	net.Start("dlogs.SendLang")
	net.WriteString(GetDMGLogLang)
	net.SendToServer()
end)

function dlogs:OpenMenu()
	local x, y = 665, 680

	local show_outdated = outdated and GetConVar("ttt_dmglogs_updatenotifications"):GetBool()

	if show_outdated then
		y = y + 30
	end

	self.Menu = vgui.Create("DFrame")
	self.Menu:SetSize(x, y)
	self.Menu:SetTitle("TTT dlogs version " .. self.Version)
	self.Menu:SetDraggable(true)
	self.Menu:MakePopup()
	self.Menu:SetKeyboardInputEnabled(false)
	self.Menu:Center()
	self.Menu.AboutPos = 0
	self.Menu.AboutPosMax = 35
	self.Menu.AboutState = false

	self.Menu.About = function(self)
		self.AboutState = not self.AboutState
	end

	local old_think = self.Menu.Think

	self.Menu.Think = function(self)
		self.AboutMoving = true

		if self.AboutState and self.AboutPos < self.AboutPosMax then
			self.AboutPos = self.AboutPos + 15
		elseif not self.AboutState and self.AboutPos > 0 then
			self.AboutPos = self.AboutPos - 15
		else
			self.AboutMoving = false
		end

		if old_think then
			old_think(self)
		end
	end

	self.Menu.PaintOver = function(self, w, h)
		local _x, _y, _w, _h = x - 200, show_outdated and 80 or 50, 195, self.AboutPos
		surface.SetDrawColor(color_black)
		surface.DrawRect(_x, _y, _w, _h)
		surface.SetDrawColor(color_lightyellow)
		surface.DrawRect(_x + 1, _y + 1, _w - 2, _h - 2)

		if self.AboutPos >= 35 then
			surface.SetFont("DermaDefault")
			surface.SetTextColor(color_black)
			surface.SetTextPos(_x + 5, _y + 5)
			surface.DrawText("Created by Tommy228.")
			surface.SetTextPos(_x + 5, _y + 25)
			surface.DrawText("Licensed under GPL-3.0.")
		end
	end

	if show_outdated then
		local info = vgui.Create("dlogs_InfoLabel", self.Menu)
		info:SetText(TTTLogTranslate(GetDMGLogLang, "UpdateNotify"))
		info:SetInfoColor("blue")
		info:SetPos(5, 30)
		info:SetSize(x - 10, 25)
	end

	self.Tabs = vgui.Create("DPropertySheet", self.Menu)
	self.Tabs:SetPos(5, show_outdated and 60 or 30)
	self.Tabs:SetSize(x - 10, show_outdated and y - 65 or y - 35)
	self:DrawDamageTab(x, y)
	self:DrawShootsTab(x, y)
	self:DrawOldLogs(x, y)
	self:DrawRDMManager(x, y)

	self.About = vgui.Create("DButton", self.Menu)
	self.About:SetPos(x - 60, show_outdated and 57 or 27)
	self.About:SetSize(55, 19)
	self.About:SetText("▼" .. TTTLogTranslate(GetDMGLogLang, "About"))

	self.About.DoClick = function()
		self.Menu:About()
		self.About:SetText(self.Menu.AboutState and "▲" .. TTTLogTranslate(GetDMGLogLang, "About") or "▼" .. TTTLogTranslate(GetDMGLogLang, "About"))
	end
end

concommand.Add("damagelog", function()
	dlogs:OpenMenu()
end)

hook.Add("PlayerButtonDown", "dlogs_MenuKey", function(p, k)
    if (k == dlogs.Config.Key) then
    	if (IsValid(dlogs.Menu)) then
			if (dlogs:IsRecording()) then
				dlogs:StopRecording()
				dlogs.Menu:SetVisible(true)
			else
				dlogs.Menu:Close()
			end
		else
			dlogs:OpenMenu()
		end
    end
end)

function dlogs:StrRole(role)
	if role == ROLE_TRAITOR then
		return TTTLogTranslate(GetDMGLogLang, "traitor")
	elseif role == ROLE_DETECTIVE then
		return TTTLogTranslate(GetDMGLogLang, "detective")
	elseif role == "disconnected" then
		return TTTLogTranslate(GetDMGLogLang, "disconnected")
	else
		return TTTLogTranslate(GetDMGLogLang, "innocent")
	end
end

net.Receive("dlogs.InformSuperAdmins", function()
	local nick = net.ReadString()

	if nick then
		chat.AddText(color_red, nick, color_white, " " .. TTTLogTranslate(GetDMGLogLang, "AbuseNote"))
	end
end)

net.Receive("dlogs.Ded", function()
	if GetConVar("ttt_dmglogs_rdmpopups"):GetBool() and net.ReadUInt(1, 1) == 1 then
		if LocalPlayer().IsGhost and LocalPlayer():IsGhost() then return end
		local death_reason = net.ReadString()
		if not death_reason then return end
		local frame = vgui.Create("DFrame")
		frame:SetSize(250, 120)
		frame:SetTitle(TTTLogTranslate(GetDMGLogLang, "PopupNote"))
		frame:ShowCloseButton(false)
		frame:Center()
		local reason = vgui.Create("DLabel", frame)
		reason:SetText(string.format(TTTLogTranslate(GetDMGLogLang, "KilledBy"), death_reason))
		reason:SizeToContents()
		reason:SetPos(5, 32)
		local report = vgui.Create("DButton", frame)
		report:SetPos(5, 55)
		report:SetSize(240, 25)
		report:SetText(TTTLogTranslate(GetDMGLogLang, "OpenMenu"))

		report.DoClick = function()
			net.Start("dlogs.StartReport")
			net.SendToServer()
			frame:Close()
		end

		local report_icon = vgui.Create("DImageButton", report)
		report_icon:SetMaterial("materials/icon16/report_go.png")
		report_icon:SetPos(1, 5)
		report_icon:SizeToContents()
		local close = vgui.Create("DButton", frame)
		close:SetPos(5, 85)
		close:SetSize(240, 25)
		close:SetText(TTTLogTranslate(GetDMGLogLang, "WasntRDM"))

		close.DoClick = function()
			frame:Close()
		end

		local close_icon = vgui.Create("DImageButton", close)
		close_icon:SetPos(2, 5)
		close_icon:SetMaterial("materials/icon16/cross.png")
		close_icon:SizeToContents()
		frame:MakePopup()
		chat.AddText(color_red, "[RDM Manager] ", COLOR_WHITE, TTTLogTranslate(GetDMGLogLang, "OpenReportMenu"), color_lightblue, " ", dlogs.RDM_Manager_Command, COLOR_WHITE, " ", TTTLogTranslate(GetDMGLogLang, "Command"), ".")
	end
end)

hook.Add("StartChat", "dlogs_StartChat", function()
	if IsValid(dlogs.Menu) then
		dlogs.Menu:SetPos(ScrW() - dlogs.Menu:GetWide(), ScrH() / 2 - dlogs.Menu:GetTall() / 2)
	end
end)

hook.Add("FinishChat", "dlogs_FinishChat", function()
	if IsValid(dlogs.Menu) then
		dlogs.Menu:Center()
	end
end)
