CreateClientConVar("ttt_dmglogs_showinnocents", "0", true, true)

cvars.AddChangeCallback("ttt_dmglogs_showinnocents", function(name, old, new)
	if IsValid(dlogs.Menu) then
		dlogs:SetRolesListView(dlogs.Roles, dlogs.CurrentRoles)
	end
end)

surface.CreateFont("dlogs.Highlight", {
	font = "Verdana",
	size = 13
})

local PANEL = {}

function PANEL:SetPlayer(nick)
	self.Text = nick
	surface.SetFont("dlogs.Highlight")
	local xtext, ytext = surface.GetTextSize(self.Text)
	self:SetSize(xtext + 25, ytext + 4)
	self.Close = vgui.Create("TipsButton", self)

	self.Close.Colors = {
		default = COLOR_LGRAY,
		hover = Color(0, 100, 200),
		press = COLOR_BLUE
	}

	self.Close:SetPos(xtext + 10, 2)
	self.Close:SetSize(13, 13)
	self.Close:SetText("")

	self.Close.PaintOver = function(self, w, h)
		surface.SetFont("DermaDefault")
		local x, y = surface.GetTextSize("X")
		surface.SetTextPos(w / 2 - x / 2 + 1, h / 2 - y / 2)
		surface.DrawText("X")
	end

	self.Close.DoClick = function()
		for k, v in pairs(dlogs.PlayersCombo.Players) do
			if self.Text == v.nick then
				table.RemoveByValue(dlogs.Highlighted, k)
				dlogs.PlayerSelect:UpdatePlayers()
				break
			end
		end
	end

	self.SizeX = xtext + 25
end

function PANEL:Paint(w, h)
	if not self.Text then return end
	surface.SetDrawColor(Color(242, 242, 242))
	surface.DrawRect(0, 0, w, h)
	surface.SetDrawColor(Color(0, 50, 200))
	surface.DrawLine(0, 0, w - 1, 0)
	surface.DrawLine(w - 1, 0, w - 1, h - 1)
	surface.DrawLine(w - 1, h - 1, 0, h - 1)
	surface.DrawLine(0, h - 1, 0, 0)
	surface.SetFont("dlogs.Highlight")
	surface.SetTextColor(color_black)
	surface.SetTextPos(3, 1)
	surface.DrawText(self.Text)
end

derma.DefineControl("dlogs.FiltersPlayer", "", PANEL, "DPanel")
dlogs.Highlighted = dlogs.Highlighted or {}
dlogs.ShadowHigh = dlogs.ShadowHigh or {}

function dlogs:DrawDamageTab(x, y)
	local function askLogs()
		if not self.SelectedRound then return end
		self.dlogs:Clear()
		self.dlogs:AddLine("", "", TTTLogTranslate(GetDMGLogLang, "Loading"))
		self.receiving = true
		net.Start("dlogs.Askdlogs")
		net.WriteInt(self.SelectedRound, 32)
		net.SendToServer()
	end

	self.DamageTab = vgui.Create("DListLayout")
	self.Panel = self.DamageTab:Add("DPanel")
	self.Panel:SetSize(x - 40, 195)
	self.PanelOptions = vgui.Create("DPanelList", self.Panel)
	self.PanelOptions:SetSpacing(7)
	self.PanelOptions:StretchToParent(12, 5, 0, 0)
	local forms = {}
	self.RF = vgui.Create("DForm", self.PanelOptions)
	self.RF:SetName(TTTLogTranslate(GetDMGLogLang, "RoundFilter"))
	self.RoundPanel = vgui.Create("DPanel")
	self.RoundPanel:SetHeight(90)
	self.RoundPanel.Paint = function() end
	self.Round = vgui.Create("DComboBox", self.RoundPanel)
	self.Round:SetSize(500, 22)
	self.Round:SetPos(0, 0)
	local old_click = self.Round.DoClick

	self.Round.DoClick = function(panel)
		local sync_ent = self:GetSyncEnt()
		if IsValid(sync_ent) and (sync_ent:GetLastRoundMapExists() or sync_ent:GetPlayedRounds() > 0) then return old_click(panel) end
	end

	self.Filters = vgui.Create("DButton", self.RoundPanel)
	self.Filters:SetText(TTTLogTranslate(GetDMGLogLang, "EditFilter"))
	self.Filters:SetPos(505, 0)
	self.Filters:SetSize(85, 22)

	self.Filters.DoClick = function(Filters, forcedX, forcedY)
		local filters = DermaMenu()

		local x,y = gui.MouseX(), gui.MouseY()

		for k, v in pairs(dlogs.filters) do
			local value = dlogs.filter_settings[k]

			local option = filters:AddOption(TTTLogTranslate(GetDMGLogLang, k), function()
				dlogs.filter_settings[k] = not dlogs.filter_settings[k]
				dlogs:SaveFilters()
				askLogs()
				timer.Simple(0, function()
					Filters:DoClick(forcedX or x, forcedY or y)
				end)
			end)

			option:SetIcon(value and "icon16/accept.png" or "icon16/delete.png")
		end

		filters:Open(forcedX or x, forcedY or y, isnumber(forcedX))
	end

	self.PlayerSelect = vgui.Create("DPanel", self.RoundPanel)
	self.PlayerSelect:SetPos(0, 30)
	self.PlayerSelect:SetSize(590, 60)
	self.PlayerSelect.Panels = {}

	self.PlayerSelect.UpdatePlayers = function(self)
		for k, v in pairs(self.Panels) do
			v:Remove()
		end

		table.Empty(self.Panels)

		if #dlogs.Highlighted > 0 then
			dlogs.PS_Label:SetText(dlogs.PS_Label.Text)
			surface.SetFont("dlogs.Highlight")
			local x = surface.GetTextSize(dlogs.PS_Label.Text)
			x = x + 10

			for k, v in ipairs(dlogs.Highlighted) do
				local ply = vgui.Create("dlogs.FiltersPlayer", self)
				table.insert(self.Panels, ply)
				ply:SetPlayer(dlogs.PlayersCombo.Players[v].nick)
				ply:SetPos(x, 8)
				x = x + ply.SizeX + 5
			end
		else
			dlogs.PS_Label:SetText(dlogs.PS_Label.Text .. " " .. TTTLogTranslate(GetDMGLogLang, "None"))
		end
	end

	self.PS_Label = vgui.Create("DLabel", self.PlayerSelect)
	self.PS_Label.Text = TTTLogTranslate(GetDMGLogLang, "CurrentFilter")
	self.PS_Label:SetFont("dlogs.Highlight")
	self.PS_Label:SetTextColor(color_black)
	self.PS_Label:SetText(self.PS_Label.Text .. " " .. TTTLogTranslate(GetDMGLogLang, "None"))
	self.PS_Label:SetPos(5, 10)
	self.PS_Label:SizeToContents()
	self.PlayersCombo = vgui.Create("DComboBox", self.PlayerSelect)
	self.PlayersCombo:SetPos(5, 30)
	self.PlayersCombo:SetSize(490, 20)
	self.PlayersCombo:AddChoice(TTTLogTranslate(GetDMGLogLang, "NoPlayers"), NULL)

	self.PlayersCombo.Update = function(self)
		self:Clear()

		for k, v in pairs(self.Players) do
			self:AddChoice(v.nick, k)
		end

		if table.Count(self.Players) > 0 then
			self:ChooseOptionID(1)
			self:SetEnabled(true)
		else
			self:SetEnabled(false)
		end
	end

	self.PlayersCombo.FirstSelect = true
	self.PlayersCombo.OnSelect = function(self, index, value, data)
		self.CurrentlySelected = value
	end

	self.PlayersCombo:SetEnabled(false)
	self.Highlight = vgui.Create("DButton", self.PlayerSelect)
	self.Highlight:SetPos(500, 30)
	self.Highlight:SetSize(80, 20)
	self.Highlight:SetText("Highlight")

	self.Highlight.DoClick = function(self)
		local nick, selected = dlogs.PlayersCombo:GetSelected()
		if table.HasValue(dlogs.Highlighted, selected) then return end
		if #dlogs.Highlighted >= 3 then
			Derma_Message(TTTLogTranslate(GetDMGLogLang, "MorePlayers"), TTTLogTranslate(GetDMGLogLang, "Error"), "OK")
		else
			table.insert(dlogs.Highlighted, selected)
			dlogs.PlayerSelect:UpdatePlayers()
		end
	end

	self.RF:AddItem(self.RoundPanel)
	self.PanelOptions:AddItem(self.RF)
	self.RF:SetHeight(150)
	self.RF:SetExpanded(true)
	table.insert(forms, self.RF)
	self.DamageInfoBox = vgui.Create("DForm", self.PanelOptions)
	self.DamageInfoBox:SetName(TTTLogTranslate(GetDMGLogLang, "DmgInfo"))
	self.DamageInfo = vgui.Create("DListView")
	self.DamageInfo:SetHeight(90)
	self.DamageInfo:AddColumn(TTTLogTranslate(GetDMGLogLang, "DmgInfo")).DoClick = function() end
	self.DamageInfoBox:AddItem(self.DamageInfo)
	self.PanelOptions:AddItem(self.DamageInfoBox)
	self.DamageInfoBox:SetHeight(350)
	self.DamageInfoBox:SetExpanded(false)
	table.insert(forms, self.DamageInfoBox)
	self.RoleInfos = vgui.Create("DForm", self.PanelOptions)
	self.RoleInfos:SetName(TTTLogTranslate(GetDMGLogLang, "Role"))
	self.Roles = vgui.Create("DListView")
	self.Roles:AddColumn(TTTLogTranslate(GetDMGLogLang, "Player"))
	self.Roles:AddColumn(TTTLogTranslate(GetDMGLogLang, "Role"))
	self.Roles:AddColumn(TTTLogTranslate(GetDMGLogLang, "Alive"))
	self.Roles:SetHeight(90)
	self.RoleInfos:AddItem(self.Roles)
	self.PanelOptions:AddItem(self.RoleInfos)
	self.RoleInfos:SetHeight(350)
	self.RoleInfos:SetExpanded(false)
	local show_innocents = vgui.Create("DCheckBoxLabel", self.RoleInfos)
	show_innocents:SetPos(455, 3)
	show_innocents:SetText(TTTLogTranslate(GetDMGLogLang, "ShowInnocent"))
	show_innocents:SetTextColor(color_white)
	show_innocents:SetConVar("ttt_dmglogs_showinnocents")
	show_innocents:SizeToContents()
	table.insert(forms, self.RoleInfos)

	for k, v in pairs(forms) do
		local old_toggle = v.Toggle

		v.Toggle = function(self)
			if self:GetExpanded() then
				return
			else
				for _, s in pairs(forms) do
					if s:GetExpanded() then
						old_toggle(s)
					end
				end
			end

			return old_toggle(v)
		end
	end

	self.dlogs = self.DamageTab:Add("DListView")
	self.dlogs:SetHeight(415)
	self.dlogs:AddColumn(TTTLogTranslate(GetDMGLogLang, "Time")):SetFixedWidth(40)
	self.dlogs:AddColumn(TTTLogTranslate(GetDMGLogLang, "Type")):SetFixedWidth(40)
	self.dlogs.EventColumn = self.dlogs:AddColumn(TTTLogTranslate(GetDMGLogLang, "Event"))
	self.dlogs.EventColumn:SetFixedWidth(529)
	self.dlogs.IconColumn = self.dlogs:AddColumn("")
	self.dlogs.IconColumn:SetFixedWidth(30)

	self.dlogs.Think = function(panel)
		if panel.VBar.Enabled and not panel.Scrollbar then
			panel.EventColumn:SetFixedWidth(509)
			panel.IconColumn:SetFixedWidth(50)
			panel.Scrollbar = true
		elseif not panel.VBar.Enabled and panel.Scrollbar then
			panel.EventColumn:SetFixedWidth(529)
			panel.IconColumn:SetFixedWidth(30)
			panel.Scrollbar = false
		end
	end

	self.Tabs:AddSheet(TTTLogTranslate(GetDMGLogLang, "dlogs"), self.DamageTab, "icon16/application_view_detail.png")
	local sync_ent = self:GetSyncEnt()
	if not IsValid(sync_ent) then return end

	self.Round.FirstSelect = true
	self.Round.OnSelect = function(_, value, index, data)
		self.SelectedRound = data
		if self.Round.FirstSelect then
			self.Round.FirstSelect = false
			return
		end
		self.ShootColumn:UpdateText()
		self.ShootsList:Clear()
		askLogs()
	end

	local PlayedRounds = sync_ent:GetPlayedRounds()
	local LastMapExists = sync_ent:GetLastRoundMapExists()
	local LastChoise = 0

	if LastMapExists then
		self.Round:AddChoice(TTTLogTranslate(GetDMGLogLang, "LastRound"), -1)
		LastChoise = LastChoise + 1

		if PlayedRounds <= 0 then
			self.SelectedRound = -1
			askLogs()
			self.Round:ChooseOptionID(1)
		end
	end

	if PlayedRounds > 1 or (LocalPlayer():CanUsedlogs() and PlayedRounds > 0) then
		local i_count = 1

		if PlayedRounds > 10 then
			i_count = PlayedRounds - 10
		end

		if not LocalPlayer():CanUsedlogs() then
			PlayedRounds = PlayedRounds - 1
		end

		for i = i_count, PlayedRounds do
			if i == PlayedRounds and LocalPlayer():CanUsedlogs() then
				self.Round:AddChoice(TTTLogTranslate(GetDMGLogLang, "CurrentRound"), i)
			else
				self.Round:AddChoice(TTTLogTranslate(GetDMGLogLang, "Round") .. " " .. tostring(i), i)
			end

			LastChoise = LastChoise + 1
		end

		if not LocalPlayer():CanUsedlogs() or (GetConVar("ttt_dmglogs_currentround"):GetBool() or not LocalPlayer():IsActive()) then
			self.Round:ChooseOptionID(LastChoise)
		else
			self.Round:ChooseOptionID(LastChoise - 1 > 0 and LastChoise - 1 or LastChoise)
		end

		askLogs()
	elseif not LastMapExists then
		self.Round:AddChoice(language.GetPhrase(TTTLogTranslate(GetDMGLogLang, "NoLogsAvailable")))
		self.Round:ChooseOptionID(1)
	end

	self.Round.OpenMenu = function(self, pControlOpener)
		if pControlOpener and pControlOpener == self.TextEntry then return end
		if #self.Choices == 0 then return end

		if IsValid(self.Menu) then
			self.Menu:Remove()
			self.Menu = nil
		end

		self.Menu = DermaMenu()
		local sorted = {}

		for k, v in pairs(self.Choices) do
			table.insert(sorted, {
				id = k,
				data = v
			})
		end

		for k, v in pairs(sorted, "data") do
			self.Menu:AddOption(v.data, function()
				self:ChooseOption(v.data, v.id)
			end)
		end

		local x, y = self:LocalToScreen(0, self:GetTall())
		self.Menu:SetMinimumWidth(self:GetWide())
		self.Menu:Open(x, y, false, self)
	end
end

net.Receive("dlogs.Senddlogs", function()
	local roles = net.ReadTable()
	local count = net.ReadUInt(32)
	local round = {
		logs = {}
	}
	round.roles = roles
	for i = 1, count do
		table.insert(round.logs, net.ReadTable())
	end
	dlogs.RoleNicks = {}

	for k, v in ipairs(player.GetHumans()) do
		dlogs.RoleNicks[v:Nick()] = v
	end

	if not IsValid(dlogs.Menu) then return end

	dlogs.Highlighted = {}
	if dlogs.PlayerSelect and dlogs.PlayerSelect.UpdatePlayers then
		dlogs.PlayerSelect:UpdatePlayers()
	end
	dlogs.PlayersCombo.Players = roles
	dlogs.PlayersCombo:Update()

	dlogs.CurrentRoles = roles
	dlogs:SetRolesListView(dlogs.Roles, roles)
	dlogs.dlogs:Clear()
	if count == 0 then
		dlogs.dlogs:AddLine("", "", TTTLogTranslate(GetDMGLogLang, "EmptyLogs"))
	else
		dlogs:SetListViewTable(dlogs.dlogs, round)
	end
end)

net.Receive("dlogs.SendDamageInfos", function()
	local beg = net.ReadUInt(32)
	local t = net.ReadUInt(32)
	local victim = net.ReadString()
	local att = net.ReadString()
	local victimID = net.ReadUInt(32)
	local attID = net.ReadUInt(32)
	local found = net.ReadUInt(1) == 1
	local result = false
	if found then
		result = net.ReadTable()
	end
	local roles = {
		[attID] = { nick = att },
		[victimID] = { nick = victim }
	}
	dlogs:SetDamageInfosLV(dlogs.DamageInfo, roles, att, victim, beg, t, result)
end)

net.Receive("dlogs.Refreshdlogs", function()
	local tbl = net.ReadTable()
	if not IsValid(LocalPlayer()) then return end -- sometimes happens while joining
	if not LocalPlayer().CanUsedlogs then return end
	if not LocalPlayer():CanUsedlogs() then return end

	if IsValid(dlogs.dlogs) then
		local lines = dlogs.dlogs:GetLines()

		if lines[1] and lines[1]:GetValue(3) == TTTLogTranslate(GetDMGLogLang, "Nothinghere") then
			dlogs.dlogs:Clear()
		end

		local rounds = dlogs:GetSyncEnt():GetPlayedRounds()

		if rounds == dlogs.SelectedRound then
			dlogs:AddLogsLine(dlogs.dlogs, tbl, dlogs.CurrentRoles)
		end
	end
end)
