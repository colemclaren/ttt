GetDMGLogLang = "english"

local color_lightyellow = Color(255, 245, 148)
local color_red = Color(255, 62, 62)
local color_lightblue = Color(98, 176, 255)

hook.Add("InitPostEntity", "dlogs.InitPostHTTP", function()
	net.Start("dlogs.SendLang")
	net.WriteString(GetDMGLogLang)
	net.SendToServer()
end)

function dlogs:OpenMenu()
	local x, y = 665, 680

	self.Menu = vgui.Create("DFrame")
	self.Menu:SetSize(x, y)
	self.Menu:SetTitle("Moat TTT Logs version " .. self.Version)
	self.Menu:SetDraggable(true)
	self.Menu:MakePopup()
	self.Menu:SetKeyboardInputEnabled(false)
	self.Menu:Center()

	self.Tabs = vgui.Create("DPropertySheet", self.Menu)
	self.Tabs:SetPos(5, 30)
	self.Tabs:SetSize(x - 10, y - 35)

	self:DrawDamageTab(x, y)
	self:DrawShootsTab(x, y)
	self:DrawOldLogs(x, y)
	self:DrawRDMManager(x, y)
end

function dlogs.HandleOpenMenu()
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

concommand.Add("log", dlogs.HandleOpenMenu)
concommand.Add("logs", dlogs.HandleOpenMenu)
concommand.Add("dlog", dlogs.HandleOpenMenu)
concommand.Add("damagelog", dlogs.HandleOpenMenu)

hook.Add("PlayerButtonDown", "dlogs.MenuKey", function(p, k)
    if (k == dlogs.Config.Key) then dlogs.HandleOpenMenu() end
end)

local role_strings = {["disconnected"] = "disconnected"}
function dlogs:StrRole(role)
	return GetRoleStringRaw[role] or role_strings[role] or "innocent"
end

net.Receive("dlogs.Ded", function()
    if (not GetConVar("moat_dlogs_rdmpopups"):GetBool() or net.ReadUInt(1) ~= 1) then return end

    local death_reason = net.ReadString()
    if (not death_reason) then return end

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
    chat.AddText(color_red, "[RDM Manager] ", COLOR_WHITE, TTTLogTranslate(GetDMGLogLang, "OpenReportMenu"), color_lightblue, " !report", COLOR_WHITE, " ", TTTLogTranslate(GetDMGLogLang, "Command"), ".")
end)

hook.Add("StartChat", "dlogs_StartChat", function()
	if IsValid(dlogs.Menu) then dlogs.Menu:SetPos(ScrW() - dlogs.Menu:GetWide(), ScrH()/2 - dlogs.Menu:GetTall()/2) end
end)

hook.Add("FinishChat", "dlogs_FinishChat", function()
	if IsValid(dlogs.Menu) then dlogs.Menu:Center() end
end)