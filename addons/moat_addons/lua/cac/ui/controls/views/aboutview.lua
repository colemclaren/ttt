local self = {}

function self:Init ()
	self.Lines = {{}}
	
	self.ScriptListBox = self:Create ("CACScriptListBox")
	
	local scriptUrl = "https://scriptfodder.net/scripts/view/460/"
	local profileUrl = "https://steamcommunity.com/id/_cake/"
	
	self:AddText (CAC.Font ("Roboto", 48), "!cake Anti-Cheat")
	self:AddSpacing (8)
	self:AddText (CAC.Font ("Roboto", 20), "(Beta)")
	self:AddLineBreak ()
	
	self:AddUrl (CAC.Font ("Roboto", 20), scriptUrl)
	self:AddCopyButton (scriptUrl, "script url")
		:SetNotificationControl (self:AddText (CAC.Font ("Roboto", 20), "Script url copied to clipboard!"):SetTextColor (CAC.Colors.Firebrick))
	self:AddLineBreak ()
	
	self:AddText (CAC.Font ("Roboto", 20), "Coded by ")
	self:AddUrl (CAC.Font ("Roboto", 20), "!cake", profileUrl)
	self:AddText (CAC.Font ("Roboto", 20), ".")
	self:AddCopyButton (profileUrl, "Steam profile url")
		:SetNotificationControl (self:AddText (CAC.Font ("Roboto", 20), "Steam profile url copied to clipboard!"):SetTextColor (CAC.Colors.Firebrick))
	self:AddLineBreak ()
	self:AddText (CAC.Font ("Roboto", 20), "Tested by Jamie, Lenny and Ott.")
	self:AddLineBreak ()
	self:AddText (CAC.Font ("Roboto", 20), "[redacted] by Willox and Nanocat.")
	self:AddLineBreak ()
	self:AddText (CAC.Font ("Roboto", 20), "[redacted] by Meep and Leystryku.")
	self:AddLineBreak ()
	self:AddText (CAC.Font ("Roboto", 20), "Maestro support by Velkon.")
	self:AddLineBreak ()
	
	self:AddSpacing (8)
	self:AddLineBreak ()
	
	self:AddText (CAC.Font ("Roboto", 20), "Leave bug reports ")
	self:AddUrl (CAC.Font ("Roboto", 20), "here", scriptUrl)
	self:AddText (CAC.Font ("Roboto", 20), ".")
	self:AddCopyButton (scriptUrl, "bug reporting url")
		:SetNotificationControl (self:AddText (CAC.Font ("Roboto", 20), "Bug reporting url copied to clipboard!"):SetTextColor (CAC.Colors.Firebrick))
	self:AddLineBreak ()
	
	self:AddSpacing (24)
	self:AddLineBreak ()
	
	self:AddText (CAC.Font ("Roboto", 20), "Other scripts by !cake:")
	self:AddLineBreak ()
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	local x = 8
	local y = 8
	
	for _, line in ipairs (self.Lines) do
		x = 8
		lineHeight = 0
		
		for _, control in ipairs (line) do
			if isnumber (control) then
				lineHeight = math.max (lineHeight, control)
			else
				lineHeight = math.max (lineHeight, control:GetHeight ())
			end
		end
		
		for _, control in ipairs (line) do
			if isnumber (control) then
				x = x + control
			else
				control:SetPos (x, y + 0.5 * (lineHeight - control:GetHeight ()))
				x = x + control:GetWidth ()
			end
		end
		
		y = y + lineHeight
	end
	
	y = y + 8
	self.ScriptListBox:SetPos (x, y)
	self.ScriptListBox:SetSize (w - 8 - x, h - y - 8)
end

-- Internal, do not call
function self:AddText (font, text)
	local line = self.Lines [#self.Lines]
	
	local label = self:Create ("GLabel")
	label:SetFont (font)
	label:SetTextColor (CAC.Colors.Black)
	label:SetText (text)
	label:SizeToContents ()
	
	line [#line + 1] = label
	
	return label
end

function self:AddUrl (font, text, url)
	local line = self.Lines [#self.Lines]
	
	local urlLabel = self:Create ("GUrlLabel")
	urlLabel:SetFont (font)
	urlLabel:SetText (text)
	if url then
		urlLabel:SetUrl (url)
	end
	urlLabel:SizeToContents ()
	
	line [#line + 1] = urlLabel
	
	return urlLabel
end

function self:AddCopyButton (text, description)
	self:AddSpacing (4)
	
	local line = self.Lines [#self.Lines]
	
	local copyButton = self:Create ("CACCopyButton")
	copyButton:SetText (text)
	if description then
		copyButton:SetToolTipText ("Copy " .. description)
	end
	
	line [#line + 1] = copyButton
	
	self:AddSpacing (4)
	
	return copyButton
end

function self:AddSpacing (h)
	local line = self.Lines [#self.Lines]
	
	line [#line + 1] = h
end

function self:AddLineBreak ()
	self.Lines [#self.Lines + 1] = {}
end

CAC.Register ("CACAboutView", self, "CACPanel")