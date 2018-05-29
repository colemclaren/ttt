CreateClientConVar("moat_dlogs_rdmpopups", "1", FCVAR_ARCHIVE)
CreateClientConVar("moat_dlogs_currentround", "0", FCVAR_ARCHIVE)
CreateClientConVar("moat_dlogs_showpending", "1", FCVAR_ARCHIVE)
CreateClientConVar("moat_dlogs_enablesound", "1", FCVAR_ARCHIVE)
CreateClientConVar("moat_dlogs_enablesoundoutside", "1", FCVAR_ARCHIVE)

hook.Add("TTTSettingsTabs", "dlogs.TTTSettingsTab", function(dtabs)
	local padding = dtabs:GetPadding() * 2
	local dsettings = vgui.Create("DPanelList", dtabs)
	dsettings:StretchToParent(0,0,padding,0)
	dsettings:EnableVerticalScrollbar(true)
	dsettings:SetPadding(10)
	dsettings:SetSpacing(10)

	local dgui = vgui.Create("DForm", dsettings)
	dgui:SetName(TTTLogTranslate(GetDMGLogLang, "Generalsettings"))
	local selectedcolor

	dgui:CheckBox(TTTLogTranslate(GetDMGLogLang, "RDMuponRDM"), "moat_dlogs_rdmpopups")
	dgui:CheckBox(TTTLogTranslate(GetDMGLogLang, "CurrentRoundLogs"), "moat_dlogs_currentround")
	dgui:CheckBox(TTTLogTranslate(GetDMGLogLang, "ShowPendingReports"), "moat_dlogs_showpending")
	dgui:CheckBox(TTTLogTranslate(GetDMGLogLang, "EnableSound"), "moat_dlogs_enablesound")
	dgui:CheckBox(TTTLogTranslate(GetDMGLogLang, "OutsideNotification"), "moat_dlogs_enablesoundoutside")
	dsettings:AddItem(dgui)

	local colorSettings = vgui.Create("DForm")
	colorSettings:SetName(TTTLogTranslate(GetDMGLogLang, "Colors"))

	local colorChoice = vgui.Create("DComboBox")

	local colorMixer = vgui.Create("DColorMixer")
	colorMixer:SetHeight(200)
	for k, v in pairs(dlogs.colors) do
		if (not selectedcolor and v.Custom) then
			colorMixer:SetColor(v.Custom)
			selectedcolor = k
		end

		colorChoice:AddChoice(TTTLogTranslate(GetDMGLogLang, k), k)
	end
	colorChoice:ChooseOptionID(1)
	colorChoice.OnSelect = function(panel, index, value, data)
		colorMixer:SetColor(dlogs.colors[data].Custom)
		selectedcolor = data
	end

	colorSettings:AddItem(colorChoice)
	colorSettings:AddItem(colorMixer)


	local saveColor = vgui.Create("DButton")
	saveColor:SetText(TTTLogTranslate(GetDMGLogLang, "Save"))
	saveColor.DoClick = function()
		local c = colorMixer:GetColor()
		dlogs.colors[selectedcolor].Custom = c
		dlogs:SaveColors()
	end
	local defaultcolor = vgui.Create("DButton")
	defaultcolor:SetText(TTTLogTranslate(GetDMGLogLang, "SetDefault"))
	defaultcolor.DoClick = function()
		local c = dlogs.colors[selectedcolor].Default
		colorMixer:SetColor(c)
		dlogs.colors[selectedcolor].Custom = c
		dlogs:SaveColors()
	end

	colorSettings:AddItem(saveColor)
	colorSettings:AddItem(defaultcolor)
	dsettings:AddItem(colorSettings)


	dtabs:AddSheet("dlogs", dsettings, "icon16/table_gear.png", false, false, TTTLogTranslate(GetDMGLogLang, "dlogsMenuSettings"))
end)